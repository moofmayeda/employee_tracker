require 'spec_helper'

describe Employee do
  it "belongs to a division" do
    test_division = Division.create({:name => "test division"})
    test_employee = Employee.create({:name => "test employee", :division_id => test_division.id})
    expect(test_employee.division).to eq test_division
  end

  it "has and belongs to many projects" do
    test_division = Division.create({:name => "test division"})
    test_employee = Employee.create({:name => "Employee", :division_id => test_division.id})
    test_project = Project.create({:name => "Project"})
    test_project.employees << test_employee
    expect(test_employee.projects).to eq [test_project]
  end

  describe "search_by_date" do
    it "returns the projects an employee worked on on that date" do
      test_division = Division.create({:name => "test division"})
      test_employee = Employee.create({:name => "test employee", :division_id => test_division.id})
      aug_test_project = Project.create({:name => "august test project", :start_date => "2014-08-01", :end_date => "2014-09-01"})
      jul_test_project = Project.create({:name => "july test project", :start_date => "2014-07-01", :end_date => "2014-07-31"})
      aug_test_assignment = test_employee.assignments.create({:project_id => aug_test_project.id, :description => "leader"})
      jul_test_assignment = test_employee.assignments.create({:project_id => jul_test_project.id, :description => "leader"})
      expect(test_employee.search_by_date("2014-08-15")).to eq [aug_test_project]
      expect(test_employee.search_by_date("2014-07-15")).to eq [jul_test_project]
    end
  end
end
