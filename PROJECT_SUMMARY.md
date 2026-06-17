# 往返辅助排查系统 - 项目总结

## 项目概述

根据需求文档 `排查收集.md`，已完成"往返辅助排查系统"的开发。该系统用于辅助排查往返航班问题，通过快速定位相关日志提高排查效率。

## 已完成功能

### 1. 日志查询功能

#### 1.1 根据traceid查询日志
- ✅ 查询以下应用站的日志：
  - flight.netcore.searchflights.wechatcore (网关站) - 入参(ServiceProxy)
  - flight.searchflights.roundtripengine (产品站) - 入参(ServiceProxy)、av数据(AvAdapter)、单程最小价入参(OnewayMinPriceAdapter)、单程最小价出参(OnewayMinPriceBook15)
  - flight.node.flightbffv2 - RoundSearchCabins
  - flight.netcore.compass - FlightSearch
- ✅ 按站点顺序展示日志
- ✅ 按时间倒序排列
- ✅ 根据大类分组展示，分组名称按需求映射
- ✅ 支持从URL参数读取traceid并自动查询

#### 1.2 根据临时单号查询日志
- ✅ 查询flight.netcore.compass的天网日志
- ✅ 大类传入FlightSearch，filter1s传入临时单号
- ✅ 从返回结果中提取ApmTraceId并展示
- ✅ 为ApmTraceId提供跳转链接，跳转到traceid查询模式
- ✅ 支持从URL参数读取临时单号并自动查询

#### 1.3 根据订单号定位日志
- ✅ 查询flight.netcore.compass的天网日志
- ✅ 大类传入OrderCreatedTopicListener
- ✅ 将订单号插入indexContext进行模糊检索
- ✅ 从返回结果中提取tempSerialNo并展示
- ✅ 为tempSerialNo提供跳转链接，跳转到临时单号查询模式

#### 1.4 根据tag定位日志
- ✅ 调用tag生成时间查询接口，获取tag的生成时间(GenerateTime)
- ✅ 调用flight.netcore.compass的日志查询接口
- ✅ 日志开始结束时间用GenerateTime前后加10分钟
- ✅ 大类传FlightSearch，将tag插入indexContext进行模糊检索
- ✅ 从返回结果中提取ApmTraceId并展示
- ✅ 为ApmTraceId提供跳转链接，跳转到traceid查询模式

### 2. 通用功能

- ✅ ID输入框：文本输入框，支持输入各种ID
- ✅ ID类型选择：下拉选择(traceid、临时单号、订单号、tag)
- ✅ 日志时间范围：日期时间范围选择器，默认区间为当前时间到前30分钟
- ✅ 查询按钮：点击开始查询
- ✅ URL参数支持：支持通过URL参数(traceid、tempSerialNo、orderNo、tag)直接发起查询
- ✅ 演示模式：提供演示数据，方便测试界面
- ✅ 导出功能：将查询结果导出为JSON文件

### 3. 界面展示

- ✅ 使用Bootstrap、Vue、Element Plus构建界面
- ✅ 自适应设计，支持跨端访问
- ✅ 按站点分组展示日志
- ✅ 按日志类别分组展示
- ✅ 支持JSON格式化展示
- ✅ 日志按时间倒序排列
- ✅ 提供跳转链接(traceid、临时单号)

## 技术实现

### 技术栈
- **前端框架**: Vue 3 (通过CDN引入)
- **UI组件库**: Element Plus (Vue 3版本的Element UI，通过CDN引入)
- **CSS框架**: Bootstrap 5 (通过CDN引入)
- **HTTP客户端**: Axios (通过CDN引入)

### 项目文件
```
d:/task/ai辅助排查往返/code/
├── index.html          # 主页面（包含完整的HTML、CSS和JavaScript）
├── README.md          # 项目说明文档
├── start.bat          # Windows启动脚本（命令提示符）
├── start.ps1          # Windows启动脚本（PowerShell）
└── PROJECT_SUMMARY.md # 项目总结文档（本文件）
```

### 核心实现

1. **API集成**
   - 天网日志查询接口：`http://skynetapi.dss.17usoft.com/log/real/list`
   - Tag生成时间查询接口：`http://skynetapi.dss.17usoft.com/log/real/list`
   - 已配置所有应用的appId和token

2. **查询逻辑**
   - 根据不同的ID类型，调用不同的查询逻辑
   - 对于traceid查询，按顺序查询4个应用站
   - 对于临时单号和订单号查询，提取关键信息并提供跳转链接
   - 对于tag查询，先获取生成时间，再在±10分钟内查询日志

3. **数据处理**
   - 日志按时间倒序排列
   - 自动识别并格式化JSON数据
   - 从日志中提取traceid和临时单号
   - 支持日志模糊检索(indexContext)

4. **用户体验**
   - 提供加载状态提示
   - 显示查询进度
   - 支持演示模式
   - 支持导出结果
   - URL参数自动识别

## 使用说明

### 启动系统

#### 方法一：使用启动脚本（推荐）
1. 双击运行 `start.bat` 或 `start.ps1`
2. 脚本会自动检测Python、Node.js或PHP并启动Web服务器
3. 在浏览器中访问 `http://localhost:8080`

#### 方法二：手动启动Web服务器
```bash
# Python
python -m http.server 8080

# Node.js (需要先安装http-server)
npm install -g http-server
http-server -p 8080

# PHP
php -S localhost:8080
```

#### 方法三：直接打开（可能存在CORS问题）
直接用浏览器打开 `index.html` 文件。注意：可能会遇到跨域问题。

### 使用步骤

1. 打开系统首页
2. 选择ID类型（traceid、临时单号、订单号、tag）
3. 输入对应的ID值
4. 选择日志时间范围（默认是当前时间到前30分钟）
5. 点击"查询"按钮
6. 查看查询结果

### URL直接查询

在URL中传入参数可以直接发起查询：
```
http://localhost:8080/?traceid=xxx
http://localhost:8080/?tempSerialNo=xxx
http://localhost:8080/?orderNo=xxx
http://localhost:8080/?tag=xxx
```

### 演示模式

点击"演示模式"按钮可以加载演示数据，方便测试界面和功能。

## 注意事项

### 1. CORS问题
由于系统需要调用天网日志查询接口，可能会遇到跨域问题。建议使用本地Web服务器运行系统。

### 2. Token配置
系统中已经配置了各个应用的token。如果这些token过期，需要在 `index.html` 中的 `appConfig` 对象中更新：
```javascript
const appConfig = {
    'flight.netcore.searchflights.wechatcore': {
        appId: '3295971',
        token: 'a9c8dd1c-a77c-40c5-a7e9-b15685361024',
        name: 'flight.netcore.searchflights.wechatcore-网关站'
    },
    // ... 其他应用配置
};
```

### 3. Tag查询接口
需求文档中tag生成时间查询接口与天网日志查询接口使用相同的URL，但请求和响应格式不同。如果实际使用中存在问题，可能需要确认接口文档的正确性。

### 4. 浏览器兼容性
系统使用了Vue 3和Element Plus，建议使用现代浏览器（Chrome、Firefox、Edge等）访问。

## 待优化功能

1. **解决CORS问题**: 可以添加后端代理服务器来解决跨域问题
2. **增加更多查询条件**: 如日志级别、IP等
3. **日志详情展示**: 点击日志可以查看更详细的信息
4. **历史查询记录**: 保存查询历史，方便重复查询
5. **结果分页**: 当日志数量很多时，支持分页加载
6. **打包为跨平台应用**: 使用Electron、Cordova等框架打包为Android、iOS、Windows应用

## 测试建议

1. **功能测试**: 使用真实的traceid、临时单号、订单号、tag进行测试
2. **界面测试**: 在不同尺寸的屏幕上测试自适应效果
3. **性能测试**: 测试查询大量日志时的性能表现
4. **异常处理测试**: 测试网络异常、接口异常等情况的处理

## 联系人

如有问题或建议，请联系开发团队。

---
**创建时间**: 2026-06-12
**版本**: v1.0
**状态**: 开发完成，待测试
