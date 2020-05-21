class WorkoutLogsController < ApplicationController
  before_action :set_user

  def index
    @workout_logs = @user.workouts.order(created_at: :desc).page(params[:page])
    set_part_name_chart(@user)
  end

  def search
    search_params = workout_logs_search_params
    @workout_logs = Workout.search_workout(search_params).page(params[:page])
    set_part_name_chart(@user)
    render :index
  end

  private

  def set_user
    if action_name == 'index'
      @user = User.find(params[:id])
    elsif action_name == 'search'
      @user = User.find(params[:search][:user_id])
    end
  end

  def workout_logs_search_params
    params.fetch(:search, {}).permit(:name, :user_id)
  end
end
