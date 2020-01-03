
<%--
  Created by IntelliJ IDEA.
  UserInfo: QZY
  Date: 2019/12/11
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-员工新增</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script type="text/javascript" src="/media/js/jquery.min.js"></script>
    <script>
        function updateEmp() {
            $.post("/update_emp",$('#updateEmpForm').serialize(),function (data) {
                if (data.status==200) {
                    alert(data.message)
                    location.href="/emp_list/1/1";
                }else{
                    alert(data.message)
                }
            },'json')
        }
        $(function () {
            $.post("/department_list")
        })
    </script>
</head>
<body>
<div class="layui-container" style="margin-top: 5px">
    <form class="layui-form" id="updateEmpForm">
        <div class="layui-form-item">
            <label class="layui-form-label">员工序号</label>
            <div class="layui-input-block">
                <input type="text" name="id" lay-verify="name" autocomplete="off"
                       placeholder="请输入工号" class="layui-input" value="${emp.id}" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">员工工号</label>
            <div class="layui-input-block">
                <input type="text" name="no" lay-verify="name" autocomplete="off"
                       placeholder="请输入工号" id="no1" class="layui-input" value="${emp.no}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">员工姓名</label>
            <div class="layui-input-block">
                <input type="text" name="name" lay-verify="name" autocomplete="off"
                       placeholder="请输入姓名" class="layui-input" value="${emp.name}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-block">
                <select name="did"  id="cds">
                    <c:forEach items="${alldepart}" var="dept">
                        <option value="${dept.id}" ${dept.id==emp.did?'selected':''}>--${dept.name}--</option>
                    </c:forEach>
<%--                    <option value="-1">--${Dept.name==${emp.pass}}--</option>--%>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="男" title="男" ${emp.sex=='男'?'checked':''}>
                <input type="radio" name="sex" value="女" title="女" ${emp.sex=='女'?'checked':''}>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="email" lay-verify="required" placeholder="请输入有效邮箱" autocomplete="off" class="layui-input" value="${emp.email}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" lay-verify="required" placeholder="请输入手机号" autocomplete="off" class="layui-input" value="${emp.phone}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">QQ</label>
            <div class="layui-input-inline">
                <input type="text" name="qq" lay-verify="required" placeholder="请输入QQ号码" autocomplete="off" class="layui-input" value="${emp.qq}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入职日期</label>
            <div class="layui-input-inline">
                <input type="text" name="createdate" id="date" autocomplete="off" class="layui-input" value="${emp.createdate}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">照片</label>
            <button type="button" class="layui-btn" id="upfile">
                <i class="layui-icon">&#xe67c;</i>上传图片
            </button>
            <input type="text" name="photo" id="p1" value="${emp.photo}" hidden="hidden">
            <div class="layui-input-block">
                <img alt="个人一寸照片"  id="img1" width="200px" height="300px" src="/media/upload/${emp.photo}">
            </div>
        </div>
        <div class="layui-form-item">
            <input class="layui-btn"  style="margin-left: 10%"  id="btn1" type="button" value="确认新增" onclick="updateEmp()">
        </div>
    </form>
</div>


<script src="/media/layui/layui.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form;
    layui
        .use(
            [ 'form','upload', 'layedit', 'laydate' ],
            function() {
                form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
                var upload = layui.upload;

                //执行实例
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
                // initData();
            });
    //初始化数据
    <%--function initData() {--%>
    <%--    $.getJSON("/department_list",null,function(arr){--%>
    <%--        for(i=0;i<arr.length;i++){--%>
    <%--            if (arr[i].id===${emp.did}){--%>
    <%--                $("#cds").append("<option selected value='"+arr[i].id+"'>"+arr[i].name+"</option>");--%>
    <%--            }else{--%>
    <%--                $("#cds").append("<option value='"+arr[i].id+"'>"+arr[i].name+"</option>");--%>
    <%--            }--%>

    <%--        }--%>
    <%--        form.render("select");--%>
    <%--    });--%>
    <%--}--%>
</script>
</body>
</html>