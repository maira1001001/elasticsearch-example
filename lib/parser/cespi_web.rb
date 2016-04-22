require 'json'
require 'open-uri'
require 'nokogiri'
require 'active_support/core_ext/object/blank'

module Parser

  class CespiWeb

    attr_accessor :path, :data, :record

    NBSP = Nokogiri::HTML('&nbsp;').text.freeze
    FIELD = { institution: nil, dependency: nil, office: nil }.freeze
    RECORD = { 0 => :institution, 1 => :dependency, 2 => :office }.freeze
    URL = 'http://www.cespi.unlp.edu.ar/articulo/2014/9/3/internos_adheridos_a_la_red_voip_de_unlp'.freeze

    def initialize(path)
      @path = path
      @data = []
      @record = nil
    end

    def open_url
      Nokogiri::HTML(open(URL))
    end

    def stripped(node)
      s = node.text.strip.gsub(NBSP, '')
      s unless s.empty?
    end

    def build_contact(value)
      unless value.nil?
        value.split(",").each_with_index do |v, k|
          @record[RECORD[k]] = v.strip
        end
      end
    end

    def remainder_of_division_by_4(number)
      number % 4
    end

    def write_data_into_file
      File.open(@path, 'w') { |file| file.write(@data.to_json) }
    end

    def parse_html
      page = open_url
      page.css('.body tbody td')[4..-1].map { |n| stripped(n) }.each_with_index do |value, index|
        case remainder_of_division_by_4 index
        when 0
          @record = FIELD.dup
          build_contact value
          @data << @record unless @record.nil?
        end
      end
      write_data_into_file
    end

  end

end
