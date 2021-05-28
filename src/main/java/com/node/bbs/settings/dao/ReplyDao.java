package com.node.bbs.settings.dao;

import com.node.bbs.settings.domain.Reply;

import java.util.List;

public interface ReplyDao {
    int save(Reply r);

    List<Reply> selectById(String messageId);

    String getEmail(String messageId);
}
