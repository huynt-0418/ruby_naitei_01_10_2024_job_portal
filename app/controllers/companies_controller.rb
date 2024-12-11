class CompaniesController < ApplicationController
  def index
    @pagy, @companies = pagy(
      Company.search(params[:query]),
      limit: Settings.company.page_size
    )

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end
end
