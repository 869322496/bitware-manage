<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>滴答办公系统-学员列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/media/layui/css/layui.css" media="all">
    <script src="/media/js/jquery.min.js"></script>

    <script type="text/javascript">

        /**
         * 动态修改页面大小
         */
        function goPage(select) {
            var pageSize = $(select).val();
            var url="/student_list/1/" + pageSize;
            $("#ff").prop("action",url);
            $("#ff").submit(); //提交表单
        }

        /**
         * 跳转页码
         */
        function jumpPage() {
            var number = $("#number").val();
            if (number <= 0) {
                number = 1;
            } else if (!(/(^[1-9]\d*$)/.test(number))) {
                alert("输入的页码非法！");
                $("#number").val("");
                $("#number").focus();
                return;//终止
            } else if (number >${pageUtils.pageCount}) {
                number =${pageUtils.pageCount};
            }
            toPage(number);
        }

        //使用JS提交表单
        function toPage(pageIndex) {
            var url="/student_list/"+pageIndex+"/${pageUtils.pageSize}";
            $("#ff").prop("action",url);
            $("#ff").submit();
        }

        //导出Excel
        function exportExcel() {
            //通过JS提交表单
            var url="/student_exportExcel";
            $("#ff").prop("action",url);
            $("#ff").submit(); //提交表单
        }

        function queryStudent() {
            var url="/student_list/1/${pageUtils.pageSize}";
            $("#ff").prop("action",url);
            $("#ff").submit(); //提交表单
        }

    </script>

</head>
<body>
<div class="layui-container">
    <div class="layui-row" style="margin-top: 10px">
        <form action="/student_list/1/${pageUtils.pageSize}" method="post" id="ff">
            <div class="layui-col-xs3" style="margin-right: 20px">
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">姓名：</label>
                    <div class="layui-input-block">
                        <input type="text" name="name" value="${requestScope.name}" id="no" class="layui-input" placeholder="学生姓名">
                    </div>
                </div>
            </div>
            <div class="layui-col-xs3" style="margin-right: 20px">
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">班级：</label>
                    <div class="layui-input-block">
                        <select class="layui-input" id="cds" name="class_id" value="${requestScope.class_id}">

                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs2">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button type="button" class="layui-btn"><i class="layui-icon layui-icon-search" onclick="queryStudent();">搜索</i></button>
                    </div>
                </div>
            </div>
        </form>
        <div class="layui-col-xs2">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <a class="layui-btn layui-btn-mini layui-btn-mini" href="javascript:exportExcel();" lay-event="detail">导出Excel</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="layui-container">
    <table class="layui-table" id="tbdata" lay-filter="tbop">
        <thead>
        <tr>
            <td>学号</td>
            <td>姓名</td>
            <td>班级</td>
            <td>性别</td>
            <td>手机号</td>
            <td>邮箱</td>
            <td>操作</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageUtils.records}" var="student">
            <tr>
                <td>${student.id}</td>
                <td>${student.name}</td>
                <td>${student.classes.className}</td>
                <td>${student.sex}</td>
                <td>${student.phone}</td>
                <td>${student.email}</td>
                <td><a class="layui-btn layui-btn-mini" href="/update_Student/${student.id}">编辑</a>
                    <a class="layui-btn layui-btn-mini layui-btn-mini" href="/student_details/${student.id}" lay-event="detail">查看详情</a>
                    <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del" onclick="deleteStudent(${student.id});">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
        <a href="javascript:toPage(${pageUtils.pageIndex-1})"
           class="layui-laypage-prev ${pageUtils.pageIndex==1?'layui-disabled':''}" data-page="0">
            <i class="layui-icon">&lt;</i>
        </a>

        <c:forEach begin="${pageUtils.numberStart}" end="${pageUtils.numberEnd}" var="num" step="1">
            <c:if test="${pageUtils.pageIndex==num}">
                <span style="color:red;font-weight: bold;">${num}</span>
            </c:if>
            <c:if test="${pageUtils.pageIndex!=num}">
                <a href="javascript:toPage(${num})">${num}</a>
            </c:if>
        </c:forEach>

        <a href="javascript:toPage(${pageUtils.pageIndex+1})"
           class="layui-laypage-next ${pageUtils.pageIndex==pageUtils.pageCount?'layui-disabled':''}" data-page="2">
            <i class="layui-icon">&gt;</i>
        </a>
        <span class="layui-laypage-skip">到第
							   <input type="text" id="number" min="1" value="${pageUtils.pageIndex}"
                                      class="layui-input">页
								<button type="button" class="layui-laypage-btn" onclick="jumpPage();">确定</button>
							</span>
        <span class="layui-laypage-count">【当前${pageUtils.pageIndex}/${pageUtils.pageCount}】</span>
        <span class="layui-laypage-limits">
							    <select lay-ignore="" onchange="goPage(this);">
							        <option value="5" ${pageUtils.pageSize==5?"selected":""}>5 条/页</option>
									<option value="10" ${pageUtils.pageSize==10?"selected":""}>10 条/页</option>
									<option value="20" ${pageUtils.pageSize==20?"selected":""}>20 条/页</option>
									<option value="30" ${pageUtils.pageSize==30?"selected":""}>30 条/页</option>
									<option value="40" ${pageUtils.pageSize==40?"selected":""}>40 条/页</option>
							     </select>
        </span>
        <span class="layui-laypage-count">共${pageUtils.totalCount}条</span>
    </div>
</div>

<script src="/media/layui/layui.js"></script>

<script type="text/javascript">
    function deleteCourse(){
        layui.use('table', function() {
            layer.confirm('是否确认删除学生?',function(index) {
                layer.msg("删除成功", {icon : 6});
                layer.msg("删除失败", {icon : 5});
            });
        });
    }

    $(function () {
        $.getJSON("/student_getClasses",null,function(arr){
            $("#cds").append("<option value='0'>--请选择班级--</option>");
            for(i=0;i<arr.length;i++){
                if(arr[i].id==${requestScope.class_id}){
                    $("#cds").append("<option selected value='"+arr[i].id+"'>"+arr[i].className+"</option>");
                }else{
                    $("#cds").append("<option value='"+arr[i].id+"'>"+arr[i].className+"</option>");
                }
            }
        });
    });

    function deleteStudent(id){
        layui.use('table', function() {
            layer.confirm('是否确认删除该学生?',function(index) {
                $.getJSON("/delete_student",{"id":id},function (data) {
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