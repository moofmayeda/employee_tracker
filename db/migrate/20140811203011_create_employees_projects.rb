class CreateEmployeesProjects < ActiveRecord::Migration
  def change
    create_table :employees_projects, id: false do |t|
      t.belongs_to :employee
      t.belongs_to :project

      t.timestamps
    end

    remove_column :projects, :employee_id, :integer
  end
end
