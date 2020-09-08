require_relative 'file_parser'
require_relative 'views_counter/all'
require_relative 'views_counter/uniq'

class ViewsParser
  def initialize(file_name)
    @file_name = file_name
  end

  def call
    list_views
  rescue ::FileParser::FileNotFoundError => _e
    'Sorry, the file does not exist!'
  end

  private

  def list_views
    {
      all: all_views_counter,
      uniq: uniq_views_counter
    }
  end

  def all_views_counter
    ::ViewsCounter::All.new(parsed_file).call
  end

  def uniq_views_counter
    ::ViewsCounter::Uniq.new(parsed_file).call
  end

  def parsed_file
    @_parsed_file ||= ::FileParser.new(file_name).call
  end

  attr_reader :file_name
end
