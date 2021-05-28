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
    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <link rel="shortcut icon" href="image/bitbug_favicon.ico" type="image/x-icon"/>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <script type="text/javascript">

        $(function () {

            init();
            pageList(1, 2);

            //为全选的复选框绑定事件，触发全选操作
            $("#qx").click(function () {

                $("input[name=xz]").prop("checked", this.checked);

            })

            $("#activityBody").on("click", $("input[name=xz]"), function () {

                $("#qx").prop("checked", $("input[name=xz]").length == $("input[name=xz]:checked").length);

            })

            //为保存按钮绑定事件，执行添加操作
            $("#saveBtn").click(function () {

                //找到复选框中所有挑√的复选框的jquery对象
                var $xz = $("input[name=xz]:checked");

                if (confirm("确定修改所选中的留言吗？")) {

                    //拼接参数
                    var param = "";

                    //将$xz中的每一个dom对象遍历出来，取其value值，就相当于取得了需要删除的记录的id
                    for (var i = 0; i < $xz.length; i++) {

                        param += $($xz[i]).val();

                        //如果不是最后一个元素，需要在后面追加一个&符
                        if (i < $xz.length - 1) {

                            param += "&";

                        }

                    }

                    $.ajax({

                        url: "reply/save.do",
                        data: {

                            "reply": $.trim($("#create-reply").val()),
                            "messageId": param


                        },
                        type: "post",
                        dataType: "json",
                        success: function (data) {

                            /*

                                data
                                    {"success":true/false}

                             */
                            if (data.success) {

                                $("#create-reply").val("");
                                //关闭添加操作的模态窗口
                                $("#DetailModal").modal("hide");
                                alert("修改成功");


                            } else {

                                alert("修改失败");

                            }


                        }

                    })


                }


            })

            $("#searchBtn").click(function () {

                $("#hidden-userName").val($.trim($("#search-userName").val()));
                $("#hidden-createTime").val($.trim($("#search-createTime").val()));
                $("#hidden-title").val($.trim($("#search-title").val()));
                $("#hidden-message").val($.trim($("#search-message").val()));
                pageList(1, 2);

            })

            $(".time").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "top-left"
            })

            $("#addMessage").click(function () {

                var title = $.trim($("#messageTitle").val());
                var message = $.trim($("#messageText").val());

                $.ajax({

                    url: "message/add.do",
                    data: {

                        "title": title,
                        "message": message

                    },
                    type: "get",
                    dataType: "json",
                    success: function () {

                        alert("提交成功");
                        $("#messageTitle").val("");
                        $("#messageText").val("");
                        pageList(1, 2);

                    }

                })

            })

            $("#editBtn").click(function () {

                //找到复选框中所有挑√的复选框的jquery对象
                var $xz = $("input[name=xz]:checked");


                if ($xz.length != 1) {

                    alert("请选择需要修改的一条留言");

                } else {


                    //拼接参数
                    var param = "";

                    //将$xz中的每一个dom对象遍历出来，取其value值，就相当于取得了需要删除的记录的id
                    for (var i = 0; i < $xz.length; i++) {

                        param += $($xz[i]).val();

                        //如果不是最后一个元素，需要在后面追加一个&符
                        if (i < $xz.length - 1) {

                            param += "&";

                        }

                    }

                    $.ajax({

                        url: "reply/selectById.do",
                        data: {

                            "messageId":param

                        },
                        type: "post",
                        dataType: "json",
                        success: function (data) {


                            if (data.success) {

                                $("#result").html(data.result + "\n");
                                $("#title").html(data.message);
                                $("#DetailModal").modal("show");

                            } else {

                                alert("权限不足");

                            }

                        }

                    })



                }


            })


            //为删除按钮绑定事件，执行删除操作
            $("#deleteBtn").click(function () {

                //找到复选框中所有挑√的复选框的jquery对象
                var $xz = $("input[name=xz]:checked");

                if ($xz.length == 0) {

                    alert("请选择需要删除的留言");

                    //肯定选了，而且有可能是1条，有可能是多条
                } else {


                    if (confirm("确定删除所选中的留言吗？")) {

                        //拼接参数
                        var param = "";

                        //将$xz中的每一个dom对象遍历出来，取其value值，就相当于取得了需要删除的记录的id
                        for (var i = 0; i < $xz.length; i++) {

                            param += "id=" + $($xz[i]).val();

                            //如果不是最后一个元素，需要在后面追加一个&符
                            if (i < $xz.length - 1) {

                                param += "&";

                            }

                        }

                        $.ajax({

                            url: "message/delete.do",
                            data: param,
                            type: "post",
                            dataType: "json",
                            success: function (data) {

                                /*

                                    data
                                        {"success":true/false}

                                 */
                                if (data.success) {

                                    //删除成功后
                                    alert("删除成功");
                                    //回到第一页，维持每页展现的记录数
                                    pageList($("#activityPage").bs_pagination('getOption', 'currentPage'), $("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                                } else {

                                    alert("删除失败，原因可能是权限不足或者系统崩溃，请联系管理员");

                                }


                            }

                        })


                    }


                }


            })


        })

        function init() {

            $.ajax({
                url: "user/getUser.do",
                type: "post",
                dataType: "json",
                success: function (data) {

                    if (data.user == null) {

                        $("#init").html("<div class=\"col-sm-offset-6\" id=\"init\">\n" +
                            "                您还未登录，请先\n" +
                            "                <a href=\"login.jsp\">登录</a>\n" +
                            "                或\n" +
                            "                <a href=\"workbench/settings/register.jsp\">注册</a>\n" +
                            "            </div>");

                    }

                }
            })

        }

        function pageList(pageNo, pageSize) {
            //将全选的复选框的√干掉
            $("#qx").prop("checked", false);
            //查询前，将隐藏域中保存的信息取出来，重新赋予到搜索框中
            $("#search-userName").val($.trim($("#hidden-userName").val()));
            $("#search-createTime").val($.trim($("#hidden-createTime").val()));
            $("#search-title").val($.trim($("#hidden-title").val()));
            $("#search-message").val($.trim($("#hidden-message").val()));
            $.ajax({
                url: "message/pageList.do",
                data: {
                    "pageNo": pageNo,
                    "pageSize": pageSize,
                    "userName": $.trim($("#search-userName").val()),
                    "createTime": $.trim($("#search-createTime").val()),
                    "title": $.trim($("#search-title").val()),
                    "message": $.trim($("#search-message").val())
                },
                type: "get",
                dataType: "json",
                success: function (data) {
                    var html = "";
                    //每一个n就是每一个留言对象
                    $.each(data.dataList, function (i, n) {
                        html += '<tr class="active">';
                        html += '<td><input type="checkbox" name="xz" value="' + n.id + '"/></td>';
                        html += '<td style="color: red">' + n.userName + '</td>';
                        html += '<td style="color: green">' + n.title + '</td>';
                        html += '<td></td>';
                        html += '<td></td>';
                        html += '</tr>';
                        html += '<tr class="active">';
                        html += '<td></td>';
                        html += '<td style="color: blue;">' + n.createTime + '</td>';
                        html += '<td style="color: black;">' + n.message + '</td>';
                        html += '<td><span class="glyphicon glyphicon-star"></span>1</td>';
                        html += '<td></td>';
                        html += '</tr>';
                    })
                    $("#activityBody").html(html);
                    //计算总页数
                    var totalPages = data.total % pageSize == 0 ? data.total / pageSize : parseInt(data.total / pageSize) + 1;
                    //数据处理完毕后，结合分页插件，对前端展现分页信息
                    $("#activityPage").bs_pagination({
                        currentPage: pageNo, // 页码
                        rowsPerPage: pageSize, // 每页显示的记录条数
                        maxRowsPerPage: 20, // 每页最多显示的记录条数
                        totalPages: totalPages, // 总页数
                        totalRows: data.total, // 总记录条数
                        visiblePageLinks: 3, // 显示几个卡片
                        showGoToPage: true,
                        showRowsPerPage: true,
                        showRowsInfo: true,
                        showRowsDefaultInfo: false,
                        //该回调函数时在，点击分页组件的时候触发的
                        onChangePage: function (event, data) {
                            pageList(data.currentPage, data.rowsPerPage);
                        }
                    });
                }
            })
        }

    </script>
</head>
<body>
<input type="hidden" id="hidden-userName"/>
<input type="hidden" id="hidden-createTime"/>
<input type="hidden" id="hidden-title"/>
<input type="hidden" id="hidden-message"/>

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


<h1 class="col-sm-offset-1">留言簿</h1>
<div class="container">
    <div style="top: -20px" class="col-sm-offset-4 col-sm-4">
        <div class="form-group">
            <div class="col-sm-12">
                <textarea id="messageTitle" name="messageTitle" class="form-control" rows="1"
                          placeholder="标题"></textarea>
            </div>
        </div>
    </div>
    <div style="top: 0px" class="col-sm-offset-1 col-sm-10">
        <div class="form-group">
            <div class="col-sm-12">
                <textarea id="messageText" name="message" class="form-control" rows="3" placeholder="内容"></textarea>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-4 col-sm-8" id="init">

            <input type="button" id="addMessage" class="btn btn-default col-sm-offset-8 submit-top" value="提交留言"/>

        </div>
    </div>
</div>

<div>
    <div style="position: relative; left: 10px; top: -30px;">
        <div class="page-header">

        </div>
    </div>
</div>
<div style="position: relative; top: -50px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 10px; left: 200px;">


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">用户名</div>
                        <input class="form-control" type="text" id="search-userName">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">创建时间</div>
                        <input class="form-control time" type="text" id="search-createTime">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">标题</div>
                        <input class="form-control" type="text" id="search-title"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">内容</div>
                        <input class="form-control" type="text" id="search-message"/>
                    </div>
                </div>


                <button type="button" id="searchBtn" class="btn btn-default">查询</button>


        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: white; height: 50px; position: relative;top: 10px;">

            <div class="btn-group" style="position: relative; top: -80px;">

                <button type="button" class="btn btn-default" id="editBtn"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger" id="deleteBtn"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>

        </div>
        <div style="position: relative;top: -50px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="qx"/></td>
                    <td>用户名/时间</td>
                    <td>标题/内容</td>
                </tr>
                </thead>
                <tbody id="activityBody">

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: -40px;">

            <div id="activityPage"></div>

        </div>

    </div>

</div>

<!-- 模态窗口 -->
<div class="modal fade" id="DetailModal" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="title" align="center"></h4>
            </div>
                <div class="form-control">
                    <label class="col-sm-2 control-label" style="color: red">管理员</label>
                    <div class="col-sm-10">
                        <p id="result" style="white-space: pre"></p>
                    </div>
                    <label class="col-sm-2 control-label" style="top: 20px;">回复</label>
                    <div class="col-sm-7" style="top: 10px">
                        <textarea class="form-control" rows="3" id="create-reply" placeholder="填写回复信息"
                                  style="resize: none"></textarea>
                    </div>
                </div>
            <div class="modal-footer">
                <!--

                    data-dismiss="modal"
                        表示关闭模态窗口

                -->
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveBtn">回复</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
