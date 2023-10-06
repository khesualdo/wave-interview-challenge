require 'rails_helper'

RSpec.describe "Api::V1::TimeReportsController", type: :request do
  describe "POST /api/v1/time_reports" do
    it "works" do
      file = fixture_file_upload("time-report-1.csv", "text/csv")

      post api_v1_time_reports_path, params: { time_report: file }

      expect(response).to have_http_status(204)
    end

    describe "when something goes wrong" do
      it "sends a 400" do
        file = fixture_file_upload("time-report-1.csv", "text/csv")

        allow(CSV).to receive(:parse).and_raise(StandardError)

        post api_v1_time_reports_path, params: { time_report: file }

        expect(response).to have_http_status(400)
      end

      it "sends an error message" do
        error_message = {
          "error" => "Error while processing your request."
        }

        file = fixture_file_upload("time-report-1.csv", "text/csv")

        allow(CSV).to receive(:parse).and_raise(StandardError)

        post api_v1_time_reports_path, params: { time_report: file }

        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)).to eq(error_message)
      end
    end

    describe "when importing a file with same id" do
      it "sends a 400" do
        file = fixture_file_upload("time-report-1.csv", "text/csv")

        post api_v1_time_reports_path, params: { time_report: file }

        expect(response).to have_http_status(204)

        post api_v1_time_reports_path, params: { time_report: file }

        expect(response).to have_http_status(400)
      end

      it "sends an error message" do
        error_message = {
          "error" => "Time report id already exists. Time report id must be unique."
        }

        file = fixture_file_upload("time-report-1.csv", "text/csv")

        post api_v1_time_reports_path, params: { time_report: file }

        expect(response).to have_http_status(204)

        post api_v1_time_reports_path, params: { time_report: file }

        expect(response).to have_http_status(400)
        expect(JSON.parse(response.body)).to eq(error_message)
      end
    end

    describe "when a well-formatted file is uploaded" do
      it "creates a TimeReport" do
        file = fixture_file_upload("time-report-1.csv", "text/csv")

        expect { post api_v1_time_reports_path, params: { time_report: file } }.to change {
          TimeReport.count
        }.by(1)
      end

      it "creates TimeReportsDetails" do
        file = fixture_file_upload("time-report-1.csv", "text/csv")

        expect { post api_v1_time_reports_path, params: { time_report: file } }.to change {
          TimeReportDetail.count
        }.by(1)
      end
    end
  end
end
