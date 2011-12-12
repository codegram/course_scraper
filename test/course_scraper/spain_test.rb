# encoding: utf-8
require_relative '../test_helper'

module CourseScraper
  describe Spain do
    subject { Spain.new }

    before do
      subject.setup_capybara
    end

    describe ".scrape" do
      it 'delegates to an instance' do
        Spain.stubs(:new).returns subject
        subject.expects(:scrape)

        Spain.scrape
      end
    end

    describe "#visit_category_list" do
      it 'visit the category list' do
        subject.expects(:visit)
        subject.visit_category_list
      end
    end

    describe "#each_category" do
      it 'calls a block for each category' do
        names = []
        urls  = []
        subject.each_category do |name, url|
          names << name
          urls << url
        end

        names = names[0..2]
        urls  = urls[0..2]

        names.must_equal [
          "Actividades Físicas y Deportivas",
          "Administración y Gestión",
          "Agraria"
        ]
        urls.must_equal [
          "/todofp/formacion/que-y-como-estudiar/oferta-formativa/todos-los-estudios/actividades-fisico-deportivas.html",
          "/todofp/formacion/que-y-como-estudiar/oferta-formativa/todos-los-estudios/administracion-gestion.html",
          "/todofp/formacion/que-y-como-estudiar/oferta-formativa/todos-los-estudios/agraria.html"
        ]
      end
    end

    describe "#each_course" do
      it 'calls a block for each course in a category' do
        category_url = "http://todofp.es/todofp/formacion/que-y-como-estudiar/oferta-formativa/todos-los-estudios/actividades-fisico-deportivas.html"

        names = []
        types = []

        VCR.use_cassette(:spanish_courses) do
          subject.each_course(category_url) do |name, type|
            names << name
            types << type
          end
        end

        names[0].must_equal "Conducción de actividades físico-deportivas en el medio natural"
        names[1].must_equal "Animación de actividades físico-deportivas"

        types[0].must_equal :medium
        types[1].must_equal :high
      end
    end
  end
end

