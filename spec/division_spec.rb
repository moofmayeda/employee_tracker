require 'spec_helper'

describe Division do
  it "has many employees" do
    test_division = Division.create({:name => "test division"})
    test_division2 = Division.create({:name => "test division 2"})
    employee1 = Employee.create({:name => "Employee 1", :division_id => test_division.id})
    employee2 = Employee.create({:name => "Employee 2", :division_id => test_division2.id})
    expect(test_division.employees).to eq [employee1]
  end
end
