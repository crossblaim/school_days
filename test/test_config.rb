require File.dirname(__FILE__) + '/test_helper.rb'

class TestConfig < Test::Unit::TestCase
  should "load a file with one session with no errors" do
    conf = SchoolDays.config
    assert_nothing_raised(Exception) {  conf.load( fixture_path() + "/simple_test.yml" )   }
  end

  should "load a file with two sessions correctly" do
    conf = SchoolDays.config
    assert_nothing_raised(Exception) {  conf.load( fixture_path() + "/double_session_test.yml" )  }
    assert conf.default_calendar.school_sessions.length == 2
  end

  context "holiday exceptions" do
    should "only include listed holiday exceptions, as Ruby Date objects" do
      conf = SchoolDays.config
      conf.load( fixture_path() + "/simple_test.yml" )

      assert_contains( conf.default_calendar.holiday_exceptions, Date.parse("Jan 01, 2011") )
      assert_does_not_contain( conf.default_calendar.holiday_exceptions, Date.parse("Jan 02, 2011") )
    end
  end

  context "exceptional included days" do
    should "only include exceptional included days, as Ruby date objects" do
      conf = SchoolDays.config
      conf.load( fixture_path() + "/simple_test.yml" )

      assert_contains( conf.default_calendar.included_day_exceptions, Date.parse("May 29, 2011") )
      assert_does_not_contain( conf.default_calendar.included_day_exceptions, Date.parse("May 31, 2011") )
    end
  end

  context "when loading an invalid config file" do
    # should "throw a Runtime error when we're missing start or end dates for a session" do
    #   conf = SchoolDays.config
    #   assert_raise(RuntimeError) {  conf.load( fixture_path() + "/invalid_config_test.yml" )   }
    # end
  end

  context "when loading a file with one session" do
    should "be able to find the start date" do
      conf = SchoolDays.config
      conf.load( fixture_path() + "/simple_test.yml" )
      assert_equal( Date.civil(2010, 8, 30).to_s, conf.default_calendar.school_year_start.to_s )
    end

    should "be able to find the end date" do
      conf = SchoolDays.config
      conf.load( fixture_path() + "/simple_test.yml" )
      assert_equal( Date.civil(2011, 6, 1).to_s, conf.default_calendar.school_year_end.to_s )
    end
  end

  context "when loading a file with multiple sessions" do
    should "be able to find the first start date" do
      conf = SchoolDays.config
      conf.load( fixture_path() + "/double_session_test.yml" )
      assert_equal( Date.civil(2011, 8, 29).to_s, conf.default_calendar.school_year_start.to_s )
    end

    should "be able to find the last end date" do
      conf = SchoolDays.config
      conf.load( fixture_path() + "/double_session_test.yml" )
      assert_equal( Date.civil(2012, 5, 15).to_s, conf.default_calendar.school_year_end.to_s )
    end
  end
end
