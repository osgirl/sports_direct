require 'spec_helper'

describe SportsDirect::Baseball::MLB do
  context ".schedule" do
    it "returns an array of events" do
      use_cached_requests(:baseball_mlb) do
        subject.schedule.should have(2_430).events
      end
    end
  end
end
