# KDP Author Engine

**A 6-agent AI book writing, publishing, and marketing pipeline for OpenClaw.**

From market research to bestseller ranking — fully automated, human-in-the-loop, commercial-grade.

---

## What You Get

A complete multi-agent system that writes, edits, publishes, and markets books on Amazon KDP:

| Agent | What It Does |
|-------|-------------|
| **Bookfinder** 🔎 | Weekly market scans, title recommendations, keyword intelligence, competitive analysis |
| **Author** 📖 | Pipeline orchestrator — blueprints, chapter briefs, approvals, quality gates |
| **Bookwriter** ✍️ | Writes chapters from briefs, follows humanization rules, self-reviews before submission |
| **Editor** ✏️ | 6-dimension quality scoring, developmental editing, revision management |
| **Publisher** 🚀 | KDP/IngramSpark formatting, metadata, keywords, categories, pricing, cover briefs |
| **Marketer** 📣 | Launch campaigns, Amazon Ads, ARC strategy, social media, email, performance tracking |

### Plus:
- **book-author skill** — 7 reference files covering humanization rules, quality checklists, genre playbooks, chapter workflows, KDP publishing, keyword research, and book marketing
- **Pipeline workflow** — structured Discord handoff protocol with tagged messages, rejection flows, and keyword intelligence chain
- **Cron job template** — automated weekly market scan
- **Setup script** — one command to configure everything with your details

---

## The Pipeline

```
Bookfinder scans markets weekly
    ↓ 3 title recommendations + keyword intelligence
You approve a title
    ↓
Author creates blueprint and chapter briefs
    ↓
Bookwriter drafts chapters one at a time
    ↓
Editor scores every draft (6 dimensions, minimum 7.5 to pass)
    ↓ revise and resubmit until quality gate passes
You approve each chapter
    ↓ .docx saved locally via pandoc
Author assembles full manuscript
    ↓ + keyword intelligence from Bookfinder
Publisher formats for KDP, builds metadata package
    ↓
Book goes live on Amazon
    ↓
Marketer executes launch: ARC, ads, social, email
    ↓ 30/60/90 day performance reports
```

**You stay in the loop at every approval gate.** Nothing publishes without your sign-off.

---

## Requirements

- **OpenClaw** v4.5+ with Discord enabled
- **Discord server** with 6 channels (one per agent)
- **AI model access** via OpenRouter, OpenAI, or Ollama (configurable)
- **pandoc** for .docx conversion (`brew install pandoc` on Mac)
- **jq** for setup script (`brew install jq` on Mac)

---

## Quick Start

### New to OpenClaw? Use the Quickstart Script

If this is your first time using OpenClaw, run this one command. It handles everything — installing OpenClaw, configuring it, setting up all 6 agents, and getting you live:

```bash
chmod +x quickstart.sh
./quickstart.sh
```

The script will:
1. Install Node.js, jq, and pandoc if missing
2. Install OpenClaw if not already installed
3. Walk you through OpenClaw configuration (Discord bot setup)
4. Prompt you to fill in `bookforge.config.json`
5. Configure all agent files with your details
6. Copy agent workspaces into OpenClaw
7. Register all 6 agents and Discord bindings automatically
8. Import the weekly cron job
9. Restart OpenClaw
10. Print your Discord community invite link

**Already using OpenClaw?** Skip to the manual steps below.

---

### Manual Setup (Existing OpenClaw Users)

### 1. Configure

Edit `bookforge.config.json` with your details:
- Your name, pen name, and author bio
- Your book niches and expertise
- Discord channel IDs for all 6 agents
- AI model preferences (defaults provided)
- Output directory for manuscripts

### 2. Run Setup

```bash
chmod +x setup.sh
./setup.sh
```

This replaces all `{{PLACEHOLDER}}` values across every agent file, skill, and workflow with your configuration.

### 3. Install into OpenClaw

Copy agent workspaces:
```bash
cp -r agents/bookfinder ~/.openclaw/agents-workspaces/bookfinder
cp -r agents/author ~/.openclaw/agents-workspaces/author
cp -r agents/bookwriter ~/.openclaw/agents-workspaces/bookwriter
cp -r agents/editor ~/.openclaw/agents-workspaces/editor
cp -r agents/publisher ~/.openclaw/agents-workspaces/publisher
cp -r agents/marketer ~/.openclaw/agents-workspaces/marketer
```

Copy the skill bundle:
```bash
cp -r skills/book-author ~/.openclaw/skills/book-author
```

Copy workflow files to Author's workspace:
```bash
cp workflow/BOOK_PIPELINE_WORKFLOW.md ~/.openclaw/agents-workspaces/author/
cp workflow/BOOK-PIPELINE-TEMPLATE.md ~/.openclaw/agents-workspaces/author/BOOK-PIPELINE.md
```

### 4. Register Agents in openclaw.json

Add each agent to the `agents.list` array in `~/.openclaw/openclaw.json`. Example for one agent:

```json
{
  "id": "bookfinder",
  "name": "Bookfinder",
  "workspace": "~/.openclaw/agents-workspaces/bookfinder",
  "agentDir": "~/.openclaw/agents/bookfinder/agent",
  "model": {
    "primary": "openai-codex/gpt-5.4",
    "fallbacks": [
      "openrouter/nvidia/nemotron-3-super-120b-a12b",
      "openrouter/deepseek/deepseek-chat"
    ]
  },
  "identity": {
    "name": "Bookfinder",
    "theme": "Book Market Research & Title Discovery",
    "emoji": "🔎"
  }
}
```

Repeat for: `author`, `bookwriter`, `editor`, `publisher`, `marketer`.

Add Discord bindings for each:
```json
{
  "agentId": "bookfinder",
  "match": {
    "channel": "discord",
    "peer": { "kind": "channel", "id": "YOUR_BOOKFINDER_CHANNEL_ID" }
  }
}
```

Add channel entries under `channels.discord.guilds.YOUR_GUILD_ID.channels`:
```json
"YOUR_BOOKFINDER_CHANNEL_ID": { "enabled": true }
```

### 5. Import Cron Job

```bash
openclaw cron import cron/bookfinder-weekly-scan.json
```

### 6. Restart and Test

```bash
openclaw restart
```

Test by messaging Bookfinder in `#bookfinder`:
> Run your first weekly market scan.

---

## Package Contents

```
kdp-author-engine/
├── bookforge.config.json          ← Your configuration (edit this first)
├── quickstart.sh                  ← One-command full setup (new OpenClaw users start here)
├── setup.sh                       ← Setup script only (existing OpenClaw users)
├── README.md                      ← This file
├── COMMUNITY.md                   ← Discord community invite + channel guide
├── LICENSE.md                     ← License terms
├── LISTING.md                     ← Product description for marketplaces
├── agents/
│   ├── bookfinder/                ← Market research agent
│   │   ├── AGENTS.md
│   │   ├── SOUL.md
│   │   └── IDENTITY.md
│   ├── author/                    ← Pipeline orchestrator agent
│   │   ├── AGENTS.md
│   │   ├── SOUL.md
│   │   └── IDENTITY.md
│   ├── bookwriter/                ← Chapter drafting agent
│   │   ├── AGENTS.md
│   │   ├── SOUL.md
│   │   └── IDENTITY.md
│   ├── editor/                    ← Quality review agent
│   │   ├── AGENTS.md
│   │   ├── SOUL.md
│   │   └── IDENTITY.md
│   ├── publisher/                 ← KDP publishing agent
│   │   ├── AGENTS.md
│   │   ├── SOUL.md
│   │   └── IDENTITY.md
│   └── marketer/                  ← Launch & promotion agent
│       ├── AGENTS.md
│       ├── SOUL.md
│       └── IDENTITY.md
├── skills/
│   └── book-author/
│       ├── SKILL.md               ← Core skill file (7 phases)
│       └── references/
│           ├── humanization-rules.md
│           ├── quality-checklist.md
│           ├── genre-playbooks.md
│           ├── chapter-workflow.md
│           ├── kdp-publishing.md
│           ├── keyword-research.md
│           └── book-marketing.md
├── workflow/
│   ├── BOOK_PIPELINE_WORKFLOW.md  ← Full handoff protocol
│   └── BOOK-PIPELINE-TEMPLATE.md  ← Pipeline stage tracker
├── cron/
│   └── bookfinder-weekly-scan.json ← Weekly scan cron template
└── templates/
    └── (reserved for future reference.docx, cover templates, etc.)
```

---

## Key Features

### Humanization Engine
Every chapter passes through a comprehensive anti-AI-detection system:
- 60+ forbidden words and phrases that flag AI writing
- Structural AI tell detection (repetitive patterns, uniform lists)
- Mandatory self-review by Bookwriter before Editor sees it
- 6-dimension quality scoring with humanization weighted highest (25%)

### Keyword Intelligence Chain
Keywords are researched once by Bookfinder and flow through the entire pipeline:
```
Bookfinder → Author (blueprint) → Publisher (KDP metadata) → Marketer (ad campaigns)
```
Nobody re-researches. Nobody guesses. Data-driven from Day 1.

### Quality Gate
Editor scores every chapter on 6 dimensions:
- Language Quality (20%), Humanization (25%), Genre Compliance (15%)
- Engagement (15%), Continuity (15%), Structure (10%)
- Minimum 7.5 weighted average AND no dimension below 6.0 to pass

### Genre Playbooks
Built-in playbooks for 7 genres:
Health/Wellness Non-fiction, Children's Books, AI/Technology, Faith/Ministry, Literary Fiction, Commercial/Genre Fiction, Self-Help/Business

### Full KDP Publishing
- Ebook and paperback formatting specs
- Metadata optimization (title, subtitle, description, backend keywords)
- BISAC category strategy
- Pricing intelligence (royalty tier optimization)
- KDP Select vs. wide distribution decision framework
- Pre-upload checklist

### Launch Marketing
- 12-week launch timeline (Week -6 to Week +12)
- ARC strategy with recruitment sources and tracking
- Amazon Ads setup and optimization (4 campaign types)
- Social media by genre
- Email marketing sequences
- 30/60/90-day performance reporting

---

## Customization

### Changing Agent Names
Edit `bookforge.config.json` — the setup script handles all replacements.

### Adding Niches
Add entries to `niches.categories` in the config. Bookfinder will scan all configured niches.

### Changing Models
Update `models.*` in the config. Each agent role has independent model configuration.

### Adjusting Research Schedule
Change `schedule.weeklyResearchDay` (0-6, Sunday-Saturday) and `schedule.weeklyResearchHour` in the config.

---

## Community & Support

Join **The Integrative Builder** Discord — the support community for KDP Author Engine buyers:

👉 See `COMMUNITY.md` for your invite link and channel guide.

What you get:
- `#kdp-setup-help` — setup questions, troubleshooting, step-by-step help
- `#kdp-engine-buyers` — private buyers channel with priority support and early updates
- `#kdp-share-your-books` — show off your published books
- A community of indie authors using the same pipeline

For bugs or issues, post in `#kdp-setup-help` with your OS, OpenClaw version (`openclaw --version`), and the exact error message.

---

*Built for OpenClaw. Designed for indie authors who want a professional publishing operation.*
