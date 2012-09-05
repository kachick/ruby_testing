$VERBOSE = true

require 'test/unit'

class Foo
  class << self
    class << self
      def foo; end
    end
  end
end

class Bar < Foo; end

class Test_Singleton_Class < Test::Unit::TestCase
  
  def test_singleton_class_inherited
    assert_same nil, Bar.singleton_class.foo
  end

end