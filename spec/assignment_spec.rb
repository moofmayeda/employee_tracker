require 'spec_helper'

describe Assignment do
  it "tracks an employee's contribution to a project" do
    test_division = Division.create({:name => "test division"})
    test_employee = Employee.create({:name => "test employee", :division_id => test_division.id})
    test_project = Project.create({:name => test_project})
    test_assignment = test_employee.assignments.create({:project_id => test_project.id, :description => "leader"})
    expect(test_project.employees).to eq [test_employee]
    expect(test_assignment.description).to eq "leader"
  end
end
