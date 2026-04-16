# KDP Author Engine — Project Context for Claude

## What This Is
A commercial 6-agent AI book writing, publishing, and marketing pipeline built on OpenClaw.
Sold as a digital product. Built by Dr. Leo Oteng, PharmD.

## Key URLs
- **Sales page:** https://oteng.link/kdp-author-engine
- **Download page:** https://oteng.link/kdp-author-engine/download
- **ClawHub skill:** https://clawhub.ai/droteng/kdp-author-engine
- **ClawHub bundle:** https://clawhub.ai/droteng/kdp-author-engine-bundle
- **GitHub:** https://github.com/droteng/kdp-author-engine
- **Community Discord:** https://discord.gg/yGyXDwdHU9 (The Integrative Builder)

## Pricing
- Single User License: $149 (Stripe: https://buy.stripe.com/8x2fZi6Orfnn26U2lxfrW00)
- Agency License: $397 (contact: Builder@oteng.live)

## Current Version
v1.0.3 — published on ClawHub (skill + bundle) and GitHub

## Project Structure
```
kdp-author-engine/
├── CLAUDE.md                          ← This file
├── README.md                          ← Product documentation
├── COMMUNITY.md                       ← Discord invite + channel guide
├── LICENSE.md                         ← Single User / Agency / AAAS tiers
├── LISTING.md                         ← Marketplace copy (ClawHub, Gumroad, etc.)
├── bookforge.config.json              ← Buyer configuration schema
├── openclaw.bundle.json               ← ClawHub bundle manifest
├── quickstart.sh                      ← Full first-time setup (installs OpenClaw + all agents)
├── setup.sh                           ← Config-only setup (existing OpenClaw users)
├── agents/                            ← 6 agent workspaces
│   ├── bookfinder/                    ← Market research (AGENTS.md, SOUL.md, IDENTITY.md)
│   ├── author/                        ← Pipeline orchestrator
│   ├── bookwriter/                    ← Chapter drafting
│   ├── editor/                        ← 6-dimension quality scoring
│   ├── publisher/                     ← KDP formatting & metadata
│   └── marketer/                      ← Launch, ads, performance
├── skills/
│   └── book-author/
│       ├── SKILL.md                   ← Core skill (triggers across all 6 agents)
│       └── references/                ← 7 methodology files
│           ├── humanization-rules.md
│           ├── quality-checklist.md
│           ├── genre-playbooks.md
│           ├── chapter-workflow.md
│           ├── kdp-publishing.md
│           ├── keyword-research.md
│           └── book-marketing.md
├── workflow/
│   ├── BOOK_PIPELINE_WORKFLOW.md      ← Discord handoff protocol (10 handoffs)
│   └── BOOK-PIPELINE-TEMPLATE.md     ← Pipeline stage tracker
├── cron/
│   └── bookfinder-weekly-scan.json   ← Weekly market scan cron template
└── site/
    └── author-engine/
        ├── index.html                 ← Sales landing page (oteng.link/kdp-author-engine)
        ├── kdp-author-engine-v1.0.2.zip ← Product download zip
        └── download/
            └── index.html             ← Post-purchase download page
```

## The 6-Agent Pipeline
```
Bookfinder 🔎 → Author 📖 → Bookwriter ✍️ → Editor ✏️ → Publisher 🚀 → Marketer 📣
```

## Personal OpenClaw Installation
The personal (Dr. Oteng) version lives at:
`~/.openclaw/agents-workspaces/` — bookfinder, author, bookwriter, editor, publisher, marketer
`~/.openclaw/skills/book-author/`

## When Updating This Product
1. Edit files in this project folder
2. Run `git add -A && git commit -m "..." && git push origin main`
3. Tag new version: `git tag vX.X.X && git push origin vX.X.X`
4. Republish to ClawHub: `clawhub publish skills/book-author --slug kdp-author-engine --version X.X.X ...`
5. Republish bundle: `clawhub package publish . --family bundle-plugin --name kdp-author-engine-bundle --version X.X.X ...`
6. If site files changed: re-upload to Hostinger `public_html/kdp-author-engine/`
7. Update `~/.openclaw/` personal installation if applicable

## Related Projects
- **Diabetes Action Layer (DAL):** ~/Soft Projects/diabetes-action-layer/
- **Personal OpenClaw:** ~/.openclaw/
- **The Integrative Builder Discord:** https://discord.gg/yGyXDwdHU9
