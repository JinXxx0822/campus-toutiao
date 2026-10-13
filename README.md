<h1 align="center">📱 校园头条 Campus Toutiao</h1>

<p align="center">
  基于 SSM 框架的校园内容分享平台
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Spring-5.3.x-green.svg" alt="Spring">
  <img src="https://img.shields.io/badge/SpringMVC-5.3.x-brightgreen.svg" alt="SpringMVC">
  <img src="https://img.shields.io/badge/MyBatis-3.5.x-orange.svg" alt="MyBatis">
  <img src="https://img.shields.io/badge/MySQL-8.0-blue.svg" alt="MySQL">
  <img src="https://img.shields.io/badge/Bootstrap-5-purple.svg" alt="Bootstrap">
  <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="License">
</p>

---

## 📖 项目简介

**校园头条**是一个面向高校学生的内容分享平台，参考黑马头条项目结构，将场景改为校园环境。你可以在这里发布校园资讯、学习交流、社团活动、失物招领等内容，与同学们分享校园生活的点点滴滴。

## ✨ 功能特性

### 👤 用户模块
- 用户注册（用户名、密码、昵称、学校、学院）
- 用户登录（Session 会话管理）
- 个人中心（查看个人信息、文章/关注/粉丝统计）

### 📰 文章模块
- 文章列表（按频道分类、关键词搜索、分页展示）
- 文章详情（浏览量统计、作者信息、频道信息）
- 发布文章（选择频道、填写标题和内容）
- 我的文章（查看个人发布的所有文章）

### 💬 互动模块
- 文章点赞 / 取消点赞
- 发表评论、评论列表展示

### 📂 频道分类
| 频道 | 说明 |
|------|------|
| 校园资讯 | 学校官方通知、新闻动态 |
| 学习交流 | 学习方法、考试经验、资料分享 |
| 社团活动 | 社团招新、活动预告 |
| 失物招领 | 丢失物品寻找、失物认领 |
| 校园八卦 | 校园趣事、闲聊灌水 |
| 二手市场 | 二手物品交易、转让 |

## 🛠 技术栈

| 层级 | 技术 | 版本 |
|------|------|------|
| 后端框架 | Spring + SpringMVC | 5.3.x |
| ORM框架 | MyBatis | 3.5.x |
| 数据库 | MySQL | 8.0 |
| 连接池 | C3P0 | 0.9.5.x |
| 前端 | JSP + Bootstrap | 5.x |
| 构建工具 | Maven | 3.6+ |
| JDK版本 | Java | 11+ |

## 📁 项目结构

```
campus-toutiao/
├── pom.xml                          # Maven依赖配置
├── sql/
│   └── campus_toutiao.sql           # 数据库建表脚本
└── src/
    ├── main/
    │   ├── java/com/campus/toutiao/
    │   │   ├── common/              # 通用类（Result统一返回）
    │   │   ├── entity/              # 实体类
    │   │   ├── dao/                 # MyBatis Mapper接口
    │   │   ├── service/             # Service接口
    │   │   │   └── impl/            # Service实现类
    │   │   └── controller/          # Controller控制器
    │   ├── resources/
    │   │   ├── spring/              # Spring配置文件
    │   │   ├── mybatis/             # MyBatis配置
    │   │   ├── mapper/             # MyBatis Mapper XML
    │   │   └── properties/         # 数据库配置
    │   └── webapp/
    │       ├── WEB-INF/web.xml      # Web应用配置
    │       └── jsp/                 # JSP页面
    └── test/                        # 测试代码
```

## 🚀 快速开始

### 1. 环境准备
- JDK 11 或以上
- Maven 3.6+
- MySQL 8.0
- Tomcat 9.x

### 2. 创建数据库
```sql
source sql/campus_toutiao.sql;
```

### 3. 修改数据库配置
修改 `src/main/resources/properties/db.properties`：
```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/campus_toutiao?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai
jdbc.username=root
jdbc.password=你的数据库密码
```

### 4. 部署运行
1. 用 IDEA 打开项目，等待 Maven 下载依赖
2. 配置 Tomcat 服务器，部署 war 包
3. 启动 Tomcat，访问 http://localhost:8080/campus-toutiao

## 🔑 默认测试账号

| 用户名 | 密码 | 昵称 |
|--------|------|------|
| ljw | 123456 | ljw |
| zhangsan | 123456 | 张三同学 |
| lisi | 123456 | 李四学姐 |

## 📝 开发说明

本项目参考《Java EE企业级应用开发教程（Spring+Spring MVC+MyBatis）》第14章黑马头条案例，将场景改为校园环境，适合作为 JavaEE 课程设计作业。

---

<p align="center">
  <sub>Built with ❤️ by <a href="https://github.com/JinXxx0822">JinXxx0822</a></sub>
</p>
