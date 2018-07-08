require_relative('room')
require_relative('guest')

class Reservation

# Getters
  attr_reader :guest, :room, :party_size

# Initialise argument list
  def initialize(guest, room, party_size)
    @guest = guest
    @room = room
    @party_size = party_size
  end

end
