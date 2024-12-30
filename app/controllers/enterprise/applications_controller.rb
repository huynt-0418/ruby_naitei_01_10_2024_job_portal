class Enterprise::ApplicationsController < ApplicationController
  layout "enterprise"

  def index
    applications = current_user.company.applications.order(created_at: :desc)

    @pagy, @applications = pagy(applications, limit: Settings.apply.page_size)
  end

  def show
    @application = current_user.company.applications.find_by(id: params[:id])
    return if @application.present?

    flash[:danger] = t("enterprise.applications.not_found")
    redirect_to enterprise_applications_path
  end
end
