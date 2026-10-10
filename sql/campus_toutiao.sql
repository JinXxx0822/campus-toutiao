-- ----------------------------
-- 校园头条数据库
-- ----------------------------
DROP DATABASE IF EXISTS campus_toutiao;
CREATE DATABASE campus_toutiao CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE campus_toutiao;

-- ----------------------------
-- 用户表
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
  `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
  `password` VARCHAR(100) NOT NULL COMMENT '密码',
  `nickname` VARCHAR(50) NOT NULL COMMENT '昵称',
  `avatar` VARCHAR(255) DEFAULT '/static/img/default_avatar.png' COMMENT '头像',
  `school` VARCHAR(100) COMMENT '学校',
  `college` VARCHAR(100) COMMENT '学院',
  `signature` VARCHAR(255) DEFAULT '这个人很懒，什么都没写~' COMMENT '个性签名',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- 频道表
-- ----------------------------
DROP TABLE IF EXISTS `channel`;
CREATE TABLE `channel` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '频道ID',
  `name` VARCHAR(50) NOT NULL COMMENT '频道名称',
  `description` VARCHAR(255) COMMENT '频道描述',
  `sort` INT DEFAULT 0 COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='频道表';

-- ----------------------------
-- 文章表
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '文章ID',
  `title` VARCHAR(200) NOT NULL COMMENT '标题',
  `content` TEXT NOT NULL COMMENT '内容',
  `cover_image` VARCHAR(255) COMMENT '封面图',
  `user_id` INT NOT NULL COMMENT '作者ID',
  `channel_id` INT NOT NULL COMMENT '频道ID',
  `view_count` INT DEFAULT 0 COMMENT '浏览量',
  `like_count` INT DEFAULT 0 COMMENT '点赞数',
  `comment_count` INT DEFAULT 0 COMMENT '评论数',
  `status` TINYINT DEFAULT 1 COMMENT '状态：1已发布 0草稿',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章表';

-- ----------------------------
-- 评论表
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '评论ID',
  `content` VARCHAR(500) NOT NULL COMMENT '评论内容',
  `user_id` INT NOT NULL COMMENT '评论用户ID',
  `article_id` INT NOT NULL COMMENT '文章ID',
  `parent_id` INT DEFAULT NULL COMMENT '父评论ID',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- ----------------------------
-- 文章点赞表
-- ----------------------------
DROP TABLE IF EXISTS `article_like`;
CREATE TABLE `article_like` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT NOT NULL COMMENT '用户ID',
  `article_id` INT NOT NULL COMMENT '文章ID',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  UNIQUE KEY uk_user_article (user_id, article_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章点赞表';

-- ----------------------------
-- 用户关注表
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
  `user_id` INT NOT NULL COMMENT '关注者ID',
  `followed_id` INT NOT NULL COMMENT '被关注者ID',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
  UNIQUE KEY uk_user_follow (user_id, followed_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

-- ----------------------------
-- 初始化数据
-- ----------------------------
INSERT INTO `channel` (`name`, `description`, `sort`) VALUES
('校园资讯', '学校官方通知、新闻动态', 1),
('学习交流', '学习方法、考试经验、资料分享', 2),
('社团活动', '社团招新、活动预告', 3),
('失物招领', '丢失物品寻找、失物认领', 4),
('校园八卦', '校园趣事、闲聊灌水', 5),
('二手市场', '二手物品交易、转让', 6);

INSERT INTO `user` (`username`, `password`, `nickname`, `school`, `college`, `signature`) VALUES
('ljw', '123456', 'ljw', 'XX大学', '计算机学院', '这个人很懒，什么都没写~'),
('zhangsan', '123456', '张三同学', 'XX大学', '计算机学院', '热爱编程的大二学生'),
('lisi', '123456', '李四学姐', 'XX大学', '外国语学院', '考研上岸学姐');

INSERT INTO `article` (`title`, `content`, `user_id`, `channel_id`, `view_count`, `like_count`, `comment_count`) VALUES
('关于2026年国庆节放假安排的通知', '根据国务院办公厅通知精神，结合学校实际情况，现将2026年国庆节放假安排通知如下：10月1日至7日放假调休，共7天。10月8日（星期一）正常上课。请各单位做好假期值班和安全保卫工作。', 1, 1, 1280, 56, 12),
('大二Java学习路线分享', '大家好，我是计算机学院大二的张三。今天给大家分享一下我的Java学习路线：1. JavaSE基础 2. MySQL数据库 3. Web前端基础 4. SSM框架 5. SpringBoot...希望对大家有帮助！', 2, 2, 890, 123, 25),
('计算机学院社团招新啦', '各位新同学好！计算机学院各大社团开始招新了：编程协会、机器人社团、动漫社、摄影社...无论你有没有基础，都欢迎来参加！报名时间：9月15日-9月20日，地点：大礼堂前广场。', 1, 3, 650, 89, 18),
('寻找丢失的校园卡', '本人于10月10日在图书馆三楼丢失一张校园卡，姓名：李四，卡号：2024001234。如有拾到者请联系我，必有重谢！联系QQ：123456789。', 3, 4, 320, 15, 6),
('食堂三楼新开了一家麻辣烫', '昨天去食堂三楼吃饭，发现新开了一家麻辣烫，味道还不错，价格也实惠，推荐大家去尝尝！', 2, 5, 560, 78, 21),
('转让二手考研资料', '上岸了，转让全套考研数学资料，张宇36讲、1000题、历年真题，几乎全新，价格私聊。', 3, 6, 210, 12, 3);

INSERT INTO `comment` (`content`, `user_id`, `article_id`) VALUES
('谢谢小编通知！', 2, 1),
('正好国庆可以出去玩了~', 3, 1),
('感谢分享，很实用！', 3, 2),
('请问SSM框架学到什么程度可以做项目？', 2, 2),
('已经报名编程协会了！', 2, 3),
('我捡到了，怎么联系你？', 2, 4),
('麻辣烫确实好吃！', 3, 5),
('资料还在吗？', 2, 6);

INSERT INTO `article_like` (`user_id`, `article_id`) VALUES
(2, 1), (3, 1), (2, 2), (3, 2), (2, 3), (3, 3),
(2, 4), (2, 5), (3, 5), (2, 6);

INSERT INTO `user_follow` (`user_id`, `followed_id`) VALUES
(2, 1), (3, 1), (2, 3);
