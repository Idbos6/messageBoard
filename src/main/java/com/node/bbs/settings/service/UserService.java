package com.node.bbs.settings.service;

import com.node.bbs.exception.MyUserException;
import com.node.bbs.settings.domain.User;
import org.springframework.stereotype.Service;

@Service
public interface UserService {

    User login(String loginAct, String loginPwd) throws MyUserException;

    void register(User user);

    void update(User user);

    String[] getAdminIds();
}
