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

  def self.get_set(exercise_logs)
    return 0 if exercise_logs.empty?

    exercise_logs.last.set
  end

  def self.get_max_weight(exercise_logs)
    return 0 if exercise_logs.empty?

    weight_arr = exercise_logs.map { |exercise_log| exercise_log[:weight] }
    weight_arr.max
  end

  def self.get_one_rm_max(exercise_logs)
    return 0 if exercise_logs.empty?

    one_rm_max_arr = exercise_logs.map do |exercise_log|
      once_or_more(exercise_log)
    end

    one_rm_max_arr.max
  end

  def self.get_one_rm(exercise_log)
    return 0 unless exercise_log.present?

    once_or_more(exercise_log)
  end

  def self.get_total_weight(exercise_logs)
    return 0 if exercise_logs.empty?

    sum = 0
    exercise_logs.each { |exercise_log| sum += exercise_log[:weight] * exercise_log[:rep] }
    sum
  end

  def self.once_or_more(exercise_logs)
    if exercise_logs[:rep] == 1
      exercise_logs[:weight]
    else
      choose_bench_or_squat(exercise_logs)
    end
  end

  def self.choose_bench_or_squat(exercise_log)
    # 1RM = 使用重量 × {1 + (持ち上げた回数 ÷ 40)}
    # スクワット・デッドリフトのRM換算表を作りたい場合は補正係数を33.3にする
    case exercise_log[:name]
    when 'スクワット', 'デッドリフト'
      exercise_log[:weight] * (1 + (exercise_log[:rep] / 33.3)).floor(1)
    else
      exercise_log[:weight] * (1 + (exercise_log[:rep] / 40.0)).floor(1)
    end
  end

  private_class_method :choose_bench_or_squat, :once_or_more
end
