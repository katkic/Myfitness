class MenusController < ApplicationController
  before_action :set_menu, only: %i[show edit update destroy]
  before_action :set_exercises, only: %i[new create edit update]

  def index
    @menus = Menu.where(user: current_user)
    set_part_name_chart(current_user)
  end

  def show;end

  def new
    @menu = current_user.menus.build
  end

  def create
    @menu = current_user.menus.build(menu_params)

    if @menu.save
      redirect_to menus_path, notice: "メニュー「#{@menu.name}」を作成しました"
    else
      render :new
    end
  end

  def edit;end

  def update
    if @menu.update(menu_params)
      redirect_to menus_path, notice: "メニュー「#{@menu.name}」を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @menu.destroy
    redirect_to menus_path, notice: "メニュー「#{@menu.name}」を削除しました"
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :interval, exercise_ids: [])
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def set_exercises
    @exercises_preset = Exercise.preset
    @exercises_original = Exercise.original(current_user)
  end
end
