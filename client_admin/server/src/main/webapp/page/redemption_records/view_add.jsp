<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 新增/Add -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <link rel="stylesheet" href="../../css/diy.css">
    <script src="../../js/axios.min.js"></script>

    <style>
        img {
            width: 200px;
        }
    </style>
</head>

<body>
<article class="sign_in">
    <div class="warp">
        <div class="layui-container">
            <div class="layui-row">
                <form class="layui-form" action="">
                                                                                                        <div class="layui-form-item" id="exchange_number_box">
                                            <label class="layui-form-label">兑换号</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入兑换号"
                                                       class="layui-input" id="exchange_number">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="product_number_box">
                                            <label class="layui-form-label">商品编号</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入商品编号"
                                                       class="layui-input" id="product_number">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="product_name_box">
                                            <label class="layui-form-label">商品名称</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入商品名称"
                                                       class="layui-input" id="product_name">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="product_type_box">
                                            <label class="layui-form-label">商品类型</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入商品类型"
                                                       class="layui-input" id="product_type">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="product_specifications_box">
                                            <label class="layui-form-label">商品规格</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入商品规格"
                                                       class="layui-input" id="product_specifications">
                                            </div>
                                        </div>
                                                                                                                    <div class="layui-form-item" id="required_points_box">
                                        <label class="layui-form-label">所需积分</label>
                                        <div class="layui-input-block">
                                            <input type="number" name="num" class="layui-input num" id="required_points">
                                        </div>
                                    </div>
                                                                                                    <div class="layui-form-item" id="redemption_date_box">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">兑换日期</label>
                                            <div class="layui-input-inline">
                                                <input type="text" class="layui-input" id="redemption_date"
                                                       placeholder="yyyy-MM-dd">
                                            </div>
                                        </div>
                                    </div>
                                                                                                                                                <div class="layui-form-item" id="ordinary_users_box">
                                                <label class="layui-form-label">普通用户</label>
                                                <div class="layui-input-block">
                                                    <select name="interest" lay-filter="ordinary_users"
                                                            id="ordinary_users">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                                                                    
        
    
    
    
                    </form>
                <div class="layui-btn-container">
                    <a href="#" type="button" class="layui-btn layui-btn-normal login" id="submit" >确认/Confirm</a>
                    <a href="./table.jsp" target="main_self_frame" type="button"
                       class="layui-btn layui-btn-normal login">取消/Cancel</a>
                </div>
            </div>
        </div>
    </div>
</article>
</body>
<script src="../../layui/layui.js"></script>
<script src="../../js/base.js"></script>
<script src="../../js/index.js"></script>
<script>
    var BaseUrl = baseUrl()
    let redemption_records_id = location.search.substring(1)
    layui.use(['upload', 'element', 'layer', 'laydate', 'layedit'], function () {
        var $ = layui.jquery
                , upload = layui.upload
                , element = layui.element
                , layer = layui.layer
                , laydate = layui.laydate
                , layedit = layui.layedit
                , form = layui.form;

        let url

        let token = sessionStorage.token || null
        let personInfo = JSON.parse(sessionStorage.personInfo)
        let user_group = personInfo.user_group
        let use_id = personInfo.user_id

        function  $get_stamp() {
            return new Date().getTime();
        }

        function  $get_rand(len) {
            var rand = Math.random();
            return Math.ceil(rand * 10 ** len);
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
             * 是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             */
            function $check_field(action, field, path1) {
                var o = $get_power(path1);
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
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

        let submit = document.querySelector('#submit')
        // 提交按钮校验权限
        // if (   user_group == "管理员" ||$check_action('/redemption_records/view', 'add') || $check_action('/redemption_records/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "redemption_records_id";
            let url_add = "redemption_records";
            let url_set = "redemption_records";
            let url_get_obj = "redemption_records";
            let url_upload = "redemption_records"
            let query = {
                "redemption_records_id": 0,
            }

            let form_data2 = {
                                        "exchange_number": $get_stamp(), // 兑换号
                            "product_number":  '', // 商品编号
                            "product_name":  '', // 商品名称
                            "product_type":  '', // 商品类型
                            "product_specifications":  '', // 商品规格
                            "required_points":  0, // 所需积分
                            "redemption_date":  '', // 兑换日期
                                "ordinary_users": 0, // 普通用户
                                    "redemption_records_id": 0, // ID
                                                    "user_id": 0,
                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/redemption_records/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/redemption_records/table") {
                        path1 = o.path
                            $get_power(o.path)
                    }
                }
            }

            getpath()

            /**
             * 注册时是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             * @param {String} path 路径
             */
            function $check_register_field(action, field, path1) {
                var o = $get_power(path1);
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
            }

            /**
             * 是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             */
            function $check_field(action, field) {
                var o = $get_power("/redemption_records/view");
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
            }

            /**
             * 获取路径对应操作权限 鉴权
             * @param {String} action 操作名
             */
            function $check_exam(path1, action = "get") {
                var o = $get_power(path1);
                if (o) {
                    var option = JSON.parse(o.option);
                    if (option[action])
                        return true
                }
                return false;
            }

            /**
             * 是否有审核字段的权限
             */
            function $check_examine() {
                var url = window.location.href;
                var url_ = url.split("/")
                var pg_url = url_[url_.length - 2]
                let path = "/"+ pg_url + "/table"
                var o = $get_power(path);
                if (o){
                    var option = JSON.parse(o.option);
                    if (option.examine)
                        return true
                }
                return false;
            }

                            if (user_group === '管理员') {
                    $("#exchange_number_box").show()
                } else {
                    if ($check_field('add', 'exchange_number')){
                        $("#exchange_number_box").show()
                    }else {
                        $("#exchange_number_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#product_number_box").show()
                } else {
                    if ($check_field('add', 'product_number')){
                        $("#product_number_box").show()
                    }else {
                        $("#product_number_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#product_name_box").show()
                } else {
                    if ($check_field('add', 'product_name')){
                        $("#product_name_box").show()
                    }else {
                        $("#product_name_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#product_type_box").show()
                } else {
                    if ($check_field('add', 'product_type')){
                        $("#product_type_box").show()
                    }else {
                        $("#product_type_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#product_specifications_box").show()
                } else {
                    if ($check_field('add', 'product_specifications')){
                        $("#product_specifications_box").show()
                    }else {
                        $("#product_specifications_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#required_points_box").show()
                } else {
                    if ($check_field('add', 'required_points')){
                        $("#required_points_box").show()
                    }else {
                        $("#required_points_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#redemption_date_box").show()
                } else {
                    if ($check_field('add', 'redemption_date')){
                        $("#redemption_date_box").show()
                    }else {
                        $("#redemption_date_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#ordinary_users_box").show()
                } else {
                    if ($check_field('add', 'ordinary_users')){
                        $("#ordinary_users_box").show()
                    }else {
                        $("#ordinary_users_box").hide()
                    }
                }
            
                                                                                                                                                                                                                                                                                    
            
            
            
            
            
            
            
            
    
                                                                                                                    
                            
                            
                            
                            
                            
                                                // 日期选择
                    laydate.render({
                        elem: '#redemption_date'
                        , format: 'yyyy-MM-dd'
                        , done: function (value) {
                            form_data2.redemption_date = value + ' 00:00:00'
                        }
                    });
                
                            
                    
    
                    
                            
                            
                            
                            
                            
                            
                            
                            async function list_ordinary_users() {
                        var ordinary_users = document.querySelector("#ordinary_users")
                        var op1 = document.createElement("option");
                        op1.value = '0'
                            ordinary_users.appendChild(op1)
                        // 收集数据 长度
                        var count
                        // 收集数据 数组
                        var arr = []
                        $.ajax({
                            url: BaseUrl + '/api/user/get_list?user_group=普通用户',
                            type: 'GET',
                            contentType: 'application/json; charset=UTF-8',
                            async: false,
                            dataType: 'json',
                            success: function (response) {
                                count = response.result.count
                                arr = response.result.list
                            }
                        })
                        for (var i = 0; i < arr.length; i++) {
                            var op = document.createElement("option");
                            // 给节点赋值
                            op.innerHTML = arr[i].username + "--" + arr[i].nickname
                            op.value = arr[i].user_id
                            // 新增/Add节点
                            ordinary_users.appendChild(op)
                            if (form_data2.ordinary_users==arr[i].ordinary_users){
                                op.selected = true
                            }
                            layui.form.render("select");
                        }
                    }

                    layui.form.on('select(ordinary_users)', function (data) {
                        form_data2.ordinary_users = Number(data.elem[data.elem.selectedIndex].value);
                    })
                    list_ordinary_users()
                            
                                //文本
                    let exchange_number = document.querySelector("#exchange_number")
                        exchange_number.onkeyup = function (event) {
                        form_data2.exchange_number = event.target.value
                    }
                    //文本
                                                                                //文本
                    let product_number = document.querySelector("#product_number")
                        product_number.onkeyup = function (event) {
                        form_data2.product_number = event.target.value
                    }
                    //文本
                                                                                //文本
                    let product_name = document.querySelector("#product_name")
                        product_name.onkeyup = function (event) {
                        form_data2.product_name = event.target.value
                    }
                    //文本
                                                                                //文本
                    let product_type = document.querySelector("#product_type")
                        product_type.onkeyup = function (event) {
                        form_data2.product_type = event.target.value
                    }
                    //文本
                                                                                //文本
                    let product_specifications = document.querySelector("#product_specifications")
                        product_specifications.onkeyup = function (event) {
                        form_data2.product_specifications = event.target.value
                    }
                    //文本
                                                                                                //数字
                    let required_points = document.querySelector("#required_points")
                        required_points.onkeyup = function (event) {
                        form_data2.required_points = Number(event.target.value)
                    }
                    //数字
                                                                                                                                                                    exchange_number.value = form_data2.exchange_number
                        $("#exchange_number").attr("disabled", "disabled");
                                                                                                                                                                                                                                                                var data = sessionStorage.data || ''
            if (data !== '') {
                var data2 = JSON.parse(data)
                Object.keys(form_data2).forEach(key => {
                    Object.keys(data2).forEach(dbKey => {
                        if (key === dbKey) {
                            if (key!=='examine_state' && key!=='examine_reply'){
                                $('#' + key).val(data2[key])
                                form_data2[key] = data2[key]
                                $('#' + key).attr('disabled', 'disabled')
                                        
                                    
                                    
                                    
                                    
                                    
                                    
                                                                            for (let key in form_data2) {
                                            if (key == 'ordinary_users') {
                                                let alls = document.querySelector('#ordinary_users').querySelectorAll('option')
                                                let test = form_data2[key]
                                                for (let i = 0; i < alls.length; i++) {
                                                    layui.form.render("select");
                                                    if (alls[i].value == test) {
                                                        alls[i].selected = true
                                                        form_data2.ordinary_users = alls[i].value
                                                        layui.form.render("select");
                                                    }
                                                }
                                            }
                                        }
                                    
                                                        }
                        }
                    })
                })
                sessionStorage.removeItem("data");
            }
                                                                                                                                                async function axios_get_4() {
                            if(user_group !='管理员'){
                                const {data: rese} = await axios.get(BaseUrl + '/api/user/get_list?user_group=' + user_group)
                                let data = rese.result.list

                                const {data: ress} = await axios.get(BaseUrl + '/api/user_group/get_obj?name=' + user_group)
                                const {data: res} = await axios.get(BaseUrl + '/api/' + ress.result.obj.source_table + '/get_obj?user_id=' + use_id)
                                Object.keys(form_data2).forEach(key => {
                                    Object.keys(res.result.obj).forEach(dbKey => {
                                        if (key === dbKey) {
                                            if (key!=='examine_state' && key!=='examine_reply'){
                                                $('#' + key).val(res.result.obj[key])
                                                form_data2[key] = res.result.obj[key]
                                                $('#' + key).attr('disabled', 'disabled')
                                            }
                                        }
                                    })
                                })

                                for (let key in res.result.obj) {
                                    if (key == 'user_id') {
                                        let alls = document.querySelector('#ordinary_users').querySelectorAll('option')
                                        let test = res.result.obj.user_id
                                        for (let i = 0; i < alls.length; i++) {
                                            if (alls[i].value == test) {
                                                alls[i].selected = true
                                                $('#ordinary_users').attr('disabled', 'disabled')
                                                form_data2.ordinary_users = alls[i].value
                                                layui.form.render("select");
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        axios_get_4()
                                

            if (redemption_records_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/redemption_records/get_obj', {
                        params: {
                                redemption_records_id: redemption_records_id
                        }, headers: {
                            'x-auth-token': token
                        }
                    })

                    let data = rese.result.obj
                    Object.keys(form_data2).forEach((key) => {
                        form_data2[key] = data[key];
                        $("#"+key).val(form_data2[key])
                    });

                    

            
            
            
            
            
            
            
                                        for (let key in data) {
                                if (key == 'ordinary_users') {
                                    let alls = document.querySelector('#ordinary_users').querySelectorAll('option')
                                    let test = data[key]
                                    for (let i = 0; i < alls.length; i++) {
                                        layui.form.render("select");
                                        if (alls[i].value == test) {
                                            alls[i].selected = true
                                            form_data2.ordinary_users = alls[i].value
                                            layui.form.render("select");
                                        }
                                    }
                                }
                            }
                        
                                    if (user_group === '管理员') {
                            $("#exchange_number_box").show()
                        } else {
                            if ($check_field('set', 'exchange_number') || $check_field('get', 'exchange_number')){
                                $("#exchange_number_box").show()
                            }else {
                                $("#exchange_number_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#product_number_box").show()
                        } else {
                            if ($check_field('set', 'product_number') || $check_field('get', 'product_number')){
                                $("#product_number_box").show()
                            }else {
                                $("#product_number_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#product_name_box").show()
                        } else {
                            if ($check_field('set', 'product_name') || $check_field('get', 'product_name')){
                                $("#product_name_box").show()
                            }else {
                                $("#product_name_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#product_type_box").show()
                        } else {
                            if ($check_field('set', 'product_type') || $check_field('get', 'product_type')){
                                $("#product_type_box").show()
                            }else {
                                $("#product_type_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#product_specifications_box").show()
                        } else {
                            if ($check_field('set', 'product_specifications') || $check_field('get', 'product_specifications')){
                                $("#product_specifications_box").show()
                            }else {
                                $("#product_specifications_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#required_points_box").show()
                        } else {
                            if ($check_field('set', 'required_points') || $check_field('get', 'required_points')){
                                $("#required_points_box").show()
                            }else {
                                $("#required_points_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#redemption_date_box").show()
                        } else {
                            if ($check_field('set', 'redemption_date') || $check_field('get', 'redemption_date')){
                                $("#redemption_date_box").show()
                            }else {
                                $("#redemption_date_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#ordinary_users_box").show()
                        } else {
                            if ($check_field('set', 'ordinary_users') || $check_field('get', 'ordinary_users')){
                                $("#ordinary_users_box").show()
                            }else {
                                $("#ordinary_users_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                                    //文本
                                exchange_number.value = form_data2.exchange_number
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'exchange_number')) || (!form_data2['redemption_records_id'] && $check_field('add', 'exchange_number'))) {
                            }else {
                                $("#exchange_number").attr("disabled", true);
                                $("#exchange_number > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                product_number.value = form_data2.product_number
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'product_number')) || (!form_data2['redemption_records_id'] && $check_field('add', 'product_number'))) {
                            }else {
                                $("#product_number").attr("disabled", true);
                                $("#product_number > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                product_name.value = form_data2.product_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'product_name')) || (!form_data2['redemption_records_id'] && $check_field('add', 'product_name'))) {
                            }else {
                                $("#product_name").attr("disabled", true);
                                $("#product_name > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                product_type.value = form_data2.product_type
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'product_type')) || (!form_data2['redemption_records_id'] && $check_field('add', 'product_type'))) {
                            }else {
                                $("#product_type").attr("disabled", true);
                                $("#product_type > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                product_specifications.value = form_data2.product_specifications
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'product_specifications')) || (!form_data2['redemption_records_id'] && $check_field('add', 'product_specifications'))) {
                            }else {
                                $("#product_specifications").attr("disabled", true);
                                $("#product_specifications > input[name='file']").attr('disabled', true);
                            }
                                                            //数字
                                required_points.value = form_data2.required_points
                            //数字
                            
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'required_points')) || (!form_data2['redemption_records_id'] && $check_field('add', 'required_points'))) {
                            }else {
                                $("#required_points").attr("disabled", true);
                                $("#required_points > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'redemption_date')) || (!form_data2['redemption_records_id'] && $check_field('add', 'redemption_date'))) {
                            }else {
                                $("#redemption_date").attr("disabled", true);
                                $("#redemption_date > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['redemption_records_id'] && $check_field('set', 'ordinary_users')) || (!form_data2['redemption_records_id'] && $check_field('add', 'ordinary_users'))) {
                            }else {
                                $("#ordinary_users").attr("disabled", true);
                                $("#ordinary_users > input[name='file']").attr('disabled', true);
                            }
                                                                                                                                                                                                                                                                            redemption_date.value = layui.util.toDateString(form_data2.redemption_date, "yyyy-MM-dd")
                                                                                                        layui.form.render("select");
                }
                axios_get_3()
            }


            
            submit.onclick = async function () {
                try {
                                                                    //文本
                            form_data2.exchange_number = exchange_number.value
                            //文本
                                                                    //文本
                            form_data2.product_number = product_number.value
                            //文本
                                                                    //文本
                            form_data2.product_name = product_name.value
                            //文本
                                                                    //文本
                            form_data2.product_type = product_type.value
                            //文本
                                                                    //文本
                            form_data2.product_specifications = product_specifications.value
                            //文本
                                                                    //数字
                            form_data2.required_points = Number(required_points.value)
                            //数字
                                                                    form_data2.redemption_date = layui.util.toDateString(form_data2.redemption_date, "yyyy-MM-dd")
                                                                                } catch (err) {
                    console.log(err)
                }
                            
            
                let customize_field = []
                                            customize_field.push({"field_name": "兑换号", "field_value": form_data2.exchange_number});
                                                customize_field.push({"field_name": "商品编号", "field_value": form_data2.product_number});
                                                customize_field.push({"field_name": "商品名称", "field_value": form_data2.product_name});
                                                customize_field.push({"field_name": "商品类型", "field_value": form_data2.product_type});
                                                customize_field.push({"field_name": "商品规格", "field_value": form_data2.product_specifications});
                                                customize_field.push({"field_name": "所需积分", "field_value": form_data2.required_points});
                                                customize_field.push({
                            "field_name": "兑换日期",
                            "field_value": form_data2.redemption_date,
                            "type": "date"
                        });
                                                customize_field.push({"field_name": "普通用户", "field_value": form_data2.ordinary_users});
                    
    
                if (redemption_records_id == '') {
                                        async function xzcs() {
                        form_data2.product_number = product_number.value
                        form_data2.user_id = use_id
                        var now = new Date();
                        var yy = now.getFullYear();      //年
                        var mm = now.getMonth() + 1;     //月
                        var dd = now.getDate();          //日
                        var hh = now.getHours();         //时
                        var ii = now.getMinutes();       //分
                        var ss = now.getSeconds();       //秒
                        var clock = yy + "-";
                        if (mm < 10) clock += "0";
                        clock += mm + "-";
                        if (dd < 10) clock += "0";
                        clock += dd + " ";
                        if (hh < 10) clock += "0";
                        clock += hh + ":";
                        if (ii < 10) clock += '0';
                        clock += ii + ":";
                        if (ss < 10) clock += '0';
                        clock += ss;

                        const {data: resu} = await axios.get(BaseUrl + '/api/point_products/get_obj?product_number='+form_data2.product_number,
                                {
                                    headers: {
                                        'x-auth-token': token,
                                        'Content-Type': 'application/json'
                                    }
                                })
                        let time = "&create_time_min="+clock+"&create_time_max="+clock
                        const {data: ress} = await axios.post(BaseUrl + '/api/redemption_records/count?product_number=' + form_data2.product_number + "&user_id=" + use_id,
                                {
                                    headers: {
                                        'x-auth-token': token,
                                        'Content-Type': 'application/json'
                                    }
                                })

                    if (ress.result >= resu.result.obj.limit_times) {
                        layer.msg('已超过提交次数');
                    } else {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/redemption_records/add?',
                            form_data2, {
                                headers: {
                                    'x-auth-token': token,
                                    'Content-Type': 'application/json'
                                }
                            })
                                        if (res.result == 1) {
                        layer.msg('确认/Confirm完毕');
                        setTimeout(function () {
                            window.location.replace("./table.jsp");
                        }, 1000)
                    }else {
              layer.msg(res.error.message);
            }
                                        }
                    }
                        xzcs()
                                    } else {
                                        console.log("详情/Details")
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/redemption_records/set?redemption_records_id=' + redemption_records_id,
                            form_data2, {
                                headers: {
                                    'x-auth-token': token,
                                    'Content-Type': 'application/json'
                                }
                            })
                    if (res.result == 1) {
                        layer.msg('确认/Confirm完毕');
                        setTimeout(function () {
                            window.location.replace("./table.jsp");
                        }, 1000)
                    }else {
              layer.msg(res.error.message);
            }
                }
            }
        
    })
    ;
</script>

</html>
