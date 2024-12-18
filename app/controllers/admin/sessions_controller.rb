class Admin::SessionsController < ApplicationController
  layout "auth"
  def new; end

  def create
    user = User.find_by(email: params[:email], role: Settings.roles.admin)
    if user&.authenticate(params[:password])
      handle_successful_login(user)
    else
      handle_failed_login
    end
  end

  def destroy
    log_out
    redirect_to admin_login_path
  end

  def handle_successful_login user
    reset_session
    log_in user
    flash[:success] = t "flash.login.success"
    redirect_to admin_root_path
  end

  def handle_failed_login
    flash.now[:danger] = t "flash.login.error"
    render :new, status: :unprocessable_entity
  end
end
