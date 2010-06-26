Feature: Brainfuck command line
  In order to run brainfuck source files
  A programmer
  Must be able to run them from the command line

  Scenario: Hello World on a single line
    When I run "../../bin/brainfuckr ../../bf_src/short_beer.b"
    Then I should see:
"""
3 bottles of beer on the wall, 3 bottles of beer.
Take one down and pass it around, 2 bottles of beer on the wall.

2 bottles of beer on the wall, 2 bottles of beer.
Take one down and pass it around, 1 bottle of beer on the wall.

1 bottle of beer on the wall, 1 bottle of beer.
Take one down and pass it around, no more bottles of beer on the wall.
"""
