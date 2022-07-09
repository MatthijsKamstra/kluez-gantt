# TODO

- [x] draw a rectangle on screen
  - [x] draw from left to right
  - [ ] draw from right to left
- [x] resize a rectangle on screen (width)
- [x] move a rectangle on screen
- [x] combine drag and resize
- [x] create grid (pattern) on screen
- [x] move/drag on grid
- [ ] resize on grid
- [ ] line between divs
  - [ ] svg right
  - [ ] svg curved
- [x] read mermaid files (https://mermaid-js.github.io/mermaid/#/gantt / https://mermaid-js.github.io/mermaid/#/gantt?id=syntax)
  - [ ] week, days, hours convert
  - [x] convert to json

## rules gantt

- `h` = hours
- `d` = days
- `w` = weeks (work weeks?)
- `start_date` undefined, use previousStart date
-

- source: https://mermaid-js.github.io/mermaid/#/gantt

```
    dateFormat  YYYY-MM-DD
    title       Adding GANTT diagram functionality to mermaid
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)
```

date tot date
vs
date + 5 days
