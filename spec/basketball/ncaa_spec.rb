require 'spec_helper'

describe SportsDirect::Basketball::NCAA do
  context ".schedule" do
    it "returns an array of events" do
      use_cached_requests(:basketball_ncaa) do
        subject.schedule.should have(3_496).events
      end
    end
  end
end
