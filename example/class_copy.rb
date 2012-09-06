$VERBOSE = true

cls = Class.new

class << cls

  def initialize_copy(original)
    puts caller.first
  end
  
end

cls.dup   #=> NO_OUTPUT
cls.clone #=> in `initialize_clone'

class << cls

  def initialize_dup(original)
    puts caller.first
  end
  
  def initialize_clone(original)
    puts caller.first
  end
  
end

cls.dup   #=> NO_OUTPUT      
cls.clone #=> in `clone'
