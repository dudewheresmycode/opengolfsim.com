---
title: Course Building
nav_order: 2
has_children: true
published: false
---

Some additional notes for myself on building courses using OPCD tools. I figured I would document my current notes and adjustments to the process here, in case others found it useful.

## Terrain Data Sourcing

I made a fun tool called [Course Terrain Tool](https://ctt.opengolfsim.com/) to automate the process of finding and using LAZ files.

## Inkscape Setup

1. Open an inner sat overlay
1. Select **Link** for **Image Import Type**
1. Go to **File > Document Properties**
1. Change from `px` to `mm`
1. Change size to terrain size (from `MinMax` file) in `mm`
1. Resize satellite layers to terrain size (in `mm`)
