class ChartsController < ApplicationController
  def index
    @range = Chart.get_range(params[:range])  # グラフの表示期間を取得
    @range_title = params[:range]
    @exercise_id = params[:id]
    @user = User.find(params[:user_id])
    @chart_records = {}
    @chart_values = {}
    @workouts = set_workouts  # 種目のグラフを表示するためのリンク用
    select_body_statuses_or_workouts
  end

  private

  def set_workouts
    @user.workouts.select(:exercise_id).distinct.order(:exercise_id)
  end

  def select_body_statuses_or_workouts
    if @exercise_id == '0'
      set_body_status_records
      set_body_status_chart_values
    else
      @exercise_name = find_exercise_name(@exercise_id)
      set_workout_records
      set_workout_chart_values
    end
  end

  def find_exercise_name(exercise_id)
    Exercise.find(exercise_id).name
  end

  def set_body_status_records
    @chart_records['body_weight'] = BodyStatus.get_body_status_records(current_user, @range, :body_weight)
    @chart_records['body_fat'] = BodyStatus.get_body_status_records(current_user, @range, :body_fat)
  end

  def set_body_status_chart_values
    @chart_values['body_weight_min'] = BodyStatus.get_chart_min(current_user, @range, :body_weight)
    @chart_values['body_weight_max'] = BodyStatus.get_chart_max(current_user, @range, :body_weight)
    @chart_values['body_fat_min'] = BodyStatus.get_chart_min(current_user, @range, :body_fat)
    @chart_values['body_fat_max'] = BodyStatus.get_chart_max(current_user, @range, :body_fat)
  end

  def set_workout_records
    @chart_records['max_weight'] = Workout.get_workout_records(@user, @exercise_id, @range, :max_weight)
    @chart_records['max_one_rm'] = Workout.get_workout_records(@user, @exercise_id, @range, :max_one_rm)
    @chart_records['total_weight'] = Workout.get_workout_records(@user, @exercise_id, @range, :total_weight)
  end

  def set_workout_chart_values
    @chart_values['max_weight_min'] = Workout.get_chart_min(@user, @exercise_id, @range, :max_weight)
    @chart_values['max_weight_max'] = Workout.get_chart_max(@user, @exercise_id, @range, :max_weight)
    @chart_values['max_one_rm_min'] = Workout.get_chart_min(@user, @exercise_id, @range, :max_one_rm)
    @chart_values['max_one_rm_max'] = Workout.get_chart_max(@user, @exercise_id, @range, :max_one_rm)
    @chart_values['total_weight_min'] = Workout.get_chart_min(@user, @exercise_id, @range, :total_weight)
    @chart_values['total_weight_max'] = Workout.get_chart_max(@user, @exercise_id, @range, :total_weight)
  end
end
