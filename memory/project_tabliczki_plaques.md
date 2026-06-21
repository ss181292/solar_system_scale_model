---
name: tabliczki-poster-plaques
description: Ongoing initiative to generate an OpenSCAD info-plaque (tabliczka) model for every body in the solar system scale model, one per planet/body
metadata:
  type: project
---

The project is generating physical info plaques ("tabliczki") for each celestial body, one OpenSCAD file per body in `poster_models/`. Earth's (`poster_models/earth.scad`) is done and is the reference template — same module structure (`base_plate`, `edge_wedge_x`/`edge_wedge_y` + `corner_wedge` for the frame, `body_text`, `qr_code`) should be reused for the rest of the bodies, swapping only the body-specific data (title, wrapped body text from the matching `posters/*.md`, and a freshly generated QR matrix for that body's URL slug).

**Why:** User stated there are "sporo więcej" (a lot more) of these plaques still to generate, and asked that implementation lessons be captured so future ones go faster.

**How to apply:** The detailed build technique and gotchas (QR generation via Python, building the frame as a union of `polyhedron()` wedges instead of `difference()`/`hull()`, validating `polyhedron()` winding with a full `--render`, OpenSCAD CLI path/version quirks on this machine) are written directly into `CLAUDE.md` under "Tabliczki z opisami" → "Implementacja - wnioski z poster_models/earth.scad". Read that section and reuse `poster_models/earth.scad` as a copy-paste starting point rather than re-deriving the approach from scratch. See [[feedback-no-ask-terminal-commands]] for how to work through the render/validate loop efficiently.
