class MenusController < ApplicationController
  def index
    @menus = Menu.where(user: current_user)
  end

  def show
  end

  def new
  end

  def edit
  end

  end
