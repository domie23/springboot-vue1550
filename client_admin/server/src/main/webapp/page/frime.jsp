<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 框架页面 -->
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <title>优选农产品销售管理系统</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/diy.css">
</head>

<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black" id="echars">
            <a href="./Home.jsp" target="main_self_frame" style="color: white;">
                <i class="layui-icon layui-icon-home"></i>
                主页
            </a>
        </div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
            <li>
                <h1>欢迎使用优选农产品销售管理系统</h1>
            </li>
        </ul>

        
            <ul class="layui-nav layui-layout-right" id="shopping" style="float: right;">
                                                                                                <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                            <a href="./product_information/table.jsp" target="main_self_frame"
                               style="position: relative; z-index: 1;display: none" id="product_information">商品信息</a>
                        </li>
                                                                                                                                                                                                                                                                                                                                    
                <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                    <a href="./goods_type/table.jsp" target="main_self_frame"
                       style="position: relative; z-index: 1;display: none" id="goods_type">分类列表</a>
                </li>

                <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                    <a href="./order/table.jsp" target="main_self_frame"
                       style="position: relative; z-index: 1;display: none" id="order">订单</a>
                </li>
            </ul>
        


                    <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item layui-hide layui-show-md-inline-block"
                    style="float: left; margin-left: 50px;">
                    <a id="websiteHomePage" href="javascript:void(0)">网站首页</a>
            </ul>
            </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test2" id="uls">

                <li class="layui-nav-item" id="userInfo" style="display: block;">
                    <a href="javascript:;">个人资料/Personal Data</a>
                    <dl class="layui-nav-child">
                        <dd><a href="./info.jsp" target="main_self_frame">个人信息</a></dd>
                        <dd><a href="./change_password.jsp" target="main_self_frame">修改密码</a></dd>
                    </dl>
                </li>

                                    <li class="layui-nav-item" id="site" style="display: none;">
                        <a class="" href="javascript:;">公共管理/Public Manage</a>
                        <dl class="layui-nav-child">
                                                            <dd><a href="./slides/table.jsp" target="main_self_frame">轮播图</a></dd>
                                                                                        <dd><a href="./notice/table.jsp" target="main_self_frame">系统公告</a></dd>
                                                                                </dl>
                    </li>
                
                <li class="layui-nav-item" id="userManagement" style="display: none;">
                    <a href="javascript:;">用户管理/User Manage</a>
                    <dl class="layui-nav-child">
                        <dd><a href="./user/table.jsp" target="main_self_frame" id="user">管理员</a></dd>
                                                                                    <dd style="display: none" id="ordinary_users">
                                    <a href="./ordinary_users/table.jsp" target="main_self_frame">普通用户</a>
                                </dd>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            </dl>
                </li>


                                                    
                
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe name="main_self_frame" frameborder="0" id="demoAdmin" src="./Home.jsp"
                style="width: 100%; height: 100%; border-radius: 2px;"></iframe>
    </div>
</div>

<script src="../layui/layui.js"></script>
<script src="../js/index.js"></script>
<script src="../js/base.js"></script>
<script src="../js/axios.min.js"></script>
<script>

    var BaseUrl = baseUrl()
    let personInfo = JSON.parse(sessionStorage.personInfo)
    let user_group = personInfo.user_group

    console.log(personInfo)
                let site = document.querySelector('#site')

                                        async function get_list() {

        // 更多管理请求

        let {data: ren} = await axios.get(BaseUrl + '/api/auth/get_list', {
            params: {
                user_group: personInfo.user_group
            }
        })
        var permissions = ren.result.list
        let list_data = JSON.stringify(permissions)
        sessionStorage.setItem('list_data', [list_data])

        var tables = ren.result.list;
        
        function $get_power(path) {
            var list_data = JSON.parse(sessionStorage.list_data)
            var list = list_data;
            var obj;
            for (var i = 0; i < list.length; i++) {
                var o = list[i];
                if (o.path === path) {
                    obj = o;
                    break;
                }
            }
            return obj;
        }

        /**
         * 用户组是否有这个权限
         * @param {Array} user_group 权限组
         */
        function $check_group(user_group) {
            var list = tables;
            var bl = false;
            for (var i = 0; i < user_group.length; i++) {
                bl = $check_action(user_group[i]);
                if (bl == true) {
                    break;
                }
            }
            return bl;
        }


        function $check_action(path1, action = "get") {
            var o = $get_power(path1);
            if (o && o[action] != 0 && o[action] != false) {
                return true;
            }
            return false;
        }

        var lt = [];
        for (var i = 0; i < tables.length; i++) {
            var o = tables[i];
            if (o.path.indexOf("/table") !== -1) {
                let list = ["exam", "article", "article_type", , "comment", "goods", "order","notice"];
                                                                                                                                    list.push("product_information");
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        list.push("ordinary_users");
                                                                                                                                                                                                                                                                                                                                                                                        if (list.indexOf(o.table_name) === -1) {
                    if ($check_action(o.path)) {
                        lt.push(o);
                    }
                }
            }
        }

        let uls = document.querySelector('#uls')

        for (var i = 0; i <= lt.length - 1; i++) {


            let li = document.createElement('li')
            li.className = 'layui-nav-item'
            li.id = 'more'
            let a = document.createElement('a')
            li.appendChild(a);
            a.innerHTML = lt[i].page_title
            a.href = "." + lt[i].path + ".jsp"
            a.setAttribute("target", 'main_self_frame')
            uls.appendChild(li)

        }

        let userManagement = document.querySelector('#userManagement')
        let user = document.querySelector('#user')

                    let shopping = document.querySelector('#shopping')
                let more = document.querySelectorAll('#more')

        
        if (personInfo.user_group == '管理员') {
                            site.style.display = 'block'
            
            userManagement.style.display = 'block'
                                                                    shopping.style.display = 'block'
            
                        more.forEach((item) => {
                item.style.display = 'block'
            })
        } else {
                            shopping.style.display = 'block'
                        more.forEach((item) => {
                item.style.display = 'block'
            })
        }
        if(user_group == '管理员' || $check_group(['/user/table','/user_group/table','/auth/table'                            ,'/ordinary_users/table'
                                                                                                                                                                                                                ])){
            userManagement.style.display = 'block'
        }
        if(user_group !== '管理员'){
            user.style.display = "none"
        }
                                    let ordinary_users = document.querySelector('#ordinary_users')
                if(user_group == '管理员' || $check_action('/ordinary_users/table')){
                        ordinary_users.style.display = "block"
                }else {
                        ordinary_users.style.display = "none"
                }
                                                                                                                                                                                                        
        // 权限判断
        /**
         * 获取路径对应操作权限 鉴权
         * @param {String} action 操作名
         */
        function $check_action(path1, action = "get") {
            var o = $get_power(path1);
            if (o && o[action] != 0 && o[action] != false) {
                return true;
            }
            return false;
        }

        /**
         * 获取页面标题
         * @param {String} path 路由路径
         */
        function $page_title(path) {
            var o = $get_power(path);
            if (o) {
                return o.page_title || o.mod_name;
            }
            return "";
        }
                    let order = document.querySelector("#order")
            let goods_type = document.querySelector("#goods_type")
                                                                                                            let product_information = document.querySelector("#product_information")
                                                                                                                                                                                                                                                                                                                                                
            if (user_group == "管理员" || $check_action('/order/table')) {
                order.style.display = "block"
                if ($page_title('/order/table')) {
                    order.innerHTML = $page_title('/order/table')
                }
            }
            if (user_group == "管理员" || $check_action('/goods_type/table')) {
                goods_type.style.display = "block"
                if ($page_title('/goods_type/table')) {
                    goods_type.innerHTML = $page_title('/goods_type/table')
                }
            }

        
                            
        if ($check_group(['/article/table', '/article_type/table', '/exam/table']) || $check_action('/forum/table') || $check_action('/forum_type/table') || $check_action('/article/table') || $check_action('/article_type/table') || $check_action('/exam/table')) {
            content.style.display = "block"
        }

                                                                                    if (user_group == "管理员" || $check_action('/product_information/table')) {
                            product_information.style.display = "block"
                    }
                                                                                                                                                                                                                                                                    
        /**
         * 获取权限
         * @param {String} path 路由路径
         */
        function $get_power(path) {
            var list_data = JSON.parse(sessionStorage.list_data)
            var list = list_data;
            var obj;
            for (var i = 0; i < list.length; i++) {
                var o = list[i];
                if (o.path === path) {
                    obj = o;
                    break;
                }
            }
            return obj;
        }

        var path1

        function getpath() {
            var list_data = JSON.parse(sessionStorage.list_data)
            for (var i = 0; i < list_data.length; i++) {
                var o = list_data[i];
                if (o.path === "/order/table") {

                    path1 = o.path
                        $get_power(o.path)
                }
                if (o.path === "/goods_type/table") {

                    path1 = o.path
                        $get_power(o.path)
                }
                                                                                                                                    if (o.path === "/product_information/table") {

                                path1 = o.path
                                    $get_power(o.path)
                            }
                                                                                                                                                                                                                                                                                                                                                                                                                            
            }
        }

        getpath()

        layui.element.render('nav', 'test2')
        return lt
    }

    setTimeout(() => {
        let li = document.createElement('li')
        li.className = 'layui-nav-item'
        li.id = 'quit'
        let a = document.createElement('a')
        a.innerHTML = '退出/Exit'
        li.appendChild(a);
        uls.appendChild(li)

        layui.element.render('nav', 'test2')
    }, 200)

    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element
                , layer = layui.layer
                , util = layui.util
                , $ = layui.$;

        element.on("nav(test2)", function () {
            if ($(this).context.innerHTML == '退出/Exit') {
                let {data: res} = axios.get(BaseUrl + '/api/user/quit',{
                    headers: {
                        "x-auth-token": sessionStorage.token
                    }
                })
                window.location.replace("../login.jsp")
                sessionStorage.clear()
            }
        });
    });

    get_list()

    let websiteHomePage = document.querySelector('#websiteHomePage')
    websiteHomePage.onclick = function () {
        if (sessionStorage && sessionStorage.token){
            location.href = "http://localhost:8081/?token="+sessionStorage.token;
        }else {
            location.href = "http://localhost:8081/"
        }
    }
</script>
</body>

</html>
