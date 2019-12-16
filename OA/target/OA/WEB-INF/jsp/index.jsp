<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>滴答办公系统-主页</title>
    <link rel="stylesheet" href="../../media/layui/css/layui.css" media="all">
    <!-- <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css"> -->
    <link rel="stylesheet" href="../../media/css/app.css" media="all">
    <link rel="stylesheet" href="../../media/css/font-awesome.min.css">
    <style type="text/css">
        iframe{
            width: 98%;
            height: 98%;
        }
        .layui-tab-item{
            height: 98%;
        }
    </style>
</head>

<body>
<div class="layui-layout layui-layout-admin kit-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">
            <img src="../../media/images/qf_logo.png" style="margin-right: 10px" /><span
                style="font-size: 22px">滴答办公系统</span>
        </div>

        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item kit-side-fold" lay-unselect >
                <a href="javascript:flexible();" title="侧边伸缩">
                    <i class="layui-icon layui-icon-shrink-right" id="LAY_flexible"></i>
                </a>

            </li>
            <li class="layui-nav-item" lay-unselect>
                <a href="/page_index" layadmin-event="refresh" title="刷新">
                    <i class="layui-icon layui-icon-refresh-3"></i>
                </a>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item" style="margin-right: 20px">
                <a href="javascript:showTab(1001,'/page_processlist','待办事项');">待办事项<span class="layui-badge">0</span></a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="../../media/upload/${sessionScope.loginEmp.photo}" class="layui-nav-img">
                    ${sessionScope.loginEmp.name}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:showTab(1001,'/showUserInfo/${sessionScope.loginEmp.id}','我的信息');">我的信息</a></dd>
                    <dd><a href="javascript:showTab(1001,'/showUserPhoto/${sessionScope.loginEmp.id}','更改头像');">更改头像</a></dd>
                    <dd><a href="javascript:showTab(1002,'/page_password','修改密码');">修改密码</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="/user_loginOut">注销</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black ">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-shrink="all" id="lm">
                <li class="layui-nav-item">
                    <a href="javascript:;" id="1"><i class="layui-icon layui-icon-app"></i>&nbsp;我的工具</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'page_clock','我的日历')">&nbsp;&nbsp;&nbsp;&nbsp;我的日历</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(2,'page_weather','天气查询')">&nbsp;&nbsp;&nbsp;&nbsp;天气查询</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(3,'page_map','地图查询')">&nbsp;&nbsp;&nbsp;&nbsp;地图查询</a></dd>
                    </dl>
                </li>

                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" id="1"><i class="fa fa-sitemap"></i>&nbsp;部门管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'/Department_list/1/3','部门列表')">&nbsp;&nbsp;&nbsp;&nbsp;部门列表</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'/page_departadd','部门新增')">&nbsp;&nbsp;&nbsp;&nbsp;部门新增</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" id="1"><i class="layui-icon layui-icon-user"></i>&nbsp;员工管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'/emp_list/1/1','员工列表')">&nbsp;&nbsp;&nbsp;&nbsp;员工列表</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'/page_empadd','员工新增')">&nbsp;&nbsp;&nbsp;&nbsp;员工新增</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" id="1"><i class="fa fa-graduation-cap"></i>&nbsp;专业管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'/course_list/1/2','专业列表')">&nbsp;&nbsp;&nbsp;&nbsp;专业列表</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(2,'/add_Course','专业新增')">&nbsp;&nbsp;&nbsp;&nbsp;专业新增</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" id="1"><i class="fa fa-cube"></i>&nbsp;班级管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'/class_list/1/2','班级列表')">&nbsp;&nbsp;&nbsp;&nbsp;班级列表</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(2,'/getClasses_list','班级新增')">&nbsp;&nbsp;&nbsp;&nbsp;班级新增</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" id="1"><i class="fa fa-user-secret"></i>&nbsp;学生管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" id="2" onclick="showTab(1,'/student_list/1/3','学生列表')">&nbsp;&nbsp;&nbsp;&nbsp;学生列表</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(2,'/page_studentadd','学生新增')">&nbsp;&nbsp;&nbsp;&nbsp;学生新增</a></dd>
                        <dd><a href="javascript:;" id="2" onclick="showTab(3,'/page_studentbatch','学生导入')">&nbsp;&nbsp;&nbsp;&nbsp;学生导入</a></dd>
                    </dl>
                </li>


            </ul>
        </div>
    </div>
    <div class="layui-body" id="container" >
        <!-- 内容主体区域 -->
        <div class="layui-tab" lay-filter="demo" style="width: 100%;height: 90%">
            <ul class="layui-tab-title"></ul>
            <div class="layui-tab-content" style="width: 99%;height: 98%"></div>
        </div>
    </div>

    <div class="layui-footer">
        <p>
            Copyright 2011-2018 <a href="http://www.1000phone.com/"
                                   rel="nofollow" target="_blank" title="千锋互联">北京滴答科技有限公司 Feri
            版权所有</a> 京ICP备12003911号-3 京公网安备11010802011455号
        </p>
    </div>
</div>

<script src="../../media/js/jquery.min.js"></script>
<script src="../../media/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    var element;
    layui.config({
        base: 'media/layui/lay/modules/'
    }).use(['element','app'], function(){
        element = layui.element;
        showTab(20000,"/page_main","首页");
    });
    var tid=-1;
    function showTab(id,u,n) {
        if(tid>0){
            element.tabDelete('demo',tid);
        }
        element.tabAdd('demo', {
            title:n
            ,content: '<iframe data-frameid="'+id+'" scrolling="auto" frameborder="0" src="'+u+'"></iframe>' //支持传入html
            ,id:id
        });
        element.tabChange('demo', id);
        element.render();
        tid=id;
    }

</script>

</body>

</html>