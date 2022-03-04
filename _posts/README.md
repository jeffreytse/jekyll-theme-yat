# Published Journals

## Introduction

This is directory for published journal articles.

## How to add a new publication

Add a file named `YYYY-MM-DD-<topic>.md`. Year, month, and date should match the
article's date published in an issue. If either date or month is not provided by
the journal, simply set it to `01`.

The file content should be as followings:

```yaml
---
title: "<Title>"
authors: <Authors>
journal: <Journal>
categories:
  - <category 1>
  - <category 2>
  - ...
tags:
  - <tag 1>
  - <tag 2>
  - ...
redirect_to: <article doi>
---
```
