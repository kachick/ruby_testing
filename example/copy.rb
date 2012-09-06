$VERBOSE = true

obj = Object.new

class << obj

  def initialize_copy(original)
    puts caller.first
  end
  
end

obj.dup   #=> NO_OUTPUT
obj.clone #=> in `initialize_clone'

class << obj

  def initialize_dup(original)
    puts caller.first
  end
  
  def initialize_clone(original)
    puts caller.first
  end
  
end

obj.dup   #=> NO_OUTPUT      
obj.clone #=> in `clone'

class Object
  
  def initialize_copy(original)
    puts caller.first
  end

end

obj2 = Object.new

obj2.dup   #=> NO_OUTPUT
obj2.clone #=> in `initialize_clone'

class Object
  
  def initialize_dup(original)
    puts caller.first
  end
  
  def initialize_clone(original)
    puts caller.first
  end

end

obj.dup   #=> NO_OUTPUT
obj.clone #=> in `initialize_clone'
