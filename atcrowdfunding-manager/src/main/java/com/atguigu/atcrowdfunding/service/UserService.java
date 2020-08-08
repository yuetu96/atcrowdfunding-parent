package com.atguigu.atcrowdfunding.service;


import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;

import javax.security.auth.login.LoginException;
import java.util.List;

/**
 * @author yue
 */
public interface UserService {
    TAdmin getAdminByAdminName(String loginacct, String userpswd) throws LoginException;

     List<TMenu> getMenuList();

    List<TMenu> getMenuTreeList();

    void doAddMenuTree(TMenu menu);

    void deleteTree(Integer id);
}
