# cml (C-Style Markup Language / Caramel)
codename caramel: C-style syntax markdown

checkout branch java for its current parser generator!!

`index.html preview`
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- this is a comment -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Hello   world!</h1>
</body>
</html>
```

`index.cml equivalent`
```
import cml;

cml(lang="en") {
    head {
        // this is a comment
        meta(charset="utf-8");
        meta(name="viewport", content="width=device-width, initial-scale=1.0");
        title{document}
    }
    body {
        h1{Hello world!}
    }
}
```

