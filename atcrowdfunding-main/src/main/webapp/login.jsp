<%--
  Created by IntelliJ IDEA.
  User: yue
  Date: 2020/7/25
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <%--    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css">--%>
    <%--    <link rel="stylesheet" href="${PATH}/static/bootstrap/css/bootstrap.css">--%>
    <%--    <link rel="stylesheet" href="${PATH}/static/css/font-awesome.min.css">--%>
    <%@include file="/WEB-INF/includejsp/css.jsp" %>
    <%--    <link rel="stylesheet" href="${PATH}/static/css/login.css">--%>
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="login.jsp" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form id="LoginForm" class="form-signin" role="form" method="post" action="${PATH}/loginAdmin">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" name="loginacct" value="${param.loginacct}" id="inputSuccess1" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" name="userpswd" value="${param.userpswd}" id="inputSuccess4" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <%--  <div class="form-group has-success has-feedback">
                    <select class="form-control" >
                        <option value="member">会员</option>
                        <option value="user" selected>管理</option>
                    </select>
                </div>--%>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.html">我要注册</a>
            </label>
        </div>
        <c:if test="${!empty requestScope.errorMsg}">
        <div  class="alert alert-danger" role="alert">
            ${requestScope.errorMsg}
        </div>
        </c:if>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()"> 登录</a>
    </form>
</div>
<%@include file="/WEB-INF/includejsp/js.jsp" %>
<script>
    function dologin() {
        $("#LoginForm").submit();
    }
</script>
</body>
</html>