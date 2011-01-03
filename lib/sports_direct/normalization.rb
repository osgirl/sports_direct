require 'active_support/core_ext/time/calculations'
require 'active_support/core_ext/time/conversions'
require 'active_support/core_ext/time/zones'

Time.zone = 'UTC'

module SportsDirect
  module Normalization
    def normalize_venue_name(name)
      name.gsub!(/&amp;/, '&')
      name.gsub!(/-/, ' ')
      name.gsub!(/\((.*)\)/, '\1')
      name.gsub!(/[\.']/, '')
      name.gsub!(/\bThe\b/, '')
      name.gsub!(/\s+/, ' ')
      name.sub!(/\bMountian\b/, 'Mountain')
      name.strip!
      name.split.select { |word| word.length > 1 }.join(' ')
    end
    private :normalize_venue_name

    def normalize_date(date, zone, locality, region, utc=false)
      time_zone = {
        'America/St_Thomas' => 'Atlantic Time (Canada)',
        'Canada/Atlantic' => 'Atlantic Time (Canada)',
        'Canada/Central' => 'Central Time (US & Canada)',
        'Canada/Eastern' => 'Eastern Time (US & Canada)',
        'Canada/Mountain' => 'Mountain Time (US & Canada)',
        'Canada/Newfoundland' => 'Newfoundland',
        'Canada/Pacific' => 'Pacific Time (US & Canada)',
        'EST' => 'Eastern Time (US & Canada)',
        'Etc/GMT+12' => nil,
        'US/Alaska' => 'Alaska',
        'US/Arizona' => 'Arizona',
        'US/Central' => 'Central Time (US & Canada)',
        'US/Eastern' => 'Eastern Time (US & Canada)',
        'US/Hawaii' => 'Hawaii',
        'US/Mountain' => 'Mountain Time (US & Canada)',
        'US/Pacific' => 'Pacific Time (US & Canada)'
      }[zone]

      unless time_zone
        time_zone = {
          ['Abilene', 'Texas'] => 'Central Time (US & Canada)',
          ['Monticello', 'Arkansas'] => 'Central Time (US & Canada)',
          ['Seaside', 'California'] => 'Pacific Time (US & Canada)',
          ['Vermillion', 'South Dakota'] => 'Central Time (US & Canada)'
        }[[locality, region]]
      end

      time = Time.zone.parse(date).in_time_zone(time_zone)

      utc ? time : Time.zone.parse(time.to_s.split.first(2).join(' '))
    end
    private :normalize_date

    def normalize_region(region)
      map = {
        # US states
        'Alabama' => 'AL',
        'Alaska' => 'AK',
        'Arizona' => 'AZ',
        'Arkansas' => 'AR',
        'California' => 'CA',
        'Colorado' => 'CO',
        'Connecticut' => 'CT',
        'Delaware' => 'DE',
        'District of Columbia' => 'DC',
        'Florida' => 'FL',
        'Georgia' => 'GA',
        'Hawaii' => 'HI',
        'Idaho' => 'ID',
        'Illinois' => 'IL',
        'Indiana' => 'IN',
        'Iowa' => 'IA',
        'Kansas' => 'KS',
        'Kentucky' => 'KY',
        'Louisiana' => 'LA',
        'Maine' => 'ME',
        'Maryland' => 'MD',
        'Massachusetts' => 'MA',
        'Michigan' => 'MI',
        'Minnesota' => 'MN',
        'Mississippi' => 'MS',
        'Missouri' => 'MO',
        'Montana' => 'MT',
        'Nebraska' => 'NE',
        'Nevada' => 'NV',
        'New Hampshire' => 'NH',
        'New Jersey' => 'NJ',
        'New Mexico' => 'NM',
        'New York' => 'NY',
        'North Carolina' => 'NC',
        'North Dakota' => 'ND',
        'Ohio' => 'OH',
        'Oklahoma' => 'OK',
        'Oregon' => 'OR',
        'Pennsylvania' => 'PA',
        'Rhode Island' => 'RI',
        'South Carolina' => 'SC',
        'South Dakota' => 'SD',
        'Tennessee' => 'TN',
        'Texas' => 'TX',
        'Utah' => 'UT',
        'Vermont' => 'VT',
        'Virginia' => 'VA',
        'Washington' => 'WA',
        'West Virginia' => 'WV',
        'Wisconsin' => 'WI',
        'Wyoming' => 'WY',

        # CA provinces
        'Alberta' => 'AB',
        'British Columbia' => 'BC',
        'Manitoba' => 'MB',
        'New Brunswick' => 'NB',
        'Newfoundland and Labrador' => 'NL',
        'Northwest Territories' => 'NT',
        'Nova Scotia' => 'NS',
        'Nunavut' => 'NU',
        'Ontario' => 'ON',
        'Prince Edward Island' => 'PE',
        'Quebec' => 'QC',
        'Saskatchewan' => 'SK',
        'Yukon' => 'YT'
      }

      map[region]
    end
    private :normalize_region
  end
end
