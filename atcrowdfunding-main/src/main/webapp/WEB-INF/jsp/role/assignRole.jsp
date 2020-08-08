<%--
  Created by IntelliJ IDEA.
  User: yue
  Date: 2020/7/27
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/includejsp/css.jsp" %>
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
        }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/includejsp/consoleTop.jsp"/>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/includejsp/consoleMenu.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="${PATH}/main">首页</a></li>
                <li><a href="${PATH}/admin/index">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline">
                        <div class="form-group">
                            <label for="exampleInputPassword1">未分配角色列表</label><br>
                            <select class="selectAddId form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach var="role" items="${requestScope.adminRoleMap.notHaveRoles}">
                                <option  selectAddId="${role.id}" value="${role.name}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="addRole" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="removeRole" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="selectRemoveId form-group" style="margin-left:40px;">
                            <label for="exampleInputPassword1">已分配角色列表</label><br>
                            <select class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach var="role" items="${requestScope.adminRoleMap.haveRoles}">
                                    <option selectRemoveId="${role.id}" value="${role.name}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<%@include file="/WEB-INF/includejsp/js.jsp" %>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    $("#addRole").click(function () {
        /*
        * 1、点击获取adminId和RoleId
        * 2、这里由于前面写的是同步请求，这里不能使用异步，
        */
        let adminId=${adminRoleMap.adminid};
        let roleId = $(".selectAddId option:selected").attr("selectAddId");
        window.location.href="${PATH}/adminRole/addRoleToAdmin?adminid="+adminId+"&roleid="+roleId;
    })
    $("#removeRole").click(function () {
        /*
        * 1、点击获取adminId和RoleId
        * 2、这里由于前面写的是同步请求，这里不能使用异步，
        */
        let adminId=${adminRoleMap.adminid};
        let roleId = $(".selectRemoveId option:selected").attr("selectRemoveId");
        window.location.href="${PATH}/adminRole/deleteRoleToAdmin?adminid="+adminId+"&roleid="+roleId;
    })
</script>
</body>
</html>
