module Enterprise::DashboardHelper
  def sort_options
    [
      [t("enterprise.scout.select_sorter"), ""],
      [t("enterprise.scout.name_asc"), "name"],
      [t("enterprise.scout.name_desc"), "name_desc"],
      [t("enterprise.scout.age_asc"), "age"],
      [t("enterprise.scout.age_desc"), "age_desc"]
    ]
  end

  def avatar_url_for user
    if user.avatar.attached?
      url_for(user.avatar)
    else
      "https://via.placeholder.com/80"
    end
  end
end
