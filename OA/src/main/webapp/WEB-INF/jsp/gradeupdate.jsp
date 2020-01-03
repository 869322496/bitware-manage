<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  UserInfo: QZY
  Date: 2019/12/14
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-班级修改</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
    <script src="/media/layui/layui.js"></script>
</head>
<body>

<div class="layui-container" style="margin-top: 5px">
    <form class="layui-form" id="updateClassForm">
        <div class="layui-form-item">
            <label class="layui-form-label">班级序号</label>
            <div class="layui-input-block">
                <input type="text" name="id" readonly="readonly" autocomplete="off"
                       class="layui-input" id="f1" value="${classes.id}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级名称</label>
            <div class="layui-input-block">
                <input type="text" name="className" id="f2" lay-verify="name" autocomplete="off"
                       placeholder="请输入名称" class="layui-input" value="${classes.className}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级学科</label>
            <div class="layui-input-block">
                <select name="major_id" id="cds">
                    <c:forEach items="${allMajorName}" var="AllMajor">
                        <option value="${AllMajor.id}" ${AllMajor.id==classes.major_id?'selected':''}>${AllMajor.major_name}</option>
                    </c:forEach>

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">开班日期</label>
            <div class="layui-input-block">
                <input type="text" readonly="readonly" id="f4" autocomplete="off" class="layui-input" value="${classes.class_date}" name="class_date">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级周期</label>
            <div class="layui-input-block">
                <input type="text" name="class_time" id="f5" lay-verify="name" autocomplete="off"
                       placeholder="请输入周期" class="layui-input" value="${classes.class_time}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级地址</label>
            <div class="layui-input-block">
                <input type="text" name="class_address" id="f6" lay-verify="name" autocomplete="off"
                       placeholder="请输入地址" class="layui-input" value="${classes.class_address}">
            </div>
        </div>


        <div class="layui-form-item">
            <input class="layui-btn"  style="margin-left: 10%"  type="button" value="确认修改" onclick="updateGrade()">
        </div>
    </form>
</div>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form;
    layui
        .use(
            [ 'form','upload', 'layedit', 'laydate' ],
            function() {
                form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
                var upload = layui.upload;
            });

    function updateGrade() {
      $.post("/update_class",$('#updateClassForm').serialize(),function (data) {
          if (data.status==200) {
              alert(data.message)
              location.href="/class_list/1/1";
          }else{
              alert(data.message)
          }
      },'json')
    }
</script>
</body>
</html>

