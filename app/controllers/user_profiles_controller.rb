class UserProfilesController < ApplicationController
  before_action :logged_in_user
  def update
    @user_profile = current_user.user_profile

    update_method = determine_update_method

    send(update_method) if update_method
  end

  def add_skill
    @user_profile = current_user.user_profile
    @index = @user_profile.skills.size
    respond_to(&:turbo_stream)
  end

  def remove_skill
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("skill-#{params[:skill_id]}")
      end
    end
  end

  private

  def format_skills skills
    skills.values.each_with_object({}) do |skill, result|
      result[skill["key"]] = skill["value"]
    end
  end

  def determine_update_method
    return :update_cv if params[:cv_file].present?
    return :update_bio if params[:bio].present?

    :update_skills if params[:skills].present?
  end

  def update_cv
    @user_profile.cv_file.attach(params[:cv_file])
    flash[:success] = t "flash.update_profile.update_cv_success"
    redirect_to user_path(id: current_user.id)
  end

  def update_bio
    @user_profile.bio = params[:bio]
    if @user_profile.save
      flash[:success] = t "flash.update_profile.update_bio_success"
      redirect_to user_path(id: current_user.id)
    else
      flash.now[:alert] = "flash.error"
      render "users/show"
    end
  end

  def update_skills
    if @user_profile.update(skills: format_skills(params[:skills]))
      flash[:success] = t "flash.update_profile.update_skills_success"
      redirect_to user_path(id: current_user.id)
    else
      flash.now[:alert] = "flash.error"
      render "users/show"
    end
  end
end
