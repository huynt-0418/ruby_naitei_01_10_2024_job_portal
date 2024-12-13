class UsersController < ApplicationController
  before_action :load_user_data, :logged_in_user

  def show
    @user_project = UserProject.new
    @applications = current_user.applications.recent
  end

  def update
    if @user.update(user_params)
      flash[:success] = t "user.success_update"
      redirect_to user_path(id: @user.id)
    else
      flash.now[:danger] = t "views.users.fail_update_message"
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit User::PERMITTED_PARAMS
  end

  def load_user_data
    @user = current_user
    @profile = current_user.user_profile
    @projects = @profile.user_projects
    @social_links = current_user.user_social_links
  end
end
