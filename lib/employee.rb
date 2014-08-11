class Employee < ActiveRecord::Base
  belongs_to(:division)
  has_many :assignments
  has_many :projects, :through => :assignments

  def search_by_date(date)
    self.projects.where("? BETWEEN start_date AND end_date", [date])
  end
end
