package com.node.bbs.settings.dao;

import com.node.bbs.settings.domain.User;
import java.util.Map;

public interface UserDao {

    User login(Map<String, String> map);

    void register(User user);

    void update(User user);

    String[] getAdminIds();
}