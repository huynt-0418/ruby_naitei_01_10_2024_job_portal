class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  include SessionsHelper
  include Pagy::Backend

  def switch_language
    if params[:locale].present? &&
       I18n.available_locales.include?(params[:locale].to_sym)
      session[:locale] = params[:locale]
    end
    redirect_to request.referer || root_path
  end

  private
  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "views.flash.please_log_in"
    redirect_to login_url
  end
end
