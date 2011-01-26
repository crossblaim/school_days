$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require File.dirname(__FILE__) + '/school_days/config'
require File.dirname(__FILE__) + '/school_days/school_days_calculator'

require File.dirname(__FILE__) + '/extensions/date'
require File.dirname(__FILE__) + '/extensions/fixnum'

module SchoolDays
  VERSION = '0.0.1'
end