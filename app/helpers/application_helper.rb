module ApplicationHelper
  include Pagy::Frontend

  def locations_options
    locations.map{|loc| [t(loc[:key]), loc[:value]]}
  end
end
