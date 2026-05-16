---
layout: page
title: "🇰🇷 한국어"
permalink: /ko/
lang: ko
---

# [Pixiv Encyclopedia Viewer History Extractor](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor "Pixiv Encyclopedia Viewer History Extractor")

[![Python](https://img.shields.io/badge/python-3.9|%203.10%20|%203.11|%203.12|%203.13-blue)](https://www.python.org/)
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

!["web_ui"](./assets/images/web_ui.png)

Pixiv Encyclopedia Viewer Count History를 추출하는 도구

## 일본어 README

일본어 버전은 여기에서 볼 수 있습니다: [`README.ja.md`](README.ja.md).

---

## 개요

[Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/) article에서 일별 view history data를 추출합니다.

Pixiv Encyclopedia viewer history는 실제 세계의 time-series dataset으로 활용하기 좋습니다.

대개 다음과 같은 패턴을 보여 줍니다:
- 주간 seasonality (weekday vs weekend traffic)
- events 또는 social media buzz로 인한 간헐적인 spikes

추출한 CSV는 다음 용도의 sample data로 사용할 수 있습니다:
- Time-series visualization 및 smoothing
- Seasonal decomposition
- Forecasting models (ARIMA, Prophet, etc.)


> ⚠️ **비공식 tool**  
> 이 project는 Pixiv와 제휴되어 있지 않으며 Pixiv의 endorsement를 받은 것도 아닙니다.  
> 이 script를 사용할 때는 Pixiv's Terms of Use와 robots.txt를 준수해 주세요.

## 기능

- Pixiv Encyclopedia에서 **article title** (e.g., `"ブルーアーカイブ"`)로 직접 fetch
- 또는 **local HTML file**에서 읽기
- stdout으로 **JSON Lines** output  
  (한 줄에 하나의 `{"date": "...","count": ...}`)
- `--csv output.csv`를 통한 선택적 **CSV export**

---

## 요구 사항

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## 사용법

### 0. virtual environment 만들기

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. article title로 fetch

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

이 작업은 다음을 수행합니다:

- `https://dic.pixiv.net/a/ブルーアーカイブ` 다운로드
- embedded JSON parse
- stdout에 한 줄당 하나의 JSON object print:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

file로 redirect할 수 있습니다:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. CSV로 export

stdout에 JSON을 계속 print하면서 CSV file을 작성하려면 `--csv` option을 사용합니다:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" --csv ブルーアーカイブ.csv
```

CSV content 예시:

```csv
date,count
2025-07-01,9454605
2025-07-02,9331510
2025-07-03,8884117
...
```

### 3. local HTML file 사용

article HTML을 이미 저장해 둔 경우:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Script는 `ブルーアーカイブ.html`이 file임을 감지하고 web에서 fetch하지 않고 이를 parse합니다.

---

### 4. Test

```bash
pip install -r requirements.test.txt
pytest
```

### 5. environment deactivate

```bash
deactivate
```

---

## Notes / Limitations

- rate limiting은 구현되어 있지 않습니다. 다음 사항을 지켜 주세요:
  - 책임감 있게 사용하기
  - 짧은 시간 안에 많은 requests를 보내지 않기
- 이 도구는 주로 personal analysis 또는 research를 위한 간단한 utility script입니다.

---

## License
- Apache License 2.0
