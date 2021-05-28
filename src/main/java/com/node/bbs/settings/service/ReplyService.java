package com.node.bbs.settings.service;

import com.node.bbs.settings.domain.Reply;
import org.springframework.stereotype.Service;

@Service
public interface ReplyService {
    boolean save(Reply r);

    String selectById(String messageId);

    String getEmail(String messageId);
}
