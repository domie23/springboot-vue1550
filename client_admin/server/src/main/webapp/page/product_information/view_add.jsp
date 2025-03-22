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
                                                    <div class="layui-form-item">
                                <span>封面图</span>
                                <div class="layui-upload">
                                    <button type="button" class="layui-btn" id="product_information_1">上传图片</button>
                                    <div class="layui-upload-list">
                                        <img class="layui-upload-img" id="product_information_1_img">
                                        <p id="demoText"></p>
                                    </div>
                                    <div style="width: 95px;">
                                        <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                             lay-filter="product_information_1">
                                            <div class="layui-progress-bar" lay-percent=""></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 10px;"></div>
                            </div>
                            <!-- 上传封面图图片结束 -->
                            <!-- 上传主图1图片开始 -->
                            <div class="layui-form-item">
                                <span>主图_1</span>
                                <div class="layui-upload">
                                    <button type="button" class="layui-btn" id="product_information_2">上传图片</button>
                                    <div class="layui-upload-list">
                                        <img class="layui-upload-img" id="product_information_2_img">
                                        <p id="demoText1"></p>
                                    </div>
                                    <div style="width: 95px;">
                                        <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                             lay-filter="product_information_2">
                                            <div class="layui-progress-bar" lay-percent=""></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 10px;"></div>
                            </div>
                            <!-- 上传主图1图片结束 -->
                            <!-- 上传主图2图片开始 -->
                            <div class="layui-form-item">
                                <span>主图_2</span>
                                <div class="layui-upload">
                                    <button type="button" class="layui-btn" id="product_information_3">上传图片</button>
                                    <div class="layui-upload-list">
                                        <img class="layui-upload-img" id="product_information_3_img">
                                        <p id="demoText2"></p>
                                    </div>
                                    <div style="width: 95px;">
                                        <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                             lay-filter="product_information_3">
                                            <div class="layui-progress-bar" lay-percent=""></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 10px;"></div>
                            </div>
                            <!-- 上传主图2图片结束 -->
                            <!-- 上传主图3图片开始 -->
                            <div class="layui-form-item">
                                <span>主图_3</span>
                                <div class="layui-upload">
                                    <button type="button" class="layui-btn" id="product_information_4">上传图片</button>
                                    <div class="layui-upload-list">
                                        <img class="layui-upload-img" id="product_information_4_img">
                                        <p id="demoText3"></p>
                                    </div>
                                    <div style="width: 95px;">
                                        <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                             lay-filter="product_information_4">
                                            <div class="layui-progress-bar" lay-percent=""></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 10px;"></div>
                            </div>
                            <!-- 上传主图3图片结束 -->
                            <!-- 上传主图4图片开始 -->
                            <div class="layui-form-item">
                                <span>主图_4</span>
                                <div class="layui-upload">
                                    <button type="button" class="layui-btn" id="product_information_5">上传图片</button>
                                    <div class="layui-upload-list">
                                        <img class="layui-upload-img" id="product_information_5_img">
                                        <p id="demoText4"></p>
                                    </div>
                                    <div style="width: 95px;">
                                        <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                             lay-filter="product_information_5">
                                            <div class="layui-progress-bar" lay-percent=""></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 10px;"></div>
                            </div>
                            <!-- 上传主图4图片结束 -->
                            <!-- 上传主图5图片开始 -->
                            <div class="layui-form-item">
                                <span>主图_5</span>
                                <div class="layui-upload">
                                    <button type="button" class="layui-btn" id="product_information_6">上传图片</button>
                                    <div class="layui-upload-list">
                                        <img class="layui-upload-img" id="product_information_6_img">
                                        <p id="demoText5"></p>
                                    </div>
                                    <div style="width: 95px;">
                                        <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                             lay-filter="product_information_6">
                                            <div class="layui-progress-bar" lay-percent=""></div>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 10px;"></div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">标题</label>
                                <div class="layui-input-block">
                                    <input type="text" name="title" lay-verify="title" autocomplete="off"
                                           placeholder="请输入标题"
                                           class="layui-input" id="cart_title">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">描述</label>
                                <div class="layui-input-block">
                                    <input type="text" name="title" lay-verify="title" autocomplete="off"
                                           placeholder="请输入描述"
                                           class="layui-input" id="cart_description">
                                </div>
                            </div>
                            <!-- 加减按钮开始 -->
                            <div class="layui-form-item">
                                <label class="layui-form-label">原价</label>
                                <div class="layui-input-block">
                                    <input type="number" name="num" class="layui-input num" id="cart_price_ago">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">卖价</label>
                                <div class="layui-input-block">
                                    <input type="number" name="num" class="layui-input num" id="cart_price">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">库存</label></label>
                                <div class="layui-input-block">
                                    <input type="number" name="num" class="layui-input num" id="cart_inventory">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">分类</label>
                                <div class="layui-input-block">
                                    <select name="interest" lay-filter="classify2" id="classify2">
                                        <option value="" selected></option>
                                    </select>
                                </div>
                            </div>
                                                                                                        <div class="layui-form-item" id="commodity_specifications_box">
                                            <label class="layui-form-label">商品规格</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入商品规格"
                                                       class="layui-input" id="commodity_specifications">
                                            </div>
                                        </div>
                                                                
        
    
    
    
                                <div class="layui-form-item">
                                <label class="layui-form-label">正文</label>
                                <div class="layui-input-block">
                                    <textarea id="demo_zw" style="display: none;"></textarea>
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
    let product_information_id = location.search.substring(1)
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
        // if (   user_group == "管理员" ||$check_action('/product_information/view', 'add') || $check_action('/product_information/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "product_information_id";
            let url_add = "product_information";
            let url_set = "product_information";
            let url_get_obj = "product_information";
            let url_upload = "product_information"
            let query = {
                "product_information_id": 0,
            }

            let form_data2 = {
                                        "commodity_specifications":  '', // 商品规格
                                        cart_title: "",
                    cart_img: "",
                    cart_description: "",
                    cart_price_ago: 0,
                    cart_price: 0,
                    cart_inventory: 0,
                    cart_type: '',
                    cart_content: "",
                    cart_img_1: "",
                    cart_img_2: "",
                    cart_img_3: "",
                    cart_img_4: "",
                    cart_img_5: "",
                                "product_information_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/product_information/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/product_information/table") {
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
                var o = $get_power("/product_information/view");
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
                    $("#commodity_specifications_box").show()
                } else {
                    if ($check_field('add', 'commodity_specifications')){
                        $("#commodity_specifications_box").show()
                    }else {
                        $("#commodity_specifications_box").hide()
                    }
                }
            
                                                        var demo = layedit.build('demo_zw', {
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
            
            
    
                    let cart_goods_type = []
                let goods_form = {
                    goods_id: 0,
                    title: "",
                    img: "",
                    description: "",
                    price_ago: 0,
                    price: 0,
                    inventory: 0,
                    type: '',
                    content: "",
                    img_1: "",
                    img_2: "",
                    img_3: "",
                    img_4: "",
                    img_5: "",
                    source_table: "",
                    source_field: "",
                    source_id: 0,
                    user_id: 0
                }
                
                var uploadInst = upload.render({
                    elem: '#product_information_1'
                    , url: BaseUrl + '/api/product_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                    , headers: {
                        'x-auth-token': token
                    }, before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        obj.preview(function (index, file, result) {
                            $('#product_information_1_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                        });

                        element.progress('product_information_1', '0%'); //进度条复位
                        layer.msg('上传中', {icon: 16, time: 0});
                    }
                    , done: function (res) {
                        //如果上传失败
                        if (res.code > 0) {
                            return layer.msg('上传失败');
                        }
                        //上传成功的一些操作
                        //……
                        form_data2.cart_img = res.result.url
                        goods_form.img = res.result.url
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
                        element.progress('product_information_1', n + '%'); //可配合 layui 进度条元素使用
                        if (n == 100) {
                            layer.msg('上传完毕', {icon: 1});
                        }
                    }
                })
                var uploadInst = upload.render({
                    elem: '#product_information_2'
                    , url: BaseUrl + '/api/product_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                    , headers: {
                        'x-auth-token': token
                    }, before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        obj.preview(function (index, file, result) {
                            $('#product_information_2_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                        });

                        element.progress('product_information_2', '0%'); //进度条复位
                        layer.msg('上传中', {icon: 16, time: 0});
                    }
                    , done: function (res) {
                        //如果上传失败
                        if (res.code > 0) {
                            return layer.msg('上传失败');
                        }
                        //上传成功的一些操作
                        //……
                        form_data2.cart_img_1 = res.result.url
                        goods_form.img_1 = res.result.url
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
                        element.progress('product_information_2', n + '%'); //可配合 layui 进度条元素使用
                        if (n == 100) {
                            layer.msg('上传完毕', {icon: 1});
                        }
                    }
                })
                var uploadInst = upload.render({
                    elem: '#product_information_3'
                    , url: BaseUrl + '/api/product_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                    , headers: {
                        'x-auth-token': token
                    }, before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        obj.preview(function (index, file, result) {
                            $('#product_information_3_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                        });

                        element.progress('product_information_3', '0%'); //进度条复位
                        layer.msg('上传中', {icon: 16, time: 0});
                    }
                    , done: function (res) {
                        //如果上传失败
                        if (res.code > 0) {
                            return layer.msg('上传失败');
                        }
                        //上传成功的一些操作
                        //……
                        form_data2.cart_img_2 = res.result.url
                        goods_form.img_2 = res.result.url
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
                        element.progress('product_information_3', n + '%'); //可配合 layui 进度条元素使用
                        if (n == 100) {
                            layer.msg('上传完毕', {icon: 1});
                        }
                    }
                })
                var uploadInst = upload.render({
                    elem: '#product_information_4'
                    , url: BaseUrl + '/api/product_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                    , headers: {
                        'x-auth-token': token
                    }, before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        obj.preview(function (index, file, result) {
                            $('#product_information_4_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                        });

                        element.progress('product_information_4', '0%'); //进度条复位
                        layer.msg('上传中', {icon: 16, time: 0});
                    }
                    , done: function (res) {
                        //如果上传失败
                        if (res.code > 0) {
                            return layer.msg('上传失败');
                        }
                        //上传成功的一些操作
                        //……
                        form_data2.cart_img_3 = res.result.url
                        goods_form.img_3 = res.result.url
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
                        element.progress('product_information_4', n + '%'); //可配合 layui 进度条元素使用
                        if (n == 100) {
                            layer.msg('上传完毕', {icon: 1});
                        }
                    }
                })
                var uploadInst = upload.render({
                    elem: '#product_information_5'
                    , url: BaseUrl + '/api/product_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                    , headers: {
                        'x-auth-token': token
                    }, before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        obj.preview(function (index, file, result) {
                            $('#product_information_5_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                        });

                        element.progress('product_information_5', '0%'); //进度条复位
                        layer.msg('上传中', {icon: 16, time: 0});
                    }
                    , done: function (res) {
                        //如果上传失败
                        if (res.code > 0) {
                            return layer.msg('上传失败');
                        }
                        //上传成功的一些操作
                        //……
                        form_data2.cart_img_4 = res.result.url
                        goods_form.img_4 = res.result.url
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
                        element.progress('product_information_5', n + '%'); //可配合 layui 进度条元素使用
                        if (n == 100) {
                            layer.msg('上传完毕', {icon: 1});
                        }
                    }
                })
                var uploadInst = upload.render({
                    elem: '#product_information_6'
                    , url: BaseUrl + '/api/product_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                    , headers: {
                        'x-auth-token': token
                    }, before: function (obj) {
                        //预读本地文件示例，不支持ie8
                        obj.preview(function (index, file, result) {
                            $('#product_information_6_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                        });

                        element.progress('product_information_6', '0%'); //进度条复位
                        layer.msg('上传中', {icon: 16, time: 0});
                    }
                    , done: function (res) {
                        //如果上传失败
                        if (res.code > 0) {
                            return layer.msg('上传失败');
                        }
                        //上传成功的一些操作
                        //……
                        form_data2.cart_img_5 = res.result.url
                        goods_form.img_5 = res.result.url
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
                        element.progress('product_information_6', n + '%'); //可配合 layui 进度条元素使用
                        if (n == 100) {
                            layer.msg('上传完毕', {icon: 1});
                        }
                    }
                })

                async function classify2() {
                    var classify2 = document.querySelector("#classify2")
                    var op1 = document.createElement("option");
                    op1.value = '0'
                    classify2.appendChild(op1)
                    // 收集数据 长度
                    var count
                    // 收集数据 数组
                    var arr = []
                    let {data: res} = await axios.get(BaseUrl + '/api/goods_type/get_list')
                    count = res.result.count
                    arr = res.result.list
                    for (var i = 0; i < arr.length; i++) {
                        var op = document.createElement("option");

                        // 给节点赋值
                        console.log(arr[i])
                        op.innerHTML = arr[i].name
                        op.value = i + 1
                        // 新增/Add节点
                        classify2.appendChild(op)
                        layui.form.render("select");
                    }
                }

                layui.form.on('select(classify2)', function (data) {
                    form_data2.cart_type = data.elem[data.elem.selectedIndex].text;
                    goods_form.type = data.elem[data.elem.selectedIndex].text;
                })
                classify2()
                                        
                    
    
                    
                    
                                //文本
                    let commodity_specifications = document.querySelector("#commodity_specifications")
                        commodity_specifications.onkeyup = function (event) {
                        form_data2.commodity_specifications = event.target.value
                    }
                    //文本
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
                                        
                                                        }
                        }
                    })
                })
                sessionStorage.removeItem("data");
            }
                            let cart_title = document.querySelector("#cart_title")
                let cart_description = document.querySelector("#cart_description")
                let cart_price_ago = document.querySelector("#cart_price_ago")
                let cart_price = document.querySelector("#cart_price")
                let cart_inventory = document.querySelector("#cart_inventory")
                            

            if (product_information_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/product_information/get_obj', {
                        params: {
                                product_information_id: product_information_id
                        }, headers: {
                            'x-auth-token': token
                        }
                    })

                    let data = rese.result.obj
                    Object.keys(form_data2).forEach((key) => {
                        form_data2[key] = data[key];
                        $("#"+key).val(form_data2[key])
                    });

                    

            
                                    if (user_group === '管理员') {
                            $("#commodity_specifications_box").show()
                        } else {
                            if ($check_field('set', 'commodity_specifications') || $check_field('get', 'commodity_specifications')){
                                $("#commodity_specifications_box").show()
                            }else {
                                $("#commodity_specifications_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                                    //文本
                                commodity_specifications.value = form_data2.commodity_specifications
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['product_information_id'] && $check_field('set', 'commodity_specifications')) || (!form_data2['product_information_id'] && $check_field('add', 'commodity_specifications'))) {
                            }else {
                                $("#commodity_specifications").attr("disabled", true);
                                $("#commodity_specifications > input[name='file']").attr('disabled', true);
                            }
                                                            cart_title.value = form_data2.cart_title
                        cart_description.value = form_data2.cart_description
                        cart_price_ago.value = form_data2.cart_price_ago
                        cart_price.value = form_data2.cart_price
                        cart_inventory.value = form_data2.cart_inventory
                        layedit.setContent(demo, form_data2.cart_content)
                            product_information_1_img.src = fullUrl(BaseUrl,form_data2.cart_img)
                            product_information_2_img.src = fullUrl(BaseUrl,form_data2.cart_img_1)
                            product_information_3_img.src = fullUrl(BaseUrl,form_data2.cart_img_2)
                            product_information_4_img.src = fullUrl(BaseUrl,form_data2.cart_img_3)
                            product_information_5_img.src = fullUrl(BaseUrl,form_data2.cart_img_4)
                            product_information_6_img.src = fullUrl(BaseUrl,form_data2.cart_img_5)
                        for (let key in data) {
                            if (key == 'cart_type') {
                                let alls = document.querySelector('#classify2').querySelectorAll('option')
                                let test = data[key]
                                for (let i = 0; i < alls.length; i++) {
                                    if (alls[i].innerHTML == test) {
                                        alls[i].selected = 1
                                        form_data2.cart_type = alls[i].text
                                        layui.form.render("select");
                                    }
                                }
                            }
                        }
                                                                            layui.form.render("select");
                }
                axios_get_3()
            }


            
            submit.onclick = async function () {
                try {
                                                                    //文本
                            form_data2.commodity_specifications = commodity_specifications.value
                            //文本
                                    } catch (err) {
                    console.log(err)
                }
                                                form_data2.cart_title = cart_title.value
                    form_data2.cart_description = cart_description.value
                    form_data2.cart_price_ago = cart_price_ago.value
                    form_data2.cart_price = cart_price.value
                    form_data2.cart_inventory = Number(cart_inventory.value)
                    form_data2.cart_content = layedit.getContent(demo)
                
                                async function axios_get_7(url) {
                        const {data: rese} = await axios.get(BaseUrl + '/api/product_information/get_obj', {
                            params: {
                                cart_title: form_data2.cart_title,
                                cart_description: form_data2.cart_description
                            }
                        })
                    if(rese.result && rese.result.obj){
                        goods_form.source_id = rese.result.obj.product_information_id
                    }
                    delete goods_form.goods_id;
                    if(url == "/api/goods/set?"){
                        goods_form.source_id = product_information_id
                        url = url + "source_table=product_information&source_field=" +
                        goods_form.source_field +
                        '&source_id=' +
                        goods_form.source_id;
                    }
                     const {data: res2} = await axios.post(BaseUrl + url,
                        goods_form, {
                            headers: {
                                'x-auth-token': token,
                                'Content-Type': 'application/json'
                            }
                        })
                    }
                
                let customize_field = []
                                            customize_field.push({"field_name": "商品规格", "field_value": form_data2.commodity_specifications});
                    
                        goods_form = {
                        goods_id: 0,
                        title: form_data2.cart_title,
                        img: form_data2.cart_img,
                        description: form_data2.cart_description,
                        price_ago: form_data2.cart_price_ago,
                        price: form_data2.cart_price,
                        inventory: form_data2.cart_inventory,
                        type: form_data2.cart_type,
                        content: form_data2.cart_content,
                        img_1: form_data2.cart_img_1,
                        img_2: form_data2.cart_img_2,
                        img_3: form_data2.cart_img_3,
                        img_4: form_data2.cart_img_4,
                        img_5: form_data2.cart_img_5,
                        source_table: "product_information",
                        source_field: 'product_information_id',
                        source_id: 1,
                        customize_field: JSON.stringify(customize_field),
                        user_id: use_id
                    }
                
                if (product_information_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/product_information/add?',
                            form_data2, {
                                headers: {
                                    'x-auth-token': token,
                                    'Content-Type': 'application/json'
                                }
                            })
                                            axios_get_7('/api/goods/add?')
                                        if (res.result == 1) {
                        layer.msg('确认/Confirm完毕');
                        setTimeout(function () {
                            window.location.replace("./table.jsp");
                        }, 1000)
                    }else {
              layer.msg(res.error.message);
            }
                                    } else {
                                            axios_get_7('/api/goods/set?')

                                        console.log("详情/Details")
                                            async function axios_get_3() {
                            const {data: rese} = await axios.get(BaseUrl + '/api/product_information/get_obj', {
                                params: {
                                        product_information_id: product_information_id
                                }, headers: {
                                    'x-auth-token': token
                                }
                            })
                            console.log(rese)
                        }

                        axios_get_3()
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/product_information/set?product_information_id=' + product_information_id,
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
