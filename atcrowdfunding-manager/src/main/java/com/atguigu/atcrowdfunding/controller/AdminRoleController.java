package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TAdminRole;
import com.atguigu.atcrowdfunding.service.AdminRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/8/2 17:46
 */
@Controller
public class AdminRoleController {

    @Autowired
    AdminRoleService adminRoleService;

    @RequestMapping("/adminRole/deleteRoleToAdmin")
    public String deleteRoleToAdmin(TAdminRole adminRole){

        adminRoleService.deleteRoleToAdmin(adminRole);

        return "redirect:/admin/toAssignRole?adminid="+adminRole.getAdminid();
    }
    @RequestMapping("/adminRole/addRoleToAdmin")
    public String addRoleToAdmin(TAdminRole adminRole){

        adminRoleService.addRoleToAdmin(adminRole);

        return "redirect:/admin/toAssignRole?adminid="+adminRole.getAdminid();
    }

}
