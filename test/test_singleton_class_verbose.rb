$VERBOSE = true

require 'test/unit'

class Foo

  class << self
    
    def public_first
      :public_first
    end
    
    private

    def private_first
      :private_first
    end
    
    class << self
      
      def public_second
        :public_second
      end
      
      private
      
      def private_second
        :private_second
      end
      
      class << self
        
        def public_too_deep
          :public_too_deep
        end
        
        private
        
        def private_too_deep
          :private_too_deep
        end
        
      end
      
    end
    
  end
  
end

class Bar < Foo
end

class Test_Singleton_Class < Test::Unit::TestCase
  
  def test_singleton_class_loop
    assert_same :public_first, Foo.public_first
    assert_same :public_second, Foo.singleton_class.public_second
    assert_same :public_too_deep, Foo.singleton_class.singleton_class.public_too_deep
  end
  
  def test_singleton_class_loop_private_via_send
    assert_same :private_first, Foo.__send__(:private_first)
    assert_same :private_second, Foo.singleton_class.__send__(:private_second)
    assert_same :private_too_deep, Foo.singleton_class.singleton_class.__send__(:private_too_deep)
  end
  
  def test_singleton_class_inherited
    assert_same :public_first, Bar.public_first
    
    tester = self
    Bar.class_eval do
      tester.assert_same :public_second, singleton_class.public_second
      tester.assert_same :public_too_deep, singleton_class.singleton_class.public_too_deep
    end
  end
  
  def test_singleton_class_inherited_private_via_send
    assert_same :private_first, Bar.__send__(:private_first)
    assert_same :private_second, Bar.singleton_class.__send__(:private_second)
    assert_same :private_too_deep, Bar.singleton_class.singleton_class.__send__(:private_too_deep)
    
    tester = self
    Bar.class_eval do
      tester.assert_same :private_second, singleton_class.__send__(:private_second)
      tester.assert_same :private_too_deep, singleton_class.singleton_class.__send__(:private_too_deep)
    end
  end

end