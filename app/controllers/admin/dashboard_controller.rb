class Admin::DashboardController < ApplicationController
  layout "admin"
  def index
    redirect_to admin_login_path unless logged_in?
    @jobs = Job.pending
  end
end
