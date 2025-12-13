#import "slides_utils.typ": *

// Default configuration constants
// Comand line command to list fonts: typst fonts
// Recomended dyslectic friendly fonts: OpenDyslexic, Comic Sans MS
#let default-header-font-size = 21pt
#let default-content-font-size = 21pt
#let default-main-font = "Calibri"
#let default-code-font = "Consolas"

// State variables to pass configuration from slides() to slide() function
// To list available system fonts, use the command: typst fonts
#let header-font-size-state = state("header-font-size", default-header-font-size)
#let main-font-state = state("main-font", default-main-font)
#let code-font-state = state("code-font", default-code-font)
#let equation-numbering-state = state("equation-numbering", "(1)")
#let reset-equation-state = state("reset-equation", true)
#let footer-text-state = state("footer-text", "")

// Main configuration function for presentations
#let slides(
  ratio: "16-9",
  // The font family for the entire presentation. Can be controlled per slide too.
  main-font: default-main-font,
  code-font: default-code-font,
  // The font sizes for all elements can be customized in each slide using em-units
  font-size-headers: default-header-font-size, // Default header font size that also affects slide header height
  font-size-content: default-content-font-size, // Default content font size. 
  footer_text: "", // Text to show in the footer. Empty by default.
  reset_equation_numbers_per_slide: true, // Reset equation numbering on each slide
  equation_numbering: true, // Enable automatic equation numbering that starts on 1. Set to false to disable.
  body,
) = {
  header-font-size-state.update(font-size-headers)
  main-font-state.update(main-font)
  code-font-state.update(code-font)
  reset-equation-state.update(reset_equation_numbers_per_slide)
  footer-text-state.update(footer_text)
  let numbering_format = if equation_numbering { "(1)" } else { none }
  equation-numbering-state.update(numbering_format)
  set text(font: main-font, size: font-size-content)
  set page(paper: "presentation-" + ratio, fill: white)
  set math.equation(numbering: numbering_format)
  body
}

// Slide with colored header
#let slide(
  headercolor: blue,
  title: none,
  slide-main-font: none,
  slide-main-font-size: none,
  slide-code-font: none,
  slide-code-font-size: none,
  body,
) = {
  set page(
    fill: white,
    header-ascent: if title != none { 65% } else { 66% },
    header: [],
    margin: if title != none {
      (x: 1.6cm, top: 2.5cm, bottom: 1.2cm)
    } else {
      (x: 1.6cm, top: 1.75cm, bottom: 1.2cm)
    },
    background: context {
      place(slide-header(title, headercolor, header-font-size-state.get()))
    },
    footer: context [
      #set text(size: 12pt, fill: gray)
      #grid(
        columns: (1fr, 1fr),
        align: (left + horizon, right + horizon),
        footer-text-state.get(),
        counter(page).display("1 / 1", both: true)
      )
    ],
  )

  set par(justify: true)
  set align(horizon)

  // Apply slide-specific font settings
  context {
    let font = if slide-main-font != none { slide-main-font } else { main-font-state.get() }
    let size = if slide-main-font-size != none { slide-main-font-size } else { text.size }
    let code-font-val = if slide-code-font != none { slide-code-font } else { code-font-state.get() }
    let code-size = slide-code-font-size
    set text(font: font, size: size)
    show raw: set text(font: code-font-val, size: if code-size != none { code-size } else { size })

    // Reset equation numbering for each slide
    if reset-equation-state.get() == true {
      counter(math.equation).update(0)
    }

    v(0cm)
    body
  }
}
