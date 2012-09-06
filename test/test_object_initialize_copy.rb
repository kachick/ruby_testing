$VERBOSE = true

require 'test/unit'

class Test_Object_Copy < Test::Unit::TestCase
  
  def test_initialize_copy_dup
    peep = nil
    obj = Object.new
    
    obj.singleton_class.class_eval do
      define_method :initialize_copy do |original|
        peep = :initialize_copy
      end
    end
    
    obj.dup
    assert_same nil, peep
  end
  
  def test_initialize_copy_clone
    peep = nil
    obj = Object.new
    
    obj.singleton_class.class_eval do
      define_method :initialize_copy do |original|
        peep = :initialize_copy
      end
    end

    obj.clone
    assert_same :initialize_copy, peep
  end

  def test_initialize_dup
    peep = nil
    obj = Object.new
    
    obj.singleton_class.class_eval do
      define_method :initialize_dup do |original|
        peep = :initialize_dup
      end
    end
    
    obj.dup
    assert_same nil, peep
  end

  def test_initialize_clone
    peep = nil
    obj = Object.new
    
    obj.singleton_class.class_eval do
      define_method :initialize_clone do |original|
        peep = :initialize_clone
      end
    end

    obj.clone
    assert_same :initialize_clone, peep
  end

end