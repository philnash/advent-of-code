class GuardRecord
  def self.time_format
    "%Y-%m-%d %H:%M"
  end

  def self.parse_list(lines)
    lines.map { |line| self.parse(line) }.compact.sort { |a,b| a.time <=> b.time }
  end

  def self.parse(text)
    time_stamp = text.match(/\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2})\]/)
    if time_stamp
      time = Time.parse_utc(time_stamp[1], time_format)
      guard_id = text.match(/#(\d+)\s/)
      if guard_id
        return GuardRecord.new(time, guard_id[1], GuardAction::BeginsShift)
      elsif text.match(/falls asleep/)
        return GuardRecord.new(time, nil, GuardAction::FallsAsleep)
      else
        return GuardRecord.new(time, nil, GuardAction::WakesUp)
      end
    end
  end

  getter time : Time
  getter guard_id : String | Nil
  getter action : GuardAction

  def initialize(@time, @guard_id, @action)
  end

  def to_s
    if guard_id
      "[#{time.to_s(GuardRecord.time_format)}] Guard ##{guard_id} begins shift"
    elsif action.falls_asleep?
      "[#{time.to_s(GuardRecord.time_format)}] falls asleep"
    else
      "[#{time.to_s(GuardRecord.time_format)}] wakes up"
    end
  end
end

enum GuardAction
  BeginsShift
  FallsAsleep
  WakesUp
end

class Guard
  getter id : String
  getter minutes_asleep : Int32
  getter sleeping_minutes : Array(Int32)

  def initialize(@id)
    @minutes_asleep = 0
    @sleeping_minutes = Array.new(60, 0)
  end

  def add_sleep_period(falls_asleep, wakes_up)
    @minutes_asleep += (wakes_up.time - falls_asleep.time).minutes
    (falls_asleep.time.minute...wakes_up.time.minute).to_a.each do |minute|
      @sleeping_minutes[minute] += 1
    end
  end

  def max_sleepy_minute
    max = @sleeping_minutes.max
    {@sleeping_minutes.index(max), max}
  end
end

class Guards
  getter guards : Array(Guard)
  def initialize()
    @guards = [] of Guard
  end

  def create_from_guard_records(records)
    current_guard = nil
    falls_asleep = nil
    records.each do |guard_record|
      if guard_record.guard_id
        current_guard = find_or_create(guard_record.guard_id.to_s)
      elsif guard_record.action.falls_asleep?
        falls_asleep = guard_record
      else
        if current_guard && falls_asleep
          current_guard.add_sleep_period(falls_asleep, guard_record)
        end
      end
    end
  end

  def find_or_create(id)
    guard = guards.find { |g| g.id == id }
    if !guard
      guard = Guard.new(id)
      @guards.push(guard)
    end
    return guard
  end
end