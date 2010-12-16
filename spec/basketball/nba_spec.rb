require 'spec_helper'

describe SportsDirect::Basketball::NBA do
  context ".schedule" do
    it "returns an array of events" do
      use_cached_requests(:basketball_nba) do
        subject.schedule.should have(854).events
      end
    end
  end
end
