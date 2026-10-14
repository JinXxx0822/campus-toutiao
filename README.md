# 校园头条 (Campus Toutiao)

基于 SSM (Spring + SpringMVC + MyBatis) 框架开发的校园内容分享平台，参考黑马头条项目结构，面向高校学生提供资讯发布、学习交流、社团活动等功能。

## 技术栈

- **后端框架**：Spring 5.3.x + SpringMVC + MyBatis 3.5.x
- **数据库**：MySQL 8.0
- **连接池**：C3P0
- **前端**：JSP + Bootstrap 5
- **构建工具**：Maven
- **JDK版本**：11+

## 功能模块

### 用户模块
- 用户注册（用户名、密码、昵称、学校、学院）
- 用户登录（Session会话管理）
- 个人中心（查看个人信息、文章统计）

### 文章模块
- 文章列表（按频道分类、关键词搜索、分页展示）
- 文章详情（浏览量统计、作者信息、频道信息）
- 发布文章（选择频道、填写标题和内容）
- 我的文章（查看个人发布的所有文章）

### 互动模块
- 文章点赞 / 取消点赞
- 发表评论
- 评论列表展示

### 频道模块
- 校园资讯、学习交流、社团活动、失物招领、校园八卦、二手市场

## 项目结构

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
    │   │   │   ├── applicationContext.xml
    │   │   │   └── springmvc.xml
    │   │   ├── mybatis/
    │   │   │   └── sqlMapConfig.xml # MyBatis配置
    │   │   ├── mapper/              # MyBatis Mapper XML
    │   │   └── properties/
    │   │       └── db.properties    # 数据库配置
    │   └── webapp/
    │       ├── WEB-INF/
    │       │   └── web.xml          # Web应用配置
    │       ├── static/              # 静态资源
    │       └── jsp/                 # JSP页面
    └── test/                        # 测试代码
```

## 快速开始

### 1. 环境准备
- JDK 11 或以上
- Maven 3.6+
- MySQL 8.0
- Tomcat 9.x

### 2. 数据库配置
```sql
# 执行建表脚本
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
- 用IDEA打开项目，配置Maven
- 配置Tomcat服务器，部署war包
- 启动Tomcat，访问 http://localhost:8080/campus-toutiao

## 默认测试账号

| 用户名 | 密码 | 昵称 |
|--------|------|------|
| admin | 123456 | 校园小编 |
| zhangsan | 123456 | 张三同学 |
| lisi | 123456 | 李四学姐 |

## 开发说明

本项目参考《Java EE企业级应用开发教程（Spring+Spring MVC+MyBatis）》第14章黑马头条案例，将场景改为校园环境，适合作为JavaEE课程设计作业。

---

**作者**：校园头条项目组  
**日期**：2026年10月
