<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-cn">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="media/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="media/css/font-awesome.min.css" media="all">
    <!--使用了JQuery，需要导入JS-->
    <script type="text/javascript" src="media/js/jquery.min.js"></script>

    <script type="application/javascript">
        $(function () {
            $.getJSON("/getLoginlogs",function (result) {
                //alert(JSON.stringify(result));
                for(var i=0;i<result.length;i++){
                    var timeString=result[i].createtime;  // 2019-12-10 10:25:51.0
                    timeString=timeString.substr(0,timeString.length-2);
                    $("#tt").append("<tr><td>"+result[i].no+"</td><td>"+result[i].ip+"</td><td>"+result[i].location+"</td><td>"+timeString+"</td></tr>");
                }
            });
        });
    </script>

    <style>
        .info-box {
            height: 85px;
            background-color: white;
            background-color: #ecf0f5;
        }

        .info-box .info-box-icon {
            border-top-left-radius: 2px;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 2px;
            display: block;
            float: left;
            height: 85px;
            width: 85px;
            text-align: center;
            font-size: 45px;
            line-height: 85px;
            background: rgba(0, 0, 0, 0.2);
        }

        .info-box .info-box-content {
            padding: 5px 10px;
            margin-left: 85px;
        }

        .info-box .info-box-content .info-box-text {
            display: block;
            font-size: 14px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-transform: uppercase;
        }

        .info-box .info-box-content .info-box-number {
            display: block;
            font-weight: bold;
            font-size: 18px;
        }
        .major {
            font-weight: 10px;
            color: #01AAED;
        }
        .main {
            margin-top: 25px;
        }

        .main .layui-row {
            margin: 10px 0;
        }
    </style>
</head>

<body>
<div class="layui-fluid main">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md3">
            <div class="info-box">
					<span class="info-box-icon"
                          style="background-color: #00c0ef !important; color: white;">
						<i class="fa fa-child" ></i></span>
                <div class="info-box-content">在线人数<span
                        class="info-box-number" id="s1">90</span>
                </div>
            </div>
        </div>

        <div class="layui-col-md3">
            <div class="info-box">
					<span class="info-box-icon"
                          style="background-color: #00a65a !important; color: white;"><i
                            class="fa fa-users" aria-hidden="true"></i></span>
                <div class="info-box-content">
                    <span class="info-box-text">员工人数</span> <span
                        class="info-box-number" id="s3">65</span>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="info-box">
					<span class="info-box-icon"
                          style="background-color: #f39c12 !important; color: white;"><i
                            class="fa fa-users" aria-hidden="true"></i></span>
                <div class="info-box-content">
                    <span class="info-box-text">在读班级</span> <span
                        class="info-box-number" id="s4">85</span>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="info-box">
					<span class="info-box-icon"
                          style="background-color: #dd4b39 !important; color: white;"><i
                            class="fa fa-graduation-cap" aria-hidden="true"></i></span>
                <div class="info-box-content">
                    <span class="info-box-text">学员人数</span>
                    <span
                            class="info-box-number" id="s4">85</span>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-row">
        <div class="layui-col-md12" style="text-align: center">
            <h2>你的足迹</h2>
        </div>
    </div>
    <div>
        <table class="layui-table" id="tbdata">
            <thead>
            <tr>
                <td>登录账户</td>
                <td>登录IP</td>
                <td>登录城市</td>
                <td>登录时间</td>
            </tr>
            </thead>
            <tbody id="tt">


            </tbody>
        </table>
    </div>
</div>
</body>

</html>