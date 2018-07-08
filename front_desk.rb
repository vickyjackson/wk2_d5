require_relative('reservation')
require_relative('room')
require_relative('guest')

class FrontDesk

# Getters
  attr_reader :rooms, :checked_in_guests, :till

# Initialise argument list
  def initialize(rooms)
    @rooms = rooms
    @reservations = []
    @checked_in_guests = []
    @till = 500
    @booking_fee = 20
  end

# Private class methods
  private
  def find_room(room)
    @rooms.find { |karaoke_room| karaoke_room.name == room.name }
  end

  def find_reservation_by_name(name)
    @reservations.find { |reservation| reservation.guest.name == name }
  end

  def find_checked_in_guest_by_name(name)
    @checked_in_guests.find { |guest| guest.guest.name == name }
  end

# Public class methods
  public

  # Check if room is available
  def is_room_available?(room, party_size)
    found_room = find_room(room)
    return true if (found_room != nil) && (found_room.capacity >= party_size)
    return false
  end

  # Check if guest has a reservation
  def has_reservation?(name)
    found_reservation = find_reservation_by_name(name)
    return false if found_reservation == nil
    return true
  end

  # Create a reservation if room is available
  # Add the new reservation to the reservations array
  # Charge guest the booking fee
  # Add booking fee to till
  # Provide confirmation of reservation
  def create_reservation(guest, room, party_size)
    if (!is_room_available?(room, party_size)) || (!guest.can_afford_to_pay?(@booking_fee))
      return nil
    end
    guest.pay(@booking_fee)
    @till += @booking_fee
    new_reservation = Reservation.new(guest, room, party_size)
    @reservations << new_reservation
    return "Thanks, your reservation is held under #{new_reservation.guest.name}"
  end

  # Find the reservation and check the guest in
  # Add the reservation to the checked_in_guests array
  def check_in(guest)
    found_reservation = find_reservation_by_name(guest.name)
    if found_reservation == nil
      return "Sorry, we couldn't find your reservation."
    end
    @checked_in_guests << found_reservation
    return "Thanks, you are now checked in under #{guest.name}!"
  end

  def check_in_by_name(guest_name)
    found_reservation = find_reservation_by_name(guest_name)
    if found_reservation == nil
      return "Sorry, we couldn't find your reservation."
    end
    @checked_in_guests << found_reservation
    return "Thanks, you are now checked in under #{guest_name}!"
  end

  # Find the reservation and check the guest out
  # Remove the reservation from the checked_in_guests array
  def check_out(guest)
    found_reservation = find_reservation_by_name(guest.name)
    found_guest = find_checked_in_guest_by_name(guest.name)
    if found_guest == nil
      return "Sorry, we couldn't find your reservation."
    end
    @reservations.delete(found_reservation)
    @checked_in_guests.delete(found_guest)
    return "You are now checked out! See you next time!"
  end

  def check_out_by_name(guest_name)
    found_reservation = find_reservation_by_name(guest_name)
    found_guest = find_checked_in_guest_by_name(guest_name)
    if found_guest == nil
      return "Sorry, we couldn't find your reservation."
    end
    @reservations.delete(found_reservation)
    @checked_in_guests.delete(found_guest)
    return "You are now checked out! See you next time!"
  end

  # Find the room that the guest is in
  # Add a song to the playlist in that room
  def add_song_request(guest, song)
    found_guest = find_checked_in_guest_by_name(guest.name)
    found_guest.room.playlist << song
  end

end
