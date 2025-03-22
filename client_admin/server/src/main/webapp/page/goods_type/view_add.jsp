<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 分类列表新增/Add -->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <script src="../../js/axios.min.js" charset="utf-8"></script>
  <link rel="stylesheet" href="../../layui/css/layui.css">
  <link rel="stylesheet" href="../../css/diy.css">
</head>

<body>
  <article class="sign_in">
    <div class="warp goods_type">
      <div class="layui-container">
        <div class="layui-row">
          <form class="layui-form" action="">
            <div class="layui-form-item">
              <label class="layui-form-label">分类名称</label>
              <div class="layui-input-block">
                <input type="text" name="title" lay-verify="title" autocomplete="off" placeholder="" class="layui-input"
                  id="name">
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

<script src="../../layui/layui.js" charset="utf-8"></script>
<script src="../../js/base.js" charset="utf-8"></script>

<script>
  var BaseUrl = baseUrl()
  let token = localStorage.getItem('token') || null

  let name = document.querySelector('#name')
  let submit = document.querySelector('#submit')

  let form = {
    type_id: 0,
    desc: "",
    icon: ""
  }
  submit.onclick = async function () {
    form['name'] = name.value
    const { data: ress } = await axios.post(BaseUrl + '/api/goods_type/add?',
      form, {
      headers: {
        'x-auth-token': token,
        'Content-Type': 'application/json'
      }
    }
    )
    if (ress.result == 1) {
      layer.msg('确认/Confirm成功');
      setTimeout(function () { window.location.replace("./table.jsp"); }, 1000)
    }
  }
</script>

</html>
