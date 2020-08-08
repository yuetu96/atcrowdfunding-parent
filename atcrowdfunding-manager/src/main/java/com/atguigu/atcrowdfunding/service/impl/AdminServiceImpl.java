package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.*;
import com.atguigu.atcrowdfunding.dao.TAdminMapper;
import com.atguigu.atcrowdfunding.dao.TAdminRoleMapper;
import com.atguigu.atcrowdfunding.dao.TRoleMapper;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.management.relation.Role;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/7/27 17:33
 */
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    TAdminMapper adminMapper;
    @Autowired
    TRoleMapper roleMapper;
    @Autowired
    TAdminRoleMapper adminRoleMapper;

    @Override
    public PageInfo<TAdmin> selectAllAdmin(HashMap<String, Object> conditionMap) {

        TAdminExample example = new TAdminExample();
        Object condition = (String)conditionMap.get("condition");

        if (!StringUtils.isEmpty(condition)){
            TAdminExample.Criteria criteria1 = example.createCriteria();
            TAdminExample.Criteria criteria2 = example.createCriteria();
            TAdminExample.Criteria criteria3 = example.createCriteria();

            criteria1.andLoginacctLike("%" + condition + "%");
            criteria2.andUsernameLike("%"+condition+"%");
            criteria3.andEmailLike("%"+condition+"%");
            //三者是或者的模糊查询
            example.or(criteria1);
            example.or(criteria2);
            example.or(criteria3);
        }

        List<TAdmin> adminList = adminMapper.selectByExample(example);

        //navigatePages代表查询的  默认是8
        int navigatePages = 5;
        //封装分页数据
        PageInfo<TAdmin> adminPages = new PageInfo<>(adminList, navigatePages);

        return adminPages;
    }


    @Override
    public void saveAdmin(TAdmin admin) {
        adminMapper.insertSelective(admin);
    }

    @Override
    public TAdmin selectAdminById(Integer id) {

        TAdmin admin = adminMapper.selectByPrimaryKey(id);
        return admin;
    }

    @Override
    public void updateAdmin(TAdmin admin) {
        adminMapper.updateByPrimaryKeySelective(admin);
    }

    @Override
    public void deleteAdminById(Integer id) {
        adminMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteAdmins(String idStr) {
        String[] idStrArray = idStr.split(",");
        ArrayList<Integer> list = new ArrayList<Integer>();
        for (String s : idStrArray) {
            list.add(Integer.parseInt(s));
        }
        TAdminExample adminExample = new TAdminExample();
        adminExample.createCriteria().andIdIn(list);
        adminMapper.deleteByExample(adminExample);
    }

    @Override
    public Map<String,Object> getAssignRoles(Integer adminid) {
        Map<String, Object> adminRoleMap = new HashMap<>();
        //要根据adminId查出来admin.List<TAdminRole>
        TAdminRoleExample example = new TAdminRoleExample();
        example.createCriteria().andAdminidEqualTo(adminid);
        //查出来的信息有roleId
        List<TAdminRole> tAdminRoles = adminRoleMapper.selectByExample(example);
        List<TRole> haveRoles = new ArrayList<>();
        //查询所有的角色
        List<TRole> notHaveRoles = roleMapper.selectByExample(null);
        tAdminRoles.forEach(TAdminRole->{
            TRole role = roleMapper.selectByPrimaryKey(TAdminRole.getRoleid());
            haveRoles.add(role);
        });
        TRole noRole = new TRole();
        List<TRole> willDelete=new ArrayList();
        if (haveRoles.size()!=0){
            for (int i = 0; i < notHaveRoles.size(); i++) {
                noRole = notHaveRoles.get(i);
                for (TRole role:haveRoles) {
                    //把已经拥有的角色从全部中去掉，是没有的角色
                    if (noRole.getId().equals(role.getId())){
                        System.out.println("role = " + role);
                        willDelete.add(noRole);
                        System.out.println("tRole = " + notHaveRoles);
                    }
                };
            }
            notHaveRoles.removeAll(willDelete);
        }
        //把adminId也放在map中
        adminRoleMap.put("adminid",adminid);
        //把adminRole
        adminRoleMap.put("adminRoles",tAdminRoles);
        //已经拥有的角色
        adminRoleMap.put("haveRoles",haveRoles);
        //没有拥有的角色
        adminRoleMap.put("notHaveRoles",notHaveRoles);


        return adminRoleMap;
    }
}
