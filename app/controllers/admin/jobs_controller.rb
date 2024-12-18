class Admin::JobsController < ApplicationController
  def update
    @job = Job.find(params[:id])
    if @job.update(status: params[:status])
      flash[:success] = t "flash.jobs.update_success"
      redirect_to admin_root_path
    else
      render "admin/dashboard/index"
    end
  end
end
