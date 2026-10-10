package com.campus.toutiao.entity;

/**
 * 频道实体类
 */
public class Channel {
    private Integer id;
    private String name;
    private String description;
    private Integer sort;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
}
