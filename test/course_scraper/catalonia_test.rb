# encoding: utf-8
require_relative '../test_helper'

module CourseScraper
  describe Catalonia do
    subject { Catalonia.new }

    before do
      subject.setup_capybara
    end

    describe ".scrape" do
      it 'delegates to an instance' do
        Catalonia.stubs(:new).returns subject
        subject.expects(:scrape)

        Catalonia.scrape
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
          "Activitats físiques i esportives",
          "Agrària",
          "Comerç i màrqueting"
        ]
        urls.must_equal [
          "/portal/site/queestudiar/menuitem.796f7d19c318c94cd56a1c76b0c0e1a0/?vgnextoid=e01237a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextchannel=e01237a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextfmt=default",
          "/portal/site/queestudiar/menuitem.796f7d19c318c94cd56a1c76b0c0e1a0/?vgnextoid=d6e237a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextchannel=d6e237a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextfmt=default",
          "/portal/site/queestudiar/menuitem.796f7d19c318c94cd56a1c76b0c0e1a0/?vgnextoid=1d8337a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextchannel=1d8337a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextfmt=default"
        ]
      end
    end

    describe "#each_course" do
      it 'calls a block for each course in a category' do
        category_url = "http://www20.gencat.cat/portal/site/queestudiar/menuitem.796f7d19c318c94cd56a1c76b0c0e1a0/?vgnextoid=e01237a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextchannel=e01237a9f4f2b210VgnVCM2000009b0c1e0aRCRD&vgnextfmt=default://google.com"

        names = []
        types = []

        VCR.use_cassette(:catalan_courses) do
          subject.each_course(category_url) do |name, type|
            names << name
            types << type
          end
        end

        names[0].must_match /i esportives/
        names[1].must_match /sicoesportives en el medi natural/
        names[2].must_match /en el medi natural, perfil professional/

        types[0].must_equal :high
        types[1].must_equal :medium
        types[2].must_equal :medium
      end
    end
  end
end
