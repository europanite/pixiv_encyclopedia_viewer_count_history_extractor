---
layout: page
title: "🇩🇪 Deutsch"
permalink: /de/
lang: de
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

> Diese README ist eine übersetzte Version. Die englische Version ist die maßgebliche Quelle.

!["web_ui"](./assets/images/web_ui.png)

Ein Extraktionswerkzeug für Pixiv Encyclopedia Viewer Count History

---

## Überblick

Extrahiert tägliche Verlaufdaten der Aufrufzahlen aus einem Artikel der [Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/).

Die Pixiv Encyclopedia viewer history ist ein nützliches reales time-series dataset.

Sie zeigt häufig:
- Wöchentliche seasonality (weekday vs weekend traffic)
- Gelegentliche spikes durch events oder social media buzz

Du kannst die extrahierte CSV als sample data verwenden für:
- Time-series visualization und smoothing
- Seasonal decomposition
- Forecasting models (ARIMA, Prophet, etc.)


> ⚠️ **Unofficial tool**  
> Dieses project ist nicht mit Pixiv verbunden und wird nicht von Pixiv endorsed.  
> Bitte beachte Pixiv's Terms of Use und robots.txt, wenn du dieses script verwendest.

## Features

- Abruf per **article title** (e.g., `"ブルーアーカイブ"`) direkt aus der Pixiv Encyclopedia
- Oder Lesen aus einer **local HTML file**
- Ausgabe von **JSON Lines** auf stdout  
  (eine Zeile pro `{"date": "...","count": ...}`)
- Optionaler **CSV export** über `--csv output.csv`

---

## Requirements

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Usage

### 0. Virtual environment erstellen

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Per article title abrufen

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

Dies wird:

- `https://dic.pixiv.net/a/ブルーアーカイブ` herunterladen
- Das embedded JSON parsen
- Ein JSON object pro Zeile auf stdout ausgeben:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

Du kannst die Ausgabe in eine file umleiten:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. Als CSV exportieren

Verwende die option `--csv`, um eine CSV file zu schreiben, während JSON weiterhin auf stdout ausgegeben wird:

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

### 3. Eine local HTML file verwenden

Wenn du den article HTML bereits gespeichert hast:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Das script erkennt, dass `ブルーアーカイブ.html` eine file ist, und parst sie, statt sie aus dem Web abzurufen.


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

### 5. Environment deaktivieren

```bash
deactivate
```

---

## Notes / Limitations

- Rate limiting ist nicht implementiert; bitte:
  - Verantwortungsbewusst verwenden
  - Nicht viele requests in kurzer Zeit senden
- Dies ist ein simple utility script, hauptsächlich für personal analysis oder research gedacht.

---

## License
- Apache License 2.0