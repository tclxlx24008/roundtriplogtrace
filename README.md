# 往返辅助排查系统

## 简介

往返辅助排查系统是一个用于辅助排查往返航班问题的日志查询工具。该系统可以根据不同的ID类型（traceid、临时单号、订单号、tag）快速定位相关日志，帮助开发人员提高排查效率。

## 技术栈

- **前端框架**: Vue 3 (CDN)
- **UI组件库**: Element Plus (CDN)
- **CSS框架**: Bootstrap 5 (CDN)
- **HTTP客户端**: Axios (CDN)

## 功能特性

### 1. 日志查询

支持四种ID类型的日志查询：

#### 1.1 根据traceid查询日志
- 自动查询多个应用站的日志：
  - flight.netcore.searchflights.wechatcore (网关站)
  - flight.searchflights.roundtripengine (产品站)
  - flight.node.flightbffv2
  - flight.netcore.compass
- 按站点分组展示日志
- 按时间倒序排列
- 支持根据URL参数自动查询

#### 1.2 根据临时单号查询日志
- 查询flight.netcore.compass的日志
- 自动提取ApmTraceId
- 提供跳转到traceid查询的链接

#### 1.3 根据订单号查询日志
- 查询flight.netcore.compass的日志
- 自动提取临时单号
- 提供跳转到临时单号查询的链接

#### 1.4 根据tag查询日志
- 自动查询tag的生成时间
- 在生成时间前后10分钟内查询日志
- 自动提取ApmTraceId
- 提供跳转到traceid查询的链接

### 2. 日志展示

- 按应用站分组展示
- 按日志类别分组展示
- 支持JSON格式化展示
- 支持日志时间排序
- 支持提取关键信息并提供跳转链接

### 3. URL参数支持

系统支持通过URL参数直接发起查询：

- `?traceid=xxx` - 根据traceid查询
- `?tempSerialNo=xxx` - 根据临时单号查询
- `?orderNo=xxx` - 根据订单号查询
- `?tag=xxx` - 根据tag查询

## 使用方法

### 方法一：直接打开（可能存在CORS问题）

直接用浏览器打开 `index.html` 文件。

**注意**: 由于浏览器的同源策略限制，直接打开可能会遇到CORS（跨域）问题。如果遇到此问题，请使用方法二。

### 方法二：使用本地Web服务器（推荐）

#### 使用Python启动Web服务器

```bash
# Python 3.x
python -m http.server 8080

# 然后在浏览器中访问
# http://localhost:8080
```

#### 使用Node.js启动Web服务器

```bash
# 安装http-server
npm install -g http-server

# 启动服务器
http-server -p 8080

# 然后在浏览器中访问
# http://localhost:8080
```

#### 使用PHP启动Web服务器

```bash
php -S localhost:8080

# 然后在浏览器中访问
# http://localhost:8080
```

### 使用步骤

1. 打开系统首页
2. 选择ID类型（traceid、临时单号、订单号、tag）
3. 输入对应的ID值
4. 选择日志时间范围（默认是当前时间到前30分钟）
5. 点击"查询"按钮
6. 查看查询结果

### URL直接查询

在URL中传入参数可以直接发起查询，例如：

```
http://localhost:8080/?traceid=your-traceid-here
http://localhost:8080/?tempSerialNo=your-temp-serial-no-here
http://localhost:8080/?orderNo=your-order-no-here
http://localhost:8080/?tag=your-tag-here
```

## 接口说明

### 天网日志查询接口

- **URL**: `http://skynetapi.dss.17usoft.com/log/real/list`
- **方法**: POST
- **功能**: 查询天网日志

### Tag生成时间查询接口

- **URL**: `http://skynetapi.dss.17usoft.com/log/real/list`
- **方法**: POST
- **功能**: 查询tag的生成时间

## 注意事项

1. **CORS问题**: 由于系统需要调用天网日志查询接口，可能会遇到跨域问题。建议使用本地Web服务器运行系统。

2. **Token配置**: 系统中已经配置了各个应用的token，如果这些token过期，需要在 `index.html` 中的 `appConfig` 对象中更新。

3. **时间范围**: 查询traceid时，建议选择合适的时间范围，避免查询时间过长导致查询缓慢。

4. **浏览器兼容性**: 系统使用了Vue 3和Element Plus，建议使用现代浏览器（Chrome、Firefox、Edge等）访问。

## 后续优化方向

1. **解决CORS问题**: 可以添加后端代理服务器来解决跨域问题
2. **增加更多查询条件**: 如日志级别、IP等
3. **日志详情展示**: 点击日志可以查看更详细的信息
4. **历史查询记录**: 保存查询历史，方便重复查询
5. **导出功能**: 将查询结果导出为文件
6. **打包为跨平台应用**: 使用Electron、Cordova等框架打包为Android、iOS、Windows应用

## 项目结构

```
code/
├── index.html          # 主页面（包含完整的HTML、CSS和JavaScript）
├── README.md          # 项目说明文档
└── server.py          # (可选) Python启动脚本
```

## 常见问题

### Q: 为什么查询没有结果？

A: 请检查：
1. ID值是否正确
2. 时间范围是否合适
3. 网络连接是否正常
4. Token是否过期

### Q: 为什么会遇到CORS错误？

A: 由于浏览器的安全限制，直接打开HTML文件可能无法调用跨域API。请使用本地Web服务器运行系统。

### Q: 如何更新Token？

A: 在 `index.html` 文件中找到 `appConfig` 对象，更新对应应用的token值。

## 联系方式

如有问题或建议，请联系开发团队。
