---
name: feedback-no-ask-terminal-commands
description: User prefers Claude run validation/terminal commands directly without asking for permission first, especially during iterative OpenSCAD/geometry debugging
metadata:
  type: feedback
---

Don't ask before running validation/terminal commands (e.g. OpenSCAD preview/render checks, quick scripts) — just run them and report results.

**Why:** Stated explicitly during iterative debugging of `poster_models/earth.scad` ("Nie pytaj się o uruchomienia komend w terminalu") after repeated confirmation prompts slowed down a tight edit-render-inspect loop.

**How to apply:** When doing exploratory/validation work that is read-only or writes only to temp/scratch files (rendering previews, running test scripts, checking output), proceed without asking first. Still confirm before destructive or shared-impact actions per standard policy — this preference is about low-risk iteration loops, not a blanket waiver. Came up in the context of [[tabliczki-poster-plaques]].
