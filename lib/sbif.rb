require 'open-uri'
require 'json'
require 'date'

class SBIF

  VERSION = "0.2.2"
  SITE = "http://api.sbif.cl/api-sbif/recursos"
  INDICATORS = %w(uf utm dolar euro)

  attr_reader :api_key

  def initialize(params)
    @api_key = params[:api_key]
  end

  INDICATORS.each do |currency|
    method_name = currency.to_sym
    define_method(method_name) do |*args|
      date = args[0] || {}
      get_data(currency, date)
    end
  end

  private
    def get_data(currency, date)
      date = format_date(:year => date[:year], :month => date[:month], :day => date[:day])
      begin
        content = open("#{SITE}/#{currency}/#{date}?apikey=#{self.api_key}&formato=json")
      rescue
        content = ""
      end
      values = parse_server_response(content)
      if values.size < 1
        nil
      elsif values.size == 1
        begin
          to_float(values[0]["Valor"])
        rescue
          nil
        end
      else
        results = {}
        values.each do |v|
          results[v["Fecha"]] = to_float(v["Valor"])
        end
        results
      end
    end

    def parse_server_response(content)
      result = ""
      case
      when content.kind_of?(StringIO)
        result = content.string
      when content.kind_of?(Tempfile)
        result = content.read
      else
        result = JSON.generate({"Fecha" => "", "Valor" => "0"})
      end
      JSON.parse(result).values[0]
    end

    def format_date(params = {})
      date = []
      [params[:year], params[:month], params[:day]].each do |e|
        break if e.nil?
        date << e
      end
      date = date.join("/")
    end

    def to_float(string)
      string.gsub(".","").gsub(",",".").to_f
    end

end
