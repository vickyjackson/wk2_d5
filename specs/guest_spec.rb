require('minitest/autorun')
require('../guest')

class TestGuest < Minitest::Test

  def setup()
  @guest1 = Guest.new("Austin Powers", 300, "Stayin' Alive")
  @guest2 = Guest.new("Disco Stu", 10, "Stayin' Alive" )
  end

  def test_pay__can_afford()
    @guest1.pay(30)
    assert_equal(270, @guest1.wallet())
  end

  def test_pay__cant_afford()
    actual = @guest2.pay(30)
    assert_nil(actual)
  end

end
