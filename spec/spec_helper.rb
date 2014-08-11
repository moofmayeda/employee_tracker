require 'active_record'
require 'employee'
require 'division'
require 'project'
require 'assignment'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Employee.all.each { |employee| employee.destroy }
    Division.all.each { |division| division.destroy }
    Project.all.each { |division| division.destroy }
    Assignment.all.each { |division| division.destroy }
  end
end
