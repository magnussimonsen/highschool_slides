#import "slides_utils.typ": *

// ============================================================================
// Defaults & Constants
// ============================================================================

// Fonts: Fallback lists ensure the template works across different OSs.
// "Liberation Sans" on Linux, "Calibri" on Windows, "Roboto" on Web.

// WINDOWS fonts list (to get wrid of warnings)
//#let default-main-font = ("Calibri", "Arial")
//#let default-code-font = ("Consolas", "Courier New")

// LINUX fonts list (to get rid of warnings)
//#let default-main-font = ("Liberation Sans", "Noto Sans", "Arial")
//#let default-code-font = ("Liberation Mono", "Noto Mono", "Courier New")

// Dyslexia-friendly alternative (uncomment to use)
#let default-main-font = ("Comic Neue", "OpenDyslexic")
#let default-code-font = ("Comic Neue", "OpenDyslexic")

// Font Sizes
#let default-header-font-size = 22pt
#let default-content-font-size = 20pt
#let default-focusbox-font-size = 1em
#let default-table-font-size = 1em

// Layout Constants
// These control the spacing and geometry of the slides.
#let layout-header-height-title = 1.6em
#let layout-header-height-no-title = 1.5em
#let layout-header-inset = 0.6cm
#let layout-top-margin-extra = 0.5cm
#let layout-top-margin-default = 1.75cm
#let layout-margin-x = 1.6cm
#let layout-margin-bottom = 1.2cm

// ============================================================================
// State Management
// ============================================================================

// We use state to pass configuration from the global `slides` show rule
// down to individual `slide` calls.
#let s-header-font-size = state("header-font-size", default-header-font-size)
#let s-main-font = state("main-font", default-main-font)
#let s-code-font = state("code-font", default-code-font)
#let s-equation-numbering = state("equation-numbering", "(1)")
#let s-reset-equation = state("reset-equation", false)
#let s-footer-text = state("footer-text", "")
#let s-focusbox-font-size = state("focusbox-font-size", default-focusbox-font-size)
#let s-table-font-size = state("table-font-size", default-table-font-size)
#let s-current-subslide = state("current-subslide", 1)

// ============================================================================
// Animation Helper Functions
// ============================================================================

// Count pause markers in content
#let count-pauses(body-content) = {
  let pause-count = 0
  let max-count = 0

  // Walk through content
  if type(body-content) == content and body-content.has("children") {
    for child in body-content.children {
      if type(child) == content {
        if child.func() == metadata and type(child.value) == dictionary {
          let kind = child.value.at("kind", default: none)
          if kind == "slides-pause" {
            pause-count += 1
            max-count = calc.max(max-count, pause-count)
          } else if kind == "slides-meanwhile" {
            max-count = calc.max(max-count, pause-count)
            pause-count = 1
          }
        }
      }
    }
  }

  calc.max(1, max-count)
}

// Process content for a specific subslide
// Hide content that appears after pauses not yet reached
#let process-content-for-subslide(body-content, target-subslide) = {
  // Helper to check if item is a pause/meanwhile marker
  let is-pause-marker(item) = {
    if type(item) != content { return (false, none) }
    if item.func() != metadata { return (false, none) }
    if type(item.value) != dictionary { return (false, none) }
    let kind = item.value.at("kind", default: none)
    if kind == "slides-pause" { return (true, "pause") }
    if kind == "slides-meanwhile" { return (true, "meanwhile") }
    return (false, none)
  }

  // Process sequence content by walking through children
  let current-step = 1
  let parts = ()
  let current-part = ()

  if type(body-content) == content and body-content.has("children") {
    for child in body-content.children {
      let (is-marker, marker-type) = is-pause-marker(child)

      if is-marker {
        if marker-type == "pause" {
          if current-part.len() > 0 {
            parts.push((step: current-step, content: current-part.sum(default: [])))
            current-part = ()
          }
          current-step += 1
        } else if marker-type == "meanwhile" {
          if current-part.len() > 0 {
            parts.push((step: current-step, content: current-part.sum(default: [])))
            current-part = ()
          }
          current-step = 1
        }
      } else {
        current-part.push(child)
      }
    }
  } else {
    // No children, return as-is
    return body-content
  }

  // Add remaining content
  if current-part.len() > 0 {
    parts.push((step: current-step, content: current-part.sum(default: [])))
  }

  // If no parts (no pauses found), return original content
  if parts.len() == 0 {
    return body-content
  }

  // Combine parts that should be visible at target-subslide
  let visible = ()
  for part in parts {
    if part.step <= target-subslide {
      visible.push(part.content)
    }
  }

  if visible.len() == 0 {
    return []
  }

  visible.sum(default: [])
}

// ============================================================================
// Main Configuration (Global)
// ============================================================================

#let slides(
  ratio: "16-9",
  main-font: default-main-font,
  code-font: default-code-font,
  font-size-headers: default-header-font-size,
  font-size-content: default-content-font-size,
  focusbox-font-size: default-focusbox-font-size,
  table-font-size: default-table-font-size,
  footer_text: "",
  reset_equation_numbers_per_slide: true,
  equation_numbering_globally: true,
  body,
) = {
  // Update global state with user configuration
  s-header-font-size.update(font-size-headers)
  s-main-font.update(main-font)
  s-code-font.update(code-font)
  s-focusbox-font-size.update(focusbox-font-size)
  s-table-font-size.update(table-font-size)
  s-reset-equation.update(reset_equation_numbers_per_slide)
  s-footer-text.update(footer_text)

  let numbering_format = if equation_numbering_globally { "(1)" } else { none }
  s-equation-numbering.update(numbering_format)

  // Apply global document settings
  set text(font: main-font, size: font-size-content)
  set page(paper: "presentation-" + ratio, fill: white)
  set math.equation(numbering: numbering_format)

  body
}

// ============================================================================
// Slide Definition
// ============================================================================

#let slide(
  headercolor: blue,
  title: none,
  center_x: false,
  center_y: true,
  slide-main-font: none,
  slide-main-font-size: none,
  slide-code-font: none,
  slide-code-font-size: none,
  slide-equation-numbering: auto,
  repeat: auto, // NEW: Number of subslides (auto = auto-detect from pauses)
  body,
) = {
  // Determine number of repetitions
  let actual-repeat = if repeat == auto {
    count-pauses(body)
  } else {
    repeat
  }

  // Generate one page for each subslide
  for subslide-index in range(1, actual-repeat + 1) {
    // Process body content for current subslide
    let processed-body = process-content-for-subslide(body, subslide-index)

    // Generate the slide page
    context {
      s-current-subslide.update(subslide-index)

      // 1. Calculate Layout
      let header-size = s-header-font-size.get()
      let has-title = title != none
      let header-em-height = if has-title { layout-header-height-title } else { layout-header-height-no-title }

      // Measure header height in absolute units to determine top margin
      let header-height-absolute = measure(text(size: header-size)[#v(header-em-height)]).height
      let top-margin = if has-title {
        header-height-absolute + layout-top-margin-extra
      } else {
        layout-top-margin-default
      }

      // 2. Setup Page
      set page(
        fill: white,
        header-ascent: if has-title { 65% } else { 66% },
        header: [], // We draw the header manually in the background to avoid margin issues
        margin: (x: layout-margin-x, top: top-margin, bottom: layout-margin-bottom),
        background: {
          place(slide-header(title, headercolor, s-header-font-size.get()))
        },
        footer: [
          #set text(size: 12pt, fill: gray)
          #grid(
            columns: (1fr, 1fr),
            align: (left + horizon, right + horizon),
            s-footer-text.get(), counter(page).display("1 / 1", both: true),
          )
        ],
      )

      set par(justify: true)

      // 3. Apply Slide-Specific Styles
      let x_align = if center_x { center } else { left }
      let y_align = if center_y { horizon } else { top }

      // Resolve fonts and sizes (fallback to global state if not overridden)
      let font = if slide-main-font != none { slide-main-font } else { s-main-font.get() }
      let size = if slide-main-font-size != none { slide-main-font-size } else { text.size }
      let code-font-val = if slide-code-font != none { slide-code-font } else { s-code-font.get() }
      let code-size = slide-code-font-size

      // Resolve equation numbering
      let eq-numbering = if slide-equation-numbering == auto {
        s-equation-numbering.get()
      } else if slide-equation-numbering {
        "(1)"
      } else {
        none
      }

      set text(font: font, size: size)
      set math.equation(numbering: eq-numbering)
      set align(x_align + y_align)

      // Raw code blocks always use the code font
      show raw: set text(font: code-font-val, size: if code-size != none { code-size } else { size })

      // Reset equation counter if configured
      if s-reset-equation.get() == true {
        counter(math.equation).update(0)
      }

      // Small vertical correction to start content
      v(0cm)
      processed-body
    }
  }
}
