+++++++             # Set number of powers of two to be computed in cell #0
>                   # Keep cell #1 to be 0 so we can find it again
>+<<                # Store 1 (the first power of 2) in cell #2 & back to cell #0
[
  ->>               # Decrease counter & skip past cell #1
  [>]<              # Search next zero valued cell #X and use the one before it as a counter
  [->+>+<<]         # Copy the value in #X to #X1 & #X2
  >>                # Use #X2 to count down again
  [-<+<+>>]         # Add the value in #X2 to #X (which now starts at zero) and #X1 (which now starts at the original value of #X)
  <[<]<             # Go back to cell #0 via #1 (who's value is 0) 
]
?
