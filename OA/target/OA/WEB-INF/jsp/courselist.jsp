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
    <title>滴答办公系统-学科列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script src="/media/js/jquery.min.js"></script>
</head>
<body>
<div class="layui-container">
    <table class="layui-table" id="tbdata" lay-filter="tbop">
        <thead>
        <tr>
            <td>序号</td>
            <td>学科名称</td>
            <td>周数</td>
            <td>成立日期</td>
            <td>类型</td>
            <td>操作</td>
        </tr>
        </thead>
        <tbody>
       <c:forEach items="${pageUtils.records}" var="course">
           <tr>
               <td>${course.id}</td>
               <td>${course.major_name}</td>
               <td>${course.major_time}</td>
               <td>${course.major_date}</td>
               <td>${course.majorType.majortype}</td>
               <td><a class="layui-btn layui-btn-mini" href="/update_Course/${course.id}">编辑</a>
                   <a class="layui-btn layui-btn-danger layui-btn-mini" onclick="deleteCourse(${course.id});">删除</a></td>

           </tr>
       </c:forEach>
        </tbody>
    </table>
    <div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
        <a href="/course_list/${pageUtils.pageIndex-1}/${pageUtils.pageSize}"
           class="layui-laypage-prev ${pageUtils.pageIndex==1?'layui-disabled':''}" data-page="0">
            <i class="layui-icon">&lt;</i>
        </a>
        <c:forEach begin="${pageUtils.numberStart}" end="${pageUtils.numberEnd}" var="num" step="1">
            <c:if test="${pageUtils.pageIndex==num}">
                <span style="color:red;font-weight: bold;">${num}</span>
            </c:if>
            <c:if test="${pageUtils.pageIndex!=num}">
                <a href="/course_list/${num}/${pageUtils.pageSize}">${num}</a>
            </c:if>
        </c:forEach>
        <a href="/course_list/${pageUtils.pageIndex+1}/${pageUtils.pageSize}"
           class="layui-laypage-next ${pageUtils.pageIndex==pageUtils.pageCount?'layui-disabled':''}" data-page="2">
            <i class="layui-icon">&gt;</i>
        </a>
        <span class="layui-laypage-skip">到第
							   <input type="text" min="1" id="number" value="${pageUtils.pageCount}" class="layui-input">页
								<button type="button" class="layui-laypage-btn" onclick="ToPage()">确定</button>
							</span>
        <span class="layui-laypage-count">共 ${pageUtils.totalCount} 条</span>
        <span class="layui-laypage-limits">
							    <select lay-ignore="" onchange="PageCount()" id="selectCount">
							        <option value="2" ${pageUtils.pageSize==2?"selected":""}>2 条/页</option>
									<option value="3" ${pageUtils.pageSize==3?"selected":""}>3 条/页</option>
									<option value="5" ${pageUtils.pageSize==5?"selected":""}>5 条/页</option>
									<option value="10" ${pageUtils.pageSize==10?"selected":""}>10 条/页</option>

							</select>
							</span>
    </div>
</div>
<script src="/media/layui/layui.js"></script>

<script type="text/javascript">
    function deleteCourse(id){
        layui.use('table', function() {
            layer.confirm('是否确认删除学科?',function(index) {
            $.getJSON("/delete_course",{"id":id},function (data) {
                if (data.status==200) {
                    layer.msg("删除成功", {icon : 6},function () {
                        window.location.reload();
                    });
                }else {
                    layer.msg("删除失败", {icon : 5});
                }
            })
            });
        });
    }
</script>


</body>
</html>