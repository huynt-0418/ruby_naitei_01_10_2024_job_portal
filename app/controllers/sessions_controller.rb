class SessionsController < ApplicationController
  layout "auth"

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      handle_successful_login(user)
    else
      handle_failed_login
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def handle_successful_login user
    forwarding_url = session[:forwarding_url]
    reset_session
    log_in user
    flash[:success] = t "flash.login.success"
    redirect_to forwarding_url || root_path
  end

  def handle_failed_login
    flash.now[:danger] = t "flash.login.error"
    render :new, status: :unprocessable_entity
  end
end
