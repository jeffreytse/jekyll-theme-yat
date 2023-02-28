# Published Journals

## Introduction

This is a directory for (published) journal articles.

## How to add a new publication

Create a file named `YYYY-MM-DD-<topic>.md` in this directory. Year, month, and
date should match the article's date published **in an issue**. If either date
or month is not provided by the journal, simply set it to `01`.

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

If a publication is accepted, but not yet published in an issue, set the date
to the date of acceptance, and add `accepted_date: true` to the front matter.
If the publication is not even published online (i.e., no DOI is available),
also add text `*Manuscript in press*` to the content instead redirecting to a
DOI. Full example:

```**yaml**
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
accepted_date: true
---
*Manuscript in press*
```

Note that the date **should be updated as soon as possible** to the date of
publication once the article is published in an issue.
