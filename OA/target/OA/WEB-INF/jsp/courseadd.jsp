<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: QZY
  Date: 2019/12/9
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-学科新增</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
</head>
<body>

<div class="layui-container" style="margin-top: 5px">
    <form class="layui-form" id="addCourseForm">
        <div class="layui-form-item">
            <label class="layui-form-label">学科名称</label>
            <div class="layui-input-block">
                <input type="text" name="major_name" lay-verify="name" autocomplete="off"
                       placeholder="请输入名称" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">成立日期</label>
            <div class="layui-input-block">
                <input type="text" name="major_date" id="date" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学科周期</label>
            <div class="layui-input-block">
                <input type="text" name="major_time" lay-verify="name" autocomplete="off"
                       placeholder="请输入周期" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学科类型</label>
            <div class="layui-input-block">
                <select name="major_type">
                    <c:forEach items="${allMajorType}" var="allmajortype">
                        <option value="${allmajortype.id}">${allmajortype.majortype}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <input class="layui-btn" style="margin-left: 10%" type="button" value="确认新增" onclick="addCourse()">
        </div>
    </form>
</div>


<script src="/media/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(
        [ 'form', 'laydate' ],
        function() {
            var form = layui.form, layer = layui.layer, laydate = layui.laydate;

            //日期
            laydate.render({
                elem : '#date'
            });


            //自定义验证规则
            form.verify({
                title : function(value) {
                    if (value.length < 5) {
                        return '标题至少得5个字符啊';
                    }
                },
                pass : [ /(.+){6,12}$/, '密码必须6到12位' ],
                content : function(value) {
                    layedit.sync(editIndex);
                }
            });
        });
    function addCourse() {
        $.post("/add_course",$('#addCourseForm').serialize(),function (data) {
            if (data.status==200) {
                alert(data.message)
                window.location.reload();
            }else{
                alert(data.message)
            }
        },'json')
    }
</script>
</body>
</html>