Tpages SNS REST 地点服务接口
===============================================================================

### 最近更新地点列表
```
GET /places
```

#### 前置条件
无

#### 接收参数
- `page`: 整数，第几页
- `per_page`: 整数，每页返回几条记录

#### 返回
`HTTP 200`
```json
{
  "total": 50,
  "per_page": 15,
  "current_page": 1,
  "last_page": 4,
  "next_page_url": "下一页的URL，可为NULL",
  "prev_page_url": "上一页的URL，可为NULL",
  "from": 1,
  "to": 15,
  "data": [
    {
      "id": 1,
      "name": "地点名称",
      "type": "地点类别在相应语言中的名称"
    }
  ]
}
```


### 地点详情
```
GET /places/{地点}
```

#### 前置条件
`{地点}`所指记录已经存在

#### 接收参数
`{地点}`：地点ID或名称slug

#### 返回
`HTTP 200`
```json
{
  "id": 1,
  "name": "地点名称",
  "type": "地点类别",
  "coord": "经纬度坐标"
  "posts": {
    // 帖子列表
  },
  "comments": {
    // 评论列表
  }
}
```



### 提交地点
```
POST /places
```

#### 前置条件
- 用户已经登录
- 用户有足够权限

#### 接收参数
`Content-Type: application/json`
```json
{
  "type": "内容类别",
  "coord": "用户所有位置坐标",
  "name": "标题",
  "description": "发表内容",
  // ......
}
```

#### 返回
`HTTP 200`
```json
{
  "place": 1,
  "type": "内容类别",
  "coord": "用户所有位置坐标",
  "name": "标题",
  "description": "发表内容",
  // ......
}
```


### 对指定地点进行操作
```
PUT /places/{地点}
```

#### 前置条件
- 用户已经登录
- 用户有足够权限
- `{地点}`所指记录已经存在

#### 接收参数
- `{地点}`：地点ID或名称slug
- 操作内容：
`Content-Type: application/json`
```json
{
  "action": "要执行的操作",
  "title": "标题",
  "comment": "分享信息"
}
```

`action`："share"、"like"、"report"、"block"、"ban"

#### 返回
如果成功，则返回：`HTTP 200`。
`Content-Type: application/json`
```json
{
  "place": 1,
  "total": 123,
  "action": "已执行的操作",
  "title": "标题",
  "message": "内容"
}
```


### 上传地点图片
```
POST /places/{地点}/images
```

#### 前置条件
- 用户已经登录
- 用户有足够权限
- `{地点}`所指记录已经存在

#### 接收参数
- `{地点}`：地点ID或名称slug
- 图片数据：
`Content-Type: application/octet-stream`
图片数据（二进制流）

#### 返回
`HTTP 200`
```json
{
  "place": 1,
  "image": 1,
  "url": "图片URL"
}
```


### 对指定地点图片进行操作
```
PUT /places/{地点}/images/{图片}
```

#### 前置条件
- 用户已经登录
- 用户有足够权限
- `{地点}`所指记录已经存在
- `{图片}`所指记录已经存在

#### 接收参数
- `{地点}`：地点ID或名称slug
- `{图片}`：图片ID

`Content-Type: application/json`
```json
{
  "action": "要执行的操作",
  "title": "标题",
  "comment": "分享信息"
}
```

`action`："share"、"like"、"report"、"block"、"ban"

#### 返回
如果成功，则返回：`HTTP 200`。
`Content-Type: application/json`
```json
{
  "place": 1,
  "total": 123,
  "action": "已执行的操作",
  "title": "标题",
  "message": "内容"
}
```
