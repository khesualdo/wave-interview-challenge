module Api
  module V1
    class TimeReportDetailsController < ApplicationController
      def index
        employee_reports = []

        if TimeReportDetail.count > 0
          employee_ids = TimeReportDetail.order(:employee_id).distinct.pluck(:employee_id)

          dates = TimeReportDetail.order(:date).distinct.pluck(:date)
          start_year = dates.first.year
          end_year = dates.last.year

          employee_ids.each do |employee_id|
            wage = TimeReportDetail.find_by(employee_id: employee_id).job_group == "A" ? 20 : 30
            for year in start_year..end_year do
              for month in 1..12 do
                startDay = 1
                endDay = 15
                first_half = TimeReportDetail.where(employee_id: employee_id, date: DateTime.new(year, month, startDay)..DateTime.new(year, month, endDay))
                employee_reports << create_employee_report(first_half, employee_id, year, month, startDay, endDay, wage) if first_half.size > 0

                startDay = 16
                endDay = Time.days_in_month(month, year)
                second_half = TimeReportDetail.where(employee_id: employee_id, date: DateTime.new(year, month, startDay)..DateTime.new(year, month, endDay))
                employee_reports << create_employee_report(second_half, employee_id, year, month, startDay, endDay, wage) if second_half.size > 0
              end
            end
          end
        end

        render json: create_payroll_report(employee_reports)
      rescue
        render json: { error: "Error while processing your request." }, status: 400
      end

      private

      def create_payroll_report (employee_reports)
        return {
          payrollReport: {
            employeeReports: employee_reports
          }
        }
      end

      def create_employee_report (time_report_details, employee_id, year, month, startDay, endDay, wage)
        amount_paid = 0
        time_report_details.each do |time_report_detail|
          amount_paid += time_report_detail.hours_worked * wage
        end

        employee_report = {}
        employee_report[:employeeId] = employee_id
        employee_report[:payPeriod] = {
          startDate: DateTime.new(year, month, startDay).strftime("%F"),
          endDate: DateTime.new(year, month, endDay).strftime("%F")
        }
        employee_report[:amountPaid] = "$#{"%.2f" % amount_paid}"

        return employee_report
      end
    end
  end
end
