# 日常记录

## 隐藏滚动条

```scss
.rows {
    &::-webkit-scrollbar {
        width: 0 !important; //chrome 和Safari
    }
    -ms-overflow-style: none; //IE 10+
    overflow: -moz-scrollbars-none; //Firefox
}
```