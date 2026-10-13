package com.campus.toutiao.common;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 密码加密工具类（课程项目演示）。
 * 采用 SHA-256 + 用户名作为盐进行哈希，避免数据库明文存储密码。
 * 注意：生产环境建议使用 BCrypt / Argon2 等专业密码哈希方案。
 */
public class PasswordUtil {

    private PasswordUtil() {
        // 工具类不实例化
    }

    /**
     * 计算加盐 SHA-256 哈希：SHA-256(salt + password)，返回 64 位十六进制字符串。
     *
     * @param password 原始密码
     * @param salt     盐（这里使用用户名）
     * @return 十六进制哈希串
     */
    public static String hash(String password, String salt) {
        String data = (salt == null ? "" : salt) + (password == null ? "" : password);
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(64);
            for (byte b : bytes) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 算法不可用", e);
        }
    }
}
