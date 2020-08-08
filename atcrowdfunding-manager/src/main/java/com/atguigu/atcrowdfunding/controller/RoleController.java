package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/7/28 16:27
 */

@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;


    @ResponseBody
    @RequestMapping("/role/deleteRoles")
    public String deleteRoles(String roleIdStr) {
        roleService.deleteRoles(roleIdStr);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/deleteRoleById")
    public String deleteRoleById(Integer id) {
        roleService.deleteRoleById(id);
        return "ok";
    }
    @ResponseBody
    @RequestMapping("/role/doUpdate")
    public String doUpdate(TRole role) {
        roleService.doUpdate(role);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/role/getRoleById")
    public TRole getRoleById(Integer id) {
        TRole role = roleService.getRoleById(id);
        return role;
    }

    @ResponseBody
    @RequestMapping("/role/doAdd")
    public String doAdd(TRole role) {

        roleService.doAdd(role);

        return "ok";
    }


    /**
     * 这里想返回对象需要使用，ResponseBody注解
     *
     * @param pageNum
     * @param pageSize
     * @param condition
     * @return PageInfo<TRole>
     */
    @ResponseBody
    @RequestMapping("/role/loadData")
    public PageInfo<TRole> loadDate(@RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum,
                                    @RequestParam(value = "pageSize", required = false, defaultValue = "2") Integer pageSize,
                                    @RequestParam(value = "condition", required = false, defaultValue = "") String condition) {

        HashMap<String, Object> paramMap = new HashMap<>();
        paramMap.put("condition", condition);
        //开启分页
        PageHelper.startPage(pageNum, pageSize);

        PageInfo<TRole> pages = roleService.listPage(paramMap);

        return pages;
    }


    @RequestMapping("/role/index")
    public String index() {
        //ajax异步请求，先返回页面在加载数据
        return "/role/index";
    }

}
