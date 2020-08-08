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
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 菜单维护</h3>
                </div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

    <!-- 添加Tree模态框 -->
    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
        Launch demo modal
    </button>

    <!-- Modal -->
    <div class="modal fade" id="addTreeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加菜单</h4>
                </div>
                <div class="modal-body">
                <form id="addTreeMenuForm" role="form">
                    <div class="form-group">
                        <label>名称</label>
                        <input type="text" class="treeName form-control" name="name" placeholder="请输入角色名称">
                            <%--<div class="btn-toolbar" role="toolbar" aria-label="...">
                                <div class="btn-group" role="group" aria-label="..."><span class="glyphicon glyphicon-heart"></span></div>
                                <div class="btn-group" role="group" aria-label="..."><span class="glyphicon glyphicon-star"></span></div>
                                <div class="btn-group" role="group" aria-label="..."><span class="glyphicon glyphicon-off"></span></div>
                            </div>--%>
                    </div>
                </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="doAddMenuTree" type="button" class="btn btn-primary">保存</button>
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
        showTree();
    });
    /*$("tbody .btn-success").click(function () {
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function () {
        window.location.href = "edit.jsp.html";
    });*/

    //找到的数据由于没有指定父的id：需要手动指定。默认是pId；我们的是pid
    function showTree(){
        let setting = {
            view:{
                selectedMulti: false,
                addDiyDom:addMenuCoin,
                addHoverDom:addHoverCoinDom,
                removeHoverDom:removeHoverCoinDom
            },
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "pid",
                }
            },
        };

        let zNodes ={};
        $.get("${PATH}/menu/showTreeList",{},function(result) {
            zNodes = result;
            zNodes.push({"id":0,"pid":0,"seqno":0,"name":"系统权限菜单","url":"#","icon":"glyphicon glyphicon-home","open":true,"checked":false})
            let tree = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            tree.expandAll(true);
        })
    }
    function addMenuCoin(treeId, treeNode) {
        let icoObj = $("#" + treeNode.tId + "_ico");
            if ( treeNode.icon ) {
                icoObj.removeClass().addClass(treeNode.icon);
            }
    }
    function addHoverCoinDom(treeId,treeNode) {
        let aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
        //禁用链接
        aObj.attr("href", "javascript:;");
        //禁用单击事件
        aObj.attr("onclick", "return false;");
        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) {
            return
        };
        let s = '<span id="btnGroup'+treeNode.tId+'">';
        if ( treeNode.level == 0 ) {
            s += '<a class="addChildTree btn btn-info dropdown-toggle btn-xs" myId="'+treeNode.id+'" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
        } else if ( treeNode.level == 1 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs"  style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
            if (treeNode.children.length == 0) {
                s += '<a class="deleteThisTree btn btn-info dropdown-toggle btn-xs" myName="'+treeNode.name+'" myId="'+treeNode.id+'" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
            }
            s += '<a class="addChildTree btn btn-info dropdown-toggle btn-xs" myId="'+treeNode.id+'"  style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
        } else if ( treeNode.level == 2 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
            s += '<a class="deleteThisTree btn btn-info dropdown-toggle btn-xs" myName="'+treeNode.name+'" myId="'+treeNode.id+'" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
        }

        s += '</span>';
        aObj.after(s);
    }
    function removeHoverCoinDom(treeId,treeNode) {
        $("#btnGroup"+treeNode.tId).remove();
    }
        //弹出模态框
    $("ul").on("click",".addChildTree",function() {

        $('#addTreeModal').modal({
        show:true, //展示模态框
        backdrop:"static",//点击其他地方不会关闭模态框
        keyboard:false//esc不关闭模态框
        })
    });

    //1、点击模态框，
    $("#doAddMenuTree").click(function() {
        //1、获取父类的id，获取字节点的数值，
        let myId = $(".addChildTree").attr("myId");
        let childName = $(".treeName").val();

        //通过ajax发送请求
        $.get("${PATH}/menu/doAddMenuTree",{pid:myId,name:childName},function(msg) {
            if (msg=="ok"){
                //关闭模态框刷新数据
                $("#addTreeModal").modal('hide');
                layer.confirm("是否刷新页面,并保存",{btn:["确定","取消"]},function() {
                    window.location.href="${PATH}/treeMain";
                },function() {
                })
                // showTree();
            }else{
                layer.msg("保存失败",{time:1000,coin:5});
            }
        })
    })

    //删除树结构
    $("ul").on("click",".deleteThisTree",function() {
        //获取要删除的id 和name
        let myId = $(".deleteThisTree").attr("myId");
        let myName = $(".deleteThisTree").attr("myName")
        //弹出是否删除
        layer.confirm("你确定删除【"+myName+"】吗？",{btn:["确定","取消"]},function() {
            //执行删除的ajax
            $.get("${PATH}/menu/deleteTree",{id:myId},function(result) {
                if (result=="ok"){
                    layer.msg("删除成功",{time:1000,coin:6})
                    //刷新页面
                    window.location.href="${PATH}/menu/index";
                }else{
                    layer.msg("删除失败",{time:1000,coin:5})
                }
            })
        },function() {
        })

    })

</script>
</body>
</html>
