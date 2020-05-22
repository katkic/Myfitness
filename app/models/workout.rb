class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_many :exercise_logs, dependent: :destroy

  accepts_nested_attributes_for :exercise_logs, allow_destroy: true

  enum condition: {
    very_good: 1,
    good:      2,
    nomal:     3,
    bad:       4,
    very_bad:  5
  }

  paginates_per 20

  # max_weight, max_one_rm, total_weightの計算&カラムにセット
  before_validation :calculate_weight

  scope :search_workout, -> (search_params) do
    return if search_params.blank?

    exercise = Exercise.name_like(search_params[:name])
    where(exercise_id: exercise.ids).find_workout_logs_by_user_id(search_params).order(created_at: :desc)
  end

  scope :find_workout_logs_by_user_id, -> (search_params) do
    where(user_id: search_params[:user_id])
  end

  scope :get_workout_records, -> (user, exercise_id, range, column) do
    find_workout(user, exercise_id, range).pluck(:created_at, column)
  end

  scope :find_workout, -> (user, exercise_id, range) do
    user.workouts.where(exercise_id: exercise_id).where(created_at: range)
  end

  private

  def calculate_weight
    exercise_logs = self.exercise_logs
    self.set = get_set(exercise_logs)
    self.max_weight = get_max_weight(exercise_logs)
    self.max_one_rm = get_max_one_rm(exercise_logs)
    self.total_weight = get_total_weight(exercise_logs)
  end

  def get_set(exercise_logs)
    return 0 if exercise_logs.empty?

    exercise_logs.last.set
  end

  def get_max_weight(exercise_logs)
    return 0 if exercise_logs.empty?

    weight_arr = exercise_logs.map { |exercise_log| exercise_log[:weight] }
    weight_arr.compact!
    weight_arr.max
  end

  def get_max_one_rm(exercise_logs)
    return 0 if exercise_logs.empty?

    one_rm_max_arr = exercise_logs.map do |exercise_log|
      once_or_more(exercise_log)
    end

    one_rm_max_arr.compact!
    one_rm_max_arr.max
  end

  def get_total_weight(exercise_logs)
    return 0 if exercise_logs.empty?

    sum = 0
    exercise_logs.each do |exercise_log|
      if exercise_log[:weight].nil? || exercise_log[:rep].nil?
        sum += 0
      else
        sum += exercise_log[:weight] * exercise_log[:rep]
      end
    end

    sum
  end

  def once_or_more(exercise_logs)
    if exercise_logs[:rep] == 1
      exercise_logs[:weight]
    else
      choose_bench_or_squat(exercise_logs)
    end
  end

  def choose_bench_or_squat(exercise_log)
    # 1RM = 使用重量 × {1 + (持ち上げた回数 ÷ 40)}
    # スクワット・デッドリフトのRM換算表を作りたい場合は補正係数を33.3にする
    exercise_name = exercise_log.workout.exercise.name
    return 0 if exercise_log[:weight].nil? || exercise_log[:rep].nil?

    case exercise_name
    when 'スクワット', 'デッドリフト'
      (exercise_log[:weight] * (1 + (exercise_log[:rep] / 33.3))).floor(1)
    else
      (exercise_log[:weight] * (1 + (exercise_log[:rep] / 40.0))).floor(1)
    end
  end
end
