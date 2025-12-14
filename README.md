# Typst Slides Template (Education)

A simple, readable slide template for teaching and classroom presentations, built with [Typst](https://typst.app/).

## Features

- **Education-focused**: Clear layouts, easy code blocks, and math support.
- **Flexible Styling**: Customizable colors, fonts, and sizes.
- **Utilities**: Built-in tools for columns, focus boxes, and equation numbering.

## Quick Start

1.  **Install Typst**: Follow instructions at [typst.app](https://typst.app/).
2.  **Check Fonts**: The template defaults to **Calibri** and **Consolas**. Ensure these are installed or configure your own (see [Configuration](#configuration)).
    - List available fonts: `typst fonts`
3.  **Run Example**:
    ```bash
    typst watch main.typ
    ```

## Usage

### 1. Global Configuration (`slides.with`)

Initialize the template at the top of your `main.typ`:

```typst
#import "slides_core.typ": *

#show: slides.with(
  ratio: "16-9",
  main-font: "Calibri",
  code-font: "Consolas",
  font-size-headers: 23pt,
  font-size-content: 21pt,
  equation_numbering_globally: true,
  footer_text: "My Course 101",
)
```

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `ratio` | `"16-9"` | Aspect ratio of the slides. |
| `main-font` | `"Calibri"` | Font for body text and headers. |
| `code-font` | `"Consolas"` | Font for raw code blocks. |
| `font-size-headers` | `23pt` | Size of header text. |
| `font-size-content` | `21pt` | Size of body text. |
| `focusbox-font-size` | `1em` | Relative size of text inside focus boxes. |
| `table-font-size` | `1em` | Relative size of text inside tables. |
| `footer_text` | `""` | Text to display in the footer (bottom left). |
| `equation_numbering_globally` | `true` | Enable global equation numbering (1, 2, 3...). |
| `reset_equation_numbers_per_slide` | `true` | Reset equation counter to 1 on each new slide. |

### 2. Creating Slides (`slide`)

```typst
#slide(title: "My Slide Title", headercolor: blue)[
  Content goes here.
]
```

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `title` | `none` | Title text in the header. If `none`, header is smaller. |
| `headercolor` | `blue` | Color of the header bar (see `slides_utils.typ` for options). |
| `center_x` | `false` | Center content horizontally. |
| `center_y` | `true` | Center content vertically. |
| `slide-main-font` | `none` | Override main font for this slide only. |
| `slide-code-font` | `none` | Override code font for this slide only. |
| `slide-equation-numbering` | `auto` | Override equation numbering for this slide (`true`/`false`). |

### 3. Utilities

#### Focus Box (`focusbox`)
Highlight important content like definitions or code.

```typst
#focusbox(bg: yellow)[
  Important warning!
]
```

| Parameter | Default | Description |
| :--- | :--- | :--- |
| `bg` | `rgb("#F3F2F0")` | Background color. |
| `text-size` | `auto` | Font size override. |
| `width` | `auto` | Width of the box. |
| `center_x` | `false` | Center text horizontally inside box. |
| `center_y` | `false` | Center text vertically inside box. |

#### Columns (`cols`)
Layout content in columns.

```typst
#cols(columns: (2fr, 1fr))[
  Left side (wider)
][
  Right side
]
```

## Project Structure

- `main.typ`: Your presentation file.
- `slides_core.typ`: Core logic and state management. **Edit this to change default behaviors.**
- `slides_utils.typ`: Design tokens (colors) and helper functions (`focusbox`, `cols`). **Edit this to add new colors or utilities.**

## Maintenance

- **Adding Colors**: Define new colors in `slides_utils.typ`.
- **Changing Defaults**: Update default values in `slides_core.typ` (top of file).
