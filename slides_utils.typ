                      
// Color definitions for headers
#let blue = rgb("#0000FF").darken(35%)   // Primary theme color. Also used for definitions
#let red = rgb("#FF0000").darken(35%)    // Statments, theorems, important notes
#let green = rgb("#00FF00").darken(35%)  // Examples, practical application
#let cyan = rgb("#22d2d2")               // Tasks and exercises 
#let magenta = rgb(138, 0, 138)          // Exploration tasks and deeper understanding
#let yellow = rgb("C4853D")              // Warnings and cautions
#let gray = rgb("#7c7c7c")               // Neutral gray useful for code and equations
#let white = rgb("FFFFFF")               // White color

// Global variable for lighter versions of colors for focus boxes
#let percent_lighter = 88%

// Creates a colored header box for slides
#let slide-header(title, color, header-font-size) = context {
  let font-size = header-font-size

  set text(size: font-size)
  let header-height = if title != none { 1.6em } else { 1.5em }

  rect(
    fill: color,
    width: 100%,
    height: header-height,
    inset: .6cm,
    if title != none {
      text(white, weight: "regular", size: font-size)[
        #h(.1cm) #title
      ]
    },
  )
}

// Colored box for highlighting content (equations, code, notes)
// Args: text-size (1em), bg (gray), center_x (false), center_y (false), font (auto)
#let focusbox(
  text-size: 1em,
  bg: rgb("#F3F2F0"),
  center_x: false,
  center_y: false,
  font: auto,
  content,
) = context {
  let bg-color = bg.lighten(percent_lighter)
  let center_x_str = if center_x { center } else { left }
  let center_y_str = if center_y { horizon } else { top }

  // Get font - handle both string and state object
  let font-family = if font == auto {
    state("main-font", "Calibri").get()
  } else if type(font) == type(state("", "")) {
    font.get()
  } else {
    font
  }

  set align(center_x_str + center_y_str)
  set text(font: font-family, size: text-size)
  show raw: set text(font: font-family) // Apply font to code blocks too
  block(
    fill: bg-color,
    inset: (x: .8cm, y: .8cm),
    breakable: false,
    above: .9cm,
    below: .9cm,
    radius: (top: .2cm, bottom: .2cm),
  )[#content]
}

// Creates a multi-column layout for slide content
// Args: columns (auto = equal width), gutter (1em), bodies (variable number of content blocks)
// Example: #cols[Left content][Right content]
// Example: #cols(columns: (2fr, 1fr))[Wide][Narrow]
// fr stands for "fractional unit"
#let cols(columns: auto, gutter: 1em, ..bodies) = {
  let bodies = bodies.pos()

  let columns = if columns == auto {
    (1fr,) * bodies.len()
  } else {
    columns
  }

  if columns.len() != bodies.len() {
    panic("Number of columns must match number of content blocks")
  }

  grid(columns: columns, gutter: gutter, ..bodies)
}
