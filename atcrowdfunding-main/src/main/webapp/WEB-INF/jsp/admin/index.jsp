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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form id="selectForm" class="form-inline" role="form" style="float:left;" method="post" action="${PATH}/admin/index">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input name="condition" class="form-control has-success" type="text" value="${param.condition}" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="selectBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button id="deleteAdmins" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除 </button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/toAdd'"><i class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input class="checkAll" type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="admin" items="${adminPages.list}" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td><input class="checkOne" adminId="${admin.id}" type="checkbox"></td>
                                    <td>${admin.loginacct}</td>
                                    <td>${admin.username}</td>
                                    <td>${admin.email}</td>
                                    <td>
                                        <button type="button" onclick="window.location.href='${PATH}/admin/toAssignRole?adminid=${admin.id}'" class="assignRole btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                        <button onclick="window.location.href='${PATH}/admin/toEdit?id=${admin.id}&pageNum=${adminPages.pageNum}'" type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button onclick="deleteAdmin('${admin.loginacct}',${admin.id})" type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:if test="${adminPages.isFirstPage || adminPages.pageNum==0}">
                                            <li class="disabled"><a href="#">上一页</a></li>
                                        </c:if>
                                        <c:if test="${!adminPages.isFirstPage && adminPages.pageNum>0}">
                                            <li><a href="${PATH}/admin/index?pageNum=${adminPages.pageNum-1}&condition=${param.condition}">上一页</a></li>
                                        </c:if>
                                        <c:forEach items="${adminPages.navigatepageNums}" var="num">
                                            <c:if test="${num==adminPages.pageNum}">
                                                <li class="active"><a href="${PATH}/admin/index?pageNum=${num}&condition=${param.condition}">${num}</a></li>
                                            </c:if>
                                            <c:if test="${num != adminPages.pageNum}">
                                                <li><a href="${PATH}/admin/index?pageNum=${num}&condition=${param.condition}">${num}</a></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${adminPages.isLastPage}">
                                            <li class="disabled"><a href="#">下一页</a></li>
                                        </c:if>
                                        <c:if test="${!adminPages.isLastPage}">
                                            <li><a href="${PATH}/admin/index?pageNum=${adminPages.pageNum+1}&condition=${param.condition}">下一页</a></li>
                                        </c:if>

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
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
    // $("tbody .btn-success").click(function () {
    //     window.location.href = "assignRole.html";
    // });
    // $("tbody .btn-primary").click(function () {
    //     window.location.href = "edit.jsp.html";
    // });

    $("#selectBtn").click(function () {
        $("#selectForm")[0].submit();
    });
    function deleteAdmin(loginacct,id) {
        layer.confirm("你是否要删除【"+loginacct+"】",{btn:["确认","取消"]},function () {
            window.location.href="${PATH}/admin/deleteAdmin?id="+id+"&pageNum=${adminPages.pageNum}"
        },function () {

        })
    }

    $(".checkAll").click(function () {
        let theadChecked = $(this).prop("checked");
        $(".checkOne").prop("checked",theadChecked);

    });

    $("#deleteAdmins").click(function () {
        let list =  $(".checkOne:checked");

        if (list.length===0){
            layer.msg("请先选择要删除的用户");
            return false;
        }
        let idArray = new Array();
        $.each(list,function (index,element) {
            let adminId = $(element).attr('adminId');
            idArray.push(adminId)
        })
        let idStr = idArray.join(",");
        layer.confirm("你是否要删除他们？",{btn:['确定','取消']},function () {
            layer.msg("删除成功",{time:1000,coin:6})
            window.location.href="${PATH}/admin/deleteAdmins?idStr="+idStr+"&pageNum="+${adminPages.pageNum};
        },function () {
        })
    });
</script>
</body>
</html>
