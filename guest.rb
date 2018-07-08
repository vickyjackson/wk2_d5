class Guest

  attr_reader :name, :wallet, :favourite_song

  def initialize(name, wallet, favourite_song)

    @name = name
    @wallet = wallet
    @favourite_song = favourite_song

  end

  # Class methods

  def can_afford_to_pay?(amount)
    if (@wallet < amount)
      return false
    else
      return true
    end
  end

  def pay(amount)
    if !can_afford_to_pay?(amount)
      return nil
    end
    @wallet -= amount
  end

end
