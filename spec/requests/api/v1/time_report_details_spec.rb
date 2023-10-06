require 'rails_helper'

RSpec.describe "Api::V1::TimeReportDetailsController", type: :request do
  describe "GET /api/v1/time_report_details" do
    it "works" do
      get api_v1_time_report_details_path

      expect(response).to have_http_status(200)
    end

    describe "when something goes wrong" do
      it "sends a 400" do
        allow(TimeReportDetail).to receive(:count).and_raise(StandardError)

        get api_v1_time_report_details_path

        expect(response).to have_http_status(400)
      end

      it "sends an error message" do
        error_message = {
          "error" => "Error while processing your request."
        }

        allow(TimeReportDetail).to receive(:count).and_raise(StandardError)

        get api_v1_time_report_details_path

        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)).to eq(error_message)
      end
    end

    describe "when there are no TimeReportDetails" do
      it "sends an empty payroll report" do
        payroll_report = {
          "payrollReport" => {
            "employeeReports" => []
          }
        }

        get api_v1_time_report_details_path

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq(payroll_report)
      end
    end

    describe "when there are TimeReportDetails" do
      it "sends a payroll report with data" do
        time_report = FactoryBot.create(:time_report)

        FactoryBot.create(
          :time_report_detail, 
          time_report: time_report,
          date: DateTime.new(2022, 1, 1),
          hours_worked: 7.5,
          employee_id: "1",
          job_group: "A"
        )

        payroll_report = {
          "payrollReport" => {
            "employeeReports" => [
              {
                "amountPaid"=>"$150.00",
                "employeeId"=>"1",
                "payPeriod"=>{
                  "endDate"=>"2022-01-15",
                  "startDate"=>"2022-01-01"
                }
              }
            ]
          }
        }
  
        get api_v1_time_report_details_path

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq(payroll_report)
      end
    end
  end
end
