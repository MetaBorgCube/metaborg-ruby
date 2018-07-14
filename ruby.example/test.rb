class Class < (
    class Superc
      def toString
      
      end  
    end
  )
  def test(a, b, str)
    puts str
    a + b
  end
end

Class.new.test(
  1,
  2,
  "returning: #{ 1 + 2 }"
)

[1, 2].each do |x|
  puts x  
end; # ambig when no explicit line sep

/test/i.match?('test')

# line comment here

10.times { |x| puts x }; # ambig when no explicit line sep

-1.2e3 + 0xEF - 0b01011

module Mod
  class ClassInModule; end # ambig when space
end

class Mod::OtherClassInModule
  def self.method
    puts ['This is', 'a class method!'].join('') # ambiguity between parentheses and no parentheses but group cstmt as argument
  end
end

# todo: fix assignment statements
# todo: fix and enable hash constructors
# todo: update hash constructor to allow for symbol key notation