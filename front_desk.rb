require_relative('room')
require_relative('guest')
require_relative('reservation')

class FrontDesk

  attr_reader :checked_in_guests, :guests, :reservations, :till

  def initialize(rooms)
    @rooms = rooms
    @reservations = []
    @checked_in_guests = []
    @till = 500
    @booking_fee = 20
  end

  private
  def find_room_by_name(room)
    @rooms.find { |karaoke_room| karaoke_room.name == room.name }
  end

  def find_reservation_by_name(name)
    @reservations.find { |reservation| reservation.guest.name == name }
  end

  def find_checked_in_guest_by_name(name)
    @checked_in_guests.find { |guest| guest.guest.name == name }
  end

  public
  def is_room_available?(room, party_size)
    found_room = find_room_by_name(room)
    return true if (found_room != nil) && (found_room.capacity >= party_size)
    return false
  end

  def has_reservation?(name)
    found_reservation = find_reservation_by_name(name)
    return false if found_reservation == nil
    return true
  end

  def create_reservation(guest, room, party_size)
    if !is_room_available?(room, party_size)
      return nil
    end
    guest.pay(@booking_fee)
    @till += @booking_fee
    new_reservation = Reservation.new(guest, room, party_size)
    @reservations << new_reservation
    return "Thanks, your reservation is held under #{new_reservation.guest.name}"
  end

  def check_in(guest)
    found_reservation = find_reservation_by_name(guest.name)
    @checked_in_guests << found_reservation
  end

  def check_out(guest)
    found_reservation = find_reservation_by_name(guest.name)
    @checked_in_guests.delete(found_reservation)
  end

  def add_song_request(guest, song)
    found_guest = find_checked_in_guest_by_name(guest.name)
    found_guest.room.playlist << song
  end

end
