<%--
  Created by IntelliJ IDEA.
  User: QZY
  Date: 2019/12/9
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-部门修改</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
    <script src="/media/layui/layui.js"></script>
    <script type="text/javascript">
        $(function () {
            //获取请求参数
            var json=getData();
            //解码参数值并解析json
            var obj=JSON.parse(decodeURI(json));
            //显示数据
            showData(obj);
        })
        //获取传递的参数信息
        function getData() {
            var url=window.location.search;
            index=url.indexOf("?");
            if(index>-1){
                var str = url.substr(index+1);
                if(str.indexOf('=')){
                    return str.split('=')[1];
                }
            }
            return null;
        }
        //显示数据
        function showData(obj) {
            $("#f1").val(obj.id);
            $("#f2").val(obj.name);
            $("#f3").val(obj.createdate);
            $("#f4").val(obj.week);
            $("#f5").val(obj.type);
        }
    </script>
</head>
<body>

<div class="layui-container" style="margin-top: 5px">
    <form class="layui-form" id="updateCourseForm">
        <div class="layui-form-item">
            <label class="layui-form-label">序号</label>
            <div class="layui-input-block">
                <input type="text" name="id" id="f2" lay-verify="name" autocomplete="off"
                       placeholder="请输入名称" class="layui-input" value="${major.id}" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学科名称</label>
            <div class="layui-input-block">
                <input type="text" name="major_name" id="f2" lay-verify="name" autocomplete="off"
                       placeholder="请输入名称" class="layui-input" value="${major.major_name}">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">成立日期</label>
            <div class="layui-input-block">
                <input type="text" readonly="readonly" id="f3" autocomplete="off" class="layui-input" value="${major.major_date}" name="major_date">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学科周期</label>
            <div class="layui-input-block">
                <input type="text" name="major_time" id="f4" lay-verify="name" autocomplete="off"
                       placeholder="请输入周期" class="layui-input" value="${major.major_time}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学科类型</label>
            <div class="layui-input-block">
                <select name="major_type">
                   <%-- <option value="1">普通</option>
                    <option value="2">精品</option>
                    <option value="3">业余</option>--%>
                    <c:forEach items="${allmajortype}" var="m">
                        <option value="${m.id}" ${m.id==major.major_type?'selected':''}>${m.majortype}</option>
                    </c:forEach>
                </select>
            </div>
        </div>


        <div class="layui-form-item">
            <input class="layui-btn"  style="margin-left: 10%"  type="button" value="确认修改" onclick="updateMajor()">
        </div>
    </form>
</div>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use([ 'form', 'laydate' ],
        function() {
            var form = layui.form, layer = layui.layer, laydate = layui.laydate;

        });
    function updateMajor() {
        $.post("/update_course",$('#updateCourseForm').serialize(),function (data) {
            if (data.status == 200) {
                alert(data.message)
                location.href="/course_list/1/2";
            }else{
                alert(data.message)
            }
        },'json')
    }
</script>
</body>
</html>