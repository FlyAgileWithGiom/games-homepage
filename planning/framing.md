# Project Framing: Fly Agile Games Homepage

## Framing Status
- [x] Motives & Success
- [x] Product Vision
- [x] What & Story Map
- [x] Architecture
- [ ] Risks (partial)

---

## 1. Motives & Success

**Status**: Complete

**Problem Statement**

Three Fly Agile games exist as standalone deployments with no shared entry point:
- La Chambre Froide (live at chambre-froide.flyagile.com)
- Hotplate (live at hotplate.flyagile.com)
- Rabbits & Hats (coming soon)

Agile coaches who run workshops with these games have no unified place to discover, share, or navigate the full suite. Each game lives as an island. There is no Fly Agile identity anchoring the collection.

**Who has this problem**

Primary: Agile coaches (like Giom) who use these games with client teams in workshops. They are tech-curious but not tech-native.

Secondary: Workshop participants (playing the games). They are even less tech-oriented. The homepage must not intimidate them.

**Success Criteria**

- A coach can share one URL that introduces all games and links to each
- A first-time visitor understands what Fly Agile Games is in under 10 seconds without reading
- The visual design reassures non-technical players that games are simple and approachable
- The page works as a standalone deliverable (no backend, no login, no CMS)
- Deployed on Scaleway, consistent with existing game deployments

**Timeline & Budget**

- No hard deadline specified
- Solo developer + AI agents
- No backend infrastructure cost beyond Scaleway static hosting

---

## 2. Product Vision

**Status**: Complete

**Unique Value**

Not just a navigation menu. The homepage is a world: a pixel art night village where each building IS a game. The metaphor carries meaning — coaches bring teams together in a shared space, just as the village brings the games together. The visual language says "playful, approachable, a bit mysterious" which matches how workshops feel.

**What makes it distinct**

- Village metaphor mirrors the workshop concept of "coming together"
- Pixel art aesthetic signals "simple games" — reassuring to non-technical audiences
- Night scene with subtle animations (slow clouds, smoke, twinkling stars) creates atmosphere without demanding attention
- Fly Agile brand identity (green accent, paper plane motif) anchors it to the coaching brand

**Target Beneficiaries**

| User | Job to be done |
|------|---------------|
| Agile coach | Share a single polished link; project professional credibility |
| Workshop participant | Land somewhere that feels game-like and non-threatening |
| Potential client | Discover that Fly Agile offers interactive tools |

---

## 3. What & Story Map

**Status**: Complete

**Core Deliverable**

A single-page static homepage acting as a visual portal to all Fly Agile workshop games, using a pixel art night village aesthetic.

**User Workflow (primary: coach sharing the link)**

1. Coach shares URL (e.g., games.flyagile.com) with workshop participants
2. Participant lands on the village scene
3. Atmosphere communicates "playful, simple" immediately (no reading required)
4. Participant identifies their game by building/sprite/badge
5. Participant clicks and enters the game

**User Workflow (secondary: discovery)**

1. Visitor arrives via Fly Agile brand channels
2. Explores the village visually
3. Understands the game suite exists
4. May bookmark or share

**Feature Priorities**

Must-have (MVP):
- Pixel art night village scene with sky, ground, buildings
- One interactive building per live game (La Chambre Froide, Hotplate)
- "Coming soon" state for Rabbits & Hats
- Subtle atmospheric animations (clouds, smoke, stars)
- Click/hover interaction on buildings leading to game URLs
- Game name + sprite badge per building (snowflake, frying pan, rabbit in hat)
- Fly Agile branding (logo, green accent #4CAF50)
- Fully static (HTML/CSS/JS, no backend)
- Mobile responsive (stacking layout)
- Deployed to Scaleway

Nice-to-have (post-MVP):
- Paper plane CSS/SVG animation (separate project idea, do not scope here)
- Description tooltips or game previews on hover
- Dark/light mode
- Multi-language support

Out of scope:
- User accounts or authentication
- Game analytics or tracking
- CMS or content management
- Any backend service

---

## 4. Architecture

**Status**: Complete

**Tech Stack**

- Pure static: HTML + CSS + JS (vanilla or minimal framework)
- Pixel art: CSS pixel art rendering (image-rendering: pixelated) or canvas
- No build pipeline required for MVP (can evolve to Vite/Parcel if needed)
- Hosting: Scaleway Object Storage or Functions (same stack as existing games)

**Design Decisions Made**

- Night scene (dark blue/purple sky) — NOT green sky
- Fly Agile green (#4CAF50) as accent only (grass, badges, UI highlights)
- Calm, minimal animation — no parallax, no heavy effects
- Prototype series A through H2 explored; H-series (h1-village-calm, h2-village-integrated) is the current direction
- Each game represented by a distinct building + sprite: snowflake (La Chambre Froide), frying pan (Hotplate), rabbit-in-hat (Rabbits & Hats)

**Integration Points**

- Links out to: chambre-froide.flyagile.com, hotplate.flyagile.com, future Rabbits & Hats URL
- No API calls, no data fetching

**Performance Requirements**

- Fast load on mobile (coaches share links in workshop, participants click immediately)
- No heavy assets — pixel art is inherently low-res
- Target: sub-2s load on 4G

**Prototype Artifacts**

Existing prototypes located at:
`/Users/guillaume/dev/flyagile/games-homepage/prototypes/`

Current candidate: **prototype-i2.html** (chosen 2026-03-09)

---

## 5. Risk Management

**Status**: Partial

**Primary Concerns**

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Visual polish takes longer than expected due to pixel art iteration | Medium | Medium | Time-box visual work; ship imperfect, refine after |
| Prototype-to-production transition adds complexity | Low | Medium | Review H-series prototypes and extract a clean production architecture |
| Mobile layout breaks village metaphor | Medium | Low | Design mobile as "stacked cards" fallback, not a scaled-down village |
| URL/domain not yet decided | Low | Low | Use placeholder during development; decide before deploy |

**Open Questions (requiring user decisions)**

1. What is the final URL / domain? (games.flyagile.com? flyagile.com/games? other?)
2. Which H-series prototype is the chosen direction? h1-village-calm or h2-village-integrated?
3. Is there a description or tagline to show on the page (e.g. "Workshop games for agile teams")?
4. Should the Fly Agile logo appear on the homepage, and if so where?
5. What happens when a "coming soon" building is clicked — tooltip? disabled state? separate info?

**Confidence Gaps**

- Mobile experience for a village metaphor scene (may need a different layout strategy)
- Whether to use canvas or pure CSS for the pixel art scene (impacts animation flexibility)

---

## 6. Framing Decisions Log

| Date | Decision |
|------|---------|
| 2026-03-09 | Night village metaphor chosen after 10+ prototype iterations (A through H series) |
| 2026-03-09 | Green (#4CAF50) is accent only, not background — sky is dark blue/purple |
| 2026-03-09 | Static deployment only, no backend |
| 2026-03-09 | Scaleway deployment (consistent with existing games) |
| 2026-03-09 | Paper plane animation scoped OUT of this project |
| 2026-03-09 | Mobile: responsive stacking acceptable (village metaphor not required on mobile) |
| 2026-03-09 | Three games: La Chambre Froide (live), Hotplate (live), Rabbits & Hats (coming soon) |
