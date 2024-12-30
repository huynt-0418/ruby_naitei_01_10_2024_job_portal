class Enterprise::InterviewProcessesController < ApplicationController
  before_action :set_application

  def create
    @interview_process = @application.interview_processes
                                     .build(interview_process_params)
    if @interview_process.save
      flash[:success] = t("flash.interview.create_success")
    else
      flash[:danger] = t("flash.interview.create_error")
    end
    redirect_to enterprise_application_path(id: @application.id)
  end

  def update
    @interview_process = @application.interview_processes.find(params[:id])
    if @interview_process.update(interview_process_params)
      flash[:success] = t("flash.interview.update_success")
    else
      flash[:danger] = t("flash.interview.update_error")
    end
    redirect_to enterprise_application_path(id: @application.id)
  end

  def destroy
    @interview_process = @application.interview_processes.find(params[:id])
    if @interview_process.destroy
      flash[:success] = t("flash.interview.delete_success")
    else
      flash[:danger] = t("flash.interview.delete_error")
    end
    redirect_to enterprise_application_path(id: @application.id)
  end

  private

  def set_application
    @application = current_user.company.applications
                               .find(params[:application_id])
  end

  def interview_process_params
    params.require(:interview_process).permit(
      :stage_number, :stage_type, :interview_time, :interview_location,
      :interview_type, :interviewer_name, :status, :feedback, :rating, :result
    )
  end
end
