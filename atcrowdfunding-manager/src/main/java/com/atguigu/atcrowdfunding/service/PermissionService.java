package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.TPermission;

import java.util.List;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/8/2 12:05
 */
public interface PermissionService {
    List<TPermission> showPermissionTree();

    void savePermission(TPermission permission);

    void deletePer(Integer id);
}
