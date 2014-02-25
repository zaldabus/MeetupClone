module RootsHelper
  def date(date)
    date = date.split("-").map(&:to_i)
    DateTime.new(date[0], date[1], date[2])
      .strftime("%a, %B %d %Y")
  end
end
