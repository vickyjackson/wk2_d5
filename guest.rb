class Guest

# Getters
  attr_reader :name, :wallet

# Initialise argument list
  def initialize(name, wallet, favourite_song)

    @name = name
    @wallet = wallet
    @favourite_song = favourite_song

  end

# Class methods

  # Check the guest can afford to pay
  def can_afford_to_pay?(amount)
    if (@wallet < amount)
      return false
    else
      return true
    end
  end

  # Pay amount if guest can afford to do so
  def pay(amount)
    if !can_afford_to_pay?(amount)
      return nil
    end
    @wallet -= amount
  end

end
