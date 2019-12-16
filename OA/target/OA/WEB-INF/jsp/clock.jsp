<%--
  Created by IntelliJ IDEA.
  User: QZY
  Date: 2019/12/9
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
    <title>jQuery事件日历</title>
    <link rel="stylesheet" href="media/css/calendar.css">
    <style type="text/css">
        html {
            font: 500 14px 'roboto';
            color: #333;
            background-color: #fafafa;
        }
        a {
            text-decoration: none;
        }
        ul, ol, li {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        #demo {
            width: 300px;
            margin: 100px auto;
        }
        p {
            margin: 0;
        }
        #dt {
            margin: 30px auto;
            height: 28px;
            width: 200px;
            padding: 0 6px;
            border: 1px solid #ccc;
            outline: none;
        }
    </style>
</head>
<body>
<div id="demo">
    <div id="ca"></div>
</div>
<script src="media/js/jquery.min.js"></script>
<script src="media/js/calendar.js"></script>
<script>
    $('#ca').calendar({
        width: 320,
        height: 320,
        data: [
            {
                date: '2015/12/24',
                value: 'Christmas Eve'
            },
            {
                date: '2015/12/25',
                value: 'Merry Christmas'
            },
            {
                date: '2016/01/01',
                value: 'Happy New Year'
            }
        ],
        onSelected: function (view, date, data) {
            console.log('view:' + view)
            alert('date:' + date)
            console.log('data:' + (data || 'None'));
        }
    });

    $('#dd').calendar({
        trigger: '#dt',
        zIndex: 999,
        format: 'yyyy-mm-dd',
        onSelected: function (view, date, data) {
            console.log('event: onSelected')
        },
        onClose: function (view, date, data) {
            console.log('event: onClose')
            console.log('view:' + view)
            console.log('date:' + date)
            console.log('data:' + (data || 'None'));
        }
    });
</script>
</body>
</html>