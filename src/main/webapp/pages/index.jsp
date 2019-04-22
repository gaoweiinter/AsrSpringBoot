<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<!-- <html xmlns="http://www.w3.org/1999/xhtml"> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>${title}</title>
<!-- 新 Bootstrap 核心 CSS 文件 -->
<link
	href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">

<!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->
<!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->
<!--[if lt IE 9]>
      <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="/js/HZRecorder.js"></script>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script> -->
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script
	src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
        function save() {
            $.ajax({
                type: "POST",
                dataType: "json",
                url: "<%=path%>/audio/saveRecord",
                data: $('#questions').serialize(),
                success: function (result) {
                    if (result) {
                        alert("添加成功");
                    }else {
                        alert("添加失败");
                    }
                },
                error : function() {
                    alert("异常！");
                }
            });
        }
    
        var recorder;
        var audio = document.querySelector('audio');
        
        // 开始录音
        function startRecording(button) {
            button.disabled = true;
            button.className="btn btn-primary hidden";
            button.nextElementSibling.disabled = false;
            button.nextElementSibling.className="btn btn-primary show";
            HZRecorder.get(function (rec) {
                recorder = rec;
                recorder.start();
            });
            
            document.getElementById("approveBtn").disabled = false;
            document.getElementById("rejectBtn").disabled = false;
        }
        
        // 播放录音
        function playRecording() {
            recorder.play(audio);
        }
        
        // 转换录音
        function uploadAudio(button,num) {
            button.disabled = true;
            button.className="btn btn-primary hidden";
            button.previousElementSibling.disabled = false;
            button.previousElementSibling.className="btn btn-primary show";
            recorder.stop();
            recorder.upload("<%=path%>/audio/upload", num);

		//createDownloadLink(num);

	}

	// 创建下载链接
	function createDownloadLink(num) {
		var blob = recorder.getBlob();
		var url = URL.createObjectURL(blob);
		var div = document.createElement('div');
		var au = document.createElement('audio');
		var hf = document.createElement('a');
		var record = "recordingslist" + num;

		au.controls = true;
		au.src = url;
		hf.href = url;
		hf.download = new Date().toISOString() + '.wav';
		hf.innerHTML = hf.download;
		div.appendChild(au);
		div.appendChild(hf);
		document.getElementById(record).appendChild(div);
	}

	function popmsg(button) {
		alert(button.value);
		button.disabled = true;
	}
</script>
</head>
<body>
	<div class="container">
		<ul class="nav nav-pills">
			<li class="active"><a href="#">Home</a></li>
			<li><a href="#">Yigo平台</a></li>
			<li><a href="#">Yigo ERP</a></li>
			<li><a href="#">日志系统</a></li>
		</ul>
		<form id="questions">
			<div class="page-header">
				<h1>语音识别演示</h1>
			</div>
			<input type="hidden" name="records[0].question" id="audioCommit"
				value="开始测试">
			<div>
				<p>请用语音审批，自动触发的按钮会变成灰色:</p>
				<small>只要语句中包含<b>通过/可以/同意</b>，则会触发”同意“，否则触发”拒绝“
				</small>
			</div>
			<br/><br/>
			<div>
				<button class="btn btn-primary" onclick="startRecording(this)">录音</button>
				<button class="btn btn-primary hidden" onclick="uploadAudio(this,1)"
					disabled hidden="true">批复</button>
				<div id="recordingslist1"></div>

				<textarea id="audioText1" name="records[0].answer" rows="3"
					cols="50">${result} </textarea>
			</div>
		</form>
	</div>
	<div class="container">
		<form method="post" enctype="multipart/form-data">
			<h2>财务审批</h2>
			<br />
			<div class="table-responsive">
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>财务审批</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" id="parsedData" name="audioData" /><br /></td>
						</tr>
					</tbody>

				</table>
				<div class="btn-group">
					<button class="btn btn-success" id="approveBtn" name="approveBtn"
						value="同意" onclick="popmsg(this)">同意</button>
				</div>
				<div class="btn-group">
					<button class="btn btn-danger" id="rejectBtn" name="rejectBtn"
						value="拒绝" onclick="popmsg(this)">拒绝</button>
				</div>


			</div>
		</form>
	</div>

</body>
</html>