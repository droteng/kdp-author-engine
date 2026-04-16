# NEXT ACTION — Author

> This file tells you exactly what to do next. Read it at the start of every session.
> When you complete the action, update this file with the next one.
> Do not talk about this action. Do it. Then confirm with the output file path or action taken.

---

## Current Next Action

**STEP 1 — Send Chapter 2 brief to Bookwriter**

Post this message in **#bookwriter**:

```
[HANDOFF: CHAPTER-BRIEF]
Book: The Blood Sugar and Heart Reset
Chapter: 2 — Why So Many Smart People Still Feel Confused

Bookwriter — draft Chapter 2.

Your brief package:
- Brief: book-projects/the-blood-sugar-and-heart-reset/chapters/ch02-brief.md
- Continuity: book-projects/the-blood-sugar-and-heart-reset/continuity.md
- Research: book-projects/the-blood-sugar-and-heart-reset/research/ch02-research-notes.md
- Humanization rules: writing-rules/HUMANIZATION-RULES.md
- Quality checklist: writing-rules/QUALITY-CHECKLIST.md

Read all five documents before writing.
Target: 2,700–3,200 words.
Include source notes. Keep all [NEEDS VERIFICATION] markers.
When done, post the complete draft to #author using the [HANDOFF: CHAPTER-DRAFT] format.
```

**After posting, move to Step 2.**

---

## STEP 2 — Review Bookwriter's draft

When Bookwriter posts `[HANDOFF: CHAPTER-DRAFT]` in **#author**:

Review the draft against:
- The chapter outline in `ch02-brief.md` — does it follow the structure you gave?
- The blueprint in `BOOK-BLUEPRINT.md` — does it match the book's positioning and audience?
- The continuity doc in `continuity.md` — does it flow from Chapter 1?
- Tone and voice — does it sound like Dr. Oteng, not an AI?

**If the draft is good (matches blueprint, outline, continuity, tone):**
→ Move to Step 3. Send to Editor.

**If the draft needs work:**
Post in **#bookwriter**:
```
[REVISION-REQUEST: CHAPTER]
Book: The Blood Sugar and Heart Reset
Chapter: 2

[List specific issues — what doesn't match the brief, what needs rewriting, what's off-tone]

Revise and resubmit to #author.
```
Then WAIT for Bookwriter to resubmit. Review again.

---

## STEP 3 — Hand off to Editor

When you approve the draft, post in **#editor**:

```
[AUTHOR-APPROVED: CHAPTER]
Book: The Blood Sugar and Heart Reset
Chapter: 2 — Why So Many Smart People Still Feel Confused

This chapter has passed my review against the blueprint and continuity rules.
Please edit and polish for publication quality — humanization, structure, prose,
show-don't-tell, continuity, and engagement.

[Paste the full approved chapter text here]
```

**After posting, move to Step 4.**

---

## STEP 4 — Wait for Editor → Dr. Oteng

What happens next (without you):
- Editor edits, rewrites, and polishes the chapter
- Editor posts the final polished version + quality scores to **#author** addressed to Dr. Oteng with `[EDITOR-FINAL: CHAPTER]`
- Dr. Oteng reads and decides:
  - **APPROVED** → move to Step 5
  - **CHANGES NEEDED** → Dr. Oteng posts in #editor, Editor revises and resubmits to #author. You wait.
  - **REJECTED** → Dr. Oteng tells you in #author. Go back to Step 2 — rewrite the brief if needed, send Bookwriter a new brief.

**Your only job during Step 4: WAIT for Dr. Oteng's decision in #author.**

---

## STEP 5 — Save and advance (after Dr. Oteng approves)

When Dr. Oteng approves Chapter 2, do ALL of these immediately:

1. Save `book-projects/the-blood-sugar-and-heart-reset/chapters/ch02-draft.md` — Editor's final polished text
2. Save `book-projects/the-blood-sugar-and-heart-reset/chapters/ch02-review-notes.md` — Editor's scores and changes summary
3. Convert: `/Users/leobiz/BOOKS/the-blood-sugar-and-heart-reset/manuscript/ch02-approved.docx` — via pandoc
4. Update `book-projects/the-blood-sugar-and-heart-reset/CHAPTER-TRACKER.md` — mark Ch2 as "Dr. Oteng Approved"
5. Update `book-projects/the-blood-sugar-and-heart-reset/continuity.md` — add Ch2 summary
6. Write `book-projects/the-blood-sugar-and-heart-reset/chapters/ch03-brief.md` — Chapter 3 brief
7. Write `book-projects/the-blood-sugar-and-heart-reset/research/ch03-research-notes.md` — Chapter 3 research
8. Update this NEXT-ACTION.md — set Step 1 to send Chapter 3 brief to Bookwriter

---

## The Full Pipeline (for reference)

```
Bookfinder scans → 3 titles → Dr. Oteng selects in #bookfinder
                                      ↓
                               Author (you)
                        writes blueprint, outlines,
                         chapter briefs, continuity
                                      ↓
                              Bookwriter drafts
                            (ghostwriter, #bookwriter)
                                      ↓
                         Author (you) reviews draft
                        against blueprint & rules
                          ↙                ↘
                     REJECT              APPROVE
                   → Bookwriter           ↓
                                       Editor
                                (edits, rewrites, polishes)
                                        ↓
                                   Dr. Oteng
                                 (final approval)
                              ↙      ↓       ↘
                        REJECT  CHANGES    APPROVE
                       → You   → Editor   → Publisher → Marketer
```

---

## Completed Actions Log
- [2026-04-13] Chapter 1 approved by Dr. Oteng
- [2026-04-13] CHAPTER-TRACKER.md updated
- [2026-04-13] continuity.md updated with Chapter 1 summary
- [2026-04-13] ch02-brief.md written
- [2026-04-13] ch02-research-notes.md written
- [2026-04-13] ch01-approved.docx saved to /Users/leobiz/BOOKS/the-blood-sugar-and-heart-reset/manuscript/
