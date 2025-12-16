#import "slides_core.typ": *

#show: slides.with(ratio: "16-9")

// Test 1: Basic pause
#slide(headercolor: blue, title: "Test 1: Basic Pause")[
  This is the first line.

  #pause

  This is the second line (appears after pause).

  #pause

  This is the third line (appears after second pause).
]
