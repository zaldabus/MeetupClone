module GroupsHelper
  def time_since(date)
    if (Time.now - date).to_i / 1.day > 30
      time = (Time.now - time).to_i / 1.month
      months = "month".pluralize(time)

      "#{time} #{months} ago"
    else
      time = (Time.now - time).to_i / 1.day
      days = "day".pluralize(time)

      "#{time} #{days} ago"
    end
  end
end
