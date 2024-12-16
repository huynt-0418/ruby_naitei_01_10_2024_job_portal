class Enterprise::DashboardController < ApplicationController
  layout "enterprise"

  def index
    candidates = User.with_role(:user)
                     .search(params[:search])
                     .sort_by_param(params[:sort_by])
    @pagy, @candidates = pagy(candidates,
                              limit: Settings.enterprise_scout.page_size)
  end
end
