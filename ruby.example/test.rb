class Class < Super
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
