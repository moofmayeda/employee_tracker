require 'active_record'

require './lib/employee'
require './lib/division'
require './lib/project'
require './lib/assignment'

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
    puts "4) View an employee's details"
    puts "5) View a division's projects"
    puts "6) View an employee's assigned projects on a specific day"
    puts "7) Projects menu"
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
      view_employee_projects
    when 5
      view_division_projects
    when 6
      search_by_date
    when 7
      projects_menu
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
  name = gets.chomp.upcase
  puts "Enter the start date (YYYY-MM-DD)"
  start_date = gets.chomp
  puts "Enter the end date (YYYY-MM-DD)"
  end_date = gets.chomp
  new_project = Project.create({:name => name, :start_date => start_date, :end_date => end_date})
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
  puts "Enter the employee's contribution"
  selected_employee.assignments.create({:project_id => selected_project.id, :description => gets.chomp.upcase})
end

def view_employee_projects
  puts "Enter the name of the employee"
  selected_employee = Employee.where({:name => gets.chomp.upcase}).first
  puts selected_employee.name + "\tDIVISION: " + selected_employee.division.name
  puts "PROJECTS:"
  selected_employee.assignments.each do |assignment|
    puts assignment.project.name + ": " + assignment.description
  end
end

def view_project_employees
  view_projects
  puts "Enter the project number"
  selected_project = Project.find(gets.chomp.to_i)
  puts "START DATE: " + selected_project.start_date.to_s + "\tEND DATE: " + selected_project.end_date.to_s
  puts "EMPLOYEES:"
  selected_project.assignments.each do |assignment|
    puts assignment.employee.name + " (" + assignment.employee.division.name + ")\tROLE:" + assignment.description
  end
end

def view_division_projects
  view_divisions
  puts "Enter the division number to view projects"
  selected_division = Division.find(gets.chomp.to_i)
  puts "PROJECTS:"
  selected_division.projects.each {|project| puts project.name}
end

def search_by_date
  puts "Enter the name of the employee"
  selected_employee = Employee.where({:name => gets.chomp.upcase}).first
  puts "Enter the date (YYYY-MM-DD)"
  date = gets.chomp
  selected_employee.search_by_date(date).each do |project|
    puts project.name + "\tSTART: " + project.start_date.to_s + "\tEND: " + project.end_date.to_s
  end
end

def projects_menu
  puts "1) Create a new project"
  puts "2) Assign a project to an employee"
  puts "3) Update dates for a project"
  puts "4) Remove an employee from a project"
  puts "5) View a project's details"
  puts "6) Return to the main menu"
  case gets.chomp.to_i
  when 1
    new_project
  when 2
    assign_project
  when 3
    update_dates
  when 4
    remove_employee_from_project
  when 5
    view_project_employees
  when 6
    welcome
  else
    puts "Enter a valid option"
  end
  projects_menu
end

def update_dates
  view_projects
  puts "Enter the project number"
  selected_project = Project.find(gets.chomp.to_i)
  puts "Enter new start date (YYYY-MM-DD)"
  selected_project.update(:start_date => gets.chomp)
  puts "Enter new end date (YYYY-MM-DD)"
  selected_project.update(:end_date => gets.chomp)
  puts "Successfully updated!"
end

def remove_employee_from_project
  view_projects
  puts "Enter the project number"
  project_id = gets.chomp.to_i
  puts "Enter the name of the employee"
  selected_employee = Employee.where({:name => gets.chomp.upcase}).first
  Assignment.where(:project_id => project_id, :employee_id => selected_employee.id).destroy_all
end

welcome

