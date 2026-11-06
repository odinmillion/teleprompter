# Teleprompter

A teleprompter for iPhone that sits behind a beam-splitter mirror. One HTML file, no build step, no dependencies, no server — hosted on GitHub Pages.

Live: https://odinmillion.github.io/teleprompter/

The interface is in Russian.

## Features

- Horizontal and vertical mirroring, independently or both at once
- Scroll speed (5–150), font size (20–120), side margins, text colour, alignment, reading guide line
- Text and settings persist in `localStorage` and survive a page reload
- Optional 3-2-1 countdown after Start, shown as a large overlay that mirrors with the text, so you can step back into position; any tap cancels it
- Wake Lock: the screen stays on while the prompter is open (Safari 16.4+)
- On-screen control: tap — start/pause, swipe — speed while scrolling or scrub while paused; the button bar hides after 2.5 s
- Keyboard and Bluetooth remotes: Space — start/pause, ↑↓ — speed, ←→ — font size, PageUp/PageDown — scrub half a screen, M — mirror ↔, V — mirror ↕, F — fullscreen, R/Home — back to start, Esc — exit
- Fullscreen button (⤢) on iPad, Android and desktop via the Fullscreen API; iPhone Safari has no Fullscreen API for page elements, so there the button shows a hint instead
- "Add to Home Screen" in Safari gives a full-screen mode without the address bar on any iPhone (`manifest.webmanifest` and icons included)

## Deploy to GitHub Pages

The shortest path is the script (needs `gh`: `brew install gh && gh auth login`):

```bash
./deploy.sh               # creates a "teleprompter" repository and enables Pages
./deploy.sh my-prompter   # a different repository name
```

Manually:

```bash
git init -b main
git add .
git commit -m "Teleprompter: first version"
gh repo create teleprompter --public --source=. --remote=origin --push
```

Then in the repository: Settings → Pages → Source: "Deploy from a branch", Branch: `main`, folder `/ (root)`. A minute later the page is up at `https://<login>.github.io/teleprompter/`.

Updates: `git commit` + `git push` — Pages rebuilds on its own.

## Files

| File | Purpose |
|---|---|
| `index.html` | The whole app: markup, styles, script |
| `manifest.webmanifest`, `icon-*.png`, `apple-touch-icon.png` | Icon and full-screen mode when added to the Home Screen |
| `.nojekyll` | Disables Jekyll on GitHub Pages |
| `deploy.sh` | Creates the repository and enables Pages via `gh` |
| `CLAUDE.md` | Context for Claude Code: architecture and constraints |

## Testing on an iPhone

1. Open the page in Safari, paste some text, tap «Начать» (Start).
2. You should see «Экран не погаснет» ("the screen will stay on") — Wake Lock is working. If not: Settings → Display & Brightness → Auto-Lock → Never.
3. Turn on the mirror you need, put the phone into the prompter, tap the text.
4. If you use Guided Access: Settings → Accessibility → Guided Access → Display Auto-Lock → Never, otherwise it overrides Wake Lock.
