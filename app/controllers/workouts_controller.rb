class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[edit update]

  def index
    @workouts = Workout.where(exercise_id: params[:exercise_id]).order(created_at: :desc)
    @exercise = @workouts.first.exercise
  end

  def show;end

  def new
    @exercise = Exercise.find(params[:exercise_id])
    @workout = Workout.new
    5.times { @workout.exercise_logs.build }
  end

  def create
    @workout = current_user.workouts.build(workout_params)
    get_exercise

    if @workout.save
      redirect_to workouts_path(exercise_id: @exercise.id), notice: "トレーニング「#{@exercise.name}」を記録しました"
    else
      render :new
    end
  end

  def edit
    @workout.exercise_logs.build
    get_exercise
  end

  def update
    get_exercise

    if @workout.update(workout_params)
      redirect_to workout_path(@workout), notice: "トレーニング「#{@exercise.name}」を更新しました"
    else
      render :edit
    end
  end

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

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def get_exercise
    @exercise = @workout.exercise
  end
end
