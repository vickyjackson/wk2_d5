class Room

# Getters
  attr_reader :name, :capacity, :playlist

# Initialise argument list
  def initialize(name, capacity, playlist)

    @name = name
    @capacity = capacity
    @playlist = playlist

  end
end
