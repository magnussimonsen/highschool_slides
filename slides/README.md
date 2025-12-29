# Classroom Deck - Simple Typst Presentation Template

A clean and simple slides template for Typst with built-in pause animations.

**Designed for Education**: This template is specifically designed for use in secondary education (high school and similar levels). It is intentionally kept simple and focused, providing just the essential features needed for effective classroom presentations.

## Features

- ✨ **Simple & Clean Design** - Minimal, professional look
- 🎬 **Animation Support** - Built-in `#pause` and `#meanwhile` for progressive reveals
- 🎨 **Color-Coded Headers** - Blue, red, green, cyan, magenta, yellow, gray
- 📦 **Focus Boxes** - Highlighted boxes for important content
- 📐 **Multi-Column Layouts** - Easy column-based layouts with `#cols`
- 🔢 **Equation Numbering** - Configurable equation numbering
- 🎯 **Customizable** - Fonts, sizes, colors, and spacing

## Quick Start

```typst
#import "@preview/classroom-deck:0.1.0": *

// For local development (in this repository), you can instead use:
// #import "lib.typ": *

// Configure the presentation
#show: slides.with(
  ratio: "16-9",
  main-font: "Calibri",  // Default value is can be tweaked in core.typ
  code-font: "Consolas", // Default value is can be tweaked in core.typ
  // Useful Windows fonts: "Calibri", "Arial"
  // Useful Windows code fonts: "Consolas", "Courier New"
  // Useful Linux fonts: "Liberation Sans", "Noto Sans", "Arial"
  // Useful Linux code fonts: "Liberation Mono", "Noto Mono", "Courier New"
  // Dyslexia-friendly fonts: "Comic Neue", "OpenDyslexic"
  font-size-headers: 20pt,
  font-size-content: 18pt,
  footer_text: "My Presentation", // Default is an empty string
  equation_numbering_globally: true,
  equation_numbering_globally: true,
)

// Create slides
#slide(headercolor: blue, title: "First Slide")[
  Content appears first

  #pause

  This appears on next click

  #pause

  This appears last
]
```

## Available Functions

### Main Functions

- **`slides()`** - Global configuration function
- **`slide()`** - Create individual slides

### Utilities

- **`focusbox()`** - Highlighted content boxes
- **`cols()`** - Multi-column layouts
- **`pause`** - Animation marker (progressive reveal)
- **`meanwhile`** - Synchronous reveal marker

### Color Palette

Pre-defined colors for headers and focusboxes:

- `blue` - Primary theme (definitions)
- `red` - Theorems, important notes
- `green` - Examples, applications
- `cyan` - Tasks, exercises
- `magenta` - Exploration tasks
- `yellow` - Warnings, cautions
- `gray` - Neutral (code, equations)
- `white` - White background

## Slide Configuration Options

```typst
#show: slides.with(
  ratio: "16-9",                        // or "4-3"
  main-font: "Calibri",                 // Main text font
  code-font: "Consolas",                // Code block font
  font-size-headers: 20pt,              // Header font size
  font-size-content: 18pt,              // Body text size
  footer_text: "",                      // Footer text
  reset_equation_numbers_per_slide: true,
  equation_numbering_globally: true,    // Enable equation numbers
  equation_numbering_globally: true,    // Enable equation numbers
)
```

## Slide Options

```typst
#slide(
  headercolor: blue,              // Header color
  title: "Slide Title",           // Slide title
  center_x: false,                // Horizontal centering
  center_y: true,                 // Vertical centering
  repeat: auto,                   // Auto-detect pauses or specify number
  slide-equation-numbering: auto, // Override equation numbering for this slide
  slide-main-font: none,          // Override main font for this slide only
  slide-main-font-size: none,     // Override main font size for this slide
  slide-code-font: none,          // Override code font for this slide only
  slide-code-font-size: none,     // Override code font size for this slide
)[
  // Slide content
]
```

## Animation Examples

Note: `#pause` and `#meanwhile` are detected only at the *top level* of a slide’s body. If you put them inside nested structures (lists, grids, blocks, etc.), auto-detection may not see them.

### Basic Pause

```typst
#slide(title: "Animation Demo")[
  First content

  #pause

  Second content

  #pause

  Third content
]
```

### Meanwhile (Synchronous Reveal)

```typst
#slide(title: "Meanwhile Demo")[
  Section A starts

  #pause

  Section A continues

  #meanwhile

  Section B starts (appears with Section A)

  #pause

  Section B continues
]
```

## Focus Box Examples

```typst
// Default gray focusbox
#focusbox[Content here]

// Colored focusbox
#focusbox(bg: blue)[Important content]

// Centered with custom size
#focusbox(bg: red, center_x: true, text-size: 1.2em, width: 80%)[
  Large centered content
]
```

## Multi-Column Layout

```typst
// Equal columns
#cols[Left content][Right content]

// Custom column widths (2:1 ratio)
#cols(columns: (2fr, 1fr))[
  Wide column
][
  Narrow column
]
```

## Backward Compatibility

Slides without `#pause` markers work exactly as before - all content appears at once. This ensures your existing slides continue to work without modification.

## File Structure

```
slides/
├── lib.typ           # Main entry point (import this)
├── core.typ          # Core slide functionality
├── utils.typ         # Utility functions & Animation logic
├── LICENSE           # MIT License
└── README.md         # This file
```

## License

MIT License - See LICENSE file for details

https://github.com/magnussimonsen/highschool_slides

## Author

Magnus Simonsen & Claude Sonnet 4.5

## Repository

https://github.com/magnussimonsen/slides
