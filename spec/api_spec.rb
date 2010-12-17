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

  context ".nba_basketball_schedule" do
    subject do
      use_cached_requests(:basketball_nba) do
        api.nba_basketball_schedule
      end
    end

    it_behaves_like "an API call"
  end

  context ".nba_basketball_teams" do
    subject do
      use_cached_requests(:basketball_nba) do
        api.nba_basketball_teams('2010-2011')
      end
    end

    it_behaves_like "an API call"
  end

  context ".ncaa_basketball_schedule" do
    subject do
      use_cached_requests(:basketball_ncaa) do
        api.ncaa_basketball_schedule
      end
    end

    it_behaves_like "an API call"
  end

  context ".ncaa_basketball_teams" do
    subject do
      use_cached_requests(:basketball_ncaa) do
        api.ncaa_basketball_teams('2010-2011')
      end
    end

    it_behaves_like "an API call"
  end

  context ".nhl_hockey_schedule" do
    subject do
      use_cached_requests(:hockey_nhl) do
        api.nhl_hockey_schedule
      end
    end

    it_behaves_like "an API call"
  end

  context ".nhl_hockey_teams" do
    subject do
      use_cached_requests(:hockey_nhl) do
        api.nhl_hockey_teams('2010-2011')
      end
    end

    it_behaves_like "an API call"
  end
end
