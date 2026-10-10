package com.campus.toutiao.entity;

import java.util.Date;

/**
 * 用户实体类
 */
public class User {
    private Integer id;
    private String username;
    private String password;
    private String nickname;
    private String avatar;
    private String school;
    private String college;
    private String signature;
    private Date createTime;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    public String getSchool() { return school; }
    public void setSchool(String school) { this.school = school; }
    public String getCollege() { return college; }
    public void setCollege(String college) { this.college = college; }
    public String getSignature() { return signature; }
    public void setSignature(String signature) { this.signature = signature; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
