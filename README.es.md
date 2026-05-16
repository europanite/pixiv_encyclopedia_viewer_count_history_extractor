---
layout: page
title: "🇪🇸 Español"
permalink: /es/
lang: es
---

# [Pixiv Encyclopedia Viewer History Extractor](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor "Pixiv Encyclopedia Viewer History Extractor")

[![Python](https://img.shields.io/badge/python-3.9|%203.10%20|%203.11|%203.12|%203.13-blue)](https://www.python.org/)
![OS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20Windows-blue)

[![CodeQL Advanced](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/codeql.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/codeql.yml)
[![Python Lint](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/lint.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/lint.yml)
[![Pytest](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/pytest.yml/badge.svg)](https://github.com/europanite/pixiv_encyclopedia_viewer_count_history_extractor/actions/workflows/pytest.yml)

!["web_ui"](./assets/images/web_ui.png)

Una herramienta de extracción para Pixiv Encyclopedia Viewer Count History

## README en japonés

La versión en japonés está aquí: [`README.ja.md`](README.ja.md).

---

## Descripción general

Extrae datos diarios del historial de visualizaciones de un artículo de [Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/).

El historial de visualizaciones de Pixiv Encyclopedia es un buen dataset de series temporales del mundo real.

A menudo muestra:
- Estacionalidad semanal (weekday vs weekend traffic)
- Spikes ocasionales causados por events o social media buzz

Puedes usar el CSV extraído como sample data para:
- Time-series visualization y smoothing
- Seasonal decomposition
- Forecasting models (ARIMA, Prophet, etc.)


> ⚠️ **Tool no oficial**  
> Este project no está afiliado a Pixiv ni cuenta con su endorsement.  
> Sigue Pixiv's Terms of Use y robots.txt al usar este script.

## Características

- Fetch directamente desde Pixiv Encyclopedia por **article title** (e.g., `"ブルーアーカイブ"`)
- O lectura desde un **local HTML file**
- Output de **JSON Lines** a stdout  
  (un `{"date": "...","count": ...}` por línea)
- **CSV export** opcional mediante `--csv output.csv`

---

## Requisitos

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Uso

### 0. Crear virtual environment

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Fetch por article title

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

Esto hará lo siguiente:

- Descargar `https://dic.pixiv.net/a/ブルーアーカイブ`
- Parsear el embedded JSON
- Print de un JSON object por línea en stdout:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

Puedes redirigirlo a un file:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. Export as CSV

Usa la option `--csv` para escribir un CSV file mientras sigues imprimiendo JSON en stdout:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" --csv ブルーアーカイブ.csv
```

Ejemplo de CSV content:

```csv
date,count
2025-07-01,9454605
2025-07-02,9331510
2025-07-03,8884117
...
```

### 3. Usar un local HTML file

Si ya has guardado el article HTML:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

El script detectará que `ブルーアーカイブ.html` es un file y lo parseará en lugar de hacer fetch desde la web.

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

- No hay rate limiting implementado; por favor:
  - Úsalo de forma responsable
  - Evita enviar muchas requests en poco tiempo
- Este es un utility script sencillo, pensado principalmente para personal analysis o research.

---

## License
- Apache License 2.0
