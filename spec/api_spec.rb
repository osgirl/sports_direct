require 'spec_helper'

describe SportsDirect::API do
  let(:api) { SportsDirect::API }

  shared_examples_for "an API call" do
    it "has a 200 response" do
      subject.code.should == 200
    end

    it "has an XML content type" do
      subject.content_type.should == 'text/xml'
    end
  end

  context ".basketball_nba_schedule" do
    subject do
      use_cached_requests(:basketball_nba) do
        api.basketball_nba_schedule
      end
    end

    it_behaves_like "an API call"
  end

  context ".basketball_nba_teams" do
    subject do
      use_cached_requests(:basketball_nba) do
        api.basketball_nba_teams('2010-2011')
      end
    end

    it_behaves_like "an API call"
  end

  context ".basketball_ncaa_schedule" do
    subject do
      use_cached_requests(:basketball_ncaa) do
        api.basketball_ncaa_schedule
      end
    end

    it_behaves_like "an API call"
  end

  context ".basketball_ncaa_teams" do
    subject do
      use_cached_requests(:basketball_ncaa) do
        api.basketball_ncaa_teams('2010-2011')
      end
    end

    it_behaves_like "an API call"
  end

  context ".hockey_nhl_schedule" do
    subject do
      use_cached_requests(:hockey_nhl) do
        api.hockey_nhl_schedule
      end
    end

    it_behaves_like "an API call"
  end

  context ".hockey_nhl_teams" do
    subject do
      use_cached_requests(:hockey_nhl) do
        api.hockey_nhl_teams('2010-2011')
      end
    end

    it_behaves_like "an API call"
  end
end
