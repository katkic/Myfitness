class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.where(exercise_id: params[:format])
    @exercise = Exercise.find(params[:format])
  end

  def show
  end

  def new
  end

  def edit
  end
end
