package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/7/29 11:16
 */
@Controller
public class MenuController {

    @Autowired
    UserService userService;

    @ResponseBody
    @RequestMapping("/menu/deleteTree")
    public String deleteTree(Integer id){
        userService.deleteTree(id);
        return "ok";
    }
    @ResponseBody
    @RequestMapping("/menu/doAddMenuTree")
    public String doAddMenuTree(TMenu menu){
        userService.doAddMenuTree(menu);
        return "ok";
    }

    @ResponseBody
    @RequestMapping("/menu/showTreeList")
    public List<TMenu> showTreeList(){
       return userService.getMenuTreeList();
    }

    @RequestMapping("/menu/index")
    public String showMenuList(){

        return "menu/index";
    }
}
