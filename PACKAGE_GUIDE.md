# How to Package the Slides Template

This guide documents how to turn this slides template into a proper Typst package that can be imported and reused across projects.

---

## Package Structure

A Typst package requires the following structure:

```
slides/
├── typst.toml          # Package manifest (required)
├── lib.typ             # Main entry point (required)
├── LICENSE             # License file (required for publishing)
├── README.md           # Documentation (recommended)
├── slides_core.typ     # Core functionality
├── slides_utils.typ    # Utilities and helpers
├── examples/           # Example files (optional)
│   ├── basic.typ
│   └── advanced.typ
└── docs/               # Additional documentation (optional)
    └── manual.md
```

---

## Step 1: Create `typst.toml` Manifest

Create a file named `typst.toml` in the package root:

```toml
[package]
name = "slides"
version = "0.1.0"
entrypoint = "lib.typ"
authors = ["Magnus Simonsen"]
license = "MIT"
description = "A simple and clean slides template for Typst presentations with pause animations"
homepage = "https://github.com/magnussimonsen/slides"
repository = "https://github.com/magnussimonsen/slides"
keywords = ["slides", "presentation", "template", "animation", "pause"]
categories = ["presentation"]
compiler = "0.12.0"
exclude = ["*.pdf", "*.png", "*.jpg", "main.typ", "pause_test.typ"]

[template]
path = "examples/basic.typ"
entrypoint = "examples/basic.typ"
thumbnail = "thumbnail.png"
```

**Key fields:**

- `name`: Package name (used in imports)
- `version`: Semantic versioning (major.minor.patch)
- `entrypoint`: Main file to import (usually `lib.typ`)
- `compiler`: Minimum Typst version required
- `exclude`: Files not to include when publishing

---

## Step 2: Create `lib.typ` Entry Point

Create `lib.typ` as the main import file:

```typst
// Slides Package - Main Entry Point
// Author: Magnus Simonsen
// A simple and clean slides template with pause animations

// ============================================================================
// Core Exports
// ============================================================================

#import "slides_core.typ": slides, slide
#import "slides_utils.typ": focusbox, cols, pause, meanwhile

// ============================================================================
// Color Exports
// ============================================================================

#import "slides_utils.typ": blue, red, green, cyan, magenta, yellow, gray, white

// ============================================================================
// Usage Example
// ============================================================================

// #import "@preview/slides:0.1.0": *
//
// #show: slides.with(
//   ratio: "16-9",
//   font-size-headers: 20pt,
//   font-size-content: 18pt,
//   footer_text: "My Presentation",
// )
//
// #slide(title: "My First Slide")[
//   Content here
//
//   #pause
//
//   More content after pause
// ]
```

---

## Step 3: Update README.md

Create or update `README.md` with comprehensive documentation:

````markdown
# Slides - Simple Typst Presentation Template

A clean and simple slides template for Typst with built-in pause animations.

## Features

- Clean, consistent design
- Automatic pause/animation support with `#pause`
- Color-coded slides (blue, red, green, etc.)
- Focus boxes for highlighting content
- Multi-column layouts
- Equation numbering options
- Customizable fonts and sizes

## Installation

### From Typst Universe (once published)

```typst
#import "@preview/slides:0.1.0": *
```
````

### Local Installation

Clone or download this repository and import locally:

```typst
#import "path/to/slides/lib.typ": *
```

## Quick Start

```typst
#import "@preview/slides:0.1.0": *

#show: slides.with(
  ratio: "16-9",
  footer_text: "My Presentation",
)

#slide(title: "First Slide")[
  Content appears first

  #pause

  This appears after clicking
]
```

## Documentation

See examples/ folder for more detailed examples.

## License

MIT License

```

---

## Step 4: Create Examples Directory

Organize example files:

```

examples/
├── basic.typ # Simple getting started example
├── advanced.typ # Advanced features demo
└── pause_demo.typ # Animation features

````

Move `main.typ` to `examples/complete.typ` and `pause_test.typ` to `examples/pause_demo.typ`.

---

## Step 5: Testing Locally

### Option A: Direct Import (Current Method)

```typst
#import "slides_core.typ": *
````

### Option B: Test as Package

Create a test project outside the package:

```
test-project/
└── presentation.typ
```

In `presentation.typ`:

```typst
#import "../slides/lib.typ": *

#show: slides.with(ratio: "16-9")
```

### Option C: Local Package Installation

1. Create local package directory:

   ```powershell
   mkdir -p $env:APPDATA\typst\packages\local\slides\0.1.0
   ```

2. Copy package files:

   ```powershell
   Copy-Item -Recurse .\slides\* $env:APPDATA\typst\packages\local\slides\0.1.0\
   ```

3. Import in any document:
   ```typst
   #import "@local/slides:0.1.0": *
   ```

---

## Step 6: Publishing to Typst Universe

### Prerequisites

1. Create account at https://typst.app
2. Install Typst CLI (already have it)
3. Have a public GitHub repository

### Publishing Commands

```powershell
# Navigate to package directory
cd slides

# Login to Typst (if not already logged in)
typst login

# Validate package structure
typst package check

# Publish to Typst Universe
typst package publish
```

### Publishing Checklist

- [ ] `typst.toml` is complete and valid
- [ ] `lib.typ` exports all public functions
- [ ] `README.md` has clear documentation
- [ ] `LICENSE` file exists
- [ ] Examples work correctly
- [ ] Version number is incremented
- [ ] Repository URL is correct
- [ ] No sensitive files in package (check `exclude` in toml)

---

## Step 7: Version Management

Use semantic versioning:

- **Patch** (0.1.X): Bug fixes, typos
- **Minor** (0.X.0): New features, backward compatible
- **Major** (X.0.0): Breaking changes

Update version in `typst.toml` before publishing:

```toml
version = "0.2.0"  # After adding new features
```

---

## Step 8: Package Maintenance

### Updating the Package

1. Make changes to code
2. Update version in `typst.toml`
3. Update CHANGELOG.md
4. Test locally
5. Commit and push to GitHub
6. Publish: `typst package publish`

### File Organization Tips

- Keep `slides_core.typ` for core logic
- Keep `slides_utils.typ` for helpers
- Don't expose internal functions in `lib.typ`
- Document all public functions
- Use consistent naming conventions

---

## Package Import Patterns

### After Publishing

Users can import your package in several ways:

**Import everything:**

```typst
#import "@preview/slides:0.1.0": *
```

**Import specific items:**

```typst
#import "@preview/slides:0.1.0": slides, slide, pause
```

**Import with alias:**

```typst
#import "@preview/slides:0.1.0" as myslides
#show: myslides.slides.with(ratio: "16-9")
```

---

## Useful Links

- [Typst Packages Documentation](https://github.com/typst/packages)
- [Typst Universe](https://typst.app/universe)
- [Package Format Specification](https://github.com/typst/packages/tree/main/SPEC.md)
- [Publishing Guide](https://github.com/typst/packages/blob/main/PUBLISHING.md)

---

## Notes

- Package names must be lowercase with hyphens (e.g., `my-slides`)
- Version must follow semantic versioning
- Packages are immutable once published (cannot unpublish)
- Keep examples minimal but comprehensive
- Test on multiple Typst versions if possible
