# 貢獻指南｜Contributing Guide

感謝你對《歐亞文明歷史動力學》（ECD）的研究有興趣。本專案以繁體中文與英文作為共同研究語言，歡迎跨學科參與。

Thank you for your interest in Eurasian Civilizational Dynamics (ECD). Traditional Chinese and English are the shared research languages. Interdisciplinary contributions are welcome.

## 1. 可貢獻的內容｜Ways to Contribute

- 原始史料線索、版本資訊、校勘與翻譯 / Primary-source leads, editions, collation, and translations
- 學術文獻與書目 / Scholarly literature and bibliography
- 人物、地點、事件與年代資料 / People, places, events, and chronology
- 商業、遷徙、宗教及知識網絡案例 / Case studies of commercial, migratory, religious, and knowledge networks
- 方法論、資料結構、地圖與視覺化 / Methodology, data structures, maps, and visualizations
- 文件校訂與中英翻譯 / Documentation editing and Chinese-English translation

## 2. 提交前原則｜Before Submitting

1. Cite traceable sources. Include page numbers, section identifiers, inscription lines, or stable URLs where available.
2. Distinguish primary evidence, scholarly interpretation, and your own hypothesis.
3. Preserve original-language text and editorial uncertainty where relevant.
4. State competing interpretations and counter-evidence rather than hiding them.
5. Do not infer direct contact, ethnic identity, or causal relationships from name similarity or chronological coincidence alone.
6. Do not upload copyrighted books, articles, images, or datasets unless redistribution is permitted. Bibliographic references and brief research notes are preferred.
7. Keep unrelated project materials out of this repository.

## 3. GitHub 工作流程｜Workflow

- **Issue:** Ask a question, propose a research task, report a source lead, or identify a correction.
- **Pull Request:** Submit a focused change with a clear description and supporting sources.
- Keep each PR limited to one topic where practical.
- For substantial claims, explain evidence, uncertainty, alternatives, and what would falsify the claim.
- Do not silently replace source transcriptions or historical data; preserve prior versions and explain changes.

## 4. 建議的史料註記格式｜Suggested Evidence Note

```yaml
record_id: ECD-SOURCE-0001
layer: A
source_type: manuscript | inscription | archaeological | document | other
title:
creator_or_author:
date_or_date_range:
repository_or_publication:
shelfmark_or_identifier:
page_line_or_section:
original_language:
transcription_status: verified | provisional | damaged | disputed
translation:
claims_supported:
uncertainties:
related_records: []
```

This is a suggested starting schema, not a mandatory database standard. Do not invent missing fields; use `unknown` or leave them blank.

## 5. 雙語文件｜Bilingual Documents

Major project-level documents should have Traditional Chinese and English versions. Keep headings and section numbering aligned where possible. If a translation is provisional, label it as such.

## 6. Review and Acceptance

Contributions are reviewed for source traceability, clarity, scope, rights, and consistency with project standards. Acceptance does not make a hypothesis permanently true; all historical interpretations remain open to revision when new evidence appears.
