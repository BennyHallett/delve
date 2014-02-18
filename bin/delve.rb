require 'delve'

name = ARGV.shift

if name.nil?
  puts "Cannot create roguelike without a name"
  exit 1
end

dir = File.expand_path('.').to_s

delve = Delve.new name
delve.create_game dir
