# frozen_string_literal: true

class UserController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]
  before_action :require_user, only: %i[show edit destroy update]
  before_action :load_user, only: %i[show edit destroy update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Signup successfully, Please login to enter chat"
      redirect_to login_path
    else
      flash.now[:errors] = @user.errors.full_messages.to_sentence
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Successfully editted your profile "
      render "show"
    else
      flash.now[:errors] = @user.errors.full_messages.to_sentence
      render "edit"
    end
  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      flash[:success] = "User is deleted"
      redirect_to login_path
    else
      flash.now[:error] = "Something went wrong"
      render "show"
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

    def load_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash.now[:errors] = "User not found"
      redirect_to root_path
    end

    def redirect_if_logged_in
      if logged_in?
        flash[:error] = "You are already logged in"
        redirect_to root_path
      end
    end
end
