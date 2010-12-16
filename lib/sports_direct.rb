require 'active_support/core_ext/object/try'
require 'active_support/core_ext/string/inflections'

module SportsDirect
  autoload :API, 'sports_direct/api'
  autoload :Normalization, 'sports_direct/normalization'

  autoload :Basketball, 'sports_direct/basketball'
end
