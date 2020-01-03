
<%--
  Created by IntelliJ IDEA.
  UserInfo: QZY
  Date: 2019/12/9
  Time: 17:38
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
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
    <form class="layui-form" id="addClassForm">
        <div class="layui-form-item">
            <label class="layui-form-label">班级名称</label>
            <div class="layui-input-block">
                <input type="text" name="className" lay-verify="name" autocomplete="off"
                       placeholder="请输入名称" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级学科</label>
            <div class="layui-input-block">
                <select name="major_id" id="cds">
                    <option value="-1">请选择学科</option>
                    <c:forEach items="${allMajorName}" var="AllMajor">
                        <option value="${AllMajor.id}" }>${AllMajor.major_name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">开班日期</label>
            <div class="layui-input-block">
                <input type="text" name="class_date" id="date" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级周期</label>
            <div class="layui-input-block">
                <input type="text" name="class_time" lay-verify="name" autocomplete="off"
                       placeholder="请输入周期" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级地址</label>
            <div class="layui-input-block">
                <input type="text" name="class_address" lay-verify="name" autocomplete="off"
                       placeholder="请输入地址" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <input class="layui-btn"  style="margin-left: 10%" type="button" value="确认新增" onclick="addClasses()">
        </div>
    </form>
</div>


<script src="/media/layui/layui.js"></script>
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
          //  initData(); //初始化数据  下拉框
        });

    //初始化数据
   /* function initData() {
        $.get("/getClasses_list",null,function(arr){
            for(i=0;i<arr.length;i++){
                $("#cds").append("<option value='"+arr[i].id+"'>"+arr[i].major_name+"</option>");
            }
            form.render("select"); //渲染下拉框
        })
    }*/
    function addClasses() {
        $.post("/add_class",$("#addClassForm").serialize(),function (data) {
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
