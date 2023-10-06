class CreateTimeReportDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :time_report_details do |t|
      t.belongs_to :time_report, null: false, foreign_key: true
      t.datetime :date
      t.float :hours_worked
      t.string :employee_id
      t.string :job_group

      t.timestamps
    end
  end
end
