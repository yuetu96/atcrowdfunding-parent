package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TAdminRole;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/8/2 18:17
 */
public interface AdminRoleService {
    void addRoleToAdmin(TAdminRole adminRole);

    void deleteRoleToAdmin(TAdminRole adminRole);
}
