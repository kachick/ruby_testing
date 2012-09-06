$VERBOSE = true

obj = Object.new

obj.class do; end
obj.singleton_class do; end
obj.inspect do; end
obj.to_s do
  p 8
end

class << obj
  
  def func
  end
  
end

obj.func do |a|
  p 8
end