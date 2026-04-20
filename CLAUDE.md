# Fly Agile Games Homepage

## Project
Single-page static homepage acting as visual portal to Fly Agile's collaborative workshop games. Pixel art night village where each building IS a game.

- **Repo**: https://github.com/FlyAgileWithGiom/games-homepage
- **Issues**: GitHub Issues (labels: setup, scene, interaction, branding, responsive, deployment, MVP, post-MVP)
- **Framing**: `planning/framing.md`
- **Backlog**: `planning/backlog.md` (source of truth is GitHub Issues)
- **Prototypes**: `prototypes/` (exploration artifacts, NOT production code)
- **Production base**: Prototype I2 (chosen after 15+ iterations)

## Tech Stack
- Pure static: HTML + CSS + vanilla JS
- No build pipeline (may evolve to Vite if needed)
- Pixel art: CSS box-shadow technique, image-rendering: pixelated
- Font: Google Fonts "Silkscreen"
- Deployment: K3s cluster on Scaleway Kapsule via ArgoCD (nginx:alpine)
- CI/CD: GitHub Actions, builds on push to main and tags (v*), triggers K8s updates

## Project Structure
```
index.html                    # Production homepage
css/style.css                 # All styles (night scene, buildings, animations)
js/main.js                    # Star generation script
Dockerfile                    # nginx:alpine static serving
.github/workflows/ci.yml      # GitHub Actions CI/CD pipeline
prototypes/                   # All visual explorations (A through I2)
planning/                     # Framing + backlog docs
```

## Art Direction (Homepage)

### Night Village Scene
- **Sky**: Dark blue/purple gradient (#1a1a3e to #2d1b69) - NIGHT, never green
- **Ground**: Green grass with Fly Agile brand green (#4CAF50) tones
- **Buildings**: ~180-200px tall, consistent pixel art style within the homepage
- **Layout**: Single unified scene, NOT split into separate sections. Buildings + signposts + sprites = one world

### Fly Agile Brand Integration
- Green (#4CAF50) as ACCENT only: grass, status badges, subtitle, hover effects
- Brand green is NOT the sky/background color
- Logo placement: TBD (see GitHub issue #10)

### Animations (CALM is the rule)
- Stars: 4-7s twinkle, staggered delays
- Clouds: 80-100s drift cycle, semi-transparent
- Smoke: 6-8s gentle rise from chimney
- Sparkles: 4-6s fade near Rabbits castle
- NOTHING fast. No walking characters. No bouncing. No flashy effects.

### Per-Game Identity
Each game keeps its own identity and can evolve independently. The homepage has its own pixel art style that represents the games without being them. Current homepage representations:
- **La Chambre Froide**: Ice/stone house, snowflake sprite, cyan palette
- **Hotplate**: Wooden restaurant, frying pan sprite, amber palette
- **Rabbits & Hats**: Purple castle, rabbit-in-hat sprite, purple palette, "coming soon" state

## Design Principles (learned from 10+ prototype iterations)
1. **Games are the focus** - buildings must be big, central, clickable
2. **Calm and simple** - the page should feel like a quiet night, not a carnival
3. **Fun with edge** - ludique and a bit intriguing, not corporate
4. **Accessible** - pixel art says "simple games", which reassures non-tech people
5. **Village = togetherness** - the metaphor carries meaning about collaboration
6. **Night > day** - daytime palettes look too childish ("fada"); night is more atmospheric
7. **No separate sections** - buildings, sprites, names must be ONE unified scene

## Anti-Patterns (things we tried and rejected)
- Green sky (doesn't evoke night)
- Separated layout: village scene on top, info cards below (disconnected, unclear why to click)
- Dashboard/card layouts (too corporate, Prototype B)
- Too many animations / walking characters (overwhelming, Prototype E1)
- Arcade/neon aesthetic (too flashy, too 80s, Prototype A)
- Terminal/CRT (too niche for coaches, Prototype D)
- Adventure map top-down (zones too abstract, Prototype E3)

## Games & URL Routing
Single domain: **play.fly-agile.com**
- `/` = homepage (this project)
- `/hotplate` = Hotplate game
- `/frozen-chamber` = La Chambre Froide

| Game | Status | URL | Homepage Color |
|------|--------|-----|---------------|
| La Chambre Froide | Needs redeployment | play.fly-agile.com/frozen-chamber | Cyan/blue |
| Hotplate | LIVE on K3s | play.fly-agile.com/hotplate | Amber/orange |
| Rabbits & Hats | LIVE on K3s | play.fly-agile.com/rabbits-hats | Purple/pink |

## Infrastructure
- **Hosting**: K3s cluster on Scaleway Kapsule (ArgoCD GitOps)
- **Infra repo**: github.com/FlyAgileWithGiom/mcp-infra-platform
- **K8s manifests**: `apps/games-homepage/` (base + overlays/prod)
- **ArgoCD app**: `argocd/games-homepage-prod.yaml`
- **Ingress**: nginx-ingress + cert-manager (letsencrypt-prod)
- **Registry**: rg.fr-par.scw.cloud/fly-agile-prod/games-homepage
- **DNS**: PlanetHoster (play.fly-agile.com → 51.159.25.216)
- **Target**: sub-2s load on 4G

## Access Model
- Invitation-only: games require an invitation to join
- Homepage displays "Invitation required -- Contact Giom" discretely
- The page is public but games are gated

## Language
- Homepage content in English (international audience)
- Game names stay in their original language (La Chambre Froide stays French)

## Target Audience
- Agile coaches sharing one URL with workshop participants
- Coaches are tech-curious, participants are NOT tech-oriented
- The page must work without explanation: land, see, click, play

## Commit Standards
Follow Fly Agile conventions:
- `feat:` new features
- `fix:` bug fixes
- `refactor:` code improvements
- `docs:` documentation
- Run tests before committing
- One commit per concern

## Brand Assets Reference
- Brand guide: Google Drive giom@giom-unlimited.com / Fly Agile's home / 01_Content Studio / Visual Assets / Brand Elements /
- Logo files: same path / Logo /
- Primary brand color: #4CAF50 (green)
- Paper plane formation = Fly Agile logo motif (separate animation project, out of scope here)
