class MenusController < ApplicationController
  before_action :set_menu, only: %i[edit update]

  def index
    @menus = Menu.where(user: current_user)
  end

  def show
  end

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

  private

  def menu_params
    params.require(:menu).permit(:name, :interval)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
