package com.node.bbs.settings.web.controller;

import com.node.bbs.exception.MyUserException;
import com.node.bbs.settings.domain.User;
import com.node.bbs.settings.service.UserService;
import com.node.bbs.utils.DateTimeUtil;
import com.node.bbs.utils.MD5Util;
import com.node.bbs.utils.UUIDUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService us;

    @ResponseBody
    @RequestMapping("/login.do")
    public Map<String, Object> login(HttpServletRequest request) throws MyUserException {

        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        // 将密码的明文形式转换为MD5的密文形式
        loginPwd = MD5Util.getMD5(loginPwd);

        Map<String, Object> map = new HashMap<>();

        User user = us.login(loginAct, loginPwd);

        request.getSession().setAttribute("user", user);

        // 如果程序执行到此处，说明业务层没有为controller抛出任何的异常
        // 表示登录成功
            /*

                {"success":true}

             */
        map.put("success", true);

        return map;

    }

    @RequestMapping("/register.do")
    public void register(HttpServletResponse response, User user) {

        user.setId(UUIDUtil.getUUID());
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        user.setCreateTime(DateTimeUtil.getSysTime());
        user.setLockState("1");
        user.setType("1");
        user.setExpireTime("2022-11-27 21:50:05");
        us.register(user);

        try {
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @ResponseBody
    @RequestMapping("/getUser.do")
    public Map<String, Object>getUser(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");
        Map<String, Object> map = new HashMap<>();
        map.put("user", user);
        return map;

    }



    @RequestMapping("/update.do")
    public void update(HttpServletResponse response, User user) {

        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        us.update(user);

        try {
            response.sendRedirect("workbench/index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @RequestMapping("/quit.do")
    public void quit(HttpServletRequest request, HttpServletResponse response) {

        request.getSession().setAttribute("user",null);
        try {
            response.sendRedirect("workbench/index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }

    }





}
