#import "slides_core.typ": *
#import "@preview/cetz:0.3.1"

// Configure the presentation
#show: slides.with(
  ratio: "16-9", // Default is "16-9" if not set. The ratio "4-3" is also supported.
  main-font: "Calibri",  // Default value is can be tweaked in slides_core.typ
  code-font: "Consolas", // Default value is can be tweaked in slides_core.typ
  font-size-headers: 20pt, // Default value is can be tweaked in slides_core.typ
  font-size-content: 18pt, // Default value is can be tweaked in slides_core.typ
  footer_text: "Heggen videregående skole", // Text to show in the footer. Empty by default if not set.
  equation_numbering_globally: true, // Default set to "false" if not set. 
)

// Blue header slide
#slide(headercolor: blue, title: "Blue Header Slide")[
  - Simple, clean and consistent design
  - If `headercolor` is not set, it defaults to `blue`. (Colors can be tweaked in slides_utils.typ)
  - Font family can be changed globally (not per slide) in the `slides` configuration

  #focusbox(bg: gray, center_x: false, text-size: 0.7em)[
    ```typst
    // Configure the presentation
    #show: slides.with(
      ratio: "16-9", // Default is "16-9" if not set
      main-font: "Calibri",  // Default value is "Calibri" if not set
      code-font: "Consolas", // Default value is "Consolas" if not set
      font-size-headers: 20pt, // 22pt is the default value if not set
      font-size-content: 19pt, // 20pt is the default value if not set
      footer_text: "", // Text to show in the footer. Empty by default if not set.
      equation_numbering_globally: true, // Default set to "false" if not set. 
)
    ```
  ]
  *Note:* Example of a gray focusbox with smaller font size to show the global slides configuration. The lightening of the focusbox background color is controlled in `slides_utils.typ` with the variable 'percent_lighter'
]
  
#slide(headercolor: blue, title: "Including Images")[
You can include images using the `#figure` command:

```typst
#figure(
  image("Leonhard_Euler.jpg", width: 15%),
  caption: [Leonhard Euler],
) <img:LeonhardEuler>
```

  #figure(
    image("Leonhard_Euler.jpg", width: 15%),
    caption: [Leonhard Euler],
  ) <img:LeonhardEuler>

  Arguably the GOAT of mathematics: @img:LeonhardEuler (referenced with Typst’s @ syntax).
]


// Mixed numbered and unnumbered equations
#slide(headercolor: gray, title: "Numbered vs unnumbered equations using '#set math.equation(numbering: none)' ")[
  *Problem:* A ball is thrown upward with initial velocity $v_0 = 15 "m/s"$. Find the maximum height.

  Start with the kinematic equation:

  $ v^2 = v_0^2 - 2 g h $ <eq:kinematic>

  At maximum height, the velocity is zero, so we set $v = 0$:

  #[
    #set math.equation(numbering: none)
    $ 0 = v_0^2 - 2 g h $
    $ h = v_0^2 / (2 g) $
  ]

  Substitute $v_0 = 15 "m/s"$ and $g = 9.8 "m/s"^2$:

  $ h = (15^2) / (2 times 9.8) = 11.5 "m" $ <eq:result>

  Only @eq:kinematic and @eq:result are numbered.
]

// Red header slide with theorem
#slide(headercolor: red, title: "Red header slide with theorem in focusbox")[
  Here's Taylor's theorem using Typst math syntax (not LaTeX):

  #focusbox(bg: red, center_x: false)[
    *Taylor's theorem:* Let $k >= 1$ be an integer and let the function $f : RR -> RR$ be $k$ times differentiable at the point $a in RR$. 
    
    Then there exists a function $h_k : RR -> RR$ such that
    $ f(x) = sum_(i=0)^k (f^(i)(a))/(i!) (x - a)^i + h_k (x) (x - a)^k, $
    
    and $lim_(x -> a) h_k (x) = 0.$
  ]

  Equation numbering is default set to false, but can be turned on by setting `equation_numbering_globally: true` in the `slides` configuration.
]

// Green header slide with Taylor series example
#slide(headercolor: green, title: "Taylor Series Example", slide-equation-numbering: false)[
  Green header slides are recommended for examples and practical applications.
  #focusbox(bg: green, center_x: true, text-size: 1.1em, width: 90%)[
    *Example:* Taylor series for $e^x$ around $a = 0$:

    
    Since $f(x) = e^x$, all derivatives are $f^(n)(x) = e^x$, and $f^(n)(0) = 1$ for all $n$.
    
    Therefore, the Taylor series is:
    $ e^x = sum_(n=0)^infinity (x^n)/(n!) = 1 + x + x^2/(2!) + x^3/(3!) + x^4/(4!) + dots.h.c $
    
    This series converges for all $x in RR$.
  ]

  *Note:* This is a green x-centered focusbox with 90% width, slightly bigger font size   and equation numbering is turned off for only this slide using `slide-equation-numbering: false`.
]

// Green header slide
#slide(headercolor: green, title: [Python code for calculating $e^x$ using the Taylor series])[
  Here’s a Python example that approximates $e^x$ using its Taylor series. *Note:* The code is shown in a white focusbox for readability and easy font-size control.
  #focusbox(bg: white, center_x: false, width: 100% , text-size: 0.85em)[
    ```python
    import math
    def exp_taylor(x, N=10):
        """Approximate e^x using the Taylor series sum_{n=0}^N x^n/n!."""
        total = 1.0  # n = 0 term
        term = 1.0
        for n in range(1, N + 1):
            term = term * x / n
            total = term + total
        return total
    x, N  = 1.0, 10
    approx = exp_taylor(x, N)
    print(f"N={N}: {approx}")
    print("math.exp(1) =", math.exp(1.0))
    ```
  ]
]


#slide(headercolor: cyan, title: "Student Task (1:2 Columns)")[
  Cyan header slides are recommended for explicit student tasks and exercises.
  #cols(columns: (1fr, 2fr))[
    *Task*
    #focusbox(bg: cyan, center_x: false)[

    Compute the integral:
    $ integral x e^x dif x $
    ]
  ][
    *Hint*

      Use integration by parts:

      $ integral u dif v = u v - integral v dif u $

      choose $u = x$ and $v' = e^x$, then $u' = 1 $ and $v = e^x$.
  ]
]

#slide(headercolor: yellow, title: "Centering Slide Content", center_x: true, center_y: false)[
  By default, slides are:
  - Left-aligned horizontally 
  - Centered vertically

  This slide *overrides both to center content horizontally and vertically*.

  #focusbox(bg: gray, center_x: false, text-size: 0.85em)[
    ```typst
    #slide(headercolor: purple, title: "Centering Slide Content", center_x: true, center_y: false)[
      
    ]
    ```
  ]
]


// Calculations in Typst
#slide(headercolor: blue, title: "Live Calculations")[
  Typst can perform calculations directly in the document:

  #cols[
    *Output*

    *Basic arithmetic:*
    - Addition: #(2 + 3)
    - Multiplication: #(7 * 8)
    - Division: #(100 / 4)

    *Using variables:*
    #let mass = 10
    #let acceleration = 9.8
    #let force = mass * acceleration
    - Mass = #mass kg
    - Acceleration = #acceleration m/s²
    - Force = #force N

    *Math functions:*
    - $sqrt(15) = #(calc.sqrt(15))$
    - $2^8 = #(calc.pow(2, 8))$
    - $sin(pi/2) = #(calc.sin(calc.pi / 2))$
  ][
    *Code*

    #focusbox(bg: gray, center_x: false, text-size: 0.75em)[
      ```typst
      #(2 + 3)
      #(7 * 8)
      #(100 / 4)

      #let mass = 10
      #let acceleration = 9.8
      #let force = mass * acceleration
      #mass
      #acceleration
      #force

      #(calc.sqrt(15))
      #(calc.pow(2, 8))
      #(calc.sin(calc.pi / 2))
      ```
    ]
  ]
]

// Programming: Series Generation (Python-style loops)
#slide(headercolor: blue, title: "Generating Series using code directly in the document (Part 1)")[
  #cols[
    *Output*

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
  ][
    *Code*

    #focusbox(bg: gray, center_x: false, text-size: 0.75em)[
      ```typst
      // Squares
      #{
        let squares = ()
        for i in range(1, 11) {
          squares.push(i * i)
        }
        squares.map(str).join(", ")
      }

      // Sum
      #{
        let _sum = 0
        for i in range(1, 101) {
          _sum += i
        }
        [$ sum_(i=1)^100 i = #_sum $]
      }
      ```
    ]
  ]
]

#slide(headercolor: blue, title: "Generating Series using code directly in the document (Part 2)")[
  #cols[
    *Output*

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
  ][
    *Code*

    #focusbox(bg: gray, center_x: false, text-size: 0.75em)[
      ```typst
      // Fibonacci
      #{
        let fib = (0, 1)
        for i in range(2, 12) {
          fib.push(fib.at(-1) + fib.at(-2))
        }
        fib.map(str).join(", ")
      }

      // Powers of 2
      #{
        let powers = ()
        for i in range(0, 11) {
          powers.push(calc.pow(2, i))
        }
        powers.map(str).join(", ")
      }
      ```
    ]
  ]
]


#slide(headercolor: blue, title: "Test 3: Basic Pauses")[
  - First point appears first
  
  #pause
  
  - Second point appears second
  
  #pause
  
  - Third point appears third
  
  #pause

]