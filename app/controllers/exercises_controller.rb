class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show edit update destroy]

  def index
    set_exercise_preset_and_original
  end

  def show;end

  def new
    @exercise = current_user.exercises.build
  end

  def edit;end

  def create
    @exercise = current_user.exercises.build(exercise_params)

    if @exercise.save
      redirect_to exercise_path(@exercise), notice: "トレーニング種目「#{@exercise.name}」を登録しました"
    else
      render :new
    end
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercise_path(@exercise), notice: "トレーニング種目「#{@exercise.name}」を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to exercises_path, notice: "トレーニング種目「#{@exercise.name}」を削除しました"
  end

  def search
    @search_params = exercise_search_params
    @exercises_preset = Exercise.exercise_search(@search_params)

    # if @search_params[:name].blank? && @search_params[:part].blank? && @search_params[:category].blank?
    #   set_exercise_preset_and_original
    # else
      # @search_params[:preset] = true
      # @exercises_preset = Exercise.exercise_search(@search_params)
    # end

    render :index
  end

  private

  def exercise_params
    params.require(:exercise).permit(
      :name,
      :part,
      :category,
      :description,
      :icon,
      :icon_cache,
      :remove_icon
    )
  end

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def set_exercise_preset_and_original
    @exercises_preset = Exercise.preset
    @exercises_original = Exercise.original(current_user)
  end

  def exercise_search_params
    params.fetch(:search, {}).permit(:name, :part, :category)
  end
end
