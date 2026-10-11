package com.campus.toutiao.dao;

import com.campus.toutiao.entity.Channel;
import java.util.List;

public interface ChannelMapper {
    List<Channel> findAll();
}
