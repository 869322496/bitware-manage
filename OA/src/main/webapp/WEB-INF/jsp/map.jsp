<%--
  Created by IntelliJ IDEA.
  User: QZY
  Date: 2019/12/9
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>jQuery高德地图api</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css">
    <script src="media/js/jquery.min.js"></script>
    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <script src="http://webapi.amap.com/maps?v=1.3&key=c93e1e293e5b1c3dc581f3ff633144d3&plugin=AMap.Autocomplete,AMap.PlaceSearch,AMap.Walking,AMap.Riding"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <link rel="stylesheet" href="media/css/style.css">
</head>
<body><script src="/demos/googlegg.js"></script>
<div id="myPageTop">
    <a href="javascript:void(0);" id="show">
        路线工具（展开/收缩）
    </a>
    <div class="pageShow">
        <h3>搜索地址</h3>
        <input id="tipinput" placeholder="模糊地址搜索">
        <h3>搜索行车路径</h3>
        <input id="star" placeholder="行车开始地址">
        <span>—&nbsp;—</span>
        <input id="end" placeholder="行车结束地址">
        <span>—&nbsp;—</span>
        <a id="car" href="javascript:void(0);">
            点击搜索
        </a>

        <h3>搜索骑行路径</h3>
        <input id="cStar" placeholder="骑行开始地址">
        <span>—&nbsp;—</span>
        <input id="cEnd" placeholder="骑行结束地址">
        <span>—&nbsp;—</span>
        <a id="riding" href="javascript:void(0);">
            点击搜索
        </a>

        <h3>搜索步行路径</h3>
        <input id="wStar" placeholder="步行开始地址">
        <span>—&nbsp;—</span>
        <input id="wEnd" placeholder="步行结束地址">
        <span>—&nbsp;—</span>
        <a id="walk" href="javascript:void(0);">
            点击搜索
        </a>
        <div style="margin:20px 0;">
            <a id="box" href="javascript:void(0);">
                鼠标右键拖取选框放大地图
            </a>
            <a id="meter" href="javascript:void(0);">
                测量距离
            </a>
        </div>
    </div>
</div>
<div id="container"></div>
<div id="panel"></div>
<script src="media/js/main.js"></script>
</body>
</html>
