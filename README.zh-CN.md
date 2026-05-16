---
layout: page
title: "🇨🇳 中文"
permalink: /zh-CN/
lang: zh-CN
---

# [Pixiv Encyclopedia Viewer History Extractor](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor "Pixiv Encyclopedia Viewer History Extractor")

[![Python](https://img.shields.io/badge/python-3.9|%203.10%20|%203.11|%203.12|%203.13-blue)](https://www.python.org/)
![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-blue)

[![CodeQL Advanced](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/codeql.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/codeql.yml)
[![Python Lint](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/lint.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/lint.yml)
[![Pytest](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/pytest.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/pytest.yml)

!["web_ui"](./assets/images/web_ui.png)

用于提取 Pixiv Encyclopedia Viewer Count History 的工具

## 日文 README

日文版请见 [`README.ja.md`](README.ja.md).

---

## 概览

从 [Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/) 文章中提取每日浏览历史数据。

Pixiv Encyclopedia viewer history 是一个很好的真实世界时间序列数据集。

它通常会显示:
- 周期性周内模式（weekday vs weekend traffic）
- 由 events 或 social media buzz 引发的偶发 spikes

你可以将提取出的 CSV 用作以下场景的 sample data:
- Time-series visualization 和 smoothing
- Seasonal decomposition
- Forecasting models (ARIMA, Prophet, etc.)


> ⚠️ **非官方 tool**  
> 本 project 与 Pixiv 没有关联，也未获得 Pixiv 的 endorsement。  
> 使用此 script 时，请遵守 Pixiv's Terms of Use 和 robots.txt。

## 功能

- 直接从 Pixiv Encyclopedia 按 **article title**（e.g., `"ブルーアーカイブ"`）fetch
- 或从 **local HTML file** 读取
- 向 stdout 输出 **JSON Lines**  
  （每行一个 `{"date": "...","count": ...}`）
- 通过 `--csv output.csv` 可选地进行 **CSV export**

---

## 要求

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## 用法

### 0. 创建 virtual environment

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. 按 article title fetch

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

这将:

- 下载 `https://dic.pixiv.net/a/ブルーアーカイブ`
- parse embedded JSON
- 向 stdout 每行 print 一个 JSON object:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

你可以将其 redirect 到 file:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. Export as CSV

使用 `--csv` option 写入 CSV file，同时仍然将 JSON print 到 stdout:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" --csv ブルーアーカイブ.csv
```

CSV content 示例:

```csv
date,count
2025-07-01,9454605
2025-07-02,9331510
2025-07-03,8884117
...
```

### 3. 使用 local HTML file

如果你已经保存了 article HTML:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Script 会检测到 `ブルーアーカイブ.html` 是一个 file，并会 parse 它，而不是从 web fetch。

---

### 4. Test

```bash
pip install -r requirements.test.txt
pytest
```

### 5. Deactivate environment

```bash
deactivate
```

---

## Notes / Limitations

- 尚未实现 rate limiting；请:
  - 负责任地使用
  - 避免在短时间内发送大量 requests
- 这是一个简单的 utility script，主要用于 personal analysis 或 research。

---

## License
- Apache License 2.0
