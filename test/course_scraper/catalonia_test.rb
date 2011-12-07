require_relative '../test_helper'

require 'capybara'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.current_driver = :akephalos
Capybara.app_host = 'http://www20.gencat.cat'

module CourseScraper
  # Public: A scraper for all the vocational training courses in Catalonia.
  #
  # Examples
  #
  #   courses = Catalonia.scrape
  #   # => [#<CourseScraper::Course ...>, #<CourseScraper::Course ...>]
  #
  class Catalonia
    include Capybara

    # Public: Instantiates a new scraper and fires it to grab all the vocational
    # training courses in Catalonia.
    #
    # Returns the Array collection of CourseScraper::Course instances.
    def self.scrape
      new.scrape
    end

    # Internal: Visits the main page where the courses are listed.
    #
    # Returns nothing.
    def visit_course_list
      visit "/portal/site/queestudiar/menuitem.d7cfc336363a7af8e85c7273b0c0e1a0/?vgnextoid=0a8137a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextchannel=0a8137a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextfmt=default"
    end
  end
end

module CourseScraper
  describe Catalonia do
    subject { Catalonia.new }

    describe ".scrape" do
      it 'delegates to an instance' do
        Catalonia.stubs(:new).returns subject
        subject.expects(:scrape)

        Catalonia.scrape
      end
    end

    describe "#visit_course_list" do
      it 'visit the course list' do
        subject.expects(:visit)
        subject.visit_course_list
      end
    end
  end
end
