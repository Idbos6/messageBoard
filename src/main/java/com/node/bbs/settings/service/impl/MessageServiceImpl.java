package com.node.bbs.settings.service.impl;

import com.node.bbs.settings.dao.MessageDao;
import com.node.bbs.settings.domain.Message;
import com.node.bbs.settings.service.MessageService;
import com.node.bbs.settings.vo.PaginationVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class MessageServiceImpl implements MessageService {

    @Resource
    private MessageDao messageDao;

    @Override
    public PaginationVO<Message> pageList(Map<String, Object> map) {
        //取得total
        int total = messageDao.getTotalByCondition(map);

        //取得dataList
        List<Message> dataList = messageDao.getActivityListByCondition(map);

        //创建一个vo对象，将total和dataList封装到vo中
        PaginationVO<Message> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        //将vo返回
        return vo;
    }

    @Override
    public boolean add(Message m) {

        boolean flag = true;

        int count = messageDao.add(m);

        if (count != 1) {

            flag = false;

        }

        return flag;
    }

    @Override
    public boolean delete(String[] ids) {

        boolean flag = true;
        for (String id : ids) {

            int count = messageDao.delete(id);
            if (count != 1) {

                flag = false;

            }

        }

        return flag;
    }

    @Override
    public boolean isAdmin(String userId, String[] ids) {

        boolean flag = true;
        for (String id : ids) {

            if (!userId.equals(messageDao.isAdmin(id))) {

                flag = false;

            }


        }

        return flag;

    }

    @Override
    public String selectById(String messageId) {

        String message = messageDao.selectById(messageId);

        return message;
    }


}
