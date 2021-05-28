package com.node.bbs.settings.service.impl;

import com.node.bbs.settings.dao.ReplyDao;
import com.node.bbs.settings.domain.Reply;
import com.node.bbs.settings.service.ReplyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {

    @Resource
    private ReplyDao replyDao;

    @Override
    public boolean save(Reply r) {

        boolean flag = true;
        int count = replyDao.save(r);

        if (count != 1) {

            flag = false;

        }

        return flag;

    }

    @Override
    public String selectById(String messageId) {

        String result = "";
        List<Reply> list = replyDao.selectById(messageId);

        for (Reply reply : list) {

            result += reply.getCreateTime();
            result += ":";
            result += reply.getReply();
            result += "\n";


        }
        return result;
    }

    @Override
    public String getEmail(String messageId) {

        String email = replyDao.getEmail(messageId);
        return email;
    }
}
