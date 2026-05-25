---
layout: page
title: "🇯🇵 日本語"
permalink: /ja/
lang: ja
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

> このREADMEは翻訳版である。英語版が正本である。

!["web_ui"](./assets/images/web_ui.png)

Pixiv Encyclopedia Viewer Count History の抽出ツール

---

## 概要

[Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/) の記事から、日次の閲覧履歴データを抽出する。

Pixiv Encyclopedia の閲覧履歴は、実世界の時系列データセットとして扱いやすい。

多くの場合、次のような特徴が見られる:
- 週次の季節性（平日と週末のアクセス差）
- イベントやSNSでの話題化による一時的なスパイク

抽出したCSVは、次のようなサンプルデータとして利用できる:
- 時系列の可視化と平滑化
- 季節分解
- 予測モデル（ARIMA、Prophetなど）


> ⚠️ **非公式ツール**  
> このプロジェクトはPixivと提携しておらず、Pixivによる承認も受けていない。  
> このscriptを使用する際は、Pixiv's Terms of Use と robots.txt に従うこと。

## Features

- Pixiv Encyclopedia から **article title**（e.g., `"ブルーアーカイブ"`）で直接取得
- または **local HTML file** から読み込み
- stdout に **JSON Lines** を出力  
  （1行につき1つの `{"date": "...","count": ...}`）
- `--csv output.csv` による optional **CSV export**

---

## Requirements

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## Usage

### 0. Virtual environment を作成する

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. Article title で取得する

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

これは次の処理を行う:

- `https://dic.pixiv.net/a/ブルーアーカイブ` を download する
- embedded JSON を parse する
- stdout に1行ずつ JSON object を print する:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

file に redirect することもできる:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. CSVとして export する

stdout に JSON を print しながら CSV file を書き出すには、`--csv` option を使用する:

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

### 3. Local HTML file を使う

article HTML をすでに保存している場合:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Script は `ブルーアーカイブ.html` が file であることを detect し、web から fetch する代わりにそれを parse する。


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

### 5. Environment を deactivate する

```bash
deactivate
```

---

## Notes / Limitations

- Rate limiting は実装されていない。以下を守ること:
  - 責任を持って使用する
  - 短時間に多数の requests を送信しない
- これは simple utility script であり、主に personal analysis または research を目的としている。

---

## License
- Apache License 2.0