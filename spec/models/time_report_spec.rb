require 'rails_helper'

RSpec.describe TimeReport, type: :model do
  describe "creating reports" do
    describe "with same id" do
      it "raises ActiveRecord::RecordNotUnique" do
        time_report_id = 111
        FactoryBot.create(:time_report, time_report_id: time_report_id)
        expect { FactoryBot.create(:time_report, time_report_id: time_report_id) }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
end
