package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TAdminRole;
import com.atguigu.atcrowdfunding.bean.TAdminRoleExample;
import com.atguigu.atcrowdfunding.dao.TAdminRoleMapper;
import com.atguigu.atcrowdfunding.service.AdminRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/8/2 18:17
 */
@Service
public class AdminRoleServiceImpl implements AdminRoleService {
    @Autowired
    TAdminRoleMapper adminRoleMapper;

    @Override
    public void addRoleToAdmin(TAdminRole adminRole) {
        adminRoleMapper.insert(adminRole);
    }

    @Override
    public void deleteRoleToAdmin(TAdminRole adminRole) {
        TAdminRoleExample example = new TAdminRoleExample();
        example.createCriteria().andRoleidEqualTo(adminRole.getRoleid());
        adminRoleMapper.deleteByExample(example);
    }
}
