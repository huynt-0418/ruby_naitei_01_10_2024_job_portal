class HomeController < ApplicationController
  def index
    @latest_jobs = Job.order(created_at: :desc).limit(4)
  end
end
