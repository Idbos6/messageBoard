<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8"/>
    <link rel="stylesheet" href="static/main.css">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link rel="shortcut icon" href="image/bitbug_favicon.ico" type="image/x-icon" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>

<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand col-sm-offset-1">留言薄</a>
        </div>
    </div>
</nav>
<div class="jumbotron">
    <div class="container">
        <h2 class="col-sm-offset-4">&nbsp;&nbsp;注册</h2>
        <form id="user" role="form" class="form-horizontal" action="user/register.do" method="post">
            <div class="form-group">
                <label class="col-sm-offset-2 col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;名</label>
                <div class="col-sm-4">
                    <input id="name" name="name" type="text" value=""/>

                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-offset-2 col-sm-2 control-label">用户名</label>
                <div class="col-sm-4">
                    <input id="loginAct" name="loginAct" type="text" value=""/>

                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-offset-2 col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;码</label>
                <div class="col-sm-4">
                    <input id="loginPwd" name="loginPwd" type="password" value=""/>

                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-offset-2 col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;箱</label>
                <div class="col-sm-4">
                    <input id="email" name="email" type="text" value=""/>

                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-4 col-sm-4">
                    <input type="submit" class="btn btn-primary btn-lg" role="button" value="注册"/>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>

