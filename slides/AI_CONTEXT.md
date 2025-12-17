# AI Assistant Context for Typst Slides Template

This document provides context for AI assistants to help users create presentations with this Typst slides template.

## Template Overview

This is a simple, education-focused presentation template for Typst, designed for secondary education (high school). It emphasizes simplicity and essential features without overwhelming complexity.

## Core Features

- Simple slide creation with color-coded headers
- Focus boxes for highlighting content
- Pause animations for progressive content reveal
- Multi-column layouts
- Equation support (numbered and unnumbered)
- Customizable fonts, sizes, and colors

## Import and Setup

```typst
#import "@preview/classroom-deck:0.1.0": *

#show: slides.with(
  ratio: "16-9",                      // or "4-3"
  main-font: "Calibri",               // Main text font
  code-font: "Consolas",              // Code font
  font-size-headers: 20pt,            // Header size
  font-size-content: 18pt,            // Body text size
  footer_text: "My Presentation",     // Footer text
  equation_numbering_globally: true,  // Enable equation numbers
  percent_lighter: 90%,               // Focusbox background lightness (0-100%)
)
```

Note: `#pause` and `#meanwhile` markers are detected only at the top level of a slide’s body.

## Available Functions

### 1. `slide()` - Create a slide

**Parameters:**

- `headercolor`: blue, red, green, cyan, magenta, yellow, gray, white (default: blue)
- `title`: String - slide title (default: none)
- `center_x`: Boolean - horizontal centering (default: false)
- `center_y`: Boolean - vertical centering (default: true)
- `repeat`: auto or integer - number of animation subslides (default: auto)
- `slide-equation-numbering`: auto, true, or false (default: auto)
- `slide-main-font`: Override main font for this slide (default: none)
- `slide-main-font-size`: Override main font size (default: none)
- `slide-code-font`: Override code font (default: none)
- `slide-code-font-size`: Override code font size (default: none)

**Example:**

```typst
#slide(headercolor: blue, title: "Introduction")[
  Your content here
]
```

### 2. `focusbox()` - Highlighted content boxes

**Parameters:**

- `bg`: blue, red, green, cyan, magenta, yellow, gray, white (default: gray)
- `text-size`: Length - font size (e.g., 0.8em, 1.2em) (default: auto)
- `center_x`: Boolean - horizontal centering (default: false)
- `center_y`: Boolean - vertical centering (default: false)
- `width`: Length or auto - box width (e.g., 80%, 100%) (default: auto)

**Example:**

```typst
#focusbox(bg: blue, text-size: 1.1em, width: 80%)[
  Important content here
]
```

### 3. `cols()` - Multi-column layout

**Parameters:**

- `columns`: Array of fractions - column widths (default: equal widths)

**Example:**

```typst
// Equal columns
#cols[Left content][Right content]

// Custom widths (2:1 ratio)
#cols(columns: (2fr, 1fr))[Wide column][Narrow column]
```

### 4. `pause` - Animation marker

Creates progressive content reveal. Each `#pause` creates a new subslide.

**Example:**

```typst
#slide(title: "Animated Slide")[
  First content

  #pause

  Second content appears

  #pause

  Third content appears
]
```

### 5. `meanwhile` - Synchronous reveal marker

Resets the animation sequence so content appears alongside previous content.

**Example:**

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

## Color Palette

Pre-defined colors for headers and focusboxes:

- `blue` - Primary theme, definitions
- `red` - Theorems, important notes
- `green` - Examples, applications
- `cyan` - Tasks, exercises
- `magenta` - Exploration tasks
- `yellow` - Warnings, cautions
- `gray` - Neutral (code, equations)
- `white` - White background

## Common Patterns

### Basic Slide with Content

```typst
#slide(headercolor: blue, title: "My Slide")[
  Regular text content.

  - Bullet point 1
  - Bullet point 2

  *Bold text* and _italic text_
]
```

### Slide with Equation

```typst
#slide(headercolor: gray, title: "Mathematics")[
  Here's an equation:

  $ f(x) = x^2 + 2x + 1 $

  And an unnumbered one:
  #[
    #set math.equation(numbering: none)
    $ g(x) = sin(x) $
  ]
]
```

### Slide with Code

````typst
#slide(headercolor: green, title: "Code Example")[
  #focusbox(bg: gray)[
    ```python
    def hello():
        print("Hello, World!")
    ```
  ]
]
````

### Slide with Two Columns

```typst
#slide(headercolor: cyan, title: "Comparison")[
  #cols[
    *Column 1:*
    - Point A
    - Point B
  ][
    *Column 2:*
    - Point X
    - Point Y
  ]
]
```

### Slide with Table

```typst
#slide(title: "Data Table")[
  #table(
    columns: 3,
    [*Name*], [*Age*], [*Score*],
    [Alice], [20], [95],
    [Bob], [21], [87],
  )
]
```

### Slide with Image

```typst
#slide(title: "Visualization")[
  #align(center)[
    #image("chart.png", width: 70%)
  ]
]
```

### Animated Progressive Reveal

```typst
#slide(title: "Step by Step")[
  First, we introduce the problem.

  #pause

  Then, we analyze the data.

  #pause

  Finally, we draw conclusions.
]
```

### Centered Content

```typst
#slide(headercolor: yellow, title: "Important", center_x: true, center_y: true)[
  #focusbox(bg: yellow, center_x: true, width: 60%)[
    This content is centered both horizontally and vertically.
  ]
]
```

## Typography and Spacing

### Add Vertical Space

```typst
#v(1em)  // Add 1em of vertical space
#v(2cm)  // Add 2cm of vertical space
```

### Add Horizontal Space

```typst
#h(10pt)  // Add 10pt of horizontal space
```

### Text Formatting

```typst
*Bold text*
_Italic text_
`Inline code`
#text(size: 1.2em)[Larger text]
#text(fill: red)[Red text]
```

## Best Practices

1. **Use appropriate header colors** for different slide types:

   - Blue for definitions and main concepts
   - Red for theorems and important warnings
   - Green for examples
   - Cyan for student tasks
   - Gray for code and technical content

2. **Keep slides simple**: Avoid cramming too much content on one slide

3. **Use focusboxes** to highlight key information

4. **Use pause animations** to control information flow and maintain student attention

5. **Use multi-column layouts** for comparisons and side-by-side content

6. **Maintain consistent styling** throughout the presentation

7. **Test animations**: Remember that each `#pause` creates a new PDF page

## Troubleshooting

### Pause not working

- Make sure you're using `#pause` (with #) not just `pause`
- Check that `repeat: auto` is set (or omitted) in the slide parameters
- Each pause creates a separate page in the PDF

### Equation numbering issues

- Use `equation_numbering_globally: true` in `slides.with()` to enable global numbering
- Use `slide-equation-numbering: false` to disable for specific slides
- Use `#set math.equation(numbering: none)` inside `#[...]` for specific equations

### Font not found

- Ensure the font is installed on your system
- Use fallback fonts: "Calibri", "Arial" for Windows; "Liberation Sans" for Linux

### Focus box background too dark/light

- Adjust `percent_lighter` parameter in `slides.with()` (0-100%)
- Lower values = darker backgrounds
- Higher values = lighter backgrounds

## File Structure

The template consists of:

- `slides_lib.typ` - Main entry point (import this)
- `slides_core.typ` - Core slide functionality
- `slides_utils.typ` - Utility functions
- `README.md` - Documentation
- `LICENSE` - MIT License

## Version Information

- Template Name: Slides
- Version: 0.1.0
- Typst Compiler: 0.12.0+
- License: MIT
- Author: Magnus Simonsen

## When Helping Users

1. **Always ask about context**: What type of content? Educational level? Subject matter?
2. **Suggest appropriate colors**: Match header colors to content type
3. **Keep it simple**: This template is designed for simplicity - don't overcomplicate
4. **Use examples**: Provide working code snippets users can copy
5. **Test suggestions**: Ensure code will compile correctly
6. **Respect the educational focus**: Remember this is for high school level presentations

## Common User Requests and Solutions

**"How do I make text bigger?"**

```typst
#text(size: 1.5em)[Larger text here]
```

**"How do I center something?"**

```typst
#align(center)[Centered content]
```

**"How do I add a background color?"**
Use a focusbox:

```typst
#focusbox(bg: blue)[Content with blue background]
```

**"How do I make bullets appear one by one?"**

```typst
#slide[
  - First bullet

  #pause

  - Second bullet

  #pause

  - Third bullet
]
```

**"How do I put an image next to text?"**

```typst
#cols[
  Text content here
][
  #image("photo.png")
]
```
