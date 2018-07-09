require_relative('front_desk')

@room1 = Room.new("Swingin' 60s", 100, ["Good Vibrations","Mr Tabourine Man","Happy Together"])
@room2 = Room.new("Groovy 70s", 80, ["Stayin' Alive","Dancing Queen","Night Fever"])
@room3 = Room.new("Mad 90s", 50, ["Rhythm is a Dancer","Still Dre","Barbie Girl"])
@front_desk = FrontDesk.new([@room1, @room2, @room3])

# Methods

def run_main_menu()
  choice = ""
  while choice != "5"
    if choice == ""
      puts "\e[H\e[2J"
      puts "Hi, I'm KaraokeBot! Please select 1, 2, 3 or 4!"
    else
      puts "Thanks for using KaraokeBot! Can I help with anything else?"
    end
    puts ""
    puts "1. Check if a particular room is available"
    puts "2. Make a reservation"
    puts "3. Check in"
    puts "4. Check out"
    puts "5. Exit"
    puts ""
    choice = gets.chomp
    case choice
      when "1"
        is_room_available()
      when "2"
        make_reservation()
      when "3"
        check_in()
      when "4"
        check_out()
    end
  end
end

def get_room()
  puts "These are our rooms - please select one to see if it's available!"
  puts "1. #{@front_desk.rooms[0].name}"
  puts "2. #{@front_desk.rooms[1].name}"
  puts "3. #{@front_desk.rooms[2].name}"
  room_choice = gets.chomp
  case room_choice
    when "1"
      room = @front_desk.rooms[0]
    when "2"
      room = @front_desk.rooms[1]
    when "3"
      room = @front_desk.rooms[2]
  end
  return room
end

def get_party_size()
  puts "How big is your party?"
  party_size = gets.chomp.to_i
end

def is_room_available()
  puts "\e[H\e[2J"
  puts "You chose to check if a particular room is available"
  party_size = get_party_size()
  room = get_room()
  if (@front_desk.is_room_available?(room, party_size)) == true
    puts "\e[H\e[2J"
    puts "#{room.name} is available for your party size!"
  else
    puts "#{room.name} is not available for a party that big!"
  end
end

def get_guest()
  puts "Please enter your name"
  name = gets.chomp.to_s.capitalize
  puts "Please tell me how much money is in your wallet"
  wallet = gets.chomp.to_i
  puts "Please tell me your favourite song"
  favourite_song = gets.chomp.to_s.capitalize
  return Guest.new(name, wallet, favourite_song)
end

def get_guest_name()
  puts "Please enter your name"
  name = gets.chomp.to_s.capitalize
  return name
end

def make_reservation()
  puts "\e[H\e[2J"
  puts "You chose to make a reservation"
  guest = get_guest()
  room = get_room()
  party_size = get_party_size()
  reservation = @front_desk.create_reservation(guest, room, party_size)
  if reservation == nil
    puts "Sorry, we were unable to make the reservation."
    puts "Maybe you can't or afford it, or the room isn't available."
    puts ""
  else
    puts reservation
    puts ""
  end
end

def check_in()
  puts "\e[H\e[2J"
  puts "You chose to check in"
  guest_name = get_guest_name()
  check_in = @front_desk.check_in_by_name(guest_name)
  puts check_in
  puts ""
end

def check_out()
  puts "\e[H\e[2J"
  puts "You chose to check out"
  guest_name = get_guest_name()
  check_out = @front_desk.check_out_by_name(guest_name)
  puts check_out
  puts ""
end

# Everything else
run_main_menu()
