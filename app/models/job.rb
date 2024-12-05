class Job < ApplicationRecord
  belongs_to :company
  has_many :applications, dependent: :destroy
  has_many :applicants, through: :applications, source: :user

  enum work_type: {Remote: 0, Office: 1, Hybrid: 2, Oversea: 3}
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

  scope :related_jobs, lambda {|job|
    where.not(id: job.id)
         .where(company_id: job.company_id)
         .limit(Settings.jobs.related_jobs_size)
  }
end
