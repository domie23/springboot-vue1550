<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 分类列表详情/Details -->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="../../layui/css/layui.css">
  <link rel="stylesheet" href="../../css/diy.css">

  <script src="../../js/axios.min.js" charset="utf-8"></script>

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
                  id="orgName">
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
<script src="../../js/button.js"></script>
<script src="../../js/base.js" charset="utf-8"></script>

<script>
  var BaseUrl = baseUrl()
  layui.use(['upload', 'element', 'layer'], async function () {
    var $ = layui.jquery
      , upload = layui.upload
      , element = layui.element
      , layer = layui.layer;

    let token = localStorage.getItem('token') || null

    let orgName = document.querySelector('#orgName')
    let cancel = document.querySelector('#cancel')
    let submit = document.querySelector('#submit')

    let type_id = location.search.substring(1)
    let img
    const { data: rese } = await axios.get(BaseUrl+'/api/goods_type/get_obj', {
      params: {
        type_id: type_id
      }
    })
    img = rese.result.obj
    if (rese) {
      orgName.value = img.name
    }
    let set_data = {}
    submit.addEventListener('click', async function () {
      set_data['desc'] = img.desc
      set_data['icon'] = img.icon
      set_data['type_id'] = type_id
      set_data['name'] = orgName.value

      const { data: res } = await axios.post(BaseUrl+'/api/goods_type/set?type_id=' + type_id, set_data, {
        headers: {
          'x-auth-token': token,
          'Content-Type': 'application/json'
        }
      })
      if (res.result == 1) {
        layer.msg('确认/Confirm成功');
        setTimeout(function () { window.location.replace("./table.jsp"); }, 1000)
      }
    })
    cancel.onclick = function () {
      window.location = ('./table.jsp')
    }
  })
</script>

</html>
