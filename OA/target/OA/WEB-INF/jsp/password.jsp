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
    <title>滴答办公系统-班级新增</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
</head>
<body>
<div class="layui-container" style="margin-top: 5px">

    <form class="layui-form" id="updateUserPassword">
        <div class="layui-form-item" hidden>
            <label class="layui-form-label">员工ID</label>
            <div class="layui-input-inline">
                <input type="text" name="id" lay-verify="required"
                       placeholder="请输入身份证号" autocomplete="off" class="layui-input" value="${sessionScope.loginEmp.id}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">原始密码</label>
            <div class="layui-input-block">
                <input type="text" name="name" lay-verify="name" autocomplete="off"
                       placeholder="请输入密码" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-block">
                <input type="password" name="pass" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认新密码</label>
            <div class="layui-input-block">
                <input type="password" name="email" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <input class="layui-btn"  style="margin-left: 10%" type="button" value="确认修改" onclick="updateUserPassword()">
        </div>
    </form>
</div>


<script src="media/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form;
    layui.use([ 'form', 'laydate' ],
        function() {
            form = layui.form, layer = layui.layer, laydate = layui.laydate;
            //日期
            laydate.render({
                elem : '#date'
            });
            
        });
    function updateUserPassword() {
         $.post("/updateUserPassword",$('#updateUserPassword').serialize(),function (data) {
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
