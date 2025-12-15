#import "slides_core.typ": *
#import "slides_utils.typ": *

// Configure the presentation
#show: slides.with(
  ratio: "16-9",
  font-size-headers: 20pt,
  font-size-content: 18pt,
  footer_text: "Pause Feature Demo",
)

// Test 1: Basic pause
#slide(headercolor: blue, title: "Test 1: Basic Pause")[
  This is the first line.

  #pause

  This is the second line (appears after pause).

  #pause

  This is the third line (appears after second pause).
]

// Test 2: Manual repeat specification
#slide(headercolor: green, title: "Test 2: Manual Repeat", repeat: 3)[
  Content 1

  #pause

  Content 2

  #pause

  Content 3
]

// Test 3: Bullet lists with pauses
#slide(headercolor: red, title: "Test 3: Bullet Lists")[
  Here are the key points:

  - First point is always visible

  #pause

  - Second point appears after first pause

  #pause

  - Third point appears after second pause

  #pause

  - Fourth point appears last
]

// Test 4: Meanwhile marker
#slide(headercolor: cyan, title: "Test 4: Meanwhile")[
  First section starts here.

  #pause

  First section continues.

  #meanwhile

  Second section starts (appears with first section).

  #pause

  Second section continues.
]

// Test 5: Mixed content
#slide(headercolor: magenta, title: "Test 5: Mixed Content")[
  *Introduction*

  Some introductory text.

  #pause

  *Main Content*

  #focusbox(bg: blue)[
    This is important content in a focusbox.
  ]

  #pause

  *Conclusion*

  Final thoughts and summary.
]

// Test 6: No pauses (should work as before)
#slide(headercolor: gray, title: "Test 6: No Pauses")[
  This slide has no pauses.

  All content appears at once.

  This is the expected behavior for backward compatibility.
]

// Test 7: Code blocks with pauses
#slide(headercolor: yellow, title: "Test 7: Code with Pauses")[
  Let's look at some code:

  #pause

  ```python
  def hello():
      print("Hello, World!")
  ```

  #pause

  This function prints a greeting message.
]
