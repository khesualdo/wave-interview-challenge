module Api
  module V1
    class TimeReportsController < ApplicationController
      require "csv"

      def create
        file_param = params[:time_report]
        filename = file_param.original_filename
        time_report_id = filename[0...-4].split("-")[2].to_i

        new_time_report = TimeReport.create!({ time_report_id: time_report_id })

        file = File.open(file_param)
        csv = CSV.parse(file, headers: true)
        csv.each do |row|
          report_details_hash = {}
          report_details_hash[:time_report] = new_time_report

          date = row["date"].split("/")
          report_details_hash[:date] = DateTime.new(date[2].to_i, date[1].to_i, date[0].to_i)

          report_details_hash[:hours_worked] = row["hours worked"].to_f
          report_details_hash[:employee_id] = row["employee id"]
          report_details_hash[:job_group] = row["job group"]
          TimeReportDetail.create!(report_details_hash)
        end
      rescue ActiveRecord::RecordNotUnique
        render json: { error: "Time report id already exists. Time report id must be unique." }, status: 400
      rescue
        render json: { error: "Error while processing your request." }, status: 400
      end
    end
  end
end
