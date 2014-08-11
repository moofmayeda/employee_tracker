require 'active_record'

require './lib/employee'
require './lib/division'
require './lib/project'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "EMPLOYEE TRACKER"
  choice = nil
  until choice == 10
    puts "1) Create a new employee"
    puts "2) Create a new division"
    puts "3) View all employees in a division"
    puts "4) Create a new project"
    puts "5) Assign a project to an employee"
    puts "6) View an employee's projects"
    puts "7) View a project's employees"
    puts "10) Exit"
    choice = gets.chomp.to_i
    case choice
    when 1
      new_employee
    when 2
      new_division
    when 3
      view_employees
    when 4
      new_project
    when 5
      assign_project
    when 6
      view_employee_projects
    when 7
      view_project_employees
    else
      puts "Enter a valid option"
    end
  end
end

def new_employee
  view_divisions
  puts "Enter the new employee's division number"
  selected_division = Division.find(gets.chomp.to_i)
  puts "Enter the new employee's name"
  selected_division.employees.new({:name => gets.chomp.upcase})
  selected_division.save
  puts "Successfully added!"
end

def new_division
  puts "Enter the new division name"
  new_division = Division.new({:name => gets.chomp.upcase})
  new_division.save
  puts "Successfully added!"
end

def view_divisions
  puts "DIVISIONS:"
  divisions = Division.all
  divisions.each {|division| puts division.id.to_s + ") " + division.name}
end

def view_employees
  view_divisions
  puts "Enter the division number to view employees"
  selected_division = Division.find(gets.chomp.to_i)
  selected_division.employees.each do |employee|
    puts employee.id.to_s + ") " + employee.name
  end
end

def new_project
  puts "Enter the new project name"
  new_project = Project.new({:name => gets.chomp.upcase})
  new_project.save
  puts "Successfully added!"
end

def view_projects
  puts "PROJECTS:"
  Project.all.each {|project| puts project.id.to_s + ") " + project.name}
end

def assign_project
  view_projects
  puts "Enter the project number you want to assign"
  selected_project = Project.find(gets.chomp.to_i)
  puts "Enter the name of the employee"
  selected_employee = Employee.where({:name => gets.chomp.upcase}).first
  selected_project.employees << selected_employee
end

def view_employee_projects
  puts "Enter the name of the employee"
  selected_employee = Employee.where({:name => gets.chomp.upcase}).first
  selected_employee.projects.each {|project| puts project.name}
end

def view_project_employees
  view_projects
  puts "Enter the project number"
  selected_project = Project.find(gets.chomp.to_i)
  puts "EMPLOYEES"
  selected_project.employees.each {|employee| puts employee.name + employee.division}
end

welcome

