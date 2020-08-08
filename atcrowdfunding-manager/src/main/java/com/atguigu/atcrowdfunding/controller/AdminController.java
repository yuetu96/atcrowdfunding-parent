package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.util.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

/**
 * @PROJECT_NAME: atcrowdfunding-parent
 * @DESCRIPTION:
 * @author: yue
 * @DATE: 2020/7/27 10:56
 */
@Controller
public class AdminController {

    @Autowired
    AdminService adminService;



    @RequestMapping("/admin/toAssignRole")
    public String toAssignRole(Model model,Integer adminid){
        //把数据一次查出，然后放到域中转发给前端、
        Map<String, Object> adminRoleMap = adminService.getAssignRoles(adminid);
        model.addAttribute("adminRoleMap",adminRoleMap);
        return "admin/assignRole";
    }

    @RequestMapping("/admin/deleteAdmins")
    public String deleteBatch(String idStr,Integer pageNum){

        adminService.deleteAdmins(idStr);
        return "redirect:/admin/index?pageNum="+pageNum;
    }
        @RequestMapping("/admin/deleteAdmin")
    public String deleteAdmin(Integer id,Integer pageNum){
        adminService.deleteAdminById(id);
        return "redirect:/admin/index?pageNum="+pageNum;
    }
    @RequestMapping("/admin/doEdit")
    public String doEdit(TAdmin admin,Integer pageNum) {

        adminService.updateAdmin(admin);

        return "redirect:/admin/index?pageNum="+pageNum;
    }

    @RequestMapping("/admin/toEdit")
    public String toEdit(Integer id,Model model) {

        //查询一个管理员，返回
        TAdmin admin = adminService.selectAdminById(id);
        model.addAttribute("admin",admin);
        return "admin/edit";
    }

    @RequestMapping("/admin/doAdd")
    public String doAdd(TAdmin admin){

        //添加用户需要设置默认密码和创建时间
        admin.setUserpswd(Const.DEFALUT_PASSWORD);
        admin.setCreatetime(DateUtil.getFormatTime());
        adminService.saveAdmin(admin);
        return "redirect:/admin/index?pageNum="+Integer.MAX_VALUE;
    }

    @RequestMapping("/admin/toAdd")
    public String toAdd(){

        return "admin/add";
    }

    @RequestMapping("/admin/index")
    public String index(
            //这里使用设置参数属性，来设置默认值，如果前端不输入
            @RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize", required = false, defaultValue = "4") Integer pageSize,
            @RequestParam(value = "condition", required = false, defaultValue = "") String condition,
            Model model) {

        HashMap<String, Object> conditionMap = new HashMap<>();
        conditionMap.put("condition",condition);
        //开启分页--这是绑定在线程上面的，可以在同一个线程使用
        PageHelper.startPage(pageNum,pageSize);

        PageInfo<TAdmin> adminPages = adminService.selectAllAdmin(conditionMap);

        model.addAttribute("adminPages",adminPages);
        return "admin/index";
    }
}
