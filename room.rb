class Room

  attr_reader :name, :capacity, :playlist

  def initialize(name, capacity, playlist)

    @name = name
    @capacity = capacity
    @playlist = playlist

  end
end
