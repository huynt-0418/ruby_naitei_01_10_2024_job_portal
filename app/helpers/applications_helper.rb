module ApplicationsHelper
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

  def bootstrap_result_class result
    case result.to_s
    when "pass" then "bg-success"
    when "fail" then "bg-danger"
    when "waiting" then "bg-warning text-dark"
    else "bg-light text-dark"
    end
  end
end
