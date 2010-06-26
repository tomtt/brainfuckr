Feature: Brainfuck interpreter
  In order to experiment with the brainfuck language
  A programmer
  Must be able to see the result of a brainfuck program

  Scenario: Hello World on a single line
    Given the following brainfuck program:
      """
++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.
      """
    When that brainfuck program is executed
    Then the output of that brain fuck program should be "Hello World!\n"

  Scenario: Print a single character
    Given the following brainfuck program:
      """
+++++++++++++++++++++++++++++++++.
      """
    When that brainfuck program is executed
    Then the output of that brain fuck program should be "!"
