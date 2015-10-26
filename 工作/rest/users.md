Tpages SNS REST 用户服务接口
===============================================================================



个人信息接口: `/profile`
-------------------------------------------------------------------------------

#### 提取自己的个人信息
```
GET /profile
```

###### 前置条件
用户已经登录

###### 接收参数
无

###### 数据库
- `users`、及`user_profiles`表；

###### 结果缓存
- 直接缓存至`config('cache.user_cache_dir')`所指目录下的静态文件，文件名为`{id}/profile.json`。在提取时，使用`x-sendfile`直接返回该文件内容。

###### 返回
`HTTP 200`
```json
{
  "id": 1,
  "name": "昵称",
  "created_at": "帐号创建时间",
  "updated_at": "最近更新帐号信息的时间",
  "username": "用户名",
  "mobile": "手机号码",
  "email": "邮箱地址",
  "country": "相应语言中的国家名称"
  "province": "相应语言中的省份名称"
  "city": "相应语言中的城市名称"
  "birthdate": "1978-01-01 00:00:00",  // 生日
  "gender": "相应语言中的性别"
  "avatar": "头像URL"
}
```


###### 修改自己的个人信息
```
POST /profile
```

####### 前置条件
用户已经登录

####### 接收参数
以下除用户ID外，其它信息只有改动过的才需要提交。
`Content-Type: application/json`
```json
{
  "id": 1,                             // 用户ID
  "name": "昵称",
  "email": "邮箱地址",
  "mobile": "手机号码",
  "country": 1,                        // 国家ID
  "province": 1,                       // 省份ID
  "city": 1,                           // 城市ID
  "birthdate": "1978-01-01 00:00:00",  // 生日
  "gender": 1                          // 性别
}
```

###### 数据库
- `users`、及`user_profiles`表；

###### 结果缓存
- 禁用缓存，同时删除`config('cache.user_cache_dir')`所指目录下的相应缓存文件。
- 若修改昵称，则要同时将相应的symlink名称ntgh

####### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "message": "提示信息"
}
```



个人头像接口: `/avatar`
-------------------------------------------------------------------------------

用户头像存放于`config('app.avatar_dir')`所指目录下的子目录中，每个用户都有其相应的目录`{id}/`。同时，在头像根目录下以用户昵称创建symlink至向其目录。

#### 提取自己的头像
```
GET /avatar
```

###### 前置条件
用户已经登录

###### 接收参数
无

###### 数据库
无

###### 结果缓存
- 直接缓存至`config('cache.user_cache_dir')`所指目录下的静态文件，文件名为`{id}/avatars.json`。在提取时，使用`x-sendfile`直接返回该文件内容。

###### 返回
- 如果成功，则返回：`HTTP 200`
```json
{
  "big": "大头像URL",
  "medium": "中头像URL",
  "small": "小头像URL",
  "banner": "个人横幅URL",
}
```


#### 修改自己的头像
```
PUT /avatar/{头像标识}
```

###### 前置条件
用户已经登录

###### 接收参数
- `{头像标识}`可以是："big"、"medium"、"small"、"banner"。
- 图像数据是：
  `Content-Type: application/octet-stream`
  二进制数据流

###### 返回
- 如果成功，则返回：`HTTP 200`



#### 提取指定用户的头像
```
GET /avatar/{user}
```

###### 前置条件
无

###### 接收参数
- `{user}`：用户ID或昵称；

###### 数据库
无

###### 结果缓存
- 直接缓存至`config('cache.user_cache_dir')`所指目录下的静态文件，文件名为`{id}/avatars.json`。在提取时，使用`x-sendfile`直接返回该文件内容。

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "big": "大头像URL",
  "medium": "中头像URL",
  "small": "小头像URL",
  "banner": "个人横幅URL",
}
```


个人统计信息接口: `/stats`
-------------------------------------------------------------------------------


#### 提取自己的个人统计信息
```
GET /stats
```

###### 前置条件
用户已经登录

###### 接收参数
无

###### 数据库
- `users`、及`user_stats`表；

###### 结果缓存
- 直接缓存至`config('cache.user_cache_dir')`所指目录下的静态文件，文件名为`{id}/stats.json`。在提取时，使用`x-sendfile`直接返回该文件内容。

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "num_friends": 123,
  "num_follows": 123,
  "num_followed": 123,
  "num_places": 123,
  "num_posts": 123,
  "num_comments": 123,
  "num_commented": 123,
  "num_shares": 123,
  "num_shared": 123,
  "num_likes": 123,
  "num_liked": 123
}
```



个人设置接口: `/settings`
-------------------------------------------------------------------------------


#### 提取自己的个人设置
```
GET /settings
```

###### 前置条件
用户已经登录

###### 接收参数
无

###### 数据库
- `users`、及`user_settings`表；

###### 结果缓存
- 直接缓存至`config('cache.user_cache_dir')`所指目录下的静态文件，文件名为`{id}/settings.json`。在提取时，使用`x-sendfile`直接返回该文件内容。

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "notify": true
}
```


#### 修改自己的个人设置
```
POST /settings
```

###### 前置条件
用户已经登录

###### 接收参数
`Content-Type: application/json`
```json
{
  "notify": true
}
```

###### 数据库
- `users`、及`user_settings`表；

###### 结果缓存
禁用缓存，同时删除`config('cache.user_cache_dir')`所指目录下的相应缓存文件。

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "message": "提示信息"
}
```



个人内容接口: `/my`
-------------------------------------------------------------------------------


###### 我发的内容
```
GET /my/{提取类别}
```
暂时只做`posts`

####### 前置条件
用户已经登录

####### 接收参数
- `{提取类别}`: "places"、"posts"、"comments"
- `since`: 整数，从什么时候之后的内容；
- `before`: 整数，从什么时候之前的内容；
- `per_page`: 整数，返回几条记录，默认为`5`；
- 如果`since`及`before`都传了，则使用`since`；
- 如果`since`及`before`都没传，则加载最新的`per_page`条；

###### 数据库
- `users`、`places`、`comments`、`posts`表，及相关子表；

###### 结果缓存
每个用户独占一个缓存，该缓存使用`cache_ttl.private`。该缓存键值为：`get_my_{u:user_id}_{提取类别}_{s:since|b:before}_{per_page}`；

####### 返回
如果成功，则返回：`HTTP 200`
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
    "pictures": "图片1URL"
  },
  {
    // 相应类别信息2
  },
  {
    // ...........
  }
]
```



用户接口: `/user`
-------------------------------------------------------------------------------

#### 提取指定用户的个人信息
```
GET /user/{昵称}/profile
```

###### 前置条件
用户已经登录

###### 接收参数
无

###### 数据库
- `users`、及`user_profiles`表；

###### 结果缓存
- 直接缓存至`config('cache.user_cache_dir')`所指目录下的静态文件，文件名为`{id}/profile{_suffix}.json`。在提取时，使用`x-sendfile`直接返回该文件内容。
- 视当前用户与指定用户的社交关系，`{suffix}`可为：
  - 公开：`_public`
  - 朋友：`_friend`

###### 返回
如果成功，则返回：`HTTP 200`。
```json
{
  "id": 1,
  "name": "昵称",
  "created_at": "帐号创建时间",
  "updated_at": "最近更新帐号信息的时间",
  "username": "用户名",
  "mobile": "手机号码",
  "email": "邮箱地址",
  "country": "相应语言中的国家名称"
  "province": "相应语言中的省份名称"
  "city": "相应语言中的城市名称"
  "birthdate": "1978-01-01 00:00:00",  // 生日
  "gender": "相应语言中的性别"
  "avatar": "头像URL"
}
```

视当前用户与指定用户的社交关系，返回的内容详略会有不同：
- 朋友：返回朋友可见字段
- 其它：返回公开字段
- 拉黑：返回昵称

#### 提取指定用户的个人统计信息
```
GET /user/{昵称}/stats
```

###### 前置条件
用户已经登录

###### 接收参数
无

###### 数据库
- `users`、及`user_stats`表；

###### 结果缓存
- 直接缓存至`config('cache.user_cache_dir')`所指目录下的静态文件，文件名为`{id}/stats{_suffix}.json`。在提取时，使用`x-sendfile`直接返回该文件内容。
- 视当前用户与指定用户的社交关系，`{suffix}`可为：
  - 公开：`_public`
  - 朋友：`_friend`

###### 返回
如果成功，则返回：`HTTP 200`。
```json
{
  "num_friends": 123,
  "num_follows": 123,
  "num_followed": 123,
  "num_places": 123,
  "num_posts": 123,
  "num_comments": 123,
  "num_commented": 123,
  "num_shares": 123,
  "num_shared": 123,
  "num_likes": 123,
  "num_liked": 123
}
```


#### 提取指定用户发过的内容
```
GET /user/{昵称}/contents/{提取类别}
```
暂时只做`posts`

####### 前置条件
用户已经登录

####### 接收参数
- `{提取类别}`: "places"、"posts"、"comments"
- `since`: 整数，从什么时候之后的内容；
- `before`: 整数，从什么时候之前的内容；
- `per_page`: 整数，返回几条记录，默认为`5`；
- 如果`since`及`before`都传了，则使用`since`；
- 如果`since`及`before`都没传，则加载最新的`per_page`条；

###### 数据库
- `users`、`places`、`comments`、`posts`表，及相关子表；

###### 结果缓存
每个用户独占一个缓存，该缓存使用`cache_ttl.private`。该缓存键值为：`get_my_{u:user_id}_{提取类别}_{s:since|b:before}_{per_page}`；
- 视当前用户与指定用户的社交关系，`{suffix}`可为：
  - 公开：`_public`
  - 朋友：`_friend`

###### 返回
如果成功，则返回：`HTTP 200`。
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
    "pictures": "图片1URL"
  },
  {
    // 相应类别信息2
  },
  {
    // ...........
  }
]
```

视当前用户与指定用户的社交关系，返回的内容详略会有不同：
- 朋友：返回朋友可见内容
- 其它：返回公开内容
- 拉黑：空


#### 对指定用户进行操作
```
PUT /user/{昵称}
```

###### 前置条件
- 用户已经登录
- 用户有足够权限
- 双方之间的社交关系能满足相应的前提条件

###### 接收参数
`Content-Type: application/json`
```json
{
  "action": "要执行的操作",
  "content": "请求内容"
}
```

- `action`：要进行的操作。"befriend"、"follow"、"unfollow"、"block"、"ban"
- `action`可直接用`config('tpages.user_actions')`提取，无需查表；
- 除`ban`需要检测权限外，其它操作允许所有已登录用户执行。
- `ban`只能由管理员执行。

###### 数据库
- `users`、`user_relations`、及`user_requests`表；
- 若`action`为`befriend`，则在`user_requests`表中创建相应记录：
  - `from`为当前用户ID；
  - `to`为对方用户ID；
  - `action`为加朋友的动作ID；
  - `content`为请求内容；
- 若`action`为`block`，则在`user_relations`表中创建相应记录：
  - `user1`为当前用户ID；
  - `user2`为对方用户ID；
  - `status`为拉黑的ID；
- 若`action`为`follow`或`unfollow`，则在`user_relations`表中创建或删除相应记录：
  - `user1`为当前用户ID；
  - `user2`为对方用户ID；
  - `status`为关注的ID；
- 若`action`为`ban`，则修改`users`表中的相应记录，将`username`、`name`、`email`、及`mobile`字段加入`banned_`前缀。

###### 结果缓存
禁用缓存

###### 返回
如果成功，则返回：`HTTP 200`
```json
{
  "message": "提示信息"
}
```
