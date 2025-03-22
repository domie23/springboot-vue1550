<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="utf-8" %>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="login">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录/Login</title>
    <link rel="stylesheet" href="./layui/css/layui.css">
    <link rel="stylesheet" href="./css/diy.css">
    <script src="./js/axios.min.js"></script>
</head>
<style>
        </style>

<body>
<article class="">
        <div class="warp">
        <div class="layui-container">
            <div class="layui-row">
                <div>
                        <span>
                          <h1>优选农产品销售管理系统</h1>
                        </span>
                </div>
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">账号</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" lay-verify="title" autocomplete="off"
                                   placeholder="用户名 / 手机 / 邮箱"
                                   class="layui-input" id="account">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">密码</label>
                        <div class="layui-input-block">
                            <input type="password" name="password" placeholder="请输入密码" autocomplete="off"
                                   class="layui-input"
                                   id="password">
                        </div>
                    </div>
                                                                            </form>
                <div class="layui-btn-container">
                    <a type="button" class="layui-btn layui-btn-normal" id="login">登录/Login</a>
                                        <a href="./page/forgot.jsp" type="button" class="layui-btn layui-btn-normal">密码找回/Retrieve
                        password</a>
                </div>
            </div>
        </div>
    </div>
</article>
</body>
<script src="./layui/layui.js" charset="utf-8"></script>
    <script src="./js/base.js"></script>
        <script>
    var BaseUrl = baseUrl()
    let btn = document.getElementById("login");
    let account = document.getElementById("account");
    let password = document.getElementById("password");
    
    var tokenReg = new RegExp('(^|&)' + "token" + '=([^&]*)(&|$)', 'i');

    var tokenValue = window.location.search.substr(1).match(tokenReg);

    if (tokenValue != null) {
        let token = unescape(tokenValue[2]);
        tokenLogin(token);
    }

    async function tokenLogin(token){
        const {data: res} = await axios.get(BaseUrl + '/api/user/state',{
            headers: {
                "x-auth-token": token
            }
        })
        if (res && res.result && res.result.obj){
            let obj = JSON.stringify(res.result.obj)
            sessionStorage.setItem('personInfo', [obj])
            sessionStorage.setItem('token', res.result.obj.token)
            window.location.replace("./page/frime.jsp")
        }else{
            if (sessionStorage.personInfo){
                let personInfo = JSON.parse(sessionStorage.personInfo)
                if(personInfo){
                    window.location.replace("./page/frime.jsp");
                }
            }
        }
    }

    // 登录/Login
    let info
    btn.onclick = async function () {
        if (account.value === '') {
            layer.msg('请输入账号');
        } else if (password.value === '') {
            layer.msg('请输入密码');
        }
                                            else {
            const {data: res} = await axios.post(BaseUrl + '/api/user/login?', {
                "username": account.value,
                "password": password.value
            },{
                headers: {
                    "Content-Type": "application/json"
                }
            })
            info = res.result;
            if (info != undefined) {
                let obj = JSON.stringify(res.result.obj)
                sessionStorage.setItem('personInfo', [obj])
                sessionStorage.setItem('token', res.result.obj.token)
                window.location.replace("./page/frime.jsp")
            } else if (res.error.message) {
                layer.msg(res.error.message);
                account.value = ''
                password.value = ''
            }
        }
    }

    async function keyboard(event) {
        let keycode = event.keyCode;
        if (keycode == 13) {
            const {data: res} = await axios.post(BaseUrl + '/api/user/login?', {
                "username": account.value,
                "password": password.value
            },{
                headers: {
                    "Content-Type": "application/json"
                }
            })
            info = res.result;
            if (info != undefined) {
                let obj = res.result.obj;
                sessionStorage.setItem('personInfo', [obj])
                sessionStorage.setItem('token', res.result.obj.token)
                window.location.replace("./page/frime.jsp");
            } else if (res.error.message) {
                layer.msg(res.error.message);
                account.value = ''
                password.value = ''
            }
        }
    }

    //参数1：表示事件，keydown:键盘向下按；参数2：表示触发的事件处理函数
    document.addEventListener("keydown", keyboard);

    // 注册/Register
        
    // 弹出层
    layui.use('layer', function () {
        var layer = layui.layer;
    });
</script>

</html>
