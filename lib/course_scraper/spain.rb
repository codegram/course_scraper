# encoding: utf-8
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'

module CourseScraper
  # Public: A scraper for all the vocational training courses in Spain.
  #
  # Examples
  #
  #   courses = Spain.scrape
  #   # => [#<CourseScraper::Course ...>, #<CourseScraper::Course ...>]
  #
  class Spain
    include Capybara::DSL

    # Public: Instantiates a new scraper and fires it to grab all the vocational
    # training courses in Spain.
    #
    # Returns the Array collection of CourseScraper::Course instances.
    def self.scrape
      new.scrape
    end

    # Internal: Sets the configuration for capybara to work with the Todofp
    # website.
    #
    # Returns nothing.
    def setup_capybara
      Capybara.run_server = false
      Capybara.current_driver = :webkit
      Capybara.app_host       = 'http://todofp.es'
    end

    # Public: Scrapes the vocational training courses in Spain.
    #
    # Returns the Array collection of CourseScraper::Category instances with
    # nested Courses.
    def scrape
      setup_capybara

      categories = []
      each_category do |name, href|
        categories << { name: name, url: href }
      end

      categories.map do |category|
        cat = Category.new(category[:name], [])
        each_course category[:url] do |name, type|
          cat.courses << Course.new(name, type)
        end
        cat
      end
    end

    # Internal: Visits the main page where the course categories are listed.
    #
    # Returns nothing.
    def visit_category_list
      visit '/todofp/formacion/que-y-como-estudiar/oferta-formativa/todos-los-estudios.html'
    end

    # Internal: Call a block for every category.
    #
    # Yields the String name of the category and its String URL.
    #
    # Returns nothing.
    def each_category(&block)
      visit_category_list

      links = []

      within ".columnas-fp" do
        links = all('a')
      end

      links.each do |link|
        block.call link.text, link[:href]
      end
    end

    # Internal: Call a block for every course in a category URL.
    #
    # category_url - the String category URL
    #
    # Yields the String name of the course and its Symbol type.
    #
    # Returns nothing.
    def each_course(category_url, &block)
      visit category_url

      courses = []

      all('.columnas-familiafp ul:nth-of-type(1) li').each do |course|
        courses << [course.text, :medium]
      end

      all('.columnas-familiafp ul:nth-of-type(2) li').each do |course|
        courses << [course.text, :high]
      end

      courses.each do |course|
        block.call *course
      end
    end
  end
end
