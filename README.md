# 矿洞安全监控系统

一个基于 Electron + Rust 的矿洞安全监控应用程序，集成了中国移动 OneNet IoT 平台，支持桌面端和网页端访问。

---

## 功能特性

- **实时监控**：温度、湿度、甲烷浓度、心率、血氧等数据实时显示
- **设备控制**：远程控制 LED 灯、蜂鸣器等设备
- **阈值报警**：自定义报警阈值，异常自动提醒
- **历史记录**：数据历史查询与导出
- **多设备管理**：支持添加和管理多个监测设备
- **动态渲染**：基于物模型自动生成 UI，无需硬编码
- **双端支持**：桌面端 (Electron) 和网页端 (浏览器) 统一访问

---

## 技术栈

| 层级 | 技术 |
|------|------|
| 前端 | Electron + 原生 JavaScript |
| 后端 | Rust + Actix-web |
| 数据库 | SQLite (rusqlite) |
| IoT 平台 | 中国移动 OneNet |

---

## 快速开始

### 环境要求

- Node.js >= 16.x
- Rust >= 1.70
- Cargo >= 1.70

### 安装依赖

```bash
# 前端依赖
cd frontend
npm install

# 后端依赖（首次编译时自动安装）
cd ../backend
cargo build
```

### 启动应用

**Windows 一键启动**：
```bash
.\start-all.bat
```

**分别启动**：
```bash
# 终端1：启动后端
.\start-backend.bat

# 终端2：启动前端
.\start-frontend.bat
```

### 访问方式

| 端 | 访问方式 |
|---|---|
| 桌面端 (Electron) | 运行 `start-frontend.bat` 或 `npm run frontend` |
| 网页端 (浏览器) | 访问 `http://127.0.0.1:8080/web/` |
| API 服务 | `http://127.0.0.1:8080/api/` |

---

## 项目结构

```
mine-monitor/
├── backend/                 # Rust 后端服务
│   ├── src/
│   │   ├── main.rs         # 程序入口
│   │   ├── handlers.rs     # API 处理器
│   │   ├── onenet.rs       # OneNet 客户端
│   │   ├── config.rs       # 配置管理
│   │   └── database.rs     # 数据库操作
│   ├── target/debug/data/
│   │   └── app.db          # SQLite 数据库（自动创建）
│   ├── .env                # 环境变量配置
│   └── Cargo.toml
│
├── frontend/               # Electron 前端
│   ├── src/
│   │   ├── main/          # 主进程
│   │   │   ├── main.js     # 主进程入口
│   │   │   └── preload.js  # 预加载脚本
│   │   ├── pages/         # 页面组件
│   │   │   ├── dashboard.js  # 仪表盘页面
│   │   │   ├── devices.js    # 设备管理页面
│   │   │   ├── history.js    # 历史数据页面
│   │   │   ├── thresholds.js # 阈值设置页面
│   │   │   ├── settings.js   # 设置页面
│   │   │   └── about.js      # 关于页面
│   │   ├── core/          # 核心模块
│   │   │   ├── i18n.js       # 国际化
│   │   │   └── router.js     # 路由
│   │   ├── locales/       # 国际化文件
│   │   │   ├── zh.js         # 中文
│   │   │   └── en.js         # 英文
│   │   ├── app.js         # 应用主类
│   │   ├── renderer.js    # 渲染进程入口
│   │   └── web-api.js     # 网页端 API 封装
│   ├── assets/
│   │   ├── styles/        # 样式文件
│   │   │   └── main.css      # 主样式文件
│   │   └── icons/         # 图标文件
│   │       ├── logo.svg      # 应用 Logo
│   │       ├── temp.png      # 温度图标
│   │       ├── hum.png       # 湿度图标
│   │       ├── gas.png       # 甲烷图标
│   │       ├── led.png       # LED 图标
│   │       ├── alarm.png     # 蜂鸣器图标
│   │       ├── heartrate.png # 心率图标
│   │       ├── spo2.png      # 血氧图标
│   │       ├── distance.png  # 距离图标
│   │       ├── rssi.png      # 信号强度图标
│   │       ├── zone.png      # 区域图标
│   │       └── alarmstatus.png # 报警状态图标
│   ├── scripts/           # 脚本文件
│   │   ├── install.bat     # 安装脚本
│   │   └── start.bat       # 启动脚本
│   ├── index.html         # 主 HTML 文件
│   └── package.json
│
├── docs/                   # 文档
│   ├── installation.md    # 安装指南
│   ├── desktop-style.md   # 桌面风格说明
│   ├── onenet-setup.md    # OneNet 配置
│   ├── dynamic-rendering-api.md # API 接口文档
│   └── 功能更新文档_2026-03-26.md # 功能更新记录
│
├── README.md              # 项目说明
├── package.json           # 项目配置
├── start-all.bat          # 一键启动
├── start-backend.bat      # 启动后端
└── start-frontend.bat     # 启动前端
```

---

## 核心功能

### 1. 动态渲染

系统基于 OneNet 物模型自动生成 UI：

```
物模型定义 → 自动生成属性卡片 → 实时数据更新
```

无需硬编码属性，添加新属性后自动显示。

### 2. 设备控制

- 开关控制：LED 灯、蜂鸣器
- 状态验证：设置后自动验证 OneNet 返回值
- 失败回滚：设置失败自动恢复原状态

### 3. 报警系统

- 阈值配置：温度、湿度、甲烷等
- 多级报警：正常、警告、危险
- 视觉提示：卡片闪烁、状态徽章
- 数据持久化：阈值存储在 SQLite 数据库

### 4. 双端支持

- **桌面端**：Electron 应用，完整功能体验
- **网页端**：浏览器直接访问，无需安装

---

## API 接口

### 本地 API

| 接口 | 方法 | 说明 |
|------|------|------|
| `/api/health` | GET | 健康检查 |
| `/api/device/list` | GET | 获取设备列表 |
| `/api/device/add` | POST | 添加设备 |
| `/api/device/update` | POST | 更新设备 |
| `/api/device/remove` | POST | 移除设备 |
| `/api/device/thingmodel` | GET | 获取物模型 |
| `/api/device/property` | GET/POST | 获取/设置属性 |
| `/api/device/detail` | GET | 获取设备详情 |
| `/api/history` | GET | 获取历史记录 |
| `/api/history/export` | GET | 导出历史记录 |
| `/api/config/threshold` | GET | 获取完整阈值配置 |
| `/api/config/threshold/current` | GET | 获取当前阈值 |
| `/api/config/threshold/current` | POST | 保存当前阈值 |
| `/api/config/threshold/save-default` | POST | 保存为默认阈值 |
| `/api/config/threshold/reset` | POST | 恢复默认阈值 |

### OneNet API

| 接口 | 说明 |
|------|------|
| `/thingmodel/query-thing-model` | 查询物模型 |
| `/thingmodel/query-device-property` | 查询设备属性 |
| `/thingmodel/set-device-property` | 设置设备属性 |
| `/device/detail` | 查询设备详情 |

---

## 数据存储

### SQLite 数据库

系统使用 SQLite 数据库存储配置数据：

| 数据 | 存储位置 |
|------|---------|
| 阈值配置 | `data/app.db` (thresholds 表) |
| 设备配置 | `data/app.db` (devices 表) |
| 历史记录 | `data/app.db` (history 表) |

数据库文件位置：
- 开发模式：`backend/target/debug/data/app.db`
- 生产模式：可执行文件同级目录 `data/app.db`

---

## 配置说明

### 添加设备

1. 在 OneNet 平台创建产品和设备
2. 定义物模型属性
3. 生成鉴权 Token
4. 在应用中添加设备

详见 [OneNet 配置指南](./docs/onenet-setup.md)

### 自定义图标

将图标文件放入 `frontend/assets/icons/` 目录：

| 文件名 | 用途 |
|--------|------|
| logo.svg | 应用 Logo |
| temp.png | 温度图标 |
| hum.png | 湿度图标 |
| gas.png | 甲烷图标 |
| led.png | LED 图标 |
| alarm.png | 蜂鸣器图标 |

---

## 文档

- [安装与启动指南](./docs/installation.md)
- [桌面风格说明](./docs/desktop-style.md)
- [OneNet 配置指南](./docs/onenet-setup.md)
- [API 接口文档](./docs/dynamic-rendering-api.md)
- [功能更新记录](./docs/功能更新文档_2026-03-26.md)

---

## 开发

### 调试模式

```bash
# 启动后端
cd backend && cargo run

# 启动前端（带 DevTools）
cd frontend && npx electron . --remote-debugging-port=9222

# 网页端调试
# 浏览器访问 http://127.0.0.1:8080/web/
```

### 构建发布

```bash
# 构建后端
cd backend
cargo build --release

# 构建前端
cd frontend
npm run build
```

---

## 许可证

MIT License
