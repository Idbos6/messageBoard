package com.node.bbs.settings.service;

import com.node.bbs.settings.domain.Message;
import com.node.bbs.settings.vo.PaginationVO;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public interface MessageService {

    PaginationVO<Message> pageList(Map<String, Object> map);

    boolean add(Message m);

    boolean delete(String[] ids);

    boolean isAdmin(String userId, String[] ids);

    String selectById(String messageId);

}
