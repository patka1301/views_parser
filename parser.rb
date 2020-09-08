require_relative 'source/views_parser'

if ARGV.length > 1
  puts 'Please provide a single name of the file'
else
  response = ViewsParser.new(ARGV[0]).call
  if response.is_a? Hash
    response.each do |key, value|
      puts "\n**********#{key.capitalize}************"
      value.each(&method(:puts))
      puts "**************************\n"
    end
  else
    puts response
  end
end
