// ============================================================================
// Slides Library - Main Entry Point
// ============================================================================
// A simple and clean slides template for Typst presentations with pause animations
//
// Author: Magnus Simonsen
// Repository: https://github.com/magnussimonsen/slides
// License: MIT
//
// Usage:
//   #import "slidesLib/slides_lib.typ": *
//
//   #show: slides.with(
//     ratio: "16-9",
//     footer_text: "My Presentation",
//   )
//
//   #slide(title: "First Slide")[
//     Content here
//
//     #pause
//
//     More content after pause
//   ]
// ============================================================================

// Import and re-export core functionality
#import "slides_core.typ": slide, slides

// Import and re-export utilities
#import "slides_utils.typ": (
  // Layout utilities
  focusbox,
  cols,
  // Animation markers
  pause,
  meanwhile,
  // Color palette
  blue,
  red,
  green,
  cyan,
  magenta,
  yellow,
  gray,
  white,
)
