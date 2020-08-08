package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.dao.TPermissionMapper;
import com.atguigu.atcrowdfunding.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/8/2 12:06
 */
@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    TPermissionMapper permissionMapper;

    @Override
    public List<TPermission> showPermissionTree() {

        return permissionMapper.selectByExample(null);
    }

    @Override
    public void savePermission(TPermission permission) {
        permissionMapper.insert(permission);
    }

    @Override
    public void deletePer(Integer id) {
        permissionMapper.deleteByPrimaryKey(id);
    }
}
