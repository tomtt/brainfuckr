require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Brainfuck" do
  context "before execution" do
    subject { Brainfuck.new('') }
    its(:output) { should == "" }
    its(:tape) { should == [0] }
    its(:data_pointer) { should == 0 }
    its(:input) { should be_nil }
end

  context "after executing a simple program" do
    before do
      @program = "+>++>>+++++++++++++++++++++++++++++++++.<"
    end

    subject { Brainfuck.new(@program).execute }

    its(:output) { should == "!" }
    its(:tape) { should == [1, 2, 0, 33] }
    its(:data_pointer) { should == 2 }
    its(:input) { should == [] }
  end

  context "for a program that reads from input" do
    before do
      @program = ",>,<.>."
    end

    context "when executed with sufficient input" do
      subject { Brainfuck.new(@program).execute([88, 121]) }

      its(:output) { should == "Xy" }
      its(:tape) { should == [88, 121] }
      its(:data_pointer) { should == 1 }
      its(:input) { should == [] }
    end

    it "raises an error when executed with insufficient input" do
      lambda { Brainfuck.new(@program).execute([88]) }.should raise_error
    end
  end

  context "after executing a program that wraps cells beyond their min/max values" do
    before do
      @program = "->-->--+>--++"
    end

    subject { Brainfuck.new(@program).execute }

    its(:output) { should == "" }
    its(:tape) { should == [255, 254, 255, 0] }
    its(:data_pointer) { should == 3 }
    its(:input) { should == [] }
  end

  context "after executing a program that uses a single loop" do
    before do
      @program = "+++++++[->+++++<]>."
    end

    subject { Brainfuck.new(@program).execute }

    its(:output) { should == "#" }
    its(:tape) { should == [0, 35] }
    its(:data_pointer) { should == 1 }
    its(:input) { should == [] }
  end

  context "after executing a program that uses multiple loops" do
    before do
      @program = ",>,<[->>+>+<<<]>[->>>+>+<<<<]"
    end

    subject { Brainfuck.new(@program).execute([17, 23]) }

    its(:tape) { should == [0, 0, 17, 17, 23, 23] }
  end

  context "after executing a program that uses nested loops" do
    before do
      @program = "+++[->++++[->+++<]<]"
    end

    subject { Brainfuck.new(@program).execute }

    its(:tape) { should == [0, 0, 36] }
  end

  context "after executing a program with multiple loops some of which are not executed" do
    before do
      @program = "[][]++[->+++<]"
    end

    subject { Brainfuck.new(@program).execute }

    its(:tape) { should == [0, 6] }
  end

  it "puts whatever the state method returns when a '?' command is encountered" do
    bf = Brainfuck.new('?')
    bf.stub!(:state).and_return("my state")
    bf.should_receive(:puts).with("my state")
    bf.execute
  end

  it "raises an error when moving the data_pointer beyond the first position" do
    lambda { Brainfuck.new("<").execute }.should raise_error
  end

  it "raises a syntax error when executing a program with more opening braces than closing ones" do
    lambda { Brainfuck.new("+[+[-]").execute }.should raise_error(Brainfuck::SyntaxError, "Unmatched '['")
  end

  it "raises a syntax error when executing a program with more closing braces than opening ones" do
    lambda { Brainfuck.new("++]").execute }.should raise_error(Brainfuck::SyntaxError, "Unmatched ']'")
  end
end
