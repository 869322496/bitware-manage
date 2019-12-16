<%--
  Created by IntelliJ IDEA.
  User: QZY
  Date: 2019/12/9
  Time: 17:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-修改头像</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
</head>
<body>
<div class="layui-container" style="margin-top: 5px">
    <form class="layui-form" id="updateUserPhotoForm" enctype="multipart/form-data">
        <div class="layui-form-item" hidden>
            <label class="layui-form-label">员工ID</label>
            <div class="layui-input-block">
                <input type="text" name="id" lay-verify="name" autocomplete="off"
                       placeholder="请输入名称" class="layui-input" hidden="hidden" value="${user.id}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">头像</label>
            <div class="layui-input-block">
                <div class="layui-form-mid layui-word-aux">
                    <img src="/media/upload/${user.photo}" style="width: 200px;height: 250px"/>
                </div>
            </div>
        </div>
       <%-- <div class="layui-form-item">
            <label class="layui-form-label">选择文件</label>
            <div class="layui-input-block">
                <input type="file" name="mFile" id="no1" class="layui-input">
            </div>
        </div>--%>
        <div class="layui-form-item">
            <label class="layui-form-label">照片</label>
            <button type="button" class="layui-btn" id="upfile">
                <i class="layui-icon">&#xe67c;</i>上传图片
            </button>
            <input type="text" name="photo" id="p1" hidden="hidden">
            <div class="layui-input-block">
                <img alt="个人一寸照片"  id="img1" width="200px" height="300px">
            </div>
        </div>
        <div class="layui-form-item">
            <input class="layui-btn" style="margin-left: 10%"  id="btn1" type="button" value="确认导入" onclick="updateUserPhoto()">
        </div>
    </form>
</div>


<script src="/media/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form;
    layui.use(
        [ 'form','upload', 'layedit', 'laydate' ],
        function() {
            form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
            var upload = layui.upload;
            var uploadInst = upload.render({
                elem: '#upfile' //绑定元素
                ,url: '/photoUpload' //上传接口
                ,done: function(obj){
                    //上传完毕回调
                    console.log(obj);
                    if(obj.status==200){
                        $("#p1").val(obj.message);
                        $("#img1")[0].src="/media/upload/"+obj.message;
                        $("#btn1").attr("disabled",false);
                    }

                }
                ,error: function(){
                    //请求异常回调
                }
            });
            //日期
            laydate.render({
                elem : '#date1'
            });
            laydate.render({
                elem : '#date2'
            });
        });

    function updateUserPhoto() {
        $.post("/user_changePhoto",$("#updateUserPhotoForm").serialize(),function (data) {
            if (data.status==200) {
                alert(data.message)
                parent.location.href="/page_index";
            }else{
                alert(data.message)
            }
        },'json')
    }
</script>
</body>
</html>
