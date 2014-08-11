class Employee < ActiveRecord::Base
  belongs_to(:division)
  has_many :assignments
  has_many :projects, :through => :assignments
end
