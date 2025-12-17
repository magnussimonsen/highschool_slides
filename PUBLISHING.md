# Publishing this Typst template to Typst Universe

This repo contains a Typst slides template. To make it available to others via **Typst Universe** (so people can `#import` it and/or `typst init` it), you submit it to Typst’s official package index repo: https://github.com/typst/packages.

This guide is written for the current repo name:
- `git@github.com:magnussimonsen/highschool_slides.git`

Chosen Typst Universe package name:
- `classroom-deck`

## What “published” means in Typst

Typst Universe is backed by the `typst/packages` repository. When your PR is merged there, the package becomes available under the `preview` namespace:

- Import: `#import "@preview/<package-name>:<version>": *`
- Template init (CLI): `typst init @preview/<package-name>:<version>`

As of today, **all community submissions go into `preview`**, and you must always import with a full version.

## 0) Decide package identity (important)

Before anything else, decide:

- **Package name** (must follow Typst’s naming rules)
- **Version** (SemVer: `MAJOR.MINOR.PATCH`)

Read the official naming rules (they are strict):
- https://github.com/typst/packages/blob/main/docs/manifest.md#naming-rules

Notes for this repo:
- `slides` is explicitly listed as a forbidden canonical name in the rules, so this package should use a different name (you chose `classroom-deck`).

## 1) Make sure the package is a “template package” (not only a library)

A **template package** is a normal package **plus** a `[template]` section in `typst.toml` and a directory of files that get copied into new projects.

Requirements are documented here:
- https://github.com/typst/packages/blob/main/docs/manifest.md#templates

You will need to add:

1. A template directory (recommended name: `template/`).
2. A template entrypoint file inside that directory (commonly `template/main.typ`).
3. A thumbnail image (PNG or lossless WebP) that represents the initialized template.

### Recommended structure for this repo

Inside your package directory (the folder containing `typst.toml`), add:

- `template/`
  - `main.typ`  (the file users compile)
  - optionally more starter files (assets, examples, etc)

And in `typst.toml` add something like:

```toml
[template]
path = "template"
entrypoint = "main.typ"
thumbnail = "thumbnail.png"
```

The `template/main.typ` should *not* contain the whole template implementation. Instead, it should import your package and apply it, e.g.:

```typst
#import "@preview/<package-name>:<version>": *

#show: slides.with(
  ratio: "16-9",
  footer_text: "My Presentation",
)

#slide(title: "Hello")[
  First slide.
]
```

## 2) Update `typst.toml` metadata to meet Universe requirements

Typst Universe requires additional metadata beyond the compiler-minimum.

Checklist (see https://github.com/typst/packages/blob/main/docs/manifest.md):

- `name`: rename away from the forbidden canonical `slides`
- `version`: bump to the version you want to publish
- `entrypoint`: should be the library entrypoint you want `#import` to evaluate (currently `slides_lib.typ`)
- `authors`: keep as-is or add a GitHub handle / URL if desired
- `license`: ensure SPDX expression matches `LICENSE` (you have MIT)
- `description`: follow the doc’s guidance (short, ends with a period, avoid “Typst”, avoid “template” wording)
- `categories`: templates must specify at least one category
- `repository` / `homepage`: update to the new repo URL

Notes for this repo:
- Ensure `homepage` + `repository` point at `https://github.com/magnussimonsen/highschool_slides`.

## 3) Make README work on Universe

The README shown on Typst Universe must be correct and compile.

Checklist (see submission guidelines: https://github.com/typst/packages/blob/main/docs/README.md):

- Change examples from local imports:
  - from: `#import "slides_lib.typ": *`
  - to: `#import "@preview/classroom-deck:<version>": *`
- Ensure any example code in the README compiles.
- If you refer to optional fonts (like OpenDyslexic), clarify that they’re optional and how to install them.

## 4) Generate a valid template thumbnail

Templates require a thumbnail:

- Must be PNG or lossless WebP
- Must show a page of the initialized template
- Longer edge ≥ 1080 px
- File size ≤ 3 MiB

The manifest docs suggest generating it like this:

```powershell
# From the template entrypoint directory (or pass full paths)
# Example: render page 1 as a PNG
typst compile -f png --pages 1 --ppi 250 template/main.typ thumbnail.png
```

(You can compress it with `oxipng` if needed; see the manifest docs.)

Important: `thumbnail.png` is used by the package index and is automatically excluded from the downloaded bundle. Don’t reference it from your Typst code.

## 5) Sanity-check locally (recommended workflow)

Before submitting, validate:

- The library import works.
- The template init works.
- The template compiles out-of-the-box.

Recommended checks:

1. Compile your example deck:
   - `typst compile slides_example.typ`

2. Verify the template entrypoint compiles:
   - `typst compile template/main.typ`

3. Make sure the template uses **package-style imports** (`@preview/...`) rather than `../` relative imports.

## 6) Submit to Typst’s package index (the actual “publish” step)

Publishing is done by opening a PR to https://github.com/typst/packages.

Follow the official submission doc:
- https://github.com/typst/packages/blob/main/docs/README.md

High-level steps:

1. Fork `typst/packages` on GitHub.
2. Clone your fork (they recommend sparse checkout; see their docs).
3. Create the directory:

   `packages/preview/<package-name>/<version>/`

4. Copy *your package files* into that directory (must include `typst.toml`, `README.md`, `LICENSE`, and all needed `.typ` files and assets).
5. Ensure `typst.toml`’s `name` and `version` match the folder names exactly.
6. Commit and open a PR.
7. Address any CI review comments.

Once merged and CI finishes, the package becomes available for import, and should appear on Universe shortly after.

## 7) Future updates

Universe packages are effectively immutable: you don’t “edit” an existing release.

To ship changes:

- Bump the version in `typst.toml`.
- Submit a *new* folder `packages/preview/<package-name>/<new-version>/` in a new PR.
- Update README examples to use the new version.

## Quick checklist (copy/paste)

- [ ] Pick a valid, non-canonical package name (not `slides`).
- [ ] Add `[template]` section to `typst.toml`.
- [ ] Add `template/main.typ` that imports `@preview/<name>:<version>`.
- [ ] Generate `thumbnail.png` from the initialized template.
- [ ] Update `repository`/`homepage` to `magnussimonsen/highschool_slides`.
- [ ] Update README to use `@preview/...` imports and ensure examples compile.
- [ ] Submit PR to `typst/packages` under `packages/preview/<name>/<version>/`.
