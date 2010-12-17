require 'spec_helper'

describe SportsDirect::Hockey::NHL do
  context ".schedule" do
    it "returns an array of events" do
      use_cached_requests(:hockey_nhl) do
        subject.schedule.should have(762).events
      end
    end
  end
end
