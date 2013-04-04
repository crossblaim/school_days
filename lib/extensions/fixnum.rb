# hook into fixnum so we can say things like:
#  5.school_days.from_now
#  7.school_days.ago

module SchoolDays
  module FixnumExtensions
    def school_days(calendar_name = 'default')
      SchoolDays::Calculator.new(self, calendar_name)
    end

    alias :school_day :school_days

  end
end

class Fixnum
  include SchoolDays::FixnumExtensions
end
  
