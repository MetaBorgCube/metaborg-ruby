#!/usr/bin/env ruby

# Iterate over all characters except alphanumeric characters
# For each of these characters, generate a production that uses the character
# as string delimiters
numeric = (48..57)
alpha_lower = (97..122)
alpha_upper = (65..90)
matching_characters = {
  123 => 125,
  40 => 41,
  91 => 93,
  60 => 62
}

delimiter_characters = (0..127).to_a - numeric.to_a - alpha_lower.to_a - alpha_upper.to_a - matching_characters.keys - matching_characters.values

delimiter_characters.each do |char|
  puts "NonExpandedDelimitedString = [\\#{char}] NonExpandedLiteralString* [\\#{char}]"
end

puts

matching_characters.each do |char_start, char_end|
  puts "NonExpandedDelimitedString = \"#{char_start.chr}\" NonExpandedLiteralString* \"#{char_end.chr}\""
end
