require 'open-uri'
require 'json'
require 'date'

class SBIF

  VERSION = "0.1.1"
  SITE = "http://api.sbif.cl/api-sbif/recursos"
  INDICATORS = %w(uf utm dolar euro)

  attr_reader :api_key

  def initialize(params)
    @api_key = params[:api_key]
  end

  INDICATORS.each do |indicator|
    method_name = indicator.to_sym
    define_method(method_name) do |date|
      get_data(:currency => indicator, :date => date)
    end
  end

  private
    def get_data(info = {})
      params = info[:date]
      date = format_date(:year => params[:year], :month => params[:month], :day => params[:day])
      content = open("#{SITE}/#{info[:currency]}/#{date}?apikey=#{self.api_key}&formato=json")
      result = parse_server_response(content)
      JSON.parse(result)
    end

    def parse_server_response(content)
      case 
      when content.kind_of?(StringIO) 
        content.string
      when content.kind_of?(Tempfile)
        content.read
      end
    end

    def format_date(params = {})
      date = []
      [params[:year], params[:month], params[:day]].each do |e|
        break if e.nil?
        date << e
      end
      date = date.join("/")
    end

end