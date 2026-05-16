---
layout: page
title: "🇫🇷 Français"
permalink: /fr/
lang: fr
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

Un outil d'extraction pour Pixiv Encyclopedia Viewer Count History

## README en japonais

La version japonaise est disponible ici : [`README.ja.md`](README.ja.md).

---

## Vue d'ensemble

Extrayez les données quotidiennes d'historique des vues d'un article de [Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/).

L'historique des vues de Pixiv Encyclopedia est un bon dataset de séries temporelles réelles.

Il montre souvent:
- Une seasonality hebdomadaire (weekday vs weekend traffic)
- Des spikes occasionnels causés par des events ou du social media buzz

Vous pouvez utiliser le CSV extrait comme sample data pour:
- Time-series visualization et smoothing
- Seasonal decomposition
- Forecasting models (ARIMA, Prophet, etc.)


> ⚠️ **Tool non officiel**  
> Ce project n'est pas affilié à Pixiv et n'est pas endorsed par Pixiv.  
> Veuillez respecter Pixiv's Terms of Use et robots.txt lorsque vous utilisez ce script.

## Fonctionnalités

- Fetch directement depuis Pixiv Encyclopedia par **article title** (e.g., `"ブルーアーカイブ"`)
- Ou lecture depuis un **local HTML file**
- Output de **JSON Lines** vers stdout  
  (un `{"date": "...","count": ...}` par ligne)
- **CSV export** optionnel via `--csv output.csv`

---

## Prérequis

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Utilisation

### 0. Créer un virtual environment

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Fetch par article title

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

Cela va:

- Télécharger `https://dic.pixiv.net/a/ブルーアーカイブ`
- Parser le embedded JSON
- Print un JSON object par ligne vers stdout:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

Vous pouvez le redirect vers un file:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. Export as CSV

Utilisez l'option `--csv` pour écrire un CSV file tout en continuant à imprimer le JSON vers stdout:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" --csv ブルーアーカイブ.csv
```

Exemple de CSV content:

```csv
date,count
2025-07-01,9454605
2025-07-02,9331510
2025-07-03,8884117
...
```

### 3. Utiliser un local HTML file

Si vous avez déjà enregistré le article HTML:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Le script détectera que `ブルーアーカイブ.html` est un file et le parsera au lieu de le fetch depuis le web.

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

- Aucun rate limiting n'est implémenté; veuillez:
  - L'utiliser de manière responsable
  - Éviter d'envoyer de nombreuses requests en peu de temps
- Il s'agit d'un utility script simple, principalement destiné à personal analysis ou research.

---

## License
- Apache License 2.0
