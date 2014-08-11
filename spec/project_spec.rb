require 'spec_helper'

describe Project do
  it "has and belongs to many employees" do
    test_division = Division.create({:name => "test division"})
    test_employee = Employee.create({:name => "test employee", :division_id => test_division.id})
    test_project = Project.create({:name => test_project})
    test_employee.projects << test_project
    expect(test_project.employees).to eq [test_employee]
  end

  it "can update its own dates" do
    test_project = Project.create({:name => test_project})
    test_project.update(:start_date => "2014-08-01")
    test_project.update(:end_date => "2014-09-01")
    expect(test_project.start_date.to_s).to eq "2014-08-01"
  end
end
