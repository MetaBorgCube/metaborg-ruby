id0 = true
def id0
  false
end

puts "id0 - locar var shadows method:\t\t\t\t#{id0}"

if true
  id1 = true
  def id1
    false
  end
end

puts "id1 - control structures do not introduce scope:\t#{id1}"

def id2
  true
end
module Mod2
  id2 = false
end

puts "id2 - module introduces scope:\t\t\t\t#{id2}"

x = true
define_method(['i', 'd', '3'].join('').to_sym) do
  x
end

puts "id3 - method can be defined dynamically:\t\t#{id3}"

id4 = false
class Mod4
  def self.id4
    true
  end

  puts "id4 - module is a scope gate:\t\t\t\t#{id4}"
end

begin
  id5 = false
  x = 42
  class Cls5
    x
  end
rescue
  id5 = true
end

puts "id5 - class is a scope gate:\t\t\t\t#{id5}"

$id6 = false
module ScopeGate
  $id6 = true
end

puts "id6 - global var breaks scope gate:\t\t\t#{$id6}"

if true
  def id7; true end
else
  id7 = false
end

id7 = true if id7 == nil

puts "id7 - interesting case var shadows def:\t\t\t#{id7.inspect}"

class Cls
  def get
    @id8
  end

  def set
    @id8 = true
  end
end

obj = Cls.new
obj.set
id8 = obj.get
puts "id8 - instance var not lex scoped:\t\t\t#{id8.inspect}"

# http://po-ru.com/diary/ruby-parsing-ambiguities/

amb_var = 84
def amb_method(x); end

amb_var /2#/; puts 'should not be printed'
amb_method /2#/; puts 'should be printed'
