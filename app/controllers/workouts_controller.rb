class WorkoutsController < ApplicationController
  before_action :set_exercise, only: %i[new]

  def index
    @workouts = Workout.where(exercise_id: params[:exercise_id]).order(created_at: :desc)
    @exercise = Exercise.find(params[:exercise_id])

  end

  def show;end

  def new
    @workout = Workout.new
    5.times { @workout.exercise_logs.build }
  end

  def create
    @workout = current_user.workouts.build(workout_params)
    @exercise = Exercise.find(params[:workout][:exercise_id])

    if @workout.save
      redirect_to workouts_path(exercise_id: @exercise.id), notice: "トレーニング「#{@exercise.name}」を記録しました"
    else
      render :new
    end
  end

  def edit;end

  private

  def workout_params
    params.require(:workout).permit(
      :exercise_id,
      :created_at,
      :condition,
      :memo,
      exercise_logs_attributes: %i[id set weight rep]
    )
  end

  def set_exercise
    @exercise = Exercise.find(params[:exercise_id])
  end
end
