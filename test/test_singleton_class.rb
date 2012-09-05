$VERBOSE = true

require 'test/unit'

class Foo

  class << self
    
    private

    def foo
      :foo
    end
    
    class << self
      
      private
      
      def bar
        :bar
      end
      
      class << self
        
        private
        
        def hoge
          :hoge
        end
        
      end
      
    end
    
  end
  
end

class Bar < Foo
end


class Test_Singleton_Class < Test::Unit::TestCase
  
  #~ def test_singleton_class_loop
    #~ assert_same :foo, Foo.foo
    #~ assert_same :bar, Foo.singleton_class.bar
    #~ assert_same :hoge, Foo.singleton_class.singleton_class.hoge
  #~ end
  
  def test_singleton_class_loop_via_send
    assert_same :foo, Foo.__send__(:foo)
    assert_same :bar, Foo.singleton_class.__send__(:bar)
    assert_same :hoge, Foo.singleton_class.singleton_class.__send__(:hoge)
  end
  
  def test_singleton_class_inherited_eval
    assert_same :foo, Bar.__send__(:foo)
    
    tester = self
    Bar.class_eval do
      tester.assert_same :bar, singleton_class.__send__(:bar)
      tester.assert_same :hoge, singleton_class.singleton_class.__send__(:hoge)
    end
  end

end