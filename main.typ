#import "slides_core.typ": *

// Configure the presentation
#show: slides.with(
  ratio: "16-9",
  main-font: default-main-font,
  code-font: default-code-font,
  font-size-headers: 23pt,
  font-size-content: 20pt,
  footer_text: "",
)



// Enable automatic equation numbering
#set math.equation(numbering: "(1)")

// Blue header slide
#slide(headercolor: blue, title: "Blue Header Slide")[
  - This is a slide with a blue header
  - Add your content here
  - Simple and clean
]

// Red header slide
#slide(headercolor: red, title: "Red Header Slide")[
  - This is a slide with a red header
  - You can add lists
  - Or any other content

]

// Yellow header slide
#slide(headercolor: yellow, title: "Yellow Header Slide")[
  This slide has a yellow header.

  You can use paragraphs and other formatting.
]

// Green header slide
#slide(headercolor: green, title: "Green Header Slide")[
  - Green is great for positive messages
  - Environmental topics
  - Success stories
]

// Slide without title (just colored bar)
#slide(headercolor: purple)[
  This slide has no title, just a purple colored bar at the top.

  The content area is slightly larger.
]

// Slide with equations using focusbox boxes
#slide(headercolor: gray, title: "Math Equations")[
  Here's a highlighted equation:

  #focusbox(bg: gray)[
    $ E = m c^2 $
  ]

  Multiple aligned equations with one number:

  #focusbox(text-size: 20pt)[
    $
      x & = (-b plus.minus sqrt(b^2 - 4a c)) / (2a) \
      y & = a x^2 + b x + c
    $
  ]
]

// Slide with colored backgrounds
#slide(headercolor: blue, title: "Colored Backgrounds")[
  Colors are automatically lightened:

  #focusbox(bg: blue)[
    $ a^2 + b^2 = c^2 $
  ]

  #focusbox(bg: green)[
    $ sum_(i=1)^n i = (n(n+1))/2 $
  ]

  #focusbox(bg: red, text-size: 18pt)[
    Important: $ Delta = b^2 - 4a c $
  ]
]

// More colored examples
#slide(headercolor: yellow, title: "Different Color Options")[
  #focusbox(bg: yellow, text-size: 0.9em)[
    $ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $
  ]

  #focusbox(bg: purple)[
    $ lim_(x arrow infinity) (1 + 1/x)^x = e $
  ]

  #focusbox(bg: gray)[
    $ nabla times bold(E) = - (partial bold(B))/(partial t) $
  ]
]

// Math theorem example with text and equations
#slide(headercolor: red, title: "Pythagorean Theorem")[
  One of the most fundamental theorems in mathematics:

  #focusbox(bg: red, center_x: false, font: "Comic Sans MS")[
    *Theorem (Pythagoras):* In a right triangle, the square of the hypotenuse equals the sum of the squares of the other two sides.

    $ a^2 + b^2 = c^2 $

    where $c$ is the length of the hypotenuse and $a, b$ are the lengths of the other two sides.
  ]

  This theorem has countless applications in geometry, physics, and engineering.
]

// Python code example
#slide(headercolor: green, title: "Python Code Example")[
  Example of a simple Python function:

  #focusbox(bg: gray, center_x: false, font: code-font-state, text-size: 1em)[
    ```python
    def fibonacci(n):
        """Calculate the nth Fibonacci number."""
        if n <= 1:
            return n
        return fibonacci(n-1) + fibonacci(n-2)

    # Test the function
    for i in range(10):
        print(f"F({i}) = {fibonacci(i)}")
    ```
  ]

  This recursive function calculates Fibonacci numbers.
]


#slide(headercolor: blue, title: "Electric Field Visualization")[
  #figure(
    image("Electric-Field.jpg", width: 60%),
    caption: [Electric field lines around charged particles],
  ) <img:electric-field>

  See @img:electric-field for the field visualization.
]


// Two-column layout example
#slide(headercolor: purple, title: "Two Column Layout")[
  #cols[
    *Left Column*

    - Point 1
    - Point 2
    - Point 3

    You can put any content here.
  ][
    *Right Column*

    #focusbox(bg: purple)[
      $ E = m c^2 $
    ]

    More content on the right side.
  ]
]

// Custom column widths example
#slide(headercolor: green, title: "Custom Column Widths")[
  #cols(columns: (2fr, 1fr))[
    *Wide Column (2fr)*

    #focusbox(bg: green, center_x: false)[
      This column takes up twice the space of the narrow column.

      $ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $
    ]
  ][
    *Narrow (1fr)*

    Smaller content.
  ]
]

// Numbered equations example
#slide(headercolor: red, title: "Numbered Equations")[
  Einstein's famous mass-energy equation:

  $ E = m c^2 $ <eq:einstein>

  The quadratic formula:

  $ x = (-b plus.minus sqrt(b^2 - 4a c)) / (2a) $ <eq:quadratic>

  Pythagorean theorem:

  $ a^2 + b^2 = c^2 $ <eq:pythagoras>

  We can reference these equations: @eq:einstein, @eq:quadratic, and @eq:pythagoras.
]

// Mixed numbered and unnumbered equations
#slide(headercolor: yellow, title: "Numbered vs Unnumbered")[
  Some equations should be numbered:

  $ E = m c^2 $ <eq:energy>

  But intermediate steps don't need numbers:

  #[
    #set math.equation(numbering: none)
    $ F = m a $
    $ p = m v $
  ]

  Final result gets numbered:

  $ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $ <eq:gaussian>

  Only @eq:energy and @eq:gaussian are numbered.
]

// Calculations in Typst
#slide(headercolor: cyan, title: "Live Calculations")[
  Typst can perform calculations directly in the document:

  #focusbox(bg: cyan, center_x: false)[
    *Basic arithmetic:*
    - Addition: #(2 + 3) = 5
    - Multiplication: #(7 * 8) = 56
    - Division: #(100 / 4) = 25
  ]

  *Using variables:*
  #let mass = 10
  #let acceleration = 9.8
  #let force = mass * acceleration

  - Mass = #mass kg
  - Acceleration = #acceleration m/s²
  - Force = #force N

  *Math functions:*
  - Square root: $sqrt(15) = #(calc.sqrt(15))$
  - Power: $2^8 = #(calc.pow(2, 8))$
  - Sin(π/2) = #(calc.sin(calc.pi / 2))
  - Log(100) = #(calc.log(100))
  - Exponential: $e^3 = #(calc.exp(3))$
  - Natural log: $ln(20) = #(calc.ln(20))$
  - Factorial: $5! = #(calc.fact(5))$

]

// Programming: Series Generation (Python-style loops)
#slide(headercolor: magenta, title: "Generating Series")[
  Using traditional for loops (Python-style):

  *Squares of first 10 numbers:*
  #{
    let squares = ()
    for i in range(1, 11) {
      squares.push(i * i)
    }
    squares.map(str).join(", ")
  }

  *Sum of first 100 natural numbers:*
  #{
    let _sum = 0
    for i in range(1, 101) {
      _sum += i
    }
    [$ sum_(i=1)^100 i = #_sum $]
  }

  *Fibonacci sequence (first 12 terms):*
  #{
    let fib = (0, 1)
    for i in range(2, 12) {
      fib.push(fib.at(-1) + fib.at(-2))
    }
    fib.map(str).join(", ")
  }

  *Powers of 2:*
  #{
    let powers = ()
    for i in range(0, 11) {
      powers.push(calc.pow(2, i))
    }
    powers.map(str).join(", ")
  }
]
