class MenusController < ApplicationController
  def index
    @menus = Menu.where(user: current_user)
  end

  def show
  end

  def new
    @menu = current_user.menus.build
  end

  def edit
  end

  def create
    @menu = current_user.menus.build(menu_params)

    if @menu.save
      redirect_to menus_path, notice: "メニュー「#{@menu.name}」を作成しました"
    else
      render :new
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :interval)
  end
end
