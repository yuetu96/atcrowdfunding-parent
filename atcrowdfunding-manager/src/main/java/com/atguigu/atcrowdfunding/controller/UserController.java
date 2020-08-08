package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.UserService;
import com.atguigu.atcrowdfunding.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author yue
 */
@Controller
public class UserController {

    @Autowired
    UserService userService;

    @PostMapping("/loginAdmin")
    public String loginAdmin(String loginacct, String userpswd, HttpSession httpSession, Model model){

        try {
            TAdmin admin = (TAdmin) httpSession.getAttribute(Const.LOGIN_ADMIN);
            if (admin==null){
                admin = userService.getAdminByAdminName(loginacct, userpswd);
                httpSession.setAttribute(Const.LOGIN_ADMIN,admin);
            }
            return "redirect:/main";
        } catch (LoginException e) {
            e.printStackTrace();
            model.addAttribute(Const.ERROR_MESSAGE,e.getMessage());
            return "forward:/login.jsp";
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute(Const.ERROR_MESSAGE,e.getMessage());
            return "forward:/login.jsp";
        }
    }

    /**
     * 获取菜单，由于每次登陆成功为了避免重复提交都会经过重定向到main方法，这里为了解耦吧菜单查找卸载main方法中
     * 并且传送到前端
     * @return
     */
    @RequestMapping("/main")
    public String main(Model model,HttpSession session){
        TAdmin admin = (TAdmin) session.getAttribute(Const.LOGIN_ADMIN);
        String flag = session.getAttribute(Const.PARENT_MENU_LIST_FLAG)+"";
        if (admin==null){
            model.addAttribute(Const.ERROR_MESSAGE,"请先登录");
            return "forward:/login.jsp";
        }if (!Const.PARENT_MENU_LIST_FLAG.equals(flag)){
            List<TMenu> parentMenuList = userService.getMenuList();
            session.setAttribute(Const.PARENT_MENU_LIST_FLAG,"parentMenuListFlag");
            session.setAttribute("parentMenuList",parentMenuList);
        }
        return "main";
    }
    @RequestMapping("/treeMain")
    public String treeMain(Model model,HttpSession session){
        TAdmin admin = (TAdmin) session.getAttribute(Const.LOGIN_ADMIN);
        if (admin==null){
            model.addAttribute(Const.ERROR_MESSAGE,"请先登录");
            return "forward:/login.jsp";
        }
        List<TMenu> parentMenuList = userService.getMenuList();
        session.setAttribute("parentMenuList",parentMenuList);
        return "menu/index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession httpSession){
        //这里要判断防止空指针
        if (httpSession!=null){
            httpSession.invalidate();
        }
        return "forward:/login.jsp";
    }

}
