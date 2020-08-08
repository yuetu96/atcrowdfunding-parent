package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminRole;
import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/7/27 17:33
 */
public interface AdminService {
    PageInfo<TAdmin> selectAllAdmin(HashMap<String, Object> conditionMap);

    void saveAdmin(TAdmin admin);

    TAdmin selectAdminById(Integer id);

    void updateAdmin(TAdmin admin);

    void deleteAdminById(Integer id);

    void deleteAdmins(String idStr);

    Map<String,Object> getAssignRoles(Integer adminid);

}
