class Division < ActiveRecord::Base
  has_many(:employees)
  has_many :assignments, through: :employees
  has_many :projects, through: :assignments
end
