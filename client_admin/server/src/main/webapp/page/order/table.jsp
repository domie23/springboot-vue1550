<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 订单 -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <link rel="stylesheet" href="../../css/diy.css">
</head>

<body>
<div class="section1">
    <!-- 内容主体区域 -->
    <div class="manu order" style="padding: 15px;">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <div>
                    <label class="layui-form-label">订单号</label>
                    <div class="layui-input-block block">
                        <input type="text" name="title" required lay-verify="required" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div>
                    <label class="layui-form-label">商品名称</label>
                    <div class="layui-input-block block">
                        <input type="text" name="title" required lay-verify="required" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div>
                    <label class="layui-form-label">联系人姓名</label>
                    <div class="layui-input-block block">
                        <input type="text" name="title" required lay-verify="required" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div>
                    <label class="layui-form-label">状态</label>
                    <div class="layui-input-block">
                        <select name="interest" lay-filter="order" id="order">
                            <option value=""></option>
                            <option value="1">待付款</option>
                            <option value="2">已付款</option>
                        </select>
                    </div>
                </div>
            </div>
        </form>
        <div class="buts">
            <button type="button" class="layui-btn layui-btn-normal" id="inquire">查询/Query</button>
            <button type="button" class="layui-btn layui-btn-normal" id="reset">重置/Reset</button>
            <button type="button" class="layui-btn layui-btn-normal" id="delete" style="display: none">删除/Del</button>
        </div>
    </div>
    <div class="table">
        <table class="layui-hide" id="ordersList" lay-filter="ordersList"></table>
        <script type="text/html" id="barDemo">
            <button class="layui-btn layui-btn-xs" lay-event="detail">详情/Details</button>
        </script>
    </div>
</div>
</body>
<script src="../../layui/layui.js"></script>
<script src="../../js/axios.min.js" charset="utf-8"></script>
<script src="../../js/index.js"></script>
<script src="../../js/base.js" charset="utf-8"></script>


<script>
    var BaseUrl = baseUrl()
    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , table = layui.table
            , form = layui.form
            , $ = layui.$;

        let personInfo = JSON.parse(sessionStorage.personInfo)
        let user_group = personInfo.user_group
        let use_id = personInfo.user_id

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

        let deletes = document.querySelector("#delete")


        if (user_group == "管理员" || $check_action('/order/table', 'del')) {
            deletes.style.display = "block"
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
                if (o.path === "/forum/table") {
                    console.log(o.path);
                    path1 = o.path
                    $get_power(o.path)
                }
            }
        }

        getpath()

        let token = sessionStorage.token || null
        let url = BaseUrl + '/api/order/get_list?like=0'
        if(user_group==='卖家'){
            url = BaseUrl + "/api/order/get_business_order_list?user_id="+use_id;
        }else {
            if (user_group !== '管理员') {
                url = "/api/order/get_list?user_id=" + use_id;
            }
        }

        // 表单
        table.render({
            elem: '#ordersList'
            , url: url
            , headers: {
                'x-auth-token': token,
                'Content-Type': 'application/json'
            }
            , page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                , groups: 1 //只显示 1 个连续页码
                , first: false //不显示首页
                , last: false //不显示尾页

            }
            , cols: [[
                {type: 'checkbox'}
                , {field: 'title', width: 120, title: '商品名称', sort: true}
                , {field: 'order_number', width: 120, title: '订单号'}
                , {
                    field: 'img',
                    width: 120,
                    title: '商品图片',
                    sort: true,
                    templet: function (d) {return "<div><img src=" + fullUrl(BaseUrl,d.img) + "></div>"}
                }
                , {field: 'price', width: 120, title: '价格', sort: true}
                , {field: 'price_ago', width: 120, title: '原价', sort: true}
                , {field: 'num', width: 120, title: '购买数量', sort: true}
                , {field: 'price_count', width: 120, title: '总价', sort: true}
                , {field: 'contact_name', width: 120, title: '联系人名称', sort: true}
                , {field: 'contact_address', width: 120, title: '联系人地址', sort: true}
                , {field: 'state', width: 120, title: '订单状态', sort: true}
                , {
                    field: 'user_id', width: 120, title: '买家', sort: true, templet:

                        function (d) {
                            let nickname = ""
                            $.ajax({
                                url: BaseUrl + "/api/user/get_list?user_id=" + d.user_id,
                                type: "get",
                                async: false,
                                success: function (data) {
                                    if (typeof data == "string") {
                                        data = JSON.parse(data)
                                        if (data.result !== null) {
                                            nickname = data.result.list[0].nickname
                                        }
                                    } else {
                                        if (data.result !== null) {
                                            nickname = data.result.list[0].nickname
                                        }
                                    }
                                }
                            });
                            return '<span>' + nickname + '</span>'
                        }
                }
                , {
                    field: 'create_time',
                    width: 180,
                    title: '新增时间',
                    sort: true,
                    templet: "<div>{{layui.util.toDateString(d.create_time, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                }
                , {
                    field: 'update_time',
                    width: 180,
                    title: '更新时间',
                    sort: true,
                    templet: "<div>{{layui.util.toDateString(d.update_time, 'yyyy-MM-dd HH:mm:ss')}}</div>"
                }
                , {field: 'operate', width: 180, title: '操作', sort: true, fixed: 'right', toolbar: '#barDemo'}
            ]]
            , page: true,
            request: {
                limitName: 'size'
            },
            response: {
                statusName: 'code', //规定返回/Back的状态码字段为code
                statusCode: 200 //规定成功的状态码味200
            },
            parseData: function (res) {
                return {
                    "code": 200,
                    "msg": "",
                    "count": res.result.count,
                    "data": res.result.list
                }
            },
            where: {like: 0, size: 10}
        });

        // 选择框
        let state
        layui.form.on('select(order)', function (data) {
            // console.log(data.elem[data.elem.selectedIndex].text);
            request['state'] = data.elem[data.elem.selectedIndex].text
        });

        table.on('tool(ordersList)', function (obj) {
            var data = obj.data;
            window.location.href = "./view.jsp?" + data.order_id;
        });

        // 请求参数：
        let request = {
            like: 0,
            size: 10,
            page: 1,
            order_number: '',
            title: '',
            contact_name: '',
            state: state,
            orderby: 'create_time desc'
        }

        // 重置/Reset参数
        let resetName = {like: 0, size: 7, page: 1, orderby: 'create_time desc'}

        // 下拉框的重置/Reset参数
        let resetSelect = ['order']

        fun(
            "ordersList",
            BaseUrl + "/api/order/del",
            "order_id",
            request,
            resetName,
            resetSelect
        );
    })
</script>
</html>
