class Job < ApplicationRecord
  belongs_to :company
  has_many :applications, dependent: :destroy
  has_many :applicants, through: :applications, source: :user

  enum work_type: {remote: 0, office: 1, hybrid: 2, oversea: 3}
  enum status: {draft: 0, pending: 1, active: 2, closed: 3}

  scope :filter_by_work_type, lambda {|work_types|
    where(work_type: work_types) if work_types.present?
  }

  scope :filter_by_location, lambda {|locations|
    return if locations.blank?

    target_locations = Settings.jobs.filter_locations
    locations = Array(locations)

    if locations.include?("others")
      if locations.size == 1
        where.not(location: target_locations)
      else
        where.not(location: target_locations - locations)
      end
    else
      where(location: locations)
    end
  }

  scope :search_by_keyword, lambda {|keyword|
    return if keyword.blank?

    where(
      "LOWER(jobs.title) LIKE :keyword OR " \
      "LOWER(jobs.description) LIKE :keyword OR " \
      "LOWER(companies.name) LIKE :keyword",
      keyword: "%#{keyword.downcase}%"
    ).joins(:company)
  }
end
