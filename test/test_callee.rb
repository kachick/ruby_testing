$VERBOSE = true

require 'test/unit'

class Foo
  
  def foo_callee
    __callee__
  end
  
  def foo_method
    __method__
  end
  
  alias_method :bar_callee, :foo_callee
  alias_method :bar_method, :foo_method
  
end


class Test_Callee_AliasMethod < Test::Unit::TestCase
  
  def test_callee_aliased
    foo = Foo.new
    assert_same :foo_callee, foo.bar_callee
    assert_same :foo_method, foo.bar_method
  end
  
end