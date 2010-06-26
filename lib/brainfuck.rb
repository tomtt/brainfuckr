if defined?(Gem) && Gem.available?('ruby-debug')
  require 'ruby-debug'
end

class Brainfuck
  class DataPointerError < StandardError; end
  class SyntaxError < StandardError; end

  NUMBER_OF_VALUES = 256

  attr_reader :input, :output, :tape, :data_pointer

  def initialize(program)
    @program = program
    @output = ""
    @tape = [0]
    @data_pointer = 0
    @instruction_pointer = 0
    @instruction_count = 0
    compute_jump_indices
  end

  def execute(input = [])
    @input = input
    while(@instruction_pointer < @program.size) do
      @instruction_count += 1
      # debugger if @instruction_count > 10000
      case @program[@instruction_pointer].chr
      when ">"
        execute_ptr_right
      when "<"
        execute_ptr_left
      when "+"
        execute_incr
      when "-"
        execute_decr
      when "["
        if @tape[@data_pointer] == 0
          execute_jump_forward
          next
        end
      when "]"
        if @tape[@data_pointer] != 0
          execute_jump_backward
        end
      when "."
        execute_put
      when ","
        execute_get
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
    raise DataPointerError unless @data_pointer > 0
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
    # @instruction_pointer = @program.index(']', @instruction_pointer)
    @instruction_pointer = @closing_for_opening[@instruction_pointer]
  end

  def execute_jump_backward
    # @instruction_pointer = @program.rindex('[', @instruction_pointer)
    @instruction_pointer = @opening_for_closing[@instruction_pointer]
  end

  def compute_jump_indices
    opening_loops = []
    @closing_for_opening = {}
    @opening_for_closing = {}
    @program.size.times do |index|
      case @program[index].chr
      when '['
        opening_loops << index
      when ']'
        raise SyntaxError.new("Unmatched ']'") if opening_loops.empty?
        opening = opening_loops.pop
        @closing_for_opening[opening] = index
        @opening_for_closing[index] = opening
      end
    end
    raise SyntaxError.new("Unmatched '['") unless opening_loops.empty?
  end
end
