# Pause Feature Implementation Plan for Slides Template

## Analysis: How Touying's Pause Works

### Core Concepts

1. **Subslides**: Touying creates multiple "subslides" from a single slide content. Each time `#pause` is encountered, it increments a counter to create a new subslide.

2. **Metadata Markers**: `#pause` and `#meanwhile` are implemented as metadata markers:

   ```typst
   #let pause = [#metadata((kind: "touying-pause"))<touying-temporary-mark>]
   #let meanwhile = [#metadata((kind: "touying-meanwhile"))<touying-temporary-mark>]
   ```

3. **Content Parsing**: Touying parses the slide content recursively:

   - Counts how many `#pause` markers exist
   - Determines total number of subslides needed (repetitions)
   - For each subslide index, decides what content should be visible

4. **Cover Function**: Content that should be hidden is either:

   - **Hidden with space reserved** (uncover): Like `#hide()` - space is kept
   - **Completely removed** (only): Content doesn't exist at all
   - **Semi-transparent** or **gray** (alternative cover methods)

5. **Meanwhile**: Resets the subslide counter back to 1, allowing content to be revealed synchronously with new content.

### Key Implementation Files in Touying

**From `src/core.typ`:**

- `touying-slide()` function handles the repeat logic
- `_parse-content-into-results-and-repetitions()` recursively processes content
- Detects pause/meanwhile markers in metadata
- Builds different versions of the slide for each subslide index

**Animation Flow:**

```
1. Parse content → Find all pause markers → Calculate repetitions
2. For each repetition (subslide 1, 2, 3...):
   - Walk through content
   - If current position <= current subslide: show content
   - If current position > current subslide: cover content
3. Generate separate page for each subslide
```

---

## Implementation Plan for Slides Template

### Design Philosophy

- **Keep it simple**: Vanilla Typst as much as possible
- **Minimal state management**: Avoid complex OOP patterns from Touying
- **User-friendly**: Simple `#pause` command that "just works"
- **PDF-based**: Each subslide becomes a separate PDF page

### Architecture

#### Option 1: Automatic Repeat Detection (Recommended)

**Pros:** Most user-friendly, similar to Touying
**Cons:** Requires content parsing

```typst
#slide(title: "My Slide")[
  First content

  #pause

  Second content

  #pause

  Third content
]
// Automatically creates 3 pages (subslides)
```

#### Option 2: Manual Repeat Count

**Pros:** Simpler implementation, explicit control
**Cons:** User must count pauses manually

```typst
#slide(title: "My Slide", repeat: 3)[
  First content

  #pause

  Second content

  #pause

  Third content
]
// User specifies repeat: 3 to create 3 pages
```

**Recommendation:** Start with Option 2, then enhance to Option 1.

---

## Step-by-Step Implementation

### Phase 1: Basic Pause (Manual Repeat)

**1. Add pause marker to `slides_utils.typ`:**

```typst
// Pause marker for creating animation steps
#let pause = metadata((kind: "slides-pause"))
```

**2. Add state for subslide tracking in `slides_core.typ`:**

```typst
#let s-current-subslide = state("current-subslide", 1)
```

**3. Modify `slide()` function signature in `slides_core.typ`:**

```typst
#let slide(
  headercolor: blue,
  title: none,
  repeat: 1,  // NEW: Number of subslides
  // ... existing parameters
  body,
)
```

**4. Add content parsing function in `slides_utils.typ`:**

```typst
// Parse content and hide/show based on current subslide
#let parse-with-pauses(content, current-subslide) = {
  let pause-counter = 1

  // Walk through content and replace pause markers
  // Content before pause N should only show on subslide N and later

  // This is a simplified version - needs recursive processing
  // Return modified content
}
```

**5. Generate multiple pages in `slide()` function:**

```typst
#let slide(
  // ... parameters
  repeat: 1,
  body,
) = {
  // Generate 'repeat' number of pages
  for subslide in range(1, repeat + 1) {
    s-current-subslide.update(subslide)

    // Existing slide setup code...
    set page(
      // ... existing page setup
    )

    // Parse body with pause awareness
    context {
      let processed-body = parse-with-pauses(body, subslide)
      // ... rest of slide rendering
      processed-body
    }
  }
}
```

### Phase 2: Auto-Detect Repeat Count

**6. Count pause markers:**

```typst
// In slides_utils.typ
#let count-pauses(content) = {
  // Recursively walk content tree
  // Count metadata items with kind: "slides-pause"
  // Return count + 1 (initial state + pauses)
}
```

**7. Update slide to auto-detect:**

```typst
#let slide(
  repeat: auto,  // Changed to auto
  body,
) = {
  let actual-repeat = if repeat == auto {
    count-pauses(body)
  } else {
    repeat
  }

  // Continue with generation...
}
```

### Phase 3: Enhanced Features

**8. Add `#uncover()` function (like Touying):**

```typst
// Show content only on specific subslides
// Example: #uncover("2-")[Content visible from slide 2 onwards]
#let uncover(visible-subslides, content) = context {
  let current = s-current-subslide.get()
  if is-visible(current, visible-subslides) {
    content
  } else {
    hide(content)  // Reserves space
  }
}
```

**9. Add `#only()` function:**

```typst
// Show content only on specific subslides, don't reserve space
#let only(visible-subslides, content) = context {
  let current = s-current-subslide.get()
  if is-visible(current, visible-subslides) {
    content
  }
  // else: nothing (no space reserved)
}
```

**10. Add `#meanwhile` marker:**

```typst
#let meanwhile = metadata((kind: "slides-meanwhile"))
// In parsing: reset pause counter to create synchronous reveals
```

---

## Implementation Challenges & Solutions

### Challenge 1: Content Walking

**Problem:** Typst content is a tree structure that needs recursive traversal
**Solution:** Use pattern matching on content types:

```typst
#let walk-content(content, visitor) = {
  if type(content) == content {
    if content.func() == metadata {
      visitor(content)
    } else if content.has("children") {
      content.children.map(c => walk-content(c, visitor))
    }
  }
  content
}
```

### Challenge 2: Hiding vs Covering

**Problem:** Should hidden content reserve space or not?
**Solution:** Default to `#hide()` (reserves space) for `#pause`, provide `#only()` for no space

### Challenge 3: Equation Animations

**Problem:** Pauses inside math equations
**Solution:** Phase 4 feature - requires special handling like Touying's `touying-equation`

### Challenge 4: List/Bullet Animations

**Problem:** Revealing list items one by one
**Solution:**

```typst
#slide(repeat: 3)[
  - First item
  #pause
  - Second item
  #pause
  - Third item
]
```

---

## Testing Strategy

1. **Basic pause test:**

   ```typst
   #slide(repeat: 2)[
     First #pause Second
   ]
   ```

2. **Multiple pauses:**

   ```typst
   #slide(repeat: 4)[
     A #pause B #pause C #pause D
   ]
   ```

3. **With bullet lists:**

   ```typst
   #slide(repeat: 3)[
     - Item 1
     #pause
     - Item 2
     #pause
     - Item 3
   ]
   ```

4. **Auto-detection:**
   ```typst
   #slide[
     First #pause Second #pause Third
   ]
   // Should auto-create 3 pages
   ```

---

## Migration Path for Users

### Before (current):

```typst
#slide(title: "My Slide")[
  All content appears at once
]
```

### After (with pause):

```typst
#slide(title: "My Slide")[
  First content

  #pause

  Second content appears on next click

  #pause

  Third content appears last
]
```

**Backward compatibility:** Slides without `#pause` work exactly as before (repeat: 1 by default).

---

## Estimated Implementation Complexity

| Phase                    | Complexity  | Time Estimate | Priority |
| ------------------------ | ----------- | ------------- | -------- |
| Phase 1: Manual repeat   | Medium      | 2-4 hours     | High     |
| Phase 2: Auto-detect     | Medium-High | 3-5 hours     | High     |
| Phase 3: uncover/only    | Medium      | 2-3 hours     | Medium   |
| Phase 4: meanwhile       | Low         | 1-2 hours     | Low      |
| Phase 5: Equation pauses | High        | 5-8 hours     | Low      |

**Total for basic pause feature:** 5-9 hours
**Total for full feature parity:** 13-22 hours

---

## Recommended Implementation Order

1. ✅ **Start with Phase 1** (manual repeat) - Proves the concept works
2. ✅ **Add Phase 2** (auto-detect) - Makes it user-friendly
3. ✅ **Add Phase 3** (uncover/only) - Provides flexibility
4. ⏸️ **Consider Phase 4** (meanwhile) - Only if needed
5. ⏸️ **Skip Phase 5** (equations) - Complex, can be separate project

---

## Questions to Consider

1. **Should we preserve space for hidden content?**

   - Recommendation: Yes by default (use `#hide()`)

2. **Should we support complex visibility patterns like "2-4, 6"?**

   - Recommendation: Start simple with just `#pause`, add later if needed

3. **Should slide numbers reflect subslides?**

   - Recommendation: No - treat all subslides as the same slide number

4. **PDF compatibility?**
   - Each subslide = separate PDF page (works with all PDF viewers)

---

## Next Steps

1. Review this plan
2. Decide on implementation phases to include
3. Create test file with example use cases
4. Implement Phase 1 (manual repeat)
5. Test thoroughly
6. Iterate based on results
