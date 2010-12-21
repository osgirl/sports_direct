module SportsDirect
  module Baseball
    class MLB
      include Normalization

      def schedule
        (API.baseball_mlb_schedule / 'competition').collect do |event|
          normalize_event(event)
        end
      end

      def teams
        API.baseball_mlb_teams('2011') / 'team'
      end
      private :teams

      def team_name(id)
        id = id.split(':').last.to_i if id.is_a?(String)
        team_names[id]
      end
      private :team_name

      def team_names
        @team_names ||= Hash[teams.collect do |team|
          name = team.at('name').text
          nick = team.at('name[@type="nick"]/text()').to_s
          full_name = normalize_performer_name("#{name} #{nick}")

          [team.at('id').text.split(':').last.to_i, full_name]
        end]
      end
      private :team_names

      def normalize_event(event)
        details = event.at('details')
        venue = details.at('venue')
        locality = venue.at('location/city').text
        region = venue.at('location/state').try(:text)
        home_name = team_name(event.at('home-team-content/team/id').text)
        away_name = team_name(event.at('away-team-content/team/id').text)
        event_name = "#{home_name} vs. #{away_name}"

        if details.at('competition-type').text != 'Regular Season'
          event_name = "#{details.at('competition-type').text}: #{event_name}"
        end

        {
          :id => event.at('id').text.split(':').last,
          :event_name => event_name,
          :occurs_at => normalize_date(
            event.at('start-date').text,
            event.at('timezone').text,
            locality,
            region
          ),
          :occurs_at_utc => normalize_date(
            event.at('start-date').text,
            event.at('timezone').text,
            locality,
            region,
            true
          ),
          :tbd => details.at('date-tbd').text == 'true',
          :venue_name => normalize_venue_name(venue.at('name').text),
          :locality => locality,
          :region => normalize_region(region.to_s),
          :country => venue.at('location/country').text,
          :home_name => home_name,
          :away_name => away_name
        }
      end
      private :normalize_event

      def normalize_performer_name(name)
        name = name.split.uniq.join(' ')
        name.sub!(/\bChi\./, 'Chicago')
        name.sub!(/\bLA\b/, 'Los Angeles')
        name.sub!(/\bNY\b/, 'New York')
        name.strip!
        name.split.select { |word| word.length > 1 }.join(' ')
      end
      private :normalize_performer_name
    end
  end
end
