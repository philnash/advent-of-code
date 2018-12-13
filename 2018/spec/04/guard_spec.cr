require "spec"
require "../../04/guard"

input = ["[1518-11-03 00:29] wakes up", "[1518-11-01 00:55] wakes up", "[1518-11-01 00:00] Guard #10 begins shift", "[1518-11-03 00:05] Guard #10 begins shift", "[1518-11-01 00:30] falls asleep", "[1518-11-02 00:50] wakes up", "[1518-11-05 00:03] Guard #99 begins shift", "[1518-11-04 00:02] Guard #99 begins shift", "[1518-11-01 00:25] wakes up", "[1518-11-01 00:05] falls asleep", "[1518-11-01 23:58] Guard #99 begins shift", "[1518-11-05 00:45] falls asleep", "[1518-11-05 00:55] wakes up", "[1518-11-02 00:40] falls asleep", "[1518-11-03 00:24] falls asleep", "[1518-11-04 00:36] falls asleep", "[1518-11-04 00:46] wakes up"]

result = <<-STRING
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up
STRING

describe GuardRecord do
  it "parses a record with an id" do
    guard_record = GuardRecord.parse("[1518-11-01 00:00] Guard #10 begins shift")
    if guard_record
      guard_record.guard_id.should eq("10")
      guard_record.time.should eq(Time.utc(1518, 11, 1, 0, 0))
    else
      raise("Did not create a guard record")
    end
  end

  it "parses a record with an action" do
    guard_record = GuardRecord.parse("[1518-11-01 00:05] falls asleep")
    if guard_record
      guard_record.guard_id.should be_nil
      guard_record.time.should eq(Time.utc(1518, 11, 1, 0, 5))
      guard_record.action.should eq(GuardAction::FallsAsleep)
    else
      raise("Did not create a guard record")
    end
  end

  it "parses a record with an action" do
    guard_record = GuardRecord.parse("[1518-11-01 00:05] wakes up")
    if guard_record
      guard_record.guard_id.should be_nil
      guard_record.time.should eq(Time.utc(1518, 11, 1, 0, 5))
      guard_record.action.should eq(GuardAction::WakesUp)
    else
      raise("Did not create a guard record")
    end
  end

  it "parses a list of records and sorts them" do
    guard_records = GuardRecord.parse_list(input)
    guard_records.map(&.to_s).join("\n").should eq(result)
  end
end

describe Guards do
  it "creates guards from guard records" do
    guard_records = GuardRecord.parse_list(input)
    guards = Guards.new
    guards.create_from_guard_records(guard_records)
    guards.guards.size.should eq(2)
    guard10 = guards.find_or_create("10")
    guard10.minutes_asleep.should eq(50)
    guard10.max_sleepy_minute.should eq({24, 2})
    guard99 = guards.find_or_create("99")
    guard99.minutes_asleep.should eq(30)
    guard99.max_sleepy_minute.should eq({45, 3})
  end
end