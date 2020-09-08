class FileParser
  class FileNotFoundError < StandardError; end

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    raise FileNotFoundError unless File.exist?(file_name)

    parsed_file
  end

  private

  def parsed_file
    dataset = {}
    File.open(file_name).each do |line|
      path, ip = line.split(' ')

      if dataset[path]
        dataset[path] << ip
      else
        dataset[path] = [ip]
      end
    end
    dataset
  end

  attr_reader :file_name
end
