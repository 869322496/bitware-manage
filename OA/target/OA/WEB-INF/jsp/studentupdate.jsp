<%--
  Created by IntelliJ IDEA.
  User: QZY
  Date: 2019/12/9
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-学员更新</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
</head>
<body>

<div class="layui-container" style="margin-top: 5px">
    <form class="layui-form" id="updateStudentForm">
        <div class="layui-form-item">
            <label class="layui-form-label">学员序号</label>
            <div class="layui-input-block">
                <input type="text" name="id" lay-verify="name" autocomplete="off"
                       placeholder="请输入姓名" class="layui-input" value="${student.id}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学员学号</label>
            <div class="layui-input-block">
                <input type="text" name="no" lay-verify="name" autocomplete="off"
                       placeholder="请输入学号" id="no1" class="layui-input" value="${student.no}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学员姓名</label>
            <div class="layui-input-block">
                <input type="text" name="name" lay-verify="name" autocomplete="off"
                       placeholder="请输入姓名" class="layui-input" value="${student.name}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属班级</label>
            <div class="layui-input-block">
                <select name="class_id" id="cds">
                    <option value="-1">--请选择班级--</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="男" title="男" ${student.sex=="男"?'checked':''}>
                <input type="radio" name="sex" value="女" title="女" ${student.sex=="女"?'checked':''}>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="email" lay-verify="required"
                       placeholder="请输入有效邮箱" autocomplete="off" class="layui-input" value="${student.email}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" lay-verify="required"
                       placeholder="请输入手机号" autocomplete="off" class="layui-input" value="${student.phone}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">QQ</label>
            <div class="layui-input-inline">
                <input type="text" name="qq" lay-verify="required"
                       placeholder="请输入QQ" autocomplete="off" class="layui-input" value="${student.qq}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">身份证号</label>
            <div class="layui-input-inline">
                <input type="text" name="cardno" lay-verify="required"
                       placeholder="请输入身份证号" autocomplete="off" class="layui-input" value="${student.cardno}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">毕业学校</label>
            <div class="layui-input-inline">
                <input type="text" name="school" lay-verify="required"
                       placeholder="请输入毕业学校" autocomplete="off" class="layui-input" value="${student.school}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学历</label>
            <div class="layui-input-inline">
                <select name="education" >
                    <option value="初中" ${student.education=="初中"?'selected':''}>初中</option>
                    <option value="高中" ${student.education=="高中"?'selected':''}>高中</option>
                    <option value="专科" ${student.education=="专科"?'selected':''}>专科</option>
                    <option value="本科" ${student.education=="本科"?'selected':''}>本科</option>
                    <option value="硕士" ${student.education=="硕士"?'selected':''}>硕士</option>
                    <option value="博士" ${student.education=="博士"?'selected':''}>博士</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出生日期</label>
            <div class="layui-input-inline">
                <input type="text" name="birthday" id="date1" autocomplete="off"
                       class="layui-input" value="${student.birthday}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入学日期</label>
            <div class="layui-input-inline">
                <input type="text" name="createdate" id="date2" autocomplete="off"
                       class="layui-input" value="${student.createdate}">
            </div>
        </div>
        <div class="layui-form-item">
            <input class="layui-btn"  style="margin-left: 10%" id="btn1" type="button"
                   value="确认更新" onclick="update_student()">
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
            //日期
            laydate.render({
                elem : '#date1'
            });
            laydate.render({
                elem : '#date2'
            });
            initData();
        });

    function initData() {
        $.getJSON("/student_getClasses",null,function(arr){
            for(i=0;i<arr.length;i++){
                if (arr[i].id===${student.class_id}){
                    $("#cds").append("<option selected value='"+arr[i].id+"'>"+arr[i].className+"</option>");
                }else{
                    $("#cds").append("<option value='"+arr[i].id+"'>"+arr[i].className+"</option>");
                }

            }
            form.render("select");
        });
    }
    function update_student() {
        $.post("/update_student",$('#updateStudentForm').serialize(),function (data) {
            if (data.status == 200) {
                alert(data.message)
                location.href="/page_index";
            }else{
                alert(data.message)
            }
        },'json')
    }
</script>
</body>
</html>
