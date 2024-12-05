class JobsController < ApplicationController
  def index
    jobs = Job
           .filter_by_work_type(params[:work_type])
           .search_by_keyword(params[:keyword])
           .filter_by_location(params[:location])

    @pagy, @jobs = pagy(jobs, limit: Settings.jobs.page_size)
  end
end
