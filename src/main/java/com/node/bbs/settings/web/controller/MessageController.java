package com.node.bbs.settings.web.controller;

import com.node.bbs.settings.domain.Message;
import com.node.bbs.settings.domain.User;
import com.node.bbs.settings.service.MessageService;
import com.node.bbs.settings.vo.PaginationVO;
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
@RequestMapping("/message")
public class MessageController {

    @Resource
    private MessageService ms;

    @RequestMapping("/pageList.do")
    @ResponseBody
    public PaginationVO<Message> pageList(Message m, HttpServletRequest request) {

        // 第几页
        String pageNoStr = request.getParameter("pageNo");
        int pageNo = Integer.valueOf(pageNoStr);

        // 每页展现的记录数
        String pageSizeStr = request.getParameter("pageSize");
        int pageSize = Integer.valueOf(pageSizeStr);

        // 计算出略过的记录数
        int skipCount = (pageNo - 1) * pageSize;

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userName", m.getUserName());
        map.put("createTime", m.getCreateTime());
        map.put("title", m.getTitle());
        map.put("message", m.getMessage());
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        PaginationVO<Message> vo = ms.pageList(map);

        //vo--> {"total":100,"dataList":[{留言1},{2},{3}]}
        return vo;

    }

    @RequestMapping("/add.do")
    @ResponseBody
    public Map<String, Object> add(Message m, HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user"); // 从Session域中取得当前登录的用户对象
        m.setUserId(user.getId()); // 将User对象的id作为外键传入Message对象
        m.setUserName(user.getName());
        m.setId(UUIDUtil.getUUID()); // Message对象的主键，调用工具包随机生成32位UUID编码
        m.setCreateTime(DateTimeUtil.getSysTime()); // 获取当前时间传入Message对象

        boolean flag = ms.add(m); // 在tbl_message表中添加一条留言记录，成功则返回true，否则返回false

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag); // 给前台返回成功信息

        return map;

    }

    @RequestMapping("/delete.do")
    @ResponseBody
    public Map<String, Object> delete(HttpServletRequest request) {

        boolean flag = true;
        String ids[] = request.getParameterValues("id");
        User user = (User) request.getSession().getAttribute("user");
        String type = user.getType();
        boolean admin = true;
        String userId = user.getId();
        if ("1".equals(type)) { // 如果不为管理员，则验证是否为本人发出的留言，否则没有权限删除

            admin = ms.isAdmin(userId, ids);
            flag = admin;

        }

        if (admin) { // 获得权限后开始执行删除操作

            flag = ms.delete(ids);

        }

        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;

    }

}
