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

> Ce README est une version traduite. La version anglaise est la source officielle.

!["web_ui"](./assets/images/web_ui.png)

Un outil d'extraction pour Pixiv Encyclopedia Viewer Count History

---

## Vue d'ensemble

Extrait les données quotidiennes d'historique des vues depuis un article de [Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/).

L'historique des vues de Pixiv Encyclopedia est un bon dataset de séries temporelles du monde réel.

Il montre souvent:
- Une saisonnalité hebdomadaire (trafic des jours de semaine vs week-end)
- Des pics occasionnels causés par des événements ou par le buzz sur les réseaux sociaux

Vous pouvez utiliser le CSV extrait comme données d'exemple pour:
- Visualisation et lissage de séries temporelles
- Décomposition saisonnière
- Modèles de prévision (ARIMA, Prophet, etc.)


> ⚠️ **Outil non officiel**  
> Ce project n'est pas affilié à Pixiv et n'est pas endorsed par Pixiv.  
> Veuillez respecter Pixiv's Terms of Use et robots.txt lorsque vous utilisez ce script.

## Features

- Récupération par **article title** (e.g., `"ブルーアーカイブ"`) directement depuis Pixiv Encyclopedia
- Ou lecture depuis un **local HTML file**
- Sortie **JSON Lines** vers stdout  
  (un `{"date": "...","count": ...}` par ligne)
- **CSV export** optionnel via `--csv output.csv`

---

## Requirements

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Usage

### 0. Créer un virtual environment

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Récupérer par article title

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

Cela va:

- Télécharger `https://dic.pixiv.net/a/ブルーアーカイブ`
- Parser le embedded JSON
- Imprimer un JSON object par ligne vers stdout:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

Vous pouvez le rediriger vers un file:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. Exporter en CSV

Utilisez l'option `--csv` pour écrire un CSV file tout en continuant à imprimer JSON vers stdout:

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

### 3. Utiliser un local HTML file

Si vous avez déjà enregistré l'article HTML:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Le script détectera que `ブルーアーカイブ.html` est un file et le parsera au lieu de le récupérer depuis le web.


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

### 5. Désactiver environment

```bash
deactivate
```

---

## Notes / Limitations

- Aucun rate limiting n'est implémenté; veuillez:
  - L'utiliser de manière responsable
  - Éviter d'envoyer de nombreuses requests en peu de temps
- Il s'agit d'un simple utility script, principalement destiné à personal analysis ou research.

---

## License
- Apache License 2.0