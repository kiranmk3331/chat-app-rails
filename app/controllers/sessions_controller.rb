# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create ]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome you have successfully logged in "
      redirect_to root_path
    else
      flash.now[:error] = "There is something wrong with the login credentials"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

  private
    def redirect_if_logged_in
      if logged_in?
        flash[:error] = "You are already logged in"
        redirect_to root_path
      end
    end
end
