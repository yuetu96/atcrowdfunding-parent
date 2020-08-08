package com.atguigu.atcrowdfunding.listener;



import com.atguigu.atcrowdfunding.util.Const;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author yue
 */
public class StartProjectInitListener implements ServletContextListener {
    /**
     * 服务器启动的时候执行的方法
     * @param servletContextEvent
     */
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

        ServletContext context = servletContextEvent.getServletContext();
        String contextPath = context.getContextPath();
        context.setAttribute(Const.PATH, contextPath);

//        System.out.println("contextPath = " + contextPath);
    }

    /**
     *服务器关闭的时候执行的方法
     * @param servletContextEvent
     */
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
//        System.out.println("StartProjectInitListener-----contextDestroyed ");

    }
}
