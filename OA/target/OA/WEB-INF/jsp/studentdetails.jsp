   <%--
  Created by IntelliJ IDEA.
  UserInfo: QZY
  Date: 2019/12/9
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-学员详细</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
</head>
<body>
<div class="layui-container" style="margin-top: 5px">
    <form class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">学员姓名</label>
            <div class="layui-input-block">
                <div class="layui-form-mid layui-word-aux">${studentById.name}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属班级</label>
            <div class="layui-input-block">
                <div class="layui-form-mid layui-word-aux">${studentById.classes.className}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <div class="layui-form-mid layui-word-aux">${studentById.sex}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.email}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.phone}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">QQ</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.qq}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">身份证号</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.cardno}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">毕业学校</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.school}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学历</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.education}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出生日期</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.birthday}</div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入学日期</label>
            <div class="layui-input-inline">
                <div class="layui-form-mid layui-word-aux">${studentById.createdate}</div>
            </div>
        </div>
    </form>
</div>


<script src="media/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form;
    layui.use(
        [ 'form','upload', 'layedit', 'laydate' ],
        function() {
            form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
            var upload = layui.upload;
            //日期
            laydate.render({
                elem : '#date1'
            });
            laydate.render({
                elem : '#date2'
            });
            initData();
        });
    $("#cds").html(s);
    var s="<option value="-1">--请选择班级--</option>";
    for(var i=0;i<result.length;i++){

        s=s+"<option value='"+result[i].id+"'>"+result[i].name+"</option>";
</script>
</body>
</html>
