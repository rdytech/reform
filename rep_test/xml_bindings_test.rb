require 'rep_test_helper'
require 'representable218/json'  # FIXME.
require 'representable218/xml/collection'
require 'representable218/xml/hash'

require 'representable218/xml'

class XMLBindingTest < MiniTest::Spec
  module SongRepresenter
    include Representable218::XML
    property :name
    self.representation_wrap = :song
  end

  class SongWithRepresenter < ::Song
    include Representable218
    include SongRepresenter
    self.representation_wrap = :song
  end

  before do
    @doc  = Nokogiri::XML::Document.new
    @song = SongWithRepresenter.new("Thinning the Herd")
  end




  describe "AttributeBinding" do
    describe "with plain text items" do
      before do
        @property = Representable218::XML::Binding::Attribute.new(Representable218::Definition.new(:name, :attribute => true), nil, nil)
      end

      it "extracts with #read" do
        assert_equal "The Gargoyle", @property.read(Nokogiri::XML("<song name=\"The Gargoyle\" />").root)
      end

      it "inserts with #write" do
        parent = Nokogiri::XML::Node.new("song", @doc)
        @property.write(parent, "The Gargoyle")
        assert_xml_equal("<song name=\"The Gargoyle\" />", parent.to_s)
      end
    end
  end

  describe "ContentBinding" do
    before do
      @property = Representable218::XML::Binding::Content.new(Representable218::Definition.new(:name, :content => true), nil, nil)
    end

    it "extracts with #read" do
      assert_equal "The Gargoyle", @property.read(Nokogiri::XML("<song>The Gargoyle</song>").root)
    end

    it "inserts with #write" do
      parent = Nokogiri::XML::Node.new("song", @doc)
      @property.write(parent, "The Gargoyle")
      assert_xml_equal("<song>The Gargoyle</song>", parent.to_s)
    end
  end
end
