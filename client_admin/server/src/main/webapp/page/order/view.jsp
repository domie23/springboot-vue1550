<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<article class="sign_in">
    <div class="warp user">
        <div class="layui-container">
            <div class="layui-row">
                <form class="layui-form" action="">
                    <div class="layui-form-item">
                        <label class="layui-form-label">联系人姓名</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题"
                                   class="layui-input" id="contact_name">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">联系人手机</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题"
                                   class="layui-input" id="contact_phone">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">收件地址</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题"
                                   class="layui-input" id="contact_address">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">描述</label>
                        <div class="layui-input-block">
                            <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题"
                                   class="layui-input" id="description">
                        </div>
                    </div>
                    <div  class="layui-form-item">
                        <label class="layui-form-label">待付款</label>
                        <div class="layui-input-block">
                            <select name="interest" lay-filter="state" id="select">
                                <option value=""></option>
                                <option value="1">待付款</option>
                                <option value="2">已付款</option>
                            </select>
                        </div>
                    </div>
                    <div  class="layui-form-item">
                        <label class="layui-form-label">买家</label>
                        <div class="layui-input-block">
                            <select name="interest" lay-filter="email_state" id="selectt">
                                <option value=""></option>
                            </select>
                        </div>
                    </div>
                </form>
                <div class="layui-btn-container">
                    <button type="button" class="layui-btn layui-btn-normal" id="submit">确认/Confirm</button>
                    <button type="button" class="layui-btn layui-btn-normal" id="cancel">取消/Cancel</button>
                </div>
            </div>
        </div>
    </div>
</article>
</body>
<script src="../../layui/layui.js"></script>
<script src="../../js/axios.min.js" charset="utf-8"></script>
<script src="../../js/index.js"></script>
<script src="../../js/base.js" charset="utf-8"></script>

<script>
    var BaseUrl = baseUrl()
    layui.use(['element', 'layer', 'util'], async function () {
        var element = layui.element
            , layer = layui.layer
            , util = layui.util
            , table = layui.table
            , form = layui.form
            , $ = layui.$;

        let personInfo = JSON.parse(sessionStorage.personInfo)
        let token = localStorage.getItem('token') || null

        let user_group = personInfo.user_group
        let use_id = personInfo.user_id
        let order_id = location.search.substring(1)
        console.log(order_id)

        let {data: res} = await axios.get(BaseUrl + '/api/order/get_obj', {
            params: {
                order_id: order_id
            }
        })
        let value = res.result.obj
        let contact_name = document.querySelector("#contact_name")
        let contact_phone = document.querySelector("#contact_phone")
        let contact_address = document.querySelector("#contact_address")
        let description = document.querySelector("#description")
        contact_name.value = value.contact_name
        contact_phone.value = value.contact_phone
        contact_address.value = value.contact_address
        description.value = value.description

        let select =document.querySelector("#select")
        for (var i = 0; i < select.children.length; i++) {
            if (select.children[i].text == value.state) {
                select.children[i].setAttribute("selected", '1')
            }
        }

        let cancel = document.querySelector("#cancel")
        cancel.onclick = function () {
            window.location.replace("./table.jsp")
        }
        async function initt(url, id) {
            // 拿到单选框的父级节点
            var select = document.querySelector("#"+id);
            var op1 = document.createElement('option')
            op1.value = '0'
            select.appendChild(op1)
            // 收集数据 长度
            var count
            // 收集数据 数组
            var arr = []
            let { data: res } = await axios.get(url)
            count = res.result.count
            arr = res.result.list
            for (var i = 0; i < arr.length; i++) {
                // 创建节点
                var op = document.createElement('option')
                // 给节点赋值
                op.innerHTML = arr[i].nickname
                op.value = arr[i].user_id
                // 新增/Add节点
                select.appendChild(op)
                layui.form.render('select')
            }
            let selectt =document.querySelector("#selectt")
            for (var j = 0; j < selectt.children.length; j++) {
                if (selectt.children[j].value == value.user_id) {
                    select.children[j].setAttribute("selected", '1')
                }
            }
            layui.form.on('select(state)', function (data) {
                value['state'] = data.elem[data.elem.selectedIndex].text;
            })
            layui.form.render("select");
            layui.form.on('select(email_state)', function (data) {
                value['user_id'] = data.elem[data.elem.selectedIndex].value;
            })
            layui.form.render("select");
            layui.form.render('select')

        }
        initt(BaseUrl + '/api/user/get_list', 'selectt')

        layui.form.render("select");

        let submit =document.querySelector("#submit")
        submit.onclick = async function (){
            value.contact_name = contact_name.value
            value.contact_phone = contact_phone.value
            value.contact_address = contact_address.value
            value.description = description.value
            delete value.update_time
            delete value.type
            delete value.create_time


            const {data: res} = await axios.post(BaseUrl + '/api/order/set?order_id='+order_id, value, {
                headers: {
                    'x-auth-token': token,
                    'Content-Type': 'application/json'
                }
            })
            if (res.result == 1) {
                layer.msg('确认/Confirm成功');
                setTimeout(function () { window.location.replace("./table.jsp"); }, 1000)
            }
        }

    })
</script>
