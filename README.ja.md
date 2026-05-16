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

!["web_ui"](./assets/images/web_ui.png)

Pixiv百科事典の閲覧数履歴を抽出するツール

## 日本語版 README

日本語版はこちら [`README.ja.md`](README.ja.md).

---

## 概要

[Pixiv Encyclopedia (pixiv百科事典)](https://dic.pixiv.net/) の記事から、日ごとの閲覧履歴データを抽出します。

Pixiv百科事典の閲覧履歴は、実世界の時系列データセットとして扱いやすい素材です。

多くの場合、次のような特徴が見られます:
- 週次の季節性（平日と週末のトラフィック差）
- イベントやSNSでの話題化による一時的なスパイク

抽出したCSVは、次のような用途のサンプルデータとして利用できます:
- 時系列の可視化と smoothing
- 季節分解
- 予測モデル（ARIMA, Prophet, etc.）


> ⚠️ **非公式ツール**  
> このプロジェクトはPixivと提携しておらず、Pixivによる承認も受けていません。  
> このスクリプトを使用する際は、Pixiv's Terms of Use と robots.txt に従ってください。

## 機能

- Pixiv百科事典から **article title**（e.g., `"ブルーアーカイブ"`）を指定して直接 fetch
- または **local HTML file** から読み込み
- stdout に **JSON Lines** を出力  
  （1行につき1つの `{"date": "...","count": ...}`）
- `--csv output.csv` による任意の **CSV export**

---

## 要件

- Python 3.9+
- Dependencies:
  - `requests`
  - `beautifulsoup4`

---

## 使い方

### 0. virtual environment を作成する

```bash
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
```

### 1. article title で fetch する

```bash
python src/extract_viewer_history.py "ブルーアーカイブ"
```

これは次の処理を行います:

- `https://dic.pixiv.net/a/ブルーアーカイブ` をダウンロード
- embedded JSON を parse
- stdout に1行ずつJSON objectを print:

```json
{"date": "2025-07-01", "count": 9454605}
{"date": "2025-07-02", "count": 9331510}
{"date": "2025-07-03", "count": 8884117}
...
```

file に redirect することもできます:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" > ブルーアーカイブ.jsonl
```

### 2. CSVとして export する

stdout にJSONを出力しつつCSV fileも書き出すには、`--csv` option を使用します:

```bash
python src/extract_viewer_history.py "ブルーアーカイブ" --csv ブルーアーカイブ.csv
```

CSV content の例:

```csv
date,count
2025-07-01,9454605
2025-07-02,9331510
2025-07-03,8884117
...
```

### 3. local HTML file を使う

article HTML をすでに保存している場合:

```bash
python src/extract_viewer_history.py ブルーアーカイブ.html
python src/extract_viewer_history.py ブルーアーカイブ.html --csv ブルーアーカイブ.csv
```

Script は `ブルーアーカイブ.html` が file であることを検出し、webからfetchせずにそれをparseします。

---

### 4. Test

```bash
pip install -r requirements.test.txt
pytest
```

### 5. environment を deactivate する

```bash
deactivate
```

---

## Notes / Limitations

- rate limiting は実装されていません。以下に注意してください:
  - 責任を持って使用する
  - 短時間に大量の requests を送信しない
- これは主に personal analysis または research を目的とした、シンプルな utility script です。

---

## License
- Apache License 2.0
