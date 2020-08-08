package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.dao.TRoleMapper;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/7/28 17:02
 */
@Service
public class RoleServiceImpl implements RoleService {


    @Autowired
    private TRoleMapper roleMapper;

    @Override
    public PageInfo<TRole> listPage(HashMap<String, Object> paramMap) {

        String condition = (String) paramMap.get("condition");
        TRoleExample example = new TRoleExample();
        if (!StringUtils.isEmpty(condition)){
            TRoleExample.Criteria criteria1 = example.createCriteria();
            criteria1.andNameLike("%"+condition+"%");
        }
        List<TRole> roles = roleMapper.selectByExample(example);
        int navigatePages = 5;

        PageInfo<TRole> pageInfo = new PageInfo<>(roles,navigatePages);
        return pageInfo;
    }

    @Override
    public void doAdd(TRole role) {

        roleMapper.insertSelective(role);
    }

    @Override
    public TRole getRoleById(Integer id) {
        TRole tRole = roleMapper.selectByPrimaryKey(id);
        return tRole;
    }

    @Override
    public void doUpdate(TRole role) {
        roleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void deleteRoleById(Integer id) {
        roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteRoles(String idStr) {
        String[] idStrArray = idStr.split(",");
        ArrayList<Integer> list = new ArrayList<Integer>();
        for (String s : idStrArray) {
            list.add(Integer.parseInt(s));
        }
        TRoleExample example = new TRoleExample();
        example.createCriteria().andIdIn(list);
        roleMapper.deleteByExample(example);
    }
}
