# course_scraper

A course scraper that gets all the vocational training courses in Catalonia
and Spain.

# Install

In your Gemfile:

    gem 'course_scraper', git: 'git://github.com/codegram/course_scraper'

## Usage

```ruby
require 'course_scraper'
catalan_categories = CourseScraper::Catalonia.scrape

catalan_categories.each do |category|
  category.name
  # => "Administracio"
  category.courses.each do |course|
    course.name
    # => "Transport"
    course.type
    # => :medium
  end
end

spanish_categories = CourseScraper::Spain.scrape

spanish_categories.each do |category|
  category.name
  # => "Administracion"
  category.courses.each do |course|
    course.name
    # => "Transporte"
    course.type
    # => :medium
  end
end
```
