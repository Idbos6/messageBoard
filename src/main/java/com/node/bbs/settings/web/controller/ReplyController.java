package com.node.bbs.settings.web.controller;

import com.node.bbs.settings.domain.Reply;
import com.node.bbs.settings.domain.User;
import com.node.bbs.settings.service.HelpThreeEmailService;
import com.node.bbs.settings.service.MessageService;
import com.node.bbs.settings.service.ReplyService;
import com.node.bbs.settings.service.UserService;
import com.node.bbs.utils.DateTimeUtil;
import com.node.bbs.utils.UUIDUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/reply")
public class ReplyController {

    @Resource
    private MessageService ms;

    @Resource
    private ReplyService rs;

    @Resource
    private UserService us;

    @Resource
    private HelpThreeEmailService hs;

    @RequestMapping("/save.do")
    @ResponseBody
    public Map<String, Object> save(Reply r) {

        r.setId(UUIDUtil.getUUID());
        r.setCreateTime(DateTimeUtil.getSysTime());
        boolean flag = rs.save(r);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        if (flag == true) {

            String toEmail = rs.getEmail(r.getMessageId());
            String subject = "管理员回复于:" + r.getCreateTime();
            String contents = r.getReply();

            try {
                hs.SendEmail(toEmail, subject, contents);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return map;
    }

    @RequestMapping("/selectById.do")
    @ResponseBody
    public Map<String, Object> selectById(HttpServletRequest request) {

        String messageId = request.getParameter("messageId");
        boolean flag = false;
        String userId = ((User)request.getSession().getAttribute("user")).getId();
        String[] ids = us.getAdminIds();
        for (String id : ids) {

            if (userId.equals(id)) {

                flag = true;

            }

        }

        String result = rs.selectById(messageId);
        String message = ms.selectById(messageId);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("result", result);
        map.put("message",message);

        return map;
    }

}
