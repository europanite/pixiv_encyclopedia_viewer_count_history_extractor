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

> Este README es una versión traducida. La versión en inglés es la fuente oficial.

!["web_ui"](./assets/images/web_ui.png)

Una herramienta de extracción para Pixiv Encyclopedia Viewer Count History

---

## Descripción general

Extrae datos diarios del historial de visualizaciones desde un artículo de [Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/).

El historial de visualizaciones de Pixiv Encyclopedia es un buen dataset de series temporales del mundo real.

A menudo muestra:
- Estacionalidad semanal (tráfico de días laborables frente a fines de semana)
- Picos ocasionales causados por eventos o por repercusión en redes sociales

Puedes usar el CSV extraído como datos de ejemplo para:
- Visualización y suavizado de series temporales
- Descomposición estacional
- Modelos de predicción (ARIMA, Prophet, etc.)


> ⚠️ **Herramienta no oficial**  
> Este project no está afiliado a Pixiv ni cuenta con su respaldo.  
> Respeta Pixiv's Terms of Use y robots.txt al usar este script.

## Features

- Obtén datos por **article title** (e.g., `"ブルーアーカイブ"`) directamente desde Pixiv Encyclopedia
- O lee desde un **local HTML file**
- Genera **JSON Lines** en stdout  
  (un `{"date": "...","count": ...}` por línea)
- **CSV export** opcional mediante `--csv output.csv`

---

## Requirements

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Usage

### 0. Crear virtual environment

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Obtener por article title

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

Esto hará lo siguiente:

- Descargar `https://dic.pixiv.net/a/ブルーアーカイブ`
- Parsear el embedded JSON
- Imprimir un JSON object por línea en stdout:

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

### 2. Exportar como CSV

Usa la option `--csv` para escribir un CSV file mientras sigues imprimiendo JSON en stdout:

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

### 3. Usar un local HTML file

Si ya guardaste el article HTML:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

El script detectará que `ブルーアーカイブ.html` es un file y lo parseará en lugar de obtenerlo desde la web.


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

### 5. Desactivar environment

```bash
deactivate
```

---

## Notes / Limitations

- No se ha implementado rate limiting; por favor:
  - Úsalo de forma responsable
  - Evita enviar muchas requests en poco tiempo
- Este es un simple utility script, pensado principalmente para personal analysis o research.

---

## License
- Apache License 2.0