Feature: Brainfuck interpreter
  In order to experiment with the brainfuck language
  A programmer
  Must be able to see the result of a brainfuck program

  Scenario: Print a single character
    Given the following brainfuck program:
      """
++++[>++++++++<-]>+.
      """
    When that brainfuck program is executed
    Then the output of that brain fuck program should be "!"

  Scenario: Hello World on a single line
    Given the following brainfuck program:
      """
++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.
      """
    When that brainfuck program is executed
    Then the output of that brain fuck program should be "Hello World!\n"

  Scenario: Comments not using any brainfuck commands
    Given the following brainfuck program:
      """
+++++ +++++             initialize counter (cell #0) to 10
[                       use loop to set the next four cells to 70/100/30/10
    > +++++ ++              add  7 to cell #1
    > +++++ +++++           add 10 to cell #2
    > +++                   add  3 to cell #3
    > +                     add  1 to cell #4
    <<<< -                  decrement counter (cell #0)
]
> ++ .                  print 'H'
> + .                   print 'e'
+++++ ++ .              print 'l'
.                       print 'l'
+++ .                   print 'o'
> ++ .                  print ' '
<< +++++ +++++ +++++ .  print 'W'
> .                     print 'o'
+++ .                   print 'r'
----- - .               print 'l'
----- --- .             print 'd'
> + .                   print '!'
> .                     print '\n'
      """
    When that brainfuck program is executed
    Then the output of that brain fuck program should be "Hello World!\n"

  Scenario: Quine
    # This brainfuck program outputs itself, written by Keymaker
    # http://www.bf-hacks.org/programs.html
    Given the following brainfuck program:
      """
>>>++++>+>+>+>+>+>+>+>+>+++++>++++>+>+>+>+>+>+>+>+>+++>++>++++++>++++>++>++>+++++++>+++++++>+++>+++>+++++>+++>++++++>++++>+++++>+++>+>+>+>+>+>+>+>+>+++++>+++>+>+>+>+>+>+>+>+>++++>++>++++++>+++>++>++>+++++++>+>++++>+>+>+>+>+++++>+++>++>++>++>++>++>++++>++>++++++>++++>+++++>+++>+++>+++++++>++++>+>++++>++>++++++>+++>++>+++++>++>+++>+>+>++++>+++++>++>+++>+>+>+>+>+>+>+>+>+>+>+>+>+>+>+>++++>+++++>++>+++>+>+>++++>+++++>++>+++>++>++++>++++>+>+>+>+>+>+++++>+++>+++>+>+>+>+>+>+>++++>++++>++>++++++>+++>+++++>++>+++>+>+>++++>+++++>++>+++>+>++++>++++>+>+>+>+>+>+>+++++>+++>+++>++>++>++>++>++>++>++>++>++++>++++>++>++++++>+++>++++++>++++++>++++++>++++++>++++++>++++++>++++>++++>++++++>+++>+++>+++>+++++>+++>++++++>++++>+++++>+++++++>++++>++++++>++++++++[>++++++++<-]>--..<<[<]>[<++++++++[<++++++++>-]<--.+>++++[<----->-]>[<<.>+>-]<-[-<++>[-<+++++++++++++++>[-<++>[-<->>+++++[<<++++++>>-]<[-<++>[-<+>>++++++[<<-------->>-]<]]]]]]>>]<<<[<]>[.>]
      """
    When that brainfuck program is executed
    Then the output of that brain fuck program should be ">>>++++>+>+>+>+>+>+>+>+>+++++>++++>+>+>+>+>+>+>+>+>+++>++>++++++>++++>++>++>+++++++>+++++++>+++>+++>+++++>+++>++++++>++++>+++++>+++>+>+>+>+>+>+>+>+>+++++>+++>+>+>+>+>+>+>+>+>++++>++>++++++>+++>++>++>+++++++>+>++++>+>+>+>+>+++++>+++>++>++>++>++>++>++++>++>++++++>++++>+++++>+++>+++>+++++++>++++>+>++++>++>++++++>+++>++>+++++>++>+++>+>+>++++>+++++>++>+++>+>+>+>+>+>+>+>+>+>+>+>+>+>+>+>++++>+++++>++>+++>+>+>++++>+++++>++>+++>++>++++>++++>+>+>+>+>+>+++++>+++>+++>+>+>+>+>+>+>++++>++++>++>++++++>+++>+++++>++>+++>+>+>++++>+++++>++>+++>+>++++>++++>+>+>+>+>+>+>+++++>+++>+++>++>++>++>++>++>++>++>++>++++>++++>++>++++++>+++>++++++>++++++>++++++>++++++>++++++>++++++>++++>++++>++++++>+++>+++>+++>+++++>+++>++++++>++++>+++++>+++++++>++++>++++++>++++++++[>++++++++<-]>--..<<[<]>[<++++++++[<++++++++>-]<--.+>++++[<----->-]>[<<.>+>-]<-[-<++>[-<+++++++++++++++>[-<++>[-<->>+++++[<<++++++>>-]<[-<++>[-<+>>++++++[<<-------->>-]<]]]]]]>>]<<<[<]>[.>]"
