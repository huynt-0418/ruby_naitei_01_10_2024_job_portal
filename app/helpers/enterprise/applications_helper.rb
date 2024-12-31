module Enterprise::ApplicationsHelper
  def bootstrap_status_class status
    case status.to_s
    when "pending" then "bg-warning text-dark"
    when "canceled" then "bg-secondary"
    when "reviewing" then "bg-info"
    when "interviewing" then "bg-primary"
    when "accepted" then "bg-success"
    when "rejected" then "bg-danger"
    else "bg-light text-dark"
    end
  end

  def bootstrap_status_class_for_interview_process status
    case status.to_s
    when "pending" then "bg-warning text-dark"
    when "canceled" then "bg-secondary"
    when "scheduled" then "bg-primary"
    when "completed" then "bg-success"
    when "rescheduled" then "bg-info"
    else "bg-light text-dark"
    end
  end

  def bootstrap_result_class result
    case result.to_s
    when "pass" then "bg-success"
    when "fail" then "bg-danger"
    when "waiting" then "bg-warning text-dark"
    else "bg-light text-dark"
    end
  end

  def stage_type_options
    InterviewProcess.stage_types.keys.map{|type| [type.humanize, type]}
  end

  def interview_type_options
    InterviewProcess.interview_types.keys.map{|type| [type.humanize, type]}
  end

  def application_status_options
    Application.statuses.keys.map{|s| [s.humanize, s]}
  end

  def interview_process_status_options
    InterviewProcess.statuses.keys.map{|s| [s.humanize, s]}
  end

  def interview_process_result_options
    InterviewProcess.results.keys.map{|s| [s.humanize, s]}
  end
end
