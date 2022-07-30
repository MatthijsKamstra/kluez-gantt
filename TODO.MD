# TODO

- [x] draw a rectangle on screen
  - [x] draw from left to right
  - [ ] draw from right to left
- [x] resize a rectangle on screen (width)
- [x] move a rectangle on screen
- [x] combine drag and resize
- [x] create grid (pattern) on screen
- [x] move/drag on grid
- [x] resize on grid
- [ ] line between divs
  - [ ] svg right
  - [ ] svg curved
- [x] read mermaid files (https://mermaid-js.github.io/mermaid/#/gantt / https://mermaid-js.github.io/mermaid/#/gantt?id=syntax)
  - [x] week, days, hours convert
  - [x] convert to json
- [x] test convert
- [x] test excluding weekend (fixed for now)

## svg

- https://stackoverflow.com/questions/19382872/how-to-connect-html-divs-with-lines

```html
<div
  id="div1"
  style="width: 100px; height: 100px; top:0; left:0; background:#777; position:absolute;"
></div>
<div
  id="div2"
  style="width: 100px; height: 100px; top:300px; left:300px; background:#333; position:absolute;"
></div>

<svg width="500" height="500">
  <line x1="50" y1="50" x2="350" y2="350" stroke="black" />
</svg>
```

- https://codepen.io/berky93/pen/vKmZWG

```html
<div id="one" class="point"></div>
<div id="two" class="point"></div>
<svg id="svg">
  <line id="line" />
</svg>
```

```js
var line = $("#line");
var div1 = $("#one");
var div2 = $("#two");

var x1 = div1.offset().left + div1.width() / 2;
var y1 = div1.offset().top + div1.height() / 2;
var x2 = div2.offset().left + div2.width() / 2;
var y2 = div2.offset().top + div2.height() / 2;

line.attr("x1", x1).attr("y1", y1).attr("x2", x2).attr("y2", y2);
```

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
