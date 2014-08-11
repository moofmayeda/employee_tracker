class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.belongs_to :project
      t.belongs_to :employee
      t.string :description
      t.timestamps
    end

    drop_table :employees_projects
  end
end
