class CreateTimeReports < ActiveRecord::Migration[7.0]
  def change
    create_table :time_reports do |t|
      t.integer :time_report_id

      t.timestamps
    end
    add_index :time_reports, :time_report_id, unique: true
  end
end
