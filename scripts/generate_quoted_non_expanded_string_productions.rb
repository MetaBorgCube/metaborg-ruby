#!/usr/bin/env ruby

# Iterate over all characters except alphanumeric characters
# For each of these characters, generate a production that uses the character
# as string delimiters

TEST_MODE = true

numeric = (48..57).to_a
alpha_lower = (97..122).to_a
alpha_upper = (65..90).to_a
matching_characters = {
  123 => 125,
  40 => 41,
  91 => 93,
  60 => 62
}

non_delimiter_characters = numeric + alpha_lower + alpha_upper + matching_characters.keys + matching_characters.values

delimiter_characters = (0..127).to_a - non_delimiter_characters

if TEST_MODE
  delimiters = { 123 => 125 }
else
  delimiters = delimiter_characters.zip(delimiter_characters).to_h.merge(matching_characters)
end

def printable?(char)
  (32..126).include?(char)
end

def productions(*prods)
  prods.map { |s| "  #{s}" }.join("\n")
end

puts '// This module was automatically generated by /scripts/generate_quoted_non_expanded_string_productions.rb'
puts 'module QuotedNonExpandedLiteralStringGen'
puts

delimiters.each do |char_start, char_end|
  printable_char_start = printable?(char_start) ? char_start.chr : "\\#{char_end}"
  printable_char_end = printable?(char_end) ? char_end.chr : "\\#{char_end}"

  puts "// === Delimited with #{printable_char_start} and #{printable_char_end} ==="
  puts 'syntax'
  puts

  puts productions(
    "NonExDelimStr-CF = DELIM-START-#{char_start}-LEX NonExLitStr-#{char_start}-List-CF DELIM-END-#{char_start}-LEX",
    '',
    "NonExLitStr-#{char_start}-List-CF.StrQCharListEnd =",
    "NonExLitStr-#{char_start}-List-CF.StrQCharList = NonExLitStr-#{char_start}-CF NonExLitStr-#{char_start}-List-CF",
    '',
    "NonExLitStr-#{char_start}-CF = NonExLitChar-#{char_start}-CF",
    "NonExLitStr-#{char_start}-CF = NonExLitEscSeq-#{char_start}-CF",
    '',
    "NonExLitChar-#{char_start}-CF.StrQChar = NonExLitChar-#{char_start}-LEX",
    '',
    "NonExLitEscSeq-#{char_start}-CF.StrQEsc = EscMetaChar-LEX NonExLitEscChar-#{char_start}-LEX",
    "NonExLitEscSeq-#{char_start}-CF.StrQNonEsc = EscMetaChar-LEX NonExLitNonEscChar-#{char_start}-LEX",
    ''
  )

  puts 'lexical syntax'
  puts

  puts productions(
    "DELIM-START-#{char_start} = [\\#{char_start}]",
    "DELIM-END-#{char_start} = [\\#{char_end}]",
    '',
    "NonExLitChar-#{char_start} = ~[]",
    "NonExLitChar-#{char_start} = NonExLitEscChar-#{char_start} {reject}",
    '',
    "NonExLitEscChar-#{char_start} = DELIM-START-#{char_start}",
    "NonExLitEscChar-#{char_start} = DELIM-END-#{char_start}",
    "NonExLitEscChar-#{char_start} = EscMetaChar",
    '',
    "NonExLitNonEscChar-#{char_start} = ~[]",
    "NonExLitNonEscChar-#{char_start} = NonExLitEscChar-#{char_start} {reject}",
    ''
  )

  puts
end

puts 'lexical syntax'
puts

puts productions(
  'EscMetaChar = [\\\\]'
)
