require 'spec_helper'

describe SportsDirect::Basketball::NCAA do
  context ".schedule" do
    it "returns an array of events" do
      subject.schedule.should have(3_520).events
    end
  end
end
