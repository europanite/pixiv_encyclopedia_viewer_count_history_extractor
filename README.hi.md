---
layout: page
title: "🇮🇳 हिंदी"
permalink: /hi/
lang: hi
---

# [Pixiv Encyclopedia Viewer History Extractor](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor "Pixiv Encyclopedia Viewer History Extractor")

[![Python](https://img.shields.io/badge/python-3.10%20|%203.11|%203.12|%203.13-blue)](https://www.python.org/)
![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-blue)

[![CodeQL Advanced](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/codeql.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/codeql.yml)
[![Python Lint](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/lint.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/lint.yml)
[![Pytest](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/pytest.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/pytest.yml)

<p align="right">
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/">🇺🇸 English</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/hi/">🇮🇳 हिंदी</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/ja/">🇯🇵 日本語</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/zh-CN/">🇨🇳 简体中文</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/es/">🇪🇸 Español</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/pt-BR/">🇧🇷 Português (Brasil)</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/ko/">🇰🇷 한국어</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/de/">🇩🇪 Deutsch</a> |
  <a href="https://europanite.github.io/pixiv_encyclopedia_viewer_count_history_extractor/fr/">🇫🇷 Français</a>
</p>

> यह README अनुवादित संस्करण है। अंग्रेज़ी संस्करण ही आधिकारिक स्रोत है।

!["web_ui"](./assets/images/web_ui.png)

Pixiv Encyclopedia Viewer Count History के लिए एक extraction tool

---

## अवलोकन

[Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/) लेख से दैनिक view history data निकालें।

Pixiv Encyclopedia viewer history एक उपयोगी real-world time-series dataset है।

यह अक्सर दिखाता है:
- साप्ताहिक seasonality (weekday बनाम weekend traffic)
- events या social media buzz के कारण occasional spikes

निकाले गए CSV को sample data के रूप में इस्तेमाल किया जा सकता है:
- Time-series visualization और smoothing
- Seasonal decomposition
- Forecasting models (ARIMA, Prophet, etc.)


> ⚠️ **Unofficial tool**  
> यह project Pixiv से संबद्ध नहीं है और Pixiv द्वारा endorsed नहीं है।  
> इस script का उपयोग करते समय कृपया Pixiv's Terms of Use और robots.txt का पालन करें।

## Features

- Pixiv Encyclopedia से सीधे **article title** (e.g., `"ブルーアーカイブ"`) द्वारा fetch करें
- या **local HTML file** से पढ़ें
- stdout पर **JSON Lines** output करें  
  (हर line में एक `{"date": "...","count": ...}`)
- `--csv output.csv` के माध्यम से optional **CSV export**

---

## Requirements

- Python 3.10+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Usage

### 0. Virtual environment बनाएँ

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Article title द्वारा fetch करें

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

यह करेगा:

- `https://dic.pixiv.net/a/ブルーアーカイブ` download करेगा
- embedded JSON parse करेगा
- stdout पर हर line में एक JSON object print करेगा:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

आप इसे file में redirect कर सकते हैं:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. CSV के रूप में export करें

stdout पर JSON print करते हुए CSV file लिखने के लिए `--csv` option का उपयोग करें:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" --csv ブルーアーカイブ.csv
```

Example CSV content:

```csv
date,count
2025-07-01,9454605
2025-07-02,9331510
2025-07-03,8884117
...
```

### 3. Local HTML file का उपयोग करें

यदि आपने article HTML पहले से save कर रखा है:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Script detect करेगा कि `ブルーアーカイブ.html` एक file है और web से fetch करने के बजाय उसे parse करेगा।


### .4 batch collect

```bash
bash ./scripts/collect_history.sh data/list.txt data/list/
```

---

### 4. Test

```bash
pip install -r requirements.test.txt
pytest
```

### 5. Environment deactivate करें

```bash
deactivate
```

---

## Notes / Limitations

- Rate limiting implement नहीं है; कृपया:
  - इसे responsibly उपयोग करें
  - कम समय में बहुत सारे requests भेजने से बचें
- यह एक simple utility script है, जिसका मुख्य उद्देश्य personal analysis या research है।

---

## License
- Apache License 2.0