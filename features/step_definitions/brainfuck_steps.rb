Given /^the following brainfuck program:$/ do |program|
  @last_brainfuck_program = Brainfuck.new(program)
end

When /^that brainfuck program is executed$/ do
  @last_brainfuck_program.execute
end

Then /^the output of that brain fuck program should be "([^\"]*)"$/ do |expected_output|
  expected_output.gsub!('\\n', "\n")
  @last_brainfuck_program.output.should == expected_output
end
