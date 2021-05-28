package com.node.bbs.settings.dao;

import com.node.bbs.settings.domain.Message;

import java.util.List;
import java.util.Map;

public interface MessageDao {

    int getTotalByCondition(Map<String, Object> map);

    List<Message> getActivityListByCondition(Map<String, Object> map);

    int add(Message m);

    int delete(String id);

    String isAdmin(String id);

    String selectById(String messageId);

}
