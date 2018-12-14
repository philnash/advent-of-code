class Step
  class_getter steps : Array(Step)
  @@steps = [] of Step

  getter id : String
  getter prerequisites : Array(Step)
  property complete : Bool
  property working : Bool
  getter base_delay : Int32

  def self.parse(text, base_delay=0)
    match = text.match(/^Step ([A-Z]) must be finished before step ([A-Z]) can begin.$/)
    if match
      step = Step.find_or_create(match[2], base_delay)
      step2 = Step.find_or_create(match[1], base_delay)
      step.prerequisites.push(step2)
      return step
    end
  end

  def self.parse_lines(lines, base_delay=0)
    lines.each { |line| self.parse(line, base_delay) }
  end

  def initialize(@id, @base_delay = 60, @prerequisites = [] of Step, @complete = false, @working = false)
    @@steps.push(self)
  end

  def ready?
    !complete && !working && @prerequisites.all? { |step| step.complete }
  end

  def id_delay
    id.char_at(0).ord - 64
  end

  def delay
    @base_delay + id_delay
  end

  def self.find_or_create(id, base_delay = 60)
    @@steps.find { |s| s.id == id } || Step.new(id, base_delay)
  end

  def self.next_step
    available_steps = @@steps.sort_by { |s| s.id }.select { |s| s.ready? }
    available_steps.first if available_steps.any?
  end

  def self.build
    order = ""
    while step = Step.next_step
      order += step.id
      step.complete = true
    end
    order
  end

  def self.complete
    @@steps.all? &.complete
  end

  def self.build_in_parallel(workers=1)
    order = ""
    current_time = 0
    working_steps = [] of Tuple(Step, Int32)
    while !complete
      working_steps = working_steps.map do |(step, time_left)|
        step.complete = true if time_left == 1
        {step, time_left-1}
      end
      working_steps = working_steps - working_steps.select { |(step, time_left)| time_left == 0 }
      while working_steps.size < workers && (step = Step.next_step)
        working_steps.push({step, step.delay})
        step.working = true
      end
      current_time += 1 unless working_steps.empty?
    end
    return current_time
  end

  def self.reset
    @@steps.clear
  end
end