#!/usr/bin/env ruby

require 'parser/current'

# opt-in to most recent AST format:
Parser::Builders::Default.emit_lambda   = true
Parser::Builders::Default.emit_procarg0 = true
Parser::Builders::Default.emit_encoding = true
Parser::Builders::Default.emit_index    = true

code = ARGF.read unless STDIN.tty?
code = nil if [false, nil].include?(code) || /\A\s*\z/.match?(code)

code ||= <<-HEREDOC
amb_var = 84
def amb_method(x); end

amb_var /2#/; puts 'should not be printed'
amb_method /2#/; puts 'should be printed'
HEREDOC

puts
puts '== Text =='
puts
puts code
puts
puts '== AST =='
puts
p Parser::CurrentRuby.parse(code)
puts
puts '== Evaluation =='
puts
p eval(code)
