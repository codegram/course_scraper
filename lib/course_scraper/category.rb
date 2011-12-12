module CourseScraper
  # Public: A Category of vocational courses that contains them.
  #
  class Category
    attr_reader :name, :courses

    # Public: Initializes a new Category.
    #
    # name    - the String name of the category
    # courses - the Array of courses of the category
    def initialize(name, courses)
      @name    = name
      @courses = courses || []
    end
  end
end
