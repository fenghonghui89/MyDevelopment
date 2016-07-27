
# 快捷键

- cmd+r:显示目录树
- alt+shift+s:显示当前可用的snip
- cmd+shift+p:打开包选择器
- cmd+\:打开左侧目录树

# 常用插件

- markdown-preview-opener 自动打开预览
- markdown-scroll-sync 预览自动滚动
- Markdown TOC 方便给文章插入目录树
- Markdown-Writer 方便写作，例如快速插入图片
- Pretty JSON 格式化json内容
- docblockr 方便写注释
- block-comment 注释语句


# snippet技巧

- 以下snip为gfm用，多个snip的起始水平位置要对齐，否则不生效
- alt+shift+s:显示当前可用的snip

```
'.source.gfm':


  'Unordered List':
    'prefix': 'ul'
    'body': """
- $1
- $2
- $3
    """

  'Ordered List':
    'prefix': 'ol'
    'body': """
1. $1
2. $2
3. $3
    """

    '五个空行':
      'prefix': 'br'
      'body': """
&ensp;
&ensp;
&ensp;
&ensp;
&ensp;
      """

  'example1':
    'prefix': 'myex1'
    'body': """
Hello, My name is ${1:name},<br\>
I am ${2:age}
    """

  'example2':
    'prefix': 'myex2'
    'body': """
  Hello, My name is ${1:name},\n
  I am ${2:age}
      """
```
