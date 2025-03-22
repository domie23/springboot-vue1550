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
                                                                                    <div class="layui-form-item" id="product_type_box">
                                        <label class="layui-form-label">商品类型</label>
                                        <div class="layui-input-block">
                                            <select name="interest" lay-filter="product_type" id="product_type">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                                                                                    <div class="layui-form-item" id="sales_date_box">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">销售日期</label>
                                            <div class="layui-input-inline">
                                                <input type="text" class="layui-input" id="sales_date"
                                                       placeholder="yyyy-MM-dd">
                                            </div>
                                        </div>
                                    </div>
                                                                                                    <div class="layui-form-item" id="sales_amount_box">
                                        <label class="layui-form-label">销售金额</label>
                                        <div class="layui-input-block">
                                            <input type="number" name="num" class="layui-input num" id="sales_amount">
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
    let sales_information_id = location.search.substring(1)
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
        // if (   user_group == "管理员" ||$check_action('/sales_information/view', 'add') || $check_action('/sales_information/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "sales_information_id";
            let url_add = "sales_information";
            let url_set = "sales_information";
            let url_get_obj = "sales_information";
            let url_upload = "sales_information"
            let query = {
                "sales_information_id": 0,
            }

            let form_data2 = {
                                        "product_type":  '', // 商品类型
                            "sales_date":  '', // 销售日期
                            "sales_amount":  0, // 销售金额
                                    "sales_information_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/sales_information/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/sales_information/table") {
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
                var o = $get_power("/sales_information/view");
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
                    $("#product_type_box").show()
                } else {
                    if ($check_field('add', 'product_type')){
                        $("#product_type_box").show()
                    }else {
                        $("#product_type_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#sales_date_box").show()
                } else {
                    if ($check_field('add', 'sales_date')){
                        $("#sales_date_box").show()
                    }else {
                        $("#sales_date_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#sales_amount_box").show()
                } else {
                    if ($check_field('add', 'sales_amount')){
                        $("#sales_amount_box").show()
                    }else {
                        $("#sales_amount_box").hide()
                    }
                }
            
                                                                                                        
                                // 商品类型选项列表
                    let product_type_data = [""];
                
            
            
    
                                                        
                                                // 日期选择
                    laydate.render({
                        elem: '#sales_date'
                        , format: 'yyyy-MM-dd'
                        , done: function (value) {
                            form_data2.sales_date = value + ' 00:00:00'
                        }
                    });
                
                            
                    
    
                                async function product_type() {
                        var product_type = document.querySelector("#product_type")
                        var op1 = document.createElement("option");
                        op1.value = '0'
                            product_type.appendChild(op1)
                        // 收集数据 长度
                        var count
                        // 收集数据 数组
                        var arr = []
                        let {data: res} = await axios.get(BaseUrl + '/api/product_type/get_list')
                        count = res.result.count
                        arr = res.result.list
                        for (var i = 0; i < arr.length; i++) {
                            var op = document.createElement("option");

                            // 给节点赋值
                            op.innerHTML = arr[i].product_type
                            op.value = i + 1
                            // 新增/Add节点
                            product_type.appendChild(op)
                            if (form_data2.product_type==arr[i].product_type){
                                op.selected = true
                            }
                            layui.form.render("select");
                        }
                    }

                    layui.form.on('select(product_type)', function (data) {
                        form_data2.product_type = data.elem[data.elem.selectedIndex].text;
                    })
                        product_type()
                        
                            
                            
                    
                                                                                                                                        //数字
                    let sales_amount = document.querySelector("#sales_amount")
                        sales_amount.onkeyup = function (event) {
                        form_data2.sales_amount = Number(event.target.value)
                    }
                    //数字
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
                                            if (key == 'product_type') {
                                                let alls = document.querySelector('#product_type').querySelectorAll('option')
                                                let test = form_data2[key]
                                                for (let i = 0; i < alls.length; i++) {
                                                    if (alls[i].innerHTML == test) {
                                                        alls[i].selected = true
                                                        form_data2.product_type = alls[i].text
                                                        console.log(222)
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
                                                    

            if (sales_information_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/sales_information/get_obj', {
                        params: {
                                sales_information_id: sales_information_id
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
                                if (key == 'product_type') {
                                    let alls = document.querySelector('#product_type').querySelectorAll('option')
                                    let test = data[key]
                                    for (let i = 0; i < alls.length; i++) {
                                        if (alls[i].innerHTML == test) {
                                            alls[i].selected = true
                                            form_data2.product_type = alls[i].text
                                            console.log(222)
                                            layui.form.render("select");
                                        }
                                    }
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
                            $("#sales_date_box").show()
                        } else {
                            if ($check_field('set', 'sales_date') || $check_field('get', 'sales_date')){
                                $("#sales_date_box").show()
                            }else {
                                $("#sales_date_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#sales_amount_box").show()
                        } else {
                            if ($check_field('set', 'sales_amount') || $check_field('get', 'sales_amount')){
                                $("#sales_amount_box").show()
                            }else {
                                $("#sales_amount_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                
                                if (user_group === '管理员' || (form_data2['sales_information_id'] && $check_field('set', 'product_type')) || (!form_data2['sales_information_id'] && $check_field('add', 'product_type'))) {
                            }else {
                                $("#product_type").attr("disabled", true);
                                $("#product_type > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['sales_information_id'] && $check_field('set', 'sales_date')) || (!form_data2['sales_information_id'] && $check_field('add', 'sales_date'))) {
                            }else {
                                $("#sales_date").attr("disabled", true);
                                $("#sales_date > input[name='file']").attr('disabled', true);
                            }
                                                            //数字
                                sales_amount.value = form_data2.sales_amount
                            //数字
                            
                                if (user_group === '管理员' || (form_data2['sales_information_id'] && $check_field('set', 'sales_amount')) || (!form_data2['sales_information_id'] && $check_field('add', 'sales_amount'))) {
                            }else {
                                $("#sales_amount").attr("disabled", true);
                                $("#sales_amount > input[name='file']").attr('disabled', true);
                            }
                                                                                                            sales_date.value = layui.util.toDateString(form_data2.sales_date, "yyyy-MM-dd")
                                                                                            layui.form.render("select");
                }
                axios_get_3()
            }


            
            submit.onclick = async function () {
                try {
                                                                                    form_data2.sales_date = layui.util.toDateString(form_data2.sales_date, "yyyy-MM-dd")
                                                                                    //数字
                            form_data2.sales_amount = Number(sales_amount.value)
                            //数字
                                        } catch (err) {
                    console.log(err)
                }
                            
            
                let customize_field = []
                                            customize_field.push({"field_name": "商品类型", "field_value": form_data2.product_type});
                                                customize_field.push({
                            "field_name": "销售日期",
                            "field_value": form_data2.sales_date,
                            "type": "date"
                        });
                                                customize_field.push({"field_name": "销售金额", "field_value": form_data2.sales_amount});
                    
    
                if (sales_information_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/sales_information/add?',
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
                                    } else {
                                        console.log("详情/Details")
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/sales_information/set?sales_information_id=' + sales_information_id,
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
