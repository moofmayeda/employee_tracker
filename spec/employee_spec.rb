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
end
