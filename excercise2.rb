# To get all documents in the directory
# https://ruby-doc.org/core-2.6.3/Dir.html#method-c-entries
# Dir.entries("data/") puts also . and .. as directories
# Spend 50 min. on combinations of exist without having "data/" there just reading docs (forcing me not to google)
# Not entirely sure of the goal with YAML. Just output as html? 

require 'kramdown'
require 'yaml'

puts "Welcome to file reader 3000"
puts "The contents of your data directory are:"
puts Dir.children("data/")

print "Which file would you like to display:"
a = gets.chomp

abort "#{a} does not exist, exiting!" unless File.exist?("data/" + a)

contents = File.read("data/" + a)

if a.split('.')[1] = "md"
  puts Kramdown::Document.new(contents).to_html
else
  YAML.load(contents)
end
