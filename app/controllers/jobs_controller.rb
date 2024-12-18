class JobsController < ApplicationController
  def index
    jobs = Job
           .filter_by_work_type(params[:work_type])
           .search_by_keyword(params[:keyword])
           .filter_by_location(params[:location])
           .active

    @pagy, @jobs = pagy(jobs, limit: Settings.jobs.page_size)
  end

  def show
    @job = Job.find_by id: params[:id]

    if @job.nil?
      flash[:danger] = t "jobs.job_not_found"
      redirect_to root_path
    else
      @related_jobs = Job.related_jobs(@job)
    end
  end
end
