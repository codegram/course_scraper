# course_scraper

A course scraper that gets all the vocational training courses in Catalonia
and Spain.

# Install

In your Gemfile:

    gem 'course_scraper', git: 'git://github.com/codegram/course_scraper'

# Usage

    require 'course_scraper'
    categories = CourseScraper::Catalonia.scrape

    categories.each do |category|
      category.name
      # => "Administracio"
      category.courses.each do |course|
        course.name
        # => "Transport"
        course.type
        # => :medium
      end
    end
