Tpages SNS REST 社交服务接口
===============================================================================


朋友接口: `/friends`
-------------------------------------------------------------------------------

#### 朋友列表
```
GET /friends
```

###### 前置条件
用户已经登录

###### 接收参数
- `since`: 整数，从什么时候之后的朋友；
- `before`: 整数，从什么时候之前的朋友；
- `per_page`: 整数，返回几条记录，默认为`5`；
- 如果`since`及`before`都传了，则使用`since`；
- 如果`since`及`before`都没传，则加载最新的`per_page`条；

###### 数据库
- `users`及`user_relations`表；
- `user1`为当前用户；
- `status`为`2`；
- 按`created_at`倒排。

###### 结果缓存
- 每个用户独占一个缓存，缓存有效期为`config('cache.ttl_private')`。该缓存键值为：`get_friends_{u:user_id}_{s:since|b:before}_{per_page}`；

###### 返回
如果成功，则返回：`HTTP 200`
```json
[
  {
    "id": 1,              // 整数，对方用户ID
    "name": "对方用户昵称"
  },
  {
    // 用户信息
  }
]
```



社交请求接口: `/requests`
-------------------------------------------------------------------------------


#### 社交请求列表
```
GET /requests
```

###### 前置条件
用户已经登录

###### 接收参数
固定返回最新的`5`条

###### 数据库
- `users`及`user_requests`表；
- `from`为当前用户的记录放入发送列表；
- `to`为当前用户的记录放入接收列表；
- 收发各放`5`条；
- 按`sent_at`倒排。

###### 结果缓存
- 每个用户独占一个缓存，缓存有效期为`config('cache.ttl_private')`。该缓存键值为：`get_requests_{u:user_id}；

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "sent": {
    [
      {
        "user": 1,            // 整数，对方用户ID
        "name": "对方用户昵称",
        "action": "相应语言下的请求描述",
        "content": "请求的内容"
      },
      {
        // 社交请求详情
      }
    ]
  },
  "recieved": {
    [
      {
        "user": 1,            // 整数，对方用户ID
        "name": "对方用户昵称",
        "action": "相应语言下的请求描述",
        "content": "请求的内容"
      },
      {
        // 社交请求详情
      }
    ]
  },
}
```


#### 已收发的请求列表
```
GET /requests/{请求类型}
```

###### 前置条件
用户已经登录

###### 接收参数
- `{请求类型}`: `sent`、`received`
- `since`: 整数，从什么时候之后的请求；
- `before`: 整数，从什么时候之前的请求；
- `per_page`: 整数，返回几条记录，默认为`5`；
- 如果`since`及`before`都传了，则使用`since`；
- 如果`since`及`before`都没传，则加载最新的`per_page`条；

###### 数据库
- `users`及`user_requests`表；
- 如`{请求类型}`参数为`sent`，则`from`为当前用户的记录；
- 如`{请求类型}`参数为`received`，则`to`为当前用户的记录；
- 按`sent_at`倒排。

###### 结果缓存
- 每个用户独占一个缓存，缓存有效期为`config('cache.ttl_private')`。
- 该缓存键值为：`get_requests_{请求类型}_{u:user_id}_{s:since|b:before}_{per_page}`；

###### 返回
如果成功，则返回：`HTTP 200`
```json
[
  {
    "user": 1,            // 整数，对方用户ID
    "name": "对方用户昵称",
    "action": "相应语言下的请求描述",
    "content": "请求的内容"
  },
  {
    // 用户信息
  }
]
```


#### 对指定请求进行操作
```
PUT /requests/{user}
```

该接口会产生消息推送（拉黑除外）。

###### 前置条件
- 用户已经登录
- 所指定记录已经存在
- 如操作为`revoke`，则该请求必须由当前用户发出。

###### 接收参数
- `{user}`为对方用户ID或昵称
- `Content-Type: application/json`
    ```json
    {
      "user": 1,            // 整数，对方用户ID
      "action": "要进行的操作",
    }
    ```
- `要进行的操作`："revoke"、"accept"、"reject"、"block"

###### 数据库
- `users`、`user_requests`及`user_relations`表；
- 对于不同的操作，要执行的处理会有所不同：
  - `revoke`：
    1. 该请求必须由当前用户发出,
    2. `from`字段为当前用户，
    3. `to`字段为`{user}`所指用户，
    4. `action`字段为`action`参数所指动作，
    5. 在`user_requests`表中找到相应记录，
    6. 删除该记录；
  - `reject`：
    1. `to`字段为当前用户，
    2. `from`字段为`{user}`所指用户，
    3. `action`字段为`action`参数所指动作，
    4. 在`user_requests`表中找到相应记录，
    5. 删除该记录；
  - `accept`：
    1. `to`字段为当前用户，
    2. `from`字段为`{user}`所指用户，
    3. `action`字段为`action`参数所指动作，
    4. 在`user_requests`表中找到相应记录，
    5. 在`user_relations`表中创建两条记录：
      - 第一条记录：`user1`为当前用户，`user2`为`{user}`所指用户，`status`为相应的社交关系ID（如朋友则为`2`）；
      - 第二条记录：`user2`为当前用户，`user1`为`{user}`所指用户，`status`为相应的社交关系ID（如朋友则为`2`）；
    6. 删除`user_requests`表中找到的记录；
  - `block`：
    1. `to`字段为当前用户，
    2. `from`字段为`{user}`所指用户，
    3. `action`字段为`action`参数所指动作，
    4. 在`user_requests`表中找到相应记录，
    5. 在`user_relations`表中创建一条记录：
      - `user1`为当前用户，`user2`为`{user}`所指用户，`status`为拉黑的社交关系ID；
    6. 删除`user_requests`表中找到的记录；
    7. 该操作不产生消息推送。

###### 结果缓存
禁用缓存

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "message": "提示信息",
}
```



消息接口: `/messages`
-------------------------------------------------------------------------------

消息接口暂时保留不做。

#### 所有消息列表
```
GET /messages
```

###### 前置条件
用户已经登录

###### 接收参数
- `before`: 整数，从哪条消息之前的消息，默认为最新消息；
- `per_page`: 整数，返回几条记录，默认为`5`；

###### 返回
`HTTP 200`
```json
[
  {
    "id": 1,
    "type": "消息类别",
    "title": "标题",
    "content": "内容"
  },
  {
    // 消息信息
  }
]
```


#### 指定类型消息列表
```
GET /messages/{消息类型或ID}
```

###### 前置条件
用户已经登录

###### 接收参数
- `{消息类型}`: "unread"、或整数，如为整数则表示消息ID；
- `before`: 整数，从哪张帖子之前的消息，默认为最新消息；
- `per_page`: 整数，返回几条记录，默认为`5`；

###### 返回
`HTTP 200`
```json
[
  {
    "id": 1,
    "type": "消息类别",
    "title": "标题",
    "content": "内容"
  },
  {
    // 消息信息
  }
]
```



帖子接口: `/posts`
-------------------------------------------------------------------------------

#### 最近更新帖子列表
```
GET /posts
```

如果用户尚未登录，则只返回公开的帖子。
如果用户已登录，则返回：
- 所有公开的帖子；
- 朋友的帖子中，可以被朋友看到的帖子；
- 排除被拉黑用户发的帖子。

###### 前置条件
无

###### 接收参数
- `since`: 整数，从哪张帖子之后的帖子；
- `before`: 整数，从哪张帖子之前的帖子；
- `per_page`: 整数，返回几条记录，默认为`5`；
- 如果`since`及`before`都传了，则使用`since`；
- 如果`since`及`before`都没传，则自动使用个人`最后访问记录`自动生成`since`；
- 如果`since`及`before`都没传，而且没有`最后访问记录`，则加载最新的`per_page`条；
- `site`：整数，可选，帖子所在站点ID，默认为当前站点；
- `host`：整数，可选，帖子所属主体ID；
- `type`：整数，可选，帖子所属类型ID；
- `user`：整数，可选，发帖人用户ID；

###### 数据库
- `users`、`posts`、`post_type_info`、及`emote_contents`表；
- `post_type_info`及`emote_contents`的数据可直接用`config('tpages.post_types')`及`config('tpages.emotes')`提取，无需查表；

###### 结果缓存
- 所有未登录用户都使用同一个缓存列表，缓存有效期为`config('cache.ttl_public')`。该公开列表使用同一套参数。该缓存键值为：`get_posts_public_{s:since|b:before}_{per_page}_{type}_{host}_{user}_{site}`；
- 对于已登录用户，则每个用户独占一个缓存，缓存有效期为`config('cache.ttl_private')`。该缓存键值为：`get_posts_{u:user_id}_{s:since|b:before}_{per_page}_{type}_{host}_{user}_{site}`；

###### 返回
`HTTP 200`
```json
[
  {
    "id": 1,                          // 整数，帖子ID
    "site": 1,                        // 整数，帖子所在站点ID，默认为当前站点
    "host": 1,                        // 整数，所属主体ID，可没有
    "type": "在相应语言中的帖子类别名称",
    "user": "发帖人昵称",
    "emote": "在相应语言中的帖子心情",    // 可没有
    "url": "帖子的URL",
    "title": "标题",
    "num_likes": 123,                 // 整数，点赞总数
    "num_shares": 123,                // 整数，分享总数
    "num_comments": 123,              // 整数，评论总数
    "pictures": [
      "图片1URL",
      "图片2URL",
      "图片3URL",
      "......."
    ]
  },
  {
    // 帖子内容
  }
]
```


#### 帖子详情
```
GET /posts/{帖子}
```

###### 前置条件
- 帖子是公开的；
- 或者帖子是由朋友发的，并且是可以被朋友看到的；

###### 接收参数
- `{帖子}`：帖子ID或标题slug；
- `site`：整数，帖子所在站点ID，默认为当前站点；

###### 数据库
- `users`、`posts`、`post_type_info`、及`emote_contents`表；
- `post_type_info`及`emote_contents`的数据可直接用`config('tpages.post_types')`及`config('tpages.emotes')`提取，无需查表；

###### 结果缓存
- 所有用户都使用同一个缓存列表，缓存有效期为`config('cache.ttl_public')`。该公开列表使用同一套参数。该缓存键值为：`get_posts_{post_id}_{site_id}`；

###### 返回
`HTTP 200`
```json
{
  "id": 1,                          // 整数，帖子ID
  "site": 1,                        // 整数，帖子所在站点ID，默认为当前站点
  "host": 1,                        // 整数，所属主体ID，可没有
  "type": "在相应语言中的帖子类别名称",
  "user": "发帖人昵称",
  "emote": "在相应语言中的帖子心情",   // 可没有
  "url": "帖子的URL",
  "title": "标题",
  "content": "帖子内容",
  "num_likes": 123,                 // 整数，点赞总数
  "num_shares": 123,                // 整数，分享总数
  "num_comments": 123,              // 整数，评论总数
  "update_time": "2015-01-01 01:01:01"
  "pictures": [
    "图片1URL",
    "图片2URL",
    "图片3URL",
    "......."
  ]
}
```

###### 后续操作
返回数据后，将`post_stats`.`num_viewed`字段加1。



#### 提交帖子
```
POST /posts
```
帖子相应的图片，必须在该接口成功返回后，另行使用`POST /posts/{帖子}/images`接口逐一上传。

###### 前置条件
- 用户已经登录；
- 只能提交至当前站点；
- 只能发至当前站点；

###### 接收参数
`Content-Type: application/json`
```json
{
  "host": 1,                        // 整数，所属主体ID，可没有
  "type": 1,                        // 整数，所属类型ID，可没有，默认为`通用`
  "emote": 1,                       // 整数，帖子的心情ID，可没有
  "scope": 1,                       // 整数，公开度标识
  "title": "标题",
  "content": "文字描述",
  "coord": "用户所在位置坐标",        // 逗号分隔的经纬度浮点坐标字符串，先经度后纬度。
}
```

###### 数据库
- `users`、`posts`、`post_type_info`、及`emote_contents`表；
- `post_type_info`及`emote_contents`的数据可直接用`config('tpages.post_types')`及`config('tpages.emotes')`提取，无需查表；

###### 结果缓存
禁用缓存

###### 返回
`HTTP 200`
```json
{
  "id": 1,                          // 整数，帖子ID
  "site": 1,                        // 整数，当前站点ID
  "host": 1,                        // 整数，所属主体ID，可没有
  "type": "在相应语言中的帖子类别名称",
  "emote": 1,                       // 整数，帖子的心情，可没有
  "url": "帖子的URL",
  "title": "标题",
  "content": "帖子内容"
}
```
`config('app.post_dir')`目录为`帖子存放根目录`。在该目录下为每个帖子建立一个目录，目录名使用其ID。该目录用户存放帖子相关图片及缓存文件（如有）。同时，在`帖子存放根目录`中，以帖子的`slug`生成一个symlink，指向其对应目录。


#### 对指定帖子进行操作
```
PUT /posts/{帖子}
```

###### 前置条件
- 用户已经登录
- 帖子由当前用户发出，或当前用户有足够权限
- `{帖子}`所指记录已经存在
- `site`字段不得修改
- `user`字段不得修改

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- 操作内容：
    `Content-Type: application/json`
    ```json
    {
      "action": "要执行的操作",
      "host": 1,                         // 整数，所属主体ID，可没有，只对`edit`有用
      "type": 1,                         // 整数，类型ID，可没有，只对`edit`有用
      "emote": "在相应语言中的帖子心情",    // 整数，心情ID，可没有，只对`edit`有用
      "scope": 1,                       // 整数，公开度标识，可没有，只对`edit`有用
      "title": "标题",                   // 对`like`没用，可没有
      "content": "操作内容"              // 对`like`没用，可没有
    }
    ```
- `action`可为："edit"、"share"、"like"、"report"、"ban"；
- 除`edit`及`ban`需要检测权限外，其它操作允许所有已登录用户执行。
- `edit`必须是自己的帖子，或是管理员。
- `ban`只能由管理员执行。

###### 数据库
- `users`、`posts`、`post_type_info`、及`emote_contents`表；
- `post_type_info`及`emote_contents`的数据可直接用`config('tpages.post_types')`及`config('tpages.emotes')`提取，无需查表；

###### 结果缓存
禁用缓存

###### 返回
如果成功，则返回：`HTTP 200`。对于`edit`以外的操作，只返回`message`。
`Content-Type: application/json`
```json
{
  "message": "操作结果提示信息",
  "id": 1,                          // 整数，帖子ID
  "site": 1,                        // 整数，帖子所在站点ID
  "host": 1,                        // 整数，所属主体ID，可没有
  "type": "在相应语言中的帖子类别名称",
  "user": "发帖人昵称",
  "emote": "在相应语言中的帖子心情",   // 可没有
  "url": "帖子的URL",
  "title": "标题",
  "content": "帖子内容",
  "num_likes": 123,                 // 整数，点赞总数
  "num_shares": 123,                // 整数，分享总数
  "num_comments": 123,              // 整数，评论总数
  "pictures": [
    "图片1URL",
    "图片2URL",
    "图片3URL",
    "......."
  ]
}
```

###### 后续操作
- 返回数据后，根据执行的操作，将`post_stats`表中的相应字段字段加1：
  - `like`：`num_likes`；
  - `share`：`num_shares`；
- 如操作为`ban`，则将`posts`、`post_details`、`post_images`、`post_stats`中的相应记录提取出来，并串化后写入`action_log`表；并且将原表记录删除。


#### 删除帖子
```
DELETE /posts/{帖子}
```

将`posts`、`post_details`、`post_images`、`post_stats`中的相应记录提取出来，并串化后写入`action_log`表；并且将原表记录删除。

###### 前置条件
- 用户已经登录
- 该帖子是由当前用户发的，或者当前用户有足够权限
- `{帖子}`所指记录已经存在

###### 接收参数
- `{帖子}`：帖子ID或标题slug

###### 数据库
- `posts`表；

###### 结果缓存
禁用缓存

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "message": "提示信息",
}
```


#### 上传帖子图片
```
POST /posts/{帖子}/images
```

###### 前置条件
- 用户已经登录
- `{帖子}`所指记录已经存在
- 该帖子是由当前用户发的，或者当前用户有足够权限

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- 图片数据：
    `Content-Type: application/octet-stream`
    图片数据（二进制流）

###### 数据库
- `posts`及`post_images`表；

###### 结果缓存
禁用缓存

###### 返回
如果成功，则返回：`HTTP 200`。
```json
{
  "post": 1,                        // 整数，帖子ID
  "site": 1,                        // 整数，当前站点ID
  "image": 1,                       // 整数，帖子图片序号
  "url": "图片URL"
}
```


#### 对指定帖子图片进行操作
```
PUT /posts/{帖子}/images/{图片}
```

###### 前置条件
- 用户已经登录
- 该帖子是由当前用户发的，或当前用户有足够权限
- `{帖子}`所指记录已经存在
- `{图片}`所指记录已经存在

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- `{图片}`：图片序号
- 如果请求的`Content-Type`是二进制流的话，则表示直接传图片。先判断相应的图片文件是否存在，如果不存在就abort(404)。如果存在就覆盖该文件。其它操作为"edit"。
    图片数据：
    `Content-Type: application/octet-stream`
    图片数据（二进制流）
- 如果请求的`Content-Type`是`json`，则表示要进行其它操作。
    操作内容：
    `Content-Type: application/json`
    ```json
    {
      "action": "要执行的操作",
    }
    ```
- `action`："report"、"ban"
- 除`edit`及`ban`需要检测权限外，其它操作允许所有已登录用户执行。
- `edit`必须是自己的帖子，或是管理员。
- `ban`只能由管理员执行。将图片改名，加`banned_`前缀，不删除图片。


###### 数据库
- `post_images`表；

###### 结果缓存
禁用缓存

###### 返回
如果成功，则返回：`HTTP 200`。对于`edit`以外的操作，只返回`message`。
```json
{
  "message": "操作结果提示信息",
  "post": 1,                        // 整数，帖子ID
  "site": 1,                        // 整数，当前站点ID
  "image": 1,                       // 整数，帖子图片序号
  "url": "图片URL"
}
```

###### 后续操作
- 返回数据后，根据执行的操作，将`post_stats`表中的相应字段字段加1：
  - `like`：`num_likes`；
  - `share`：`num_shares`；
- 如操作为`ban`，则将`post_images`中的相应记录提取出来，并串化后写入`action_log`表；并且将原表记录删除（如该图片为帖子的唯一一张图片，则将其原记录改为系统默认图片）。


#### 删除指定帖子图片
```
DELETE /posts/{帖子}/images/{图片}
```

将`post_images`中的相应记录提取出来，并串化后写入`action_log`表；并且将原表记录删除（如该图片为帖子的唯一一张图片，则禁止删除）。

###### 前置条件
- 用户已经登录
- 用户有足够权限
- 该帖子是由当前用户发的
- `{帖子}`所指记录已经存在
- `{图片}`所指记录已经存在

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- `{图片}`：图片ID

###### 数据库
- `post_images`表；

###### 结果缓存
禁用缓存

###### 返回
- 如该图片为帖子的唯一一张图片，则返回`HTTP 409`及`message`。
- 如果成功，则返回：`HTTP 200`。
    ```json
    {
      "message": "操作结果提示信息",
      "post": 1,
      "image": 1,
      "url": "图片URL"
    }
    ```


#### 相关评论列表
```
GET /posts/{帖子}/comments
```

####### 前置条件
- `{帖子}`所指记录已经存在
- 帖子是公开的；
- 或者帖子是由朋友发的，并且是可以被朋友看到的；
- 排除被拉黑用户发的评论。

###### 接收参数
- `since`: 整数，从哪张帖子之后的帖子；
- `before`: 整数，从哪张帖子之前的帖子；
- `per_page`: 整数，返回几条记录，默认为`5`；
- 如果`since`及`before`都传了，则使用`since`；
- 如果`since`及`before`都没传，则加载最新的`per_page`条；
- `site`：整数，可选，帖子所在站点ID，默认为当前站点；

###### 数据库
- `posts`及`comments`表；

###### 结果缓存
- 所有未登录用户都使用同一个缓存列表，缓存有效期为`config('cache.ttl_comments')`。该列表使用同一套参数。该缓存键值为：`get_comments_{post_id}_{s:since|b:before}_{per_page}_{site}`；

####### 返回
如果成功，则返回：`HTTP 200`。
```json
[
  {
    "id": 1,                          // 整数，帖子ID
    "user": "发帖人昵称",
    "emote": "在相应语言中的帖子心情",   // 可没有
    "title": "标题",
    "content": "评论描述"
  },
  {
    // 评论信息
  }
]
```


#### 评论详情
```
GET /posts/{帖子}/comments/{评论}
```
该接口暂时保留不做。

###### 前置条件
- `{帖子}`所指记录已经存在
- `{评论}`所指记录已经存在

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- `{评论}`：评论ID

###### 返回
如果成功，则返回：`HTTP 200`。
```json
{
  "id": 1,                          // 整数，评论ID
  "title": "标题",
  "content": "评论描述"
}
```


#### 提交评论
```
POST /posts/{帖子}/comments
```

###### 前置条件
- 用户已经登录
- `{帖子}`所指记录已经存在
- 帖子是公开的；
- 或者帖子是由朋友发的，并且是可以被朋友看到的；

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- 评论内容：
`Content-Type: application/json`
```json
{
  "site": 1,                        // 整数，帖子所属站点ID，默认为当前站点
  "emote": 1,                       // 整数，心情ID，可没有
  "coord": "用户所在位置坐标",        // 逗号分隔的经纬度浮点坐标字符串，先经度后纬度。
  "title": "标题",
  "content": "评论内容"
}
```

###### 数据库
- `posts`及`comments`表；

###### 结果缓存
禁用缓存

####### 返回
如果成功，则返回：`HTTP 200`。
```json
{
  "id": 1,                          // 整数，评论ID
  "emote": "在相应语言中的帖子心情",   // 可没有
  "title": "标题",
  "content": "评论内容"
}
```


###### 对指定评论进行操作
```
PUT /posts/{帖子}/comments/{评论}
```

####### 前置条件
- 用户已经登录
- 用户有足够权限
- `{帖子}`所指记录已经存在
- `{评论}`所指记录已经存在
- 帖子是公开的；
- 或者帖子是由朋友发的，并且是可以被朋友看到的；

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- `{评论}`：评论ID
- 操作内容：
`Content-Type: application/json`
```json
{
  "action": "要执行的操作",
  "emote": 1,                       // 整数，心情ID，可没有
  "title": "标题",
  "comment": "操作内容"
}
```

`action`："edit"、"report"、"ban"

###### 数据库
- `posts`及`comments`表；

###### 结果缓存
禁用缓存

###### 返回
如果成功，则返回：`HTTP 200`。除`edit`外，其它操作只返回`message`。
`Content-Type: application/json`
```json
{
  "message": "提示信息"
  "id": 1,                          // 整数，评论ID
  "emote": "在相应语言中的帖子心情",   // 可没有
  "title": "标题",
  "content": "操作内容"
}
```

###### 后续操作
- 如操作为`ban`，则将`comments`中的相应记录提取出来，并串化后写入`action_log`表；并且将原表记录删除。


###### 删除指定评论
```
DELETE /posts/{帖子}/comments/{评论}
```
将`comments`中的相应记录提取出来，并串化后写入`action_log`表；并且将原表记录删除。

####### 前置条件
- 用户已经登录
- 该评论是由当前用户发的，或当前用户有足够权限
- `{帖子}`所指记录已经存在
- `{评论}`所指记录已经存在

###### 接收参数
- `{帖子}`：帖子ID或标题slug
- `{评论}`：评论ID

###### 返回
如果成功，则返回：`HTTP 200`。
`Content-Type: application/json`
```json
{
  "message": "提示信息"
}
```



评论接口: `/comments`
-------------------------------------------------------------------------------
该接口暂时保留不做

#### 最近更新评论列表
```
GET /comments
```

####### 前置条件
无

####### 接收参数
- `page`: 整数，第几页
- `per_page`: 整数，每页返回几条记录

####### 返回
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
  "data":[
    {
      "id": 1,
      "place": 1,
      "type": "评论类别",
      "coord": "用户所在位置坐标",
      "title": "标题",
      "content": "评论描述"
    },
    {
      // 评论信息
    }
  ]
}
```


#### 评论详情
```
GET /comments/{评论}
```

###### 前置条件
- `{评论}`所指记录已经存在

###### 接收参数
`{评论}`：评论ID

###### 返回
`HTTP 200`
```json
{
  "id": 1,
  "post": 1,
  "type": "评论类别",
  "coord": "用户发评论时所在位置坐标",
  "title": "标题",
  "content": "评论描述"
}
```


#### 提交评论
```
POST /comments
```

###### 前置条件
- 用户已经登录
- 用户有足够权限

###### 接收参数
`Content-Type: application/json`
```json
{
  "post": 1,
  "type": "内容类别",
  "coord": "用户所有位置坐标",
  "title": "标题",
  "content": "评论内容"
  // ......
}
```

####### 返回
`HTTP 200`
```json
{
  "comment": 1,
  "total": 123
  "post": 1,
  "type": "内容类别",
  "coord": "用户所有位置坐标",
  "title": "标题",
  "content": "评论内容"
}
```


###### 对指定评论进行操作
```
PUT /comments/{评论}
```

####### 前置条件
- 用户已经登录
- 用户有足够权限
- `{评论}`所指记录已经存在

###### 接收参数
- `{评论}`：评论ID
- 操作内容：
`Content-Type: application/json`
```json
{
  "action": "要执行的操作",
  "title": "标题",
  "comment": "操作内容"
}
```

`action`："edit"、"share"、"like"、"report"、"block"、"ban"

###### 返回
如果成功，则返回：`HTTP 200`。
`Content-Type: application/json`
```json
{
  "post": 1,
  "total": 123,
  "action": "已执行的操作",
  "title": "标题",
  "message": "内容"
}
```


###### 删除指定评论
```
DELETE /comments/{评论}
```

####### 前置条件
- 用户已经登录
- 用户有足够权限
- 该评论是由当前用户发的
- `{评论}`所指记录已经存在

###### 接收参数
- `{评论}`：评论ID

###### 返回
如果成功，则返回：`HTTP 200`。
`Content-Type: application/json`
```json
{
  "post": 1,
  "total": 123,
  "action": "已执行的操作",
  "title": "标题",
  "message": "内容"
}
```
