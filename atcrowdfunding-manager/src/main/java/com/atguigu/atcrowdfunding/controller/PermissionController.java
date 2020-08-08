package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.jnlp.PersistenceService;
import java.util.List;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/8/1 11:49
 */
@Controller
public class PermissionController {

    @Autowired
    PermissionService permissionService;

    @ResponseBody
    @RequestMapping("/permission/deletePer")
    public String deletePer(Integer id){
        permissionService.deletePer(id);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/permission/showPermissionTree")
    public List<TPermission> showPermissionTree(){
        List<TPermission> permissionList = permissionService.showPermissionTree();
        return permissionList;
    }
    @ResponseBody
    @RequestMapping("/permission/savePermission")
    public String savePermission(TPermission permission){
        permissionService.savePermission(permission);
        return "ok";
    }
    @RequestMapping("/permission/index")
    public String index(){
        return "permission/index";
    }
}
