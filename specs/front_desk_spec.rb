require('minitest/autorun')
require('../front_desk')

class TestFrontDesk < Minitest::Test

  def setup()
    @room1 = Room.new("Swingin' 60s", 100, ["Good Vibrations","Mr Tabourine Man","Happy Together"])
    @room2 = Room.new("Groovy 70s", 80, ["Stayin' Alive","Dancing Queen","Night Fever"])
    @room3 = Room.new("Mad 90s", 50, ["Rhythm is a Dancer","Still Dre","Barbie Girl"])
    @guest1 = Guest.new("Austin Powers", 300, "Stayin' Alive")
    @guest2 = Guest.new("Disco Stu", 250, "Night Fever")
    @front_desk = FrontDesk.new([@room1, @room2])
  end

  def test_is_room_available__true()
    actual = @front_desk.is_room_available?(@room1, 5)
    assert_equal(true, actual)
  end

  def test_is_room_available__false()
    actual = @front_desk.is_room_available?(@room1, 101)
    assert_equal(false, actual)
  end

  def test_is_room_available__invalid_room()
    actual = @front_desk.is_room_available?(@room3, 5)
    assert_equal(false, actual)
  end

  def test_is_room_available__invalid_party_size()
    actual = @front_desk.is_room_available?(@room1, 101)
    assert_equal(false, actual)
  end

  def test_create_reservation__valid()
    actual = @front_desk.create_reservation(@guest1, @room2, 5)
    assert_equal("Thanks, your reservation is held under Austin Powers", actual)
  end

  def test_create_reservation__invalid_room()
    actual = @front_desk.create_reservation(@guest1, @room3, 5)
    assert_nil(actual)
  end

  def test_create_reservation__invalid_party_size()
    actual = @front_desk.create_reservation(@guest1, @room1, 101)
    assert_nil(actual)
  end

  def test_has_reservation__valid?()
    reservation = @front_desk.create_reservation(@guest1, @room1, 5)
    actual = @front_desk.has_reservation?("Austin Powers")
    assert_equal(true, actual)
  end

  def test_has_reservation__invalid?()
    reservation = @front_desk.create_reservation(@guest1, @room1, 5)
    actual = @front_desk.has_reservation?("Fred")
    assert_equal(false, actual)
  end

  def test_check_in__party()
    @front_desk.create_reservation(@guest1, @room1, 5)
    @front_desk.check_in(@guest1)
    assert_equal(1, @front_desk.checked_in_guests.length())
  end

  def test_check_out__party()
    @front_desk.create_reservation(@guest1, @room1, 5)
    @front_desk.create_reservation(@guest2, @room1, 1)
    @front_desk.check_in(@guest1)
    @front_desk.check_in(@guest2)
    @front_desk.check_out(@guest1)
    assert_equal(1, @front_desk.checked_in_guests.length)
    assert_equal("Disco Stu", @front_desk.checked_in_guests[0].guest.name())
    assert_equal(540, @front_desk.till())
  end

  def test_add_song_request()
    @front_desk.create_reservation(@guest1, @room1, 5)
    @front_desk.check_in(@guest1)
    actual = @front_desk.add_song_request(@guest1, "Unchained Melody")
    assert_equal(["Good Vibrations","Mr Tabourine Man","Happy Together", "Unchained Melody"], @front_desk.checked_in_guests[0].room.playlist)
  end

end
