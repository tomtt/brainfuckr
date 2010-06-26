if defined?(Gem) && Gem.available?('ruby-debug')
  require 'ruby-debug'
end

class Brainfuck
  class Data_PointerError < StandardError; end

  NUMBER_OF_VALUES = 256

  attr_reader :input, :output, :tape, :data_pointer

  def initialize(program)
    @program = program
    @output = ""
    @tape = [0]
    @data_pointer = 0
    @instruction_pointer = 0
    @instruction_count = 0
  end

  def execute(input = [])
    @input = input
    while(@instruction_pointer < @program.size) do
      @instruction_count += 1
      debugger if @instruction_count > 10000
      case @program[@instruction_pointer].chr
      when "."
        execute_put
      when ">"
        execute_ptr_right
      when "<"
        execute_ptr_left
      when "+"
        execute_incr
      when "-"
        execute_decr
      when ","
        execute_get
      when "["
        if @tape[@data_pointer] == 0
          execute_jump_forward
          next
        else
          @loop_start = @instruction_pointer
        end
      when "]"
        if @tape[@data_pointer] != 0
          execute_jump_backward
          next
        end
      end
      @instruction_pointer += 1
    end
    self
  end

  def state
    state = "\n"
    state += @program + "\n"
    state += " " * @instruction_pointer + "^\n"
    state += "[%s]" % @tape.map { |value| sprintf("%3d" % value) }.join(", ") + "\n"
    state += " " + "     " * @data_pointer + "---\n"
    state
  end

  private

  def execute_put
    @output << @tape[@data_pointer]
  end

  def execute_ptr_left
    raise Data_PointerError unless @data_pointer > 0
    @data_pointer -= 1
  end

  def execute_ptr_right
    @data_pointer += 1
    if @tape.size == @data_pointer
      @tape << 0
    end
  end

  def execute_incr
    @tape[@data_pointer] = (@tape[@data_pointer] + 1) % NUMBER_OF_VALUES
  end

  def execute_decr
    @tape[@data_pointer] = (@tape[@data_pointer] - 1) % NUMBER_OF_VALUES
  end

  def execute_get
    @tape[@data_pointer] = @input.shift
  end

  def execute_jump_forward
    @instruction_pointer = @program.index(']', @instruction_pointer) + 1
  end

  def execute_jump_backward
    @instruction_pointer = @loop_start
  end
end
