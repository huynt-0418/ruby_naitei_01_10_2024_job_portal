class UserProjectsController < ApplicationController
  before_action :load_project, only: [:update, :destroy]
  before_action :load_user_data

  def create
    @user_project = current_user.user_projects.build(project_params)

    respond_to do |format|
      if @user_project.save
        handle_success(format)
      else
        handle_failure(format)
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        flash[:success] = t "flash.update_project.success"
        format.turbo_stream
        format.html{redirect_to user_path(current_user)}
      else
        flash.now[:danger] = t "flash.update_project.failed"
        format.html{render "users/show"}
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.turbo_stream
      flash.now[:success] = t "flash.delete_project.success"
      format.html{redirect_to user_path(current_user)}
    end
  end

  private

  def load_project
    @project = current_user.user_projects.find(params[:id])
    return if @project.present?

    flash[:danger] = t "flash.project_not_found"
    redirect_to user_path(id: current_user.id)
  end

  def project_params
    if params[:user_project][:technologies_used].is_a?(String)
      params[:user_project][:technologies_used] =
        JSON.parse(params[:user_project][:technologies_used])
    end
    params.require(:user_project).permit(UserProject::PERMITTED_PARAMS)
  end

  def load_user_data
    @user = current_user
    @profile = current_user.user_profile
    @projects = @profile.user_projects
    @social_links = current_user.user_social_links
  end

  def handle_success format
    flash[:success] = t "flash.create_project.success"
    format.turbo_stream
    format.html{redirect_to user_path(current_user)}
  end

  def handle_failure format
    flash.now[:danger] = t "flash.create_project.failed"
    format.html{render "users/show"}
  end
end
