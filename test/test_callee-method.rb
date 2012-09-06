$VERBOSE = true

# This test goal is "Easy check to behavior 
#   Kernel#__callee__, Kernel#__method__" .
# The behaviors modified from Ruby 2.0~

require 'forwardable'
require 'test/unit'

class Foo
  
  extend Forwardable
  
  def original_callee
    __callee__
  end
  
  def original_method
    __method__
  end
  
  alias_method :aliased_callee, :original_callee
  alias_method :aliased_method, :original_method
  
  def_delegator :self, :original_callee, :forwarded_callee
  def_delegator :self, :original_method, :forwarded_method
  
end


class Test_OwnMethodName < Test::Unit::TestCase
  
  def test___method___aliased_
    foo = Foo.new
    assert_same :original_method, foo.aliased_method
  end
  
  def test___callee___aliased_
    foo = Foo.new
    
    if RUBY_VERSION >= '2.0'
      assert_same :aliased_callee, foo.aliased_callee
    else
      assert_same :original_callee, foo.aliased_callee
    end
  end
  
  def test___method___forwarded
    foo = Foo.new
    assert_same :original_method, foo.forwarded_method
  end
  
  def test___callee___forwarded
    foo = Foo.new
    
    if RUBY_VERSION >= '2.0'
      assert_same :forwarded_callee, foo.forwarded_callee
    else
      assert_same :original_callee, foo.forwarded_callee
    end
  end
  
end