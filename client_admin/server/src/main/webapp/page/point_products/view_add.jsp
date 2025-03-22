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
                                            <select name="interest" lay-filter="product_type" id="product_type">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                                                                                    <div class="layui-upload" id="cover_box">
                                        <button type="button" class="layui-btn" id="cover">上传图片</button>
                                        <div class="layui-upload-list">
                                            <img class="layui-upload-img" id="cover_img">
                                            <p id="demoText"></p>
                                        </div>
                                        <div style="width: 95px;">
                                            <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                                 lay-filter="cover">
                                                <div class="layui-progress-bar" lay-percent=""></div>
                                            </div>
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
                                                                                    <div class="layui-form-item">
                                    <label class="layui-form-label">商品详情</label>
                                    <div class="layui-input-block">
                                        <textarea id="demo" style="display: none;"></textarea>
                                    </div>
                                </div>
                                    
        
    
                                <div class="layui-form-item">
                                <label class="layui-form-label">限制次数</label>
                                <div class="layui-input-block">
                                    <input type="text" name="title" lay-verify="title" autocomplete="off"
                                           placeholder="限制次数"
                                           class="layui-input" id="limit_times">
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
    let point_products_id = location.search.substring(1)
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
        // if (   user_group == "管理员" ||$check_action('/point_products/view', 'add') || $check_action('/point_products/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "point_products_id";
            let url_add = "point_products";
            let url_set = "point_products";
            let url_get_obj = "point_products";
            let url_upload = "point_products"
            let query = {
                "point_products_id": 0,
            }

            let form_data2 = {
                                        "product_number": $get_stamp(), // 商品编号
                            "product_name":  '', // 商品名称
                            "product_type":  '', // 商品类型
                            "cover":  '', // 封面
                            "product_specifications":  '', // 商品规格
                            "required_points":  0, // 所需积分
                            "product_details":  '', // 商品详情
                                    "point_products_id": 0, // ID
                                                "limit_times": "", // 限制次数
                                            "limit_type": 1,
                                        }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/point_products/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/point_products/table") {
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
                var o = $get_power("/point_products/view");
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
                    $("#cover_box").show()
                } else {
                    if ($check_field('add', 'cover')){
                        $("#cover_box").show()
                    }else {
                        $("#cover_box").hide()
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
                    $("#product_details_box").show()
                } else {
                    if ($check_field('add', 'product_details')){
                        $("#product_details_box").show()
                    }else {
                        $("#product_details_box").hide()
                    }
                }
            
                                                                                                                                                //常规使用 - 普通图片上传
                        var uploadInst = upload.render({
                            elem: '#cover'
                            , url: BaseUrl + '/api/point_products/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                            , headers: {
                                'x-auth-token': token
                            }, before: function (obj) {
                                //预读本地文件示例，不支持ie8
                                obj.preview(function (index, file, result) {
                                    $('#cover_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                                });

                                element.progress('cover', '0%'); //进度条复位
                                layer.msg('上传中', {icon: 16, time: 0});
                            }
                            , done: function (res) {
                                //如果上传失败
                                if (res.code > 0) {
                                    return layer.msg('上传失败');
                                }
                                //上传成功的一些操作
                                //……
                                form_data2.cover = res.result.url
                                $('#demoText').html(''); //置空上传失败的状态
                            }
                            , error: function () {
                                //演示失败状态，并实现重传
                                var demoText = $('#demoText');
                                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                                demoText.find('.demo-reload').on('click', function () {
                                    uploadInst.upload();
                                });
                            }
                            //进度条
                            , progress: function (n, elem, e) {
                                element.progress('cover', n + '%'); //可配合 layui 进度条元素使用
                                if (n == 100) {
                                    layer.msg('上传完毕', {icon: 1});
                                }
                            }
                        });
                                                                                                                            var demo = layedit.build('demo', {
                        tool: [
                            'strong' //加粗
                            , 'italic' //斜体
                            , 'underline' //下划线
                            , 'del' //删除/Del线

                            , '|' //分割线

                            , 'left' //左对齐
                            , 'center' //居中对齐
                            , 'right' //右对齐
                            , 'link' //超链接
                            , 'unlink' //清除链接
                            , 'face' //表情
                            , 'image' //插入图片
                            , 'help' //帮助
                        ]
                    });
                        
            
            
                                // 商品类型选项列表
                    let product_type_data = [""];
                
            
            
            
            
    
                                                                                                        
                            
                            
                            
                            
                            
                            
                    
    
                    
                            
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
                                                                                                                        product_number.value = form_data2.product_number
                        $("#product_number").attr("disabled", "disabled");
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
                                                                                                    

            if (point_products_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/point_products/get_obj', {
                        params: {
                                point_products_id: point_products_id
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
                            $("#cover_box").show()
                        } else {
                            if ($check_field('set', 'cover') || $check_field('get', 'cover')){
                                $("#cover_box").show()
                            }else {
                                $("#cover_box").hide()
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
                            $("#product_details_box").show()
                        } else {
                            if ($check_field('set', 'product_details') || $check_field('get', 'product_details')){
                                $("#product_details_box").show()
                            }else {
                                $("#product_details_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                                    //文本
                                product_number.value = form_data2.product_number
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['point_products_id'] && $check_field('set', 'product_number')) || (!form_data2['point_products_id'] && $check_field('add', 'product_number'))) {
                            }else {
                                $("#product_number").attr("disabled", true);
                                $("#product_number > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                product_name.value = form_data2.product_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['point_products_id'] && $check_field('set', 'product_name')) || (!form_data2['point_products_id'] && $check_field('add', 'product_name'))) {
                            }else {
                                $("#product_name").attr("disabled", true);
                                $("#product_name > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['point_products_id'] && $check_field('set', 'product_type')) || (!form_data2['point_products_id'] && $check_field('add', 'product_type'))) {
                            }else {
                                $("#product_type").attr("disabled", true);
                                $("#product_type > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['point_products_id'] && $check_field('set', 'cover')) || (!form_data2['point_products_id'] && $check_field('add', 'cover'))) {
                            }else {
                                $("#cover").attr("disabled", true);
                                $("#cover > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                product_specifications.value = form_data2.product_specifications
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['point_products_id'] && $check_field('set', 'product_specifications')) || (!form_data2['point_products_id'] && $check_field('add', 'product_specifications'))) {
                            }else {
                                $("#product_specifications").attr("disabled", true);
                                $("#product_specifications > input[name='file']").attr('disabled', true);
                            }
                                                            //数字
                                required_points.value = form_data2.required_points
                            //数字
                            
                                if (user_group === '管理员' || (form_data2['point_products_id'] && $check_field('set', 'required_points')) || (!form_data2['point_products_id'] && $check_field('add', 'required_points'))) {
                            }else {
                                $("#required_points").attr("disabled", true);
                                $("#required_points > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['point_products_id'] && $check_field('set', 'product_details')) || (!form_data2['point_products_id'] && $check_field('add', 'product_details'))) {
                            }else {
                                $("#product_details").attr("disabled", true);
                                $("#product_details > input[name='file']").attr('disabled', true);
                            }
                                                    limit_times.value = form_data2.limit_times
                                                                                                                                                                                    let cover_img = document.querySelector("#cover_img")
                                    cover_img.src = fullUrl(BaseUrl,form_data2.cover)
                                                                                                                                            layedit.setContent(demo, form_data2.product_details)
                                                layui.form.render("select");
                }
                axios_get_3()
            }


            
            submit.onclick = async function () {
                try {
                                                                    //文本
                            form_data2.product_number = product_number.value
                            //文本
                                                                    //文本
                            form_data2.product_name = product_name.value
                            //文本
                                                                                                                    //文本
                            form_data2.product_specifications = product_specifications.value
                            //文本
                                                                    //数字
                            form_data2.required_points = Number(required_points.value)
                            //数字
                                                        form_data2.product_details = layedit.getContent(demo)
                                            } catch (err) {
                    console.log(err)
                }
                            
                        let limit_times = document.querySelector("#limit_times")
                    form_data2.limit_times = Number(limit_times.value)
                    limit_times.value = form_data2.limit_times
                        
                let customize_field = []
                                            customize_field.push({"field_name": "商品编号", "field_value": form_data2.product_number});
                                                customize_field.push({"field_name": "商品名称", "field_value": form_data2.product_name});
                                                customize_field.push({"field_name": "商品类型", "field_value": form_data2.product_type});
                                                customize_field.push({
                            "field_name": "封面",
                            "field_value": form_data2.cover,
                            "type": "image"
                        });
                                                customize_field.push({"field_name": "商品规格", "field_value": form_data2.product_specifications});
                                                customize_field.push({"field_name": "所需积分", "field_value": form_data2.required_points});
                                                customize_field.push({"field_name": "商品详情", "field_value": form_data2.product_details});
                    
    
                if (point_products_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/point_products/add?',
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
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/point_products/set?point_products_id=' + point_products_id,
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
