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

!["web_ui"](./assets/images/web_ui.png)

Ein Extraktionstool für Pixiv Encyclopedia Viewer Count History

## Japanisches README

Die japanische Version findest du hier: [`README.ja.md`](README.ja.md).

---

## Überblick

Extrahiere tägliche View-History-Daten aus einem Artikel der [Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/).

Die Pixiv Encyclopedia viewer history ist ein nützliches reales time-series dataset.

Sie zeigt häufig:
- Wöchentliche seasonality (weekday vs weekend traffic)
- Gelegentliche spikes, ausgelöst durch events oder social media buzz

Du kannst die extrahierte CSV als sample data verwenden für:
- Time-series visualization und smoothing
- Seasonal decomposition
- Forecasting models (ARIMA, Prophet, etc.)


> ⚠️ **Inoffizielles tool**  
> Dieses project ist weder mit Pixiv verbunden noch von Pixiv endorsed.  
> Bitte beachte Pixiv's Terms of Use und robots.txt, wenn du dieses script verwendest.

## Features

- Direktes Fetch aus der Pixiv Encyclopedia per **article title** (e.g., `"ブルーアーカイブ"`)
- Oder Lesen aus einer **local HTML file**
- Ausgabe von **JSON Lines** nach stdout  
  (ein `{"date": "...","count": ...}` pro Zeile)
- Optionaler **CSV export** über `--csv output.csv`

---

## Anforderungen

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Nutzung

### 0. virtual environment erstellen

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Per article title fetch

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

Dies wird:

- `https://dic.pixiv.net/a/ブルーアーカイブ` herunterladen
- Das embedded JSON parsen
- Ein JSON object pro Zeile nach stdout printen:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

Du kannst die Ausgabe in eine file redirecten:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. Export as CSV

Verwende die option `--csv`, um eine CSV file zu schreiben und gleichzeitig JSON weiterhin nach stdout zu printen:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" --csv ブルーアーカイブ.csv
```

Beispiel für CSV content:

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

Das script erkennt, dass `ブルーアーカイブ.html` eine file ist, und parst diese, anstatt sie aus dem Web zu fetchen.

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

- Es ist kein rate limiting implementiert; bitte:
  - Verwende es verantwortungsbewusst
  - Vermeide es, in kurzer Zeit viele requests zu senden
- Dies ist ein einfaches utility script, das hauptsächlich für personal analysis oder research gedacht ist.

---

## License
- Apache License 2.0
