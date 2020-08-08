<%--
  Created by IntelliJ IDEA.
  User: yue
  Date: 2020/7/25
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@include file="/WEB-INF/includejsp/css.jsp"%>
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        .tree-closed {
            height : 40px;
        }
        .tree-expanded {
            height : auto;
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
                <div class="panel-heading panel-body"><i class="glyphicon glyphicon-th-list"></i> 许可权限管理 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
//添加模态框
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
    Launch demo modal
</button>
<!-- Modal -->
<div class="modal fade" id="addPermissionModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加许可权限</h4>
            </div>
            <div class="modal-body">
                <label>name</label>
                <input type="text" class="treeName form-control" name="name" placeholder="请输入角色名称">
                <label>title</label>
                <input type="text" class="treeTitle form-control" name="title" placeholder="请输入权限名称">
                <label>icon</label>
                <input type="text" class="treeIcon form-control" name="icon" placeholder="请输入图标的url">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="saveBtnPer" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/includejsp/js.jsp"%>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
        showTree();
    });
    function showTree() {
        let setting = {
            view: {
                selectedMulti: false,
                addDiyDom: function(treeId, treeNode){
                    let icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                    if ( treeNode.icon ) {
                        icoObj.removeClass().addClass(treeNode.icon).css("background","");
                    }
                },
                addHoverDom: addPermissionCoin,
                removeHoverDom:removeHiddenCoin
            },
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "pid",
                },
                key: {
                    name: "title"
                }
            },
        };
        let perList={};
        $.get("${PATH}/permission/showPermissionTree",{},function(result) {
            perList = result;
            let tree = $.fn.zTree.init($("#treeDemo"), setting, perList);
            tree.expandAll(true);
        })
    }
    
    function addPermissionCoin(treeId, treeNode) {
        let aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
        //禁用链接
        aObj.attr("href", "javascript:;");
        //禁用单击事件
        aObj.attr("onclick", "return false;");
        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
        let s = '<span id="btnGroup'+treeNode.tId+'">';
        if ( treeNode.level == 0 ) {
            s += '<a class="addPermission btn btn-info dropdown-toggle btn-xs" myId="'+treeNode.id+'" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
            if (treeNode.children.length == 0) {
                s += '<a class="deletePer btn btn-info dropdown-toggle btn-xs" myTitle="'+treeNode.title+'" myId="'+treeNode.id+'" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
            }
        } else if ( treeNode.level == 1 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
            //由于这个权限菜单没有children属性，treeNode.children是空指针，
            if (treeNode.children.length == 0) {
                s += '<a class="deletePer btn btn-info dropdown-toggle btn-xs" myTitle="'+treeNode.title+'" myId="'+treeNode.id+'" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
            }
            // s += '<a class="addPermission btn btn-info dropdown-toggle btn-xs" myId="'+treeNode.id+'" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
        }
        s += '</span>';
        aObj.after(s);
    
    }
    function removeHiddenCoin(treeId, treeNode) {
         $("#btnGroup"+treeNode.tId).remove();
    }

    //添加许可权限管理
    $("ul").on("click",".addPermission",function () {
        //获取pid。即是点击的id
        // let pid = $(this).attr("myId");
        // alert(pid)
        //弹出模态框，
        $('#addPermissionModal').modal({
            show:true, //展示模态框
            backdrop:"static",//点击其他地方不会关闭模态框
            keyboard:false//esc不关闭模态框
        })
    })
    //点击模态框确定按键
    //获取JOSN数据，pid 发送ajax请求
    $("#saveBtnPer").click(function () {
        //获取pid。即是点击的id
        let pid = $(".addPermission").attr("myId");
        let treeName=$(".treeName").val();
        let treeTitle=$(".treeTitle").val();
        let treeIcon=$(".treeIcon").val();
        let permission = {
            name:treeName,
            title:treeTitle,
            icon:treeIcon,
            pid:pid
        }
        $.get("${PATH}/permission/savePermission",permission,function (result) {
            if (result=="ok"){
                layer.msg("保存成功",{time:1000,coin:6})
                $("#addPermissionModal").modal('hide');
                //刷新页面
                showTree();
            }else{
                layer.msg("保存失败",{time:1000,coin:5})
            }
        })
    })

    //删除按钮
    $("ul").on("click",".deletePer",function (){
        //获取要删除的title
        let title = $(".deletePer").attr("myTitle")
        layer.confirm("你确定删除【"+title+"】",{btn:['确定','删除']},function () {
            //获取要删除的id
            let myId = $(".deletePer").attr("myId")
            $.get("${PATH}/permission/deletePer",{id:myId},function (result) {
                if (result=="ok"){
                    layer.msg("删除成功",{time:1000,coin:5})
                    showTree()
                }else {
                    layer.msg("删除失败",{time:1000,coin:6})
                }
            })
        },function () {
        })
    })

</script>
</body>
</html>

</body>
</html>
