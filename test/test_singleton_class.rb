$VERBOSE = true

require 'test/unit'

class Foo

  class << self

    def foo
      :foo
    end
    
    class << self
      
      def bar
        :bar
      end
      
      class << self
        
        def hoge
          :hoge
        end
        
      end
      
    end
    
  end
  
end


class Test_Singleton_Class < Test::Unit::TestCase
  
  def test_singleton_class_loop
    assert_same :foo, Foo.foo
    assert_same :bar, Foo.singleton_class.bar
    assert_same :hoge, Foo.singleton_class.singleton_class.hoge
  end
  
end