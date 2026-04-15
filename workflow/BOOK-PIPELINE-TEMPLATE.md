# Book Pipeline — KDP Author Engine

## Standard Output Protocol — Every Book
All books follow this folder structure under `{{BOOKS_DIR}}/`:
```
{{BOOKS_DIR}}/[book-title-slug]/
  manuscript/              ← Author: ch01-approved.docx ... full-manuscript.docx
  ready-to-publish/        ← Publisher: all KDP files, metadata, cover brief
  marketing/               ← Marketer: launch plan, ads, performance reports
```
- Author creates `manuscript/` when a book is approved (Stage 3)
- Publisher creates `ready-to-publish/` when manuscript is received (Stage 9)
- Marketer creates `marketing/` when launch planning begins (Stage 10)
- **All output files are .docx format** — converted via pandoc

## Pipeline Stages
1. **Research** — Bookfinder scanning markets
2. **Recommended** — Titles presented to {{AUTHOR_NAME}}
3. **Approved** — {{AUTHOR_NAME}} selected a title
4. **Blueprint** — Outline and blueprint created by Author
5. **Writing** — Bookwriter drafting chapters
6. **Review** — Editor quality review in progress
7. **Final Edit** — Complete manuscript in final pass (Author)
8. **Content Approved** — {{AUTHOR_NAME}} final content sign-off
9. **Publishing** — Publisher handling KDP formatting, metadata, upload prep
10. **Marketing** — Marketer executing launch plan, Amazon Ads, ARC campaign
11. **Published** — Live on KDP/IngramSpark, Marketer managing ongoing promotion

## Active Projects
(None yet — your first book starts here!)

## Completed Books
(None yet.)
