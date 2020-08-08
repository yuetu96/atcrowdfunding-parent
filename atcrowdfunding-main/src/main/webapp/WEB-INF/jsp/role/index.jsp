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
                    <form id="selectForm" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input name="condition" class="form-control has-success" type="text" value="${param.condition}" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="selectBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button id="deleteRoles" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除 </button>
                    <button id="saveBtn" type="button"  class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input class="checkAll" type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody >

                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="6" align="center">
                                    <ul class="pagination">
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


<!-- 添加模态框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" role="form">
                    <div class="form-group">
                        <label>名称</label>
                        <input type="text" class="form-control"  name="name" placeholder="请输入角色名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveModalBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改模态框 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">修改</h4>
            </div>
            <div class="modal-body">
                <form id="editForm" role="form">
                    <div class="form-group">
                        <label>名称</label>
                        <input type="hidden" name="id">
                        <input type="text" class="form-control"  name="name" placeholder="请输入角色名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateSaveModal" type="button" class="btn btn-primary">保存修改</button>
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
        showData(1);
    });
    // $("tbody .btn-success").click(function () {
    //     window.location.href = "assignRole.html";
    // });
    // $("tbody .btn-primary").click(function () {
    //     window.location.href = "edit.jsp.html";
    // });
    let json = {
        pageNum:1,
        pageSize:2,
        condition:""
    }
    function showData(pageNum) {
        json.pageNum=pageNum;
        $.ajax({
            type:"post",
            data:json,
            url:"${PATH}/role/loadData",
            //这里的result是pageInfo
            success:function (result) {
                $(".checkAll").prop("checked","");
                console.log(result);
                console.log(result.list);
                //这里设置最大页数，为了后面添加自动跳转到最后一个
                json.totalPages = result.pages;
                //如果成功就显示数据，这里写一个函数做这件事情
                showTable(result.list);
                //显示分页栏
                showPagination(result);
            }
        })
    }
    function showTable(list) {
        let content = '';//在js代码中，拼串推荐使用单引号
        $.each(list,function (i,e) {
            content+='<tr>';
            content+=' <td>'+(i+1)+'</td>';
            content+=' <td><input roleId="'+e.id+'" class="checkOne" type="checkbox"></td>';
            content+=' <td>'+e.name+'</td>';
            content+=' <td>';
            content+='	  <button type="button" class="editBtnClass btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
            content+='	  <button type="button" roleId="'+e.id+'"class="updateBtnClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
            content+='	  <button type="button" roleId="'+e.id+'" class="deleteBtnClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
            content+=' </td>';
            content+='</tr>';
        })

        $("tbody").html(content);
    }

    function showPagination(pageInfo) {
        let content = '';//在js代码中，拼串推荐使用单引号
        if (pageInfo.isFirstPage || pageInfo.pageNum==0){
            content+='<li class="disabled"><a href="#">上一页</a></li>';
        }else{
            content+='<li><a onclick="showData('+(pageInfo.prePage)+')">上一页</a></li>';
        }

        $.each(pageInfo.navigatepageNums,function (i,num) {
            console.log(num)
            console.log(pageInfo.pageNum)
            if (num==pageInfo.pageNum){
                content+='<li class="active"><a onclick="showData('+num+')">'+num+'</a></li>';
            }else{
                content+='<li><a onclick="showData('+num+')">'+num+'</a></li>';
            }
        })
        if (pageInfo.isLastPage){
            content += '<li class="disabled"><a href="#">下一页</a></li>';
        }else{
            content += '<li><a onclick="showData('+pageInfo.nextPage+')">下一页</a></li>';
        }

        $(".pagination").html(content);

    }

    //带条件的查询
    $("#selectBtn").click(function(){
        let condition = $("#selectForm input[name='condition']").val();
        json.condition=condition;
        showData(1);
    })

    //弹出模态框
    $("#saveBtn").click(function(){
        $("#addModal").modal({
            show: true,
            backdrop:"static",
            keyboard:false
        });
    });
    //使用ajax执行添加功能
    $("#saveModalBtn").click(function(){
        //获取信息
        let roleMsg = $("#addForm input[name='name']").val();
        //发送信息,并处理
        $.ajax({
            type:"post",
            data:{name:roleMsg},
            url:"${PATH}/role/doAdd",
            success:function (result) {
                //关闭模态框。并且清理模态框中的数据
                $("#addModal").modal("hide");
                $("#addForm input[name='name']").val("");

                if (result=="ok"){
                    //回显信息
                    showData(json.totalPages+1);
                }else{
                    layer.msg("添加失败",{time:1000,coin:6})
                }
            }
        })
    })

    //弹出模态框并回显数据
    $("tbody").on("click",".updateBtnClass",function () {
        //1、获取修改信息
        let roleId = $(this).attr("roleId");
        //2.发起ajax请求，查询数据
        $.get(
            "${PATH}/role/getRoleById",
            {id:roleId},
            function (result){
            //3.回显数据
            $("#updateModal input[name='name']").val(result.name);
            $("#updateModal input[name='id']").val(result.id);
            //4.弹出模态框
            $("#updateModal").modal({
                show:true, //展示模态框
                backdrop:"static",
                keyboard:false
            });
        });
    });
    //提交保存
    $("#updateSaveModal").click(function(){
        //获取信息
        let roleMsg = $("#editForm input[name='name']").val();
        let roleId = $("#editForm input[name='id']").val();
        //发送信息,并处理
        $.ajax({
            type:"post",
            data:{id:roleId,name:roleMsg},
            url:"${PATH}/role/doUpdate",
            success:function (result) {
                //关闭模态框。并且清理模态框中的数据
                $("#updateModal").modal("hide");
                $("#editForm input[name='name']").val("");

                if (result=="ok"){
                    //回显信息
                    showData(json.pageNum);
                }else{
                    layer.msg("修改失败",{time:1000,coin:5})
                }
            }
        })
    })

//===================删除========
    $("tbody").on("click",".deleteBtnClass",function () {
        let roleId = $(this).attr("roleId");
        let index = layer.confirm("你确定要删除？",{btn:["确定","取消"]},function () {
            $.get(
                "${PATH}/role/deleteRoleById",
                {id:roleId},
                function (result) {
                    showData(1);
                    layer.close(index)
                }
            )
        },function () {
        })
    });

    //批量删除
    $(".checkAll").click(function () {
        //找出选中的标签，prop  选中复选框为true，没选中为false
        let theadChecked = $(this).prop("checked");
        $(".checkOne").prop("checked",theadChecked);
    })
    $("#deleteRoles").click(function () {
        //将选中的标签拼接为字符串
        let list = $(".checkOne:checked")
        let roleArray = new Array();
        $.each(list,function (i,e) {
            let roleId = $(e).attr('roleId');
            roleArray.push(roleId)
        })
        //把数组拼接
        let roleIdStr = roleArray.join(",");
        //使用ajax发送到后台
        layer.confirm("你是否要删除他们？",{btn:['确定','取消']},function () {
            $.get("${PATH}/role/deleteRoles",{roleIdStr:roleIdStr},function (result) {
                if (result=="ok"){
                    layer.msg("删除成功",{time:1000,coin:6});
                    // 取消勾选  直接放到加载数据页面
                    // $(".checkAll").prop("checked","");
                    //刷新页面
                    showData(json.pageNum);
                }else{
                    layer.msg("删除失败",{time:1000,coin:5})
                }
            })
        },function () {

        })

    })
    $("tbody").on("click",".editBtnClass",function () {

    })
</script>
</body>
</html>
