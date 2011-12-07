module CourseScraper
  # Public: A vocational course.
  #
  class Course
    attr_reader :name, :type

    # Public: Initializes a new Course.
    #
    # name - the String name of the course
    # type - the Symbol type of the course (either :high or :medium).
    def initialize(name, type)
      @name = name
      @type = type
    end
  end
end
