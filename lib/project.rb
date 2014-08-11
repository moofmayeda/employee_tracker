class Project < ActiveRecord::Base
  has_many :assignments
  has_many :employees, :through => :assignments
end
