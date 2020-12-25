class Door
  def self.transform(subject : Int32, loop_size : Int32, value = 1)
    value = value.to_i64
    loop_size.times do
      value = value * subject
      value = value % 20201227
    end
    value
  end

  def self.find_loop_size(subject : Int32, public_key : Int32)
    loop_size = 1
    key = transform(subject, 1)
    while key != public_key
      key = transform(subject, 1, key)
      loop_size += 1
    end
    loop_size
  end
end

puts Door.transform(7, 8)
puts Door.transform(7, 11)

puts Door.find_loop_size(7, 5764801)
puts Door.find_loop_size(7, 17807724)

puts Door.transform(17807724, 8)
puts Door.transform(5764801, 11)

card_key, door_key = File.read_lines("./days/day25.txt").map(&.to_i)
card_loop_size = Door.find_loop_size(7, card_key)
door_loop_size = Door.find_loop_size(7, door_key)

puts Door.transform(card_key, door_loop_size)
puts Door.transform(door_key, card_loop_size)
