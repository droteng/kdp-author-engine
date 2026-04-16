# Book-Writing Pipeline Workflow & Handoffs

## Agents & Channels

| Agent | Role | Discord Channel |
|-------|------|-----------------|
| Bookfinder 🔎 | Market research, title discovery, keyword intelligence | `#bookfinder` |
| Author 📖 | Orchestrator — outlines, blueprints, approvals, saves locally | `#author` |
| Bookwriter ✍️ | Writes chapter drafts from Author's briefs | `#bookwriter` |
| Editor ✏️ | Hands-on editing — rewrites, polishes, scores, delivers publishable chapters | `#editor` |
| Publisher 🚀 | KDP formatting, metadata, upload prep | `#publisher` |
| Marketer 📣 | Launch campaigns, Amazon Ads, ongoing promotion | `#marketer` |

Each agent operates in their own OpenClaw workspace and follows the **book-author skill** (humanization rules, quality checklist, genre playbooks, keyword research, KDP publishing, marketing).

### Pipeline Stage Tracking
Author maintains `BOOK-PIPELINE.md` with stages for every active book.

**Stages:** Research → Recommended → Approved → Blueprint → Writing → Review → Final Edit → Content Approved → Publishing → Marketing → Published

---

## Handoff Protocols

### 1. Bookfinder → Dr. Oteng (Weekly)
**When:** Bookfinder completes weekly title research
**Where:** Post in `#bookfinder`
**Format:**
```text
[BOOK-FINDER: WEEKLY-REPORT]
Week of <Date>

## Recommendation #1 — [CONFIDENCE: HIGH/MED/LOW]
Title: <Title>
Subtitle: <Subtitle>
KDP Category: <Primary > Secondary>
Niche: <Specific niche>

Market Data:
| Competitor | BSR | Reviews | Rating | Price (e/p) |
|-----------|-----|---------|--------|-------------|
| <Book 1>  |     |         |        |             |
| <Book 2>  |     |         |        |             |
| <Book 3>  |     |         |        |             |
| <Book 4>  |     |         |        |             |
| <Book 5>  |     |         |        |             |

Demand: <Search volume + evidence>
Review Gaps: <What readers want that competitors miss>
Dr. Oteng's Angle: <How their expertise applies>
Format: <Ebook / Paperback / Both>
Est. Word Count: <X,000>
Revenue Estimate: $<X>/month at <price point>
Urgency: <Evergreen / Trending — window closes <date>>

Keyword Intelligence:
- Title keywords (indexed): <words>
- Subtitle keywords (indexed): <words>
- 7 Backend Keywords:
  1. <phrase> (<XX/50 chars>) — <source>
  2-7. [same format]
- Categories: <Primary BISAC> / <Secondary BISAC>

---
[Repeat for Recommendations #2 and #3]
---

@Dr. Oteng please review and indicate preferred title or request new options.
```

---

### 1b. REJECTION: Dr. Oteng rejects all 3 titles
**Where:** Reply in `#bookfinder`
```text
[REJECTION: WEEKLY-REPORT]
None of these work. Reason: <feedback>
Direction for next week: <what to look for instead>
```
Bookfinder updates WATCHLIST.md and adjusts next week.

---

### 2. Bookfinder → Author (Title Approved)
**When:** Dr. Oteng approves a book title
**Where:** Post in `#author`
**Format:**
```text
[HANDOFF: BOOK-TITLE-APPROVED]
Approved Title: <Title>
Approved Subtitle: <Subtitle>
Source: Bookfinder Weekly Report <date>

KEYWORD INTELLIGENCE PACKAGE:
- 7 Backend Keywords:
  1. <phrase> — <competition level> — <rationale>
  2-7. [same format]
- Title keywords (already indexed): <list>
- Subtitle keywords (already indexed): <list>
- Primary Category: <Full browse path + BISAC code>
- Secondary Category: <Full browse path + BISAC code>
- Post-publish categories: <2-3 additional>
- Competitive Analysis: <link to research file>

MARKET CONTEXT:
- Target audience: <specific reader persona>
- Dr. Oteng's angle: <differentiation>
- Revenue estimate: $<X>/month
- Top competitor gap: <what's missing>
- Format: <Ebook / Paperback / Both>
- Est. word count: <X,000>

@Author please begin outlining. Keyword intelligence above is for your blueprint and will pass through to Publisher and Marketer.
```

**This keyword data travels the entire pipeline — do not discard it.**

---

### 3. Author → Bookwriter (Chapter Brief)
**When:** Author finishes chapter brief
**Where:** Post in `#bookwriter`
**Format:**
```text
[HANDOFF: CHAPTER-BRIEF]
Book: <Book Title>
Chapter <X> of <Y>: "<Chapter Title>"
@Bookwriter please write this chapter based on the brief below.

CHAPTER BRIEF:
- Title: <Chapter Title>
- Goal: <One-sentence purpose>
- Target Length: <Word count>
- Audience Level: <target reader>

TONE & VOICE:
- [Tone instructions specific to this book]

HUMANIZATION RULES:
- Open with a relatable scene or hook
- Show empathy before solutions
- Normalize struggles
- Highlight small wins
- Never shame the reader

CONTINUITY:
- Previous chapter summary: <2-3 sentences>
- Running themes to maintain: <list>
- Definitions/terms established: <list>

STYLE & CRAFT:
- Vary sentence length
- Active voice
- Include action boxes / practical takeaways per brief
- End with forward-looking hint to next chapter

REFERENCE MATERIALS:
- Outline section: <excerpt>
- Research notes: <key sources>
- Genre playbook: <which genre>

Post your draft to #author when complete. Tag @Author for review.
```

---

### 3b. REJECTION: Author rejects a chapter draft
**Where:** Author posts in `#bookwriter`
```text
[REVISION-REQUEST: CHAPTER <X>]
Book: <Book Title>
Verdict: REVISION NEEDED

ISSUES (address ALL):
1. <Specific issue — what doesn't match the brief>
2. <Specific issue — what's off-tone or off-structure>
3. <Specific issue — what contradicts continuity>

KEEP (do not change):
- <What worked>

@Bookwriter please revise and resubmit to #author.
```

---

### 4. Bookwriter → Author (Draft Complete)
**When:** Bookwriter finishes a chapter draft
**Where:** Post in `#author`
**Format:**
```text
[HANDOFF: CHAPTER-DRAFT]
Book: <Book Title>
Chapter <X>: "<Chapter Title>" — draft complete.
Word count: <X,XXX>

SELF-REVIEW:
- Humanization rules followed: [check]/[warning]
- Continuity with previous chapters: [check]/[warning]
- Action box included: [check]/[warning]
- Forward-looking ending: [check]/[warning]

Notes: <areas wanting attention>

@Author please review.
```

---

### 4b. Author → Editor (Chapter Approved by Author)
**When:** Author reviews draft and it matches blueprint, outline, continuity, and tone
**Where:** Post in `#editor`
**Format:**
```text
[AUTHOR-APPROVED: CHAPTER <X>]
Book: <Book Title>
Chapter <X>: "<Chapter Title>"

This chapter has passed my review against the blueprint and continuity rules.
Please edit and polish for publication quality — humanization, structure, prose,
show-don't-tell, continuity, and engagement.

[Full approved chapter text]
```

---

### 5. Editor → Dr. Oteng (Polished Chapter)
**When:** Editor finishes editing, rewriting, and polishing the chapter
**Where:** Post in `#author`
**Format:**
```text
[EDITOR-FINAL: CHAPTER <X>]
Book: <Book Title>
Chapter <X>: "<Chapter Title>"

## Editor's Quality Report
| Dimension | Score |
|-----------|-------|
| Humanization | [X]/10 |
| Structure | [X]/10 |
| Prose Quality | [X]/10 |
| Show Don't Tell | [X]/10 |
| Continuity | [X]/10 |
| Engagement | [X]/10 |
| **Weighted Average** | **[X.X]/10** |

## Changes Made
<Summary of what was changed, rewritten, or polished — specific sections and reasons>

## Final Chapter Text
[The complete, polished chapter — ready for Dr. Oteng to read]

@Dr. Oteng this chapter is edited and ready for your final review.
```

---

### 5b. Dr. Oteng's Decision
**Where:** Reply in `#author` or `#editor`

**APPROVED:**
```text
[APPROVED: CHAPTER <X>]
```
Author saves files, updates tracker, writes next brief. Chapter moves toward Publisher.

**CHANGES NEEDED:**
Dr. Oteng posts in `#editor`:
```text
[CHANGES-NEEDED: CHAPTER <X>]
Book: <Book Title>
Feedback: <specific changes requested>
```
Editor makes the requested changes and resubmits `[EDITOR-FINAL: CHAPTER <X>] (Revised)` to #author.

**REJECTED:**
Dr. Oteng posts in `#author`:
```text
[REJECTION: CHAPTER <X>]
Reason: <feedback — fundamental issues>
```
Author translates feedback into a `[REVISION-REQUEST]` for Bookwriter in #bookwriter with specific instructions. The chapter re-enters the pipeline at Bookwriter.

---

### 6. Author saves approved chapter locally
**When:** Dr. Oteng approves a chapter
**Actions (all before responding):**

1. Save as .docx: `/Users/leobiz/BOOKS/<book-slug>/manuscript/ch<XX>-approved.docx`
2. Update CHAPTER-TRACKER.md
3. Update continuity.md
4. Write next chapter brief
5. Update BOOK-PIPELINE.md

```text
[SAVED: CHAPTER <X>]
Book: <Book Title>
File: /Users/leobiz/BOOKS/<slug>/manuscript/ch<XX>-approved.docx
Next: Chapter <X+1> brief ready — sending to Bookwriter.
```

---

### 7. Author → Publisher (Full Manuscript)
**When:** ALL chapters approved. Dr. Oteng gives final content sign-off.
**Where:** Post in `#publisher`
**Format:**
```text
[HANDOFF: FINAL-MANUSCRIPT]
Book Title: <Book Title>
Subtitle: <Subtitle>
Total Chapters: <Y>
Total Word Count: ~<X,000>
Full Manuscript: /Users/leobiz/BOOKS/<book-slug>/manuscript/full-manuscript.docx

KEYWORD INTELLIGENCE (from Bookfinder):
- 7 Backend Keywords: [list all 7]
- Primary Category: <BISAC>
- Secondary Category: <BISAC>
- Post-publish categories: <2-3>
- Title/subtitle keywords: <list>

BOOK CONTEXT:
- Genre: <genre playbook>
- Target audience: <persona>
- Comparable titles: <top 3-5>
- Tone notes: <for description copywriting>

MARKETING INPUTS:
- Author platform: <channels, following size>
- Email list: <Y/N, size>
- ARC strategy preference: <any>
- Launch timing: <if any preference>

@Publisher please begin formatting, metadata, and upload prep.
Output to: /Users/leobiz/BOOKS/<book-slug>/ready-to-publish/
```

---

### 8. Publisher → Marketer (Book is Live)
**When:** Book listing is confirmed live on Amazon
**Where:** Post in `#marketer` and `#author`
**Format:**
```text
[PUBLISHED: <Book Title>]
Status: LIVE
- KDP Ebook: <link>
- KDP Paperback: <link>
- IngramSpark: <Y/N>
- Price: $<ebook> / $<paperback>
- Categories: <where listed>

Keyword Intelligence: <link to kdp-metadata.md>
Description: <link to book-description.md>
Cover: <link or status>

Files: /Users/leobiz/BOOKS/<slug>/ready-to-publish/

@Marketer please execute the launch plan.
@Author @Dr. Oteng the book is live.
```

---

### 9. Marketer → Author (Launch Updates)
**When:** Launch milestones (Day 1, Week 1, 30-day, 60-day, 90-day)
**Where:** Post in `#marketer` and `#author`
**Format:**
```text
[LAUNCH-REPORT: <Book Title>] — Day <N> / Week <N>
Units sold: <total>
Reviews: <count> at <avg rating>
BSR: <current rank> in <category>
Ad spend: $<total> | ACOS: <X>%
Revenue: $<gross> | Royalties: $<net>

Actions taken: <what happened this period>
Next actions: <what's planned>
Issues: <any problems needing attention>
```

---

### 10. Marketer → Author (Performance Reports)
**Where:** Post in `#marketer` and `#author`
```text
[PERFORMANCE: <Book Title>] — <30/60/90>-Day Report
[Full report per template in Marketer AGENTS.md]
```

---

## Output Protocol — Every Book

```
/Users/leobiz/BOOKS/<book-title-slug>/
  manuscript/                ← Author's domain
    ch01-approved.docx
    ch02-approved.docx
    ...
    full-manuscript.docx
  ready-to-publish/          ← Publisher's domain
    formatted-ebook.epub
    formatted-paperback.pdf
    kdp-metadata.md
    book-description.md
    cover-brief.md
    pricing-strategy.md
  marketing/                 ← Marketer's domain
    launch-plan.md
    arc-tracker.md
    ad-campaigns.md
    performance-30day.md
    performance-60day.md
    performance-90day.md
```

All output files in .docx format where applicable, converted via pandoc.

---

## Keyword Intelligence Flow

```
Bookfinder researches keywords
    ↓
Weekly report includes keyword intelligence for each recommendation
    ↓
Title-approved handoff passes full keyword package to Author
    ↓
Author uses keywords in BOOK-BLUEPRINT.md
    ↓
Author passes keyword intelligence to Publisher in manuscript handoff
    ↓
Publisher uses keywords for KDP backend, description, categories
    ↓
Marketer uses keywords for Amazon Ads campaigns and SEO
```

**Nobody re-researches what Bookfinder already validated.**

---

## Notes
- All handoffs are **explicit, tagged Discord messages**
- Requires **no custom bots or code** — works with OpenClaw Discord today
- **Humans in the loop** at every approval gate (Dr. Oteng)
- **Editor adds a quality layer** between writing and approval — catches issues before the human sees them
- **Marketer extends the pipeline** past publishing into ongoing revenue optimization
- **Rejection protocols exist for every gate** — no ambiguity when something goes back
- **File discipline is non-negotiable** — if the file doesn't exist, the action didn't happen
- **Keyword intelligence travels the full pipeline** — researched once, used by everyone
