module Enterprise::JobHelper
  def work_type_options
    Job.work_types.keys.map{|key| [key.humanize, key]}
  end

  def status_options
    Job.statuses.keys.map{|key| [key.humanize, key]}
  end
end
