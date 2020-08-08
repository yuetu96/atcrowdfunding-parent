package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.dao.TAdminMapper;
import com.atguigu.atcrowdfunding.dao.TMenuMapper;
import com.atguigu.atcrowdfunding.service.UserService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.security.auth.login.LoginException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author yue
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    TAdminMapper adminMapper;

    @Autowired
    TMenuMapper menuMapper;

    @Override
    public TAdmin getAdminByAdminName(String loginacct, String userpswd) throws LoginException {

        TAdminExample tAdminExample = new TAdminExample();
        tAdminExample.createCriteria().andLoginacctEqualTo(loginacct);
        List<TAdmin> tAdmins = adminMapper.selectByExample(tAdminExample);

        //这里判断查询出来的结果
        if (tAdmins == null || tAdmins.size() == 0) {
            throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
        }
        TAdmin Admin = tAdmins.get(0);
        if (!Admin.getUserpswd().equals(MD5Util.digest(userpswd))) {
            throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
        }
        return Admin;

    }

    @Override
    public List<TMenu> getMenuList() {

        //查询所有不用设置条件
        List<TMenu> allMenus = menuMapper.selectByExample(null);
        //设置list为了前台好处理，
        List<TMenu> parentMenu = new ArrayList<>();
        //map是为了方便设置父菜单的中的子菜单
        Map<Integer,TMenu> parentMenuMap = new HashMap<>();
        allMenus.forEach(menu->{
            if (menu!=null){
                if (menu.getPid()==0){
                    parentMenu.add(menu);
                    parentMenuMap.put(menu.getId(),menu);
                }
            }

        });
        //当时考虑到数据库表可能父类在后面，所以吧迭代分开写
        allMenus.forEach(menu->{
            if (menu.getPid()!=0){
                parentMenuMap.get(menu.getPid()).getChildren().add(menu);
            }
        });
        return parentMenu;
    }

    @Override
    public List<TMenu> getMenuTreeList() {
        return menuMapper.selectByExample(null);
    }

    @Override
    public void doAddMenuTree(TMenu menu) {

        menuMapper.insertSelective(menu);
    }

    @Override
    public void deleteTree(Integer id) {
        menuMapper.deleteByPrimaryKey(id);
    }
}
