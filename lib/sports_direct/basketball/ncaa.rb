require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/inflections'

module SportsDirect
  module Basketball
    class NCAA
      include Normalization

      def schedule
        (API.ncaa_basketball_schedule / 'competition').collect do |event|
          normalize_event(event)
        end
      end

      def teams
        API.ncaa_basketball_teams('2010-2011') / 'team'
      end
      private :teams

      def team_name(id)
        id = id.split(':').last.to_i if id.is_a?(String)
        team_names[id]
      end
      private :team_name

      def team_names
        @team_names ||= Hash[teams.collect do |team|
          name = normalize_performer_name(team.at('name').text)
          nick = team.at('name[@type="nick"]/text()').to_s

          [team.at('id').text.split(':').last.to_i, "#{name} #{nick}"]
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
        sport = "Mens #{event.at('id').text.split('/')[2].titleize}"

        name = if details.at('competition-type').text == 'Regular Season'
          "#{home_name} #{sport} vs. #{away_name} #{sport}"
        else
          details.at('competition-type').text
        end

        {
          :id => event.at('id').text.split(':').last,
          :sport => sport,
          :event_name => name,
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
        name.gsub!(/&amp;/, '&')
        name.gsub!(/-/, ' ')
        name.gsub!(/\((.*)\)/, '\1')
        name.gsub!(/\s+/, ' ')
        name.sub!(/Col\./, 'College')
        name.sub!(/Conn\./, 'Connecticut')
        name.sub!(/Miami\s+Florida/, 'Miami Hurricanes')
        name.sub!(/N\.?C\.? (Asheville|Greensboro|Wilmington)/, 'UNC \1')
        name.sub!(/N\.C\./, 'North Carolina')
        name.sub!(/N\.Y\./, 'NY')
        name.sub!(/No\.Carolina/, 'North Carolina')
        name.sub!(/St\.$/, 'State')
        name.sub!(/Wis\./, 'Wisconsin')
        name.sub!(/\bCC$/, 'Corpus Christi')
        name.sub!(/\bCty\b/, 'County')
        name.sub!(/\bSE\b/, 'Southeast')
        name.sub!(/\bU(\.|\b|$)/, 'University')
        name.gsub!(/[\.']/, '')
        name.strip!
        name.split.select { |word| word.length > 1 }.join(' ')
      end
      private :normalize_performer_name
    end
  end
end
