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
                                                                                                                                <div class="layui-form-item" id="ordinary_users_box">
                                                <label class="layui-form-label">普通用户</label>
                                                <div class="layui-input-block">
                                                    <select name="interest" lay-filter="ordinary_users"
                                                            id="ordinary_users">
                                                        <option value=""></option>
                                                    </select>
                                                </div>
                                            </div>
                                                                                                                                                            <div class="layui-form-item" id="user_name_box">
                                            <label class="layui-form-label">用户姓名</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入用户姓名"
                                                       class="layui-input" id="user_name">
                                            </div>
                                        </div>
                                                                                                                    <div class="layui-form-item layui-form-text" id="message_content_box">
                                        <label class="layui-form-label">留言内容</label>
                                        <div class="layui-input-block">
                                            <textarea placeholder="请输入留言内容" class="layui-textarea"
                                                      id="message_content"></textarea>
                                        </div>
                                    </div>
                                                                                                    <div class="layui-form-item" id="message_date_box">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">留言日期</label>
                                            <div class="layui-input-inline">
                                                <input type="text" class="layui-input" id="message_date"
                                                       placeholder="yyyy-MM-dd">
                                            </div>
                                        </div>
                                    </div>
                                                                            <div class="layui-form-item">
                                <label class="layui-form-label">审核状态</label>
                                <div class="layui-input-block">
                                    <select name="interest" lay-filter="examine_state" id="examine_state">
                                        <option value=""></option>
                                        <option value="0">未审核</option>
                                        <option value="1">已通过</option>
                                        <option value="2">未通过</option>
                                    </select>
                                </div>
                            </div>
                        
                                <div class="layui-form-item">
                                <label class="layui-form-label">审核回复</label>
                                <div class="layui-input-block">
                                    <input type="text" name="title" lay-verify="title" autocomplete="off"
                                           placeholder="请输入审核回复"
                                           class="layui-input" id="examine_reply">
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
    let message_feedback_id = location.search.substring(1)
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
        // if (   user_group == "管理员" ||$check_action('/message_feedback/view', 'add') || $check_action('/message_feedback/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "message_feedback_id";
            let url_add = "message_feedback";
            let url_set = "message_feedback";
            let url_get_obj = "message_feedback";
            let url_upload = "message_feedback"
            let query = {
                "message_feedback_id": 0,
            }

            let form_data2 = {
                                            "ordinary_users": 0, // 普通用户
                            "user_name":  '', // 用户姓名
                            "message_content":  '', // 留言内容
                            "message_date":  '', // 留言日期
                            "examine_state": "未审核",
                                        "examine_reply": "",
                                        "message_feedback_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/message_feedback/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/message_feedback/table") {
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
                var o = $get_power("/message_feedback/view");
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
                    $("#ordinary_users_box").show()
                } else {
                    if ($check_field('add', 'ordinary_users')){
                        $("#ordinary_users_box").show()
                    }else {
                        $("#ordinary_users_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#user_name_box").show()
                } else {
                    if ($check_field('add', 'user_name')){
                        $("#user_name_box").show()
                    }else {
                        $("#user_name_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#message_content_box").show()
                } else {
                    if ($check_field('add', 'message_content')){
                        $("#message_content_box").show()
                    }else {
                        $("#message_content_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#message_date_box").show()
                } else {
                    if ($check_field('add', 'message_date')){
                        $("#message_date_box").show()
                    }else {
                        $("#message_date_box").hide()
                    }
                }
            
                                                                                                                                                    
            
            
            
            
    
                                                                    
                            
                            
                                                // 日期选择
                    laydate.render({
                        elem: '#message_date'
                        , format: 'yyyy-MM-dd'
                        , done: function (value) {
                            form_data2.message_date = value + ' 00:00:00'
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
                                    
                            
                            
                                layui.form.on('select(examine_state)', function (data) {
                    form_data2.examine_state = data.elem[data.elem.selectedIndex].text;
                })
                if(user_group === '管理员' || (form_data2['examine_state'] && $check_examine()) || (!form_data2['examine_state'] && $check_examine())){
                    console.log(111)
                }else {
                    $("#examine_state").attr("disabled", "disabled");
                }
                                if(user_group === '管理员' || (form_data2['examine_reply'] && $check_examine()) || (!form_data2['examine_reply'] && $check_examine())){
                    console.log(111)
                }else {
                    $("#examine_reply").attr("disabled", "disabled");
                }
            
                                                                            //文本
                    let user_name = document.querySelector("#user_name")
                        user_name.onkeyup = function (event) {
                        form_data2.user_name = event.target.value
                    }
                    //文本
                                                                                                        //多文本
                    let message_content = document.querySelector("#message_content")
                    //多文本
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
                                                                    

            if (message_feedback_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/message_feedback/get_obj', {
                        params: {
                                message_feedback_id: message_feedback_id
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
                        
            
            
            
                                for (let key in data) {
                            if (key == 'examine_state') {
                                let alls = document.querySelector('#examine_state').querySelectorAll('option')
                                let test = data[key]
                                for (let i = 0; i < alls.length; i++) {
                                    if (alls[i].innerHTML == test) {
                                        alls[i].selected = true
                                        layui.form.render("select");
                                    }
                                }
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
                                            if (user_group === '管理员') {
                            $("#user_name_box").show()
                        } else {
                            if ($check_field('set', 'user_name') || $check_field('get', 'user_name')){
                                $("#user_name_box").show()
                            }else {
                                $("#user_name_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#message_content_box").show()
                        } else {
                            if ($check_field('set', 'message_content') || $check_field('get', 'message_content')){
                                $("#message_content_box").show()
                            }else {
                                $("#message_content_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#message_date_box").show()
                        } else {
                            if ($check_field('set', 'message_date') || $check_field('get', 'message_date')){
                                $("#message_date_box").show()
                            }else {
                                $("#message_date_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                
                                if (user_group === '管理员' || (form_data2['message_feedback_id'] && $check_field('set', 'ordinary_users')) || (!form_data2['message_feedback_id'] && $check_field('add', 'ordinary_users'))) {
                            }else {
                                $("#ordinary_users").attr("disabled", true);
                                $("#ordinary_users > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                user_name.value = form_data2.user_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['message_feedback_id'] && $check_field('set', 'user_name')) || (!form_data2['message_feedback_id'] && $check_field('add', 'user_name'))) {
                            }else {
                                $("#user_name").attr("disabled", true);
                                $("#user_name > input[name='file']").attr('disabled', true);
                            }
                                                                //多文本
                                message_content.value = form_data2.message_content
                            //多文本
                        
                                if (user_group === '管理员' || (form_data2['message_feedback_id'] && $check_field('set', 'message_content')) || (!form_data2['message_feedback_id'] && $check_field('add', 'message_content'))) {
                            }else {
                                $("#message_content").attr("disabled", true);
                                $("#message_content > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['message_feedback_id'] && $check_field('set', 'message_date')) || (!form_data2['message_feedback_id'] && $check_field('add', 'message_date'))) {
                            }else {
                                $("#message_date").attr("disabled", true);
                                $("#message_date > input[name='file']").attr('disabled', true);
                            }
                                                                                                                                                                                        message_date.value = layui.util.toDateString(form_data2.message_date, "yyyy-MM-dd")
                                                            layui.form.render("select");
                }
                axios_get_3()
            }


            
            submit.onclick = async function () {
                try {
                                                                                                //文本
                            form_data2.user_name = user_name.value
                            //文本
                                                                    //多文本
                            form_data2.message_content = message_content.value
                            //多文本
                                                                        form_data2.message_date = layui.util.toDateString(form_data2.message_date, "yyyy-MM-dd")
                                                    } catch (err) {
                    console.log(err)
                }
                                    let examine_reply = document.querySelector("#examine_reply")
                    form_data2.examine_reply = examine_reply.value
                            
            
                let customize_field = []
                                            customize_field.push({"field_name": "普通用户", "field_value": form_data2.ordinary_users});
                                                customize_field.push({"field_name": "用户姓名", "field_value": form_data2.user_name});
                                                customize_field.push({"field_name": "留言内容", "field_value": form_data2.message_content});
                                                customize_field.push({
                            "field_name": "留言日期",
                            "field_value": form_data2.message_date,
                            "type": "date"
                        });
                    
    
                if (message_feedback_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/message_feedback/add?',
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
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/message_feedback/set?message_feedback_id=' + message_feedback_id,
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
