package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

import java.util.HashMap;

public interface RoleService {
    PageInfo<TRole> listPage(HashMap<String, Object> paramMap);

    void doAdd(TRole role);

    TRole getRoleById(Integer id);

    void doUpdate(TRole role);

    void deleteRoleById(Integer id);

    void deleteRoles(String idStr);



}
