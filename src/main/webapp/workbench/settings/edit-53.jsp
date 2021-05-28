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

    <script type="text/javascript">

        $(function () {

            getUser();

            $("#update").click(function () {

                $.ajax({

                    url: "user/update.do",
                    data: {

                        "name": $.trim($("#name").val()),
                        "loginAct": $.trim($("#loginAct").val()),
                        "loginPwd": $.trim($("#loginPwd").val()),
                        "email": $.trim($("#email").val()),

                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {


                        if (data.success) {

                            //修改成功后
                            //刷新市场活动信息列表（局部刷新）
                            //pageList(1,2);
                            /*

                                修改操作后，应该维持在当前页，维持每页展现的记录数

                             */
                            pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                                , $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                            alert("修改市场活动成功");
                            //关闭修改操作的模态窗口
                            $("#editActivityModal").modal("hide");


                        } else {

                            alert("修改市场活动失败");

                        }


                    }

                })

            })


        })


        function getUser() {

            $.ajax({

                url: "user/getUser.do",
                type: "post",
                dataType: "json",
                success: function (data) {

                    $("#loginAct").val(data.user.loginAct);
                    $("#name").val(data.user.name);
                    $("#loginPwd").val(data.user.loginPwd);
                    $("#email").val(data.user.email);

                }

            })

        }
    </script>

</head>
<body>


<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand">留言薄</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li><a href="workbench/settings/edit-53.jsp">修改信息</a></li>
                <li><a href="index.jsp">留言</a></li>
                <li><a href="user/quit.do">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<h1 class="col-sm-offset-1">修改个人信息</h1>
<div class="container">
    <form id="user" role="form" class="form-horizontal" action="/user/edit-53" method="post">
        <div class="form-group">
            <label class="col-sm-2 control-label">name:</label>
            <div class="col-sm-4">
                <input id="name" name="name" type="text"/>

            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">loginAct:</label>
            <div class="col-sm-4">
                <input id="loginAct" name="loginAct" type="text"/>

            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">loginPwd:</label>
            <div class="col-sm-4">
                <input id="loginPwd" name="loginPwd" type="password"/>

            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">email:</label>
            <div class="col-sm-4">
                <input id="email" name="email" type="text"/>

            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-2">
                <input type="button" id="update" value="提交修改">
            </div>
        </div>
    </form>
</div>
</body>
</html>
