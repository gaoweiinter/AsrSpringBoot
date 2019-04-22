<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" id="root">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> -->
<link href="https://semantic-ui.com/dist/components/reset.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/site.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/container.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/grid.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/header.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/image.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/menu.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/divider.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/dropdown.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/segment.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/button.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/list.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/icon.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/sidebar.css" rel="stylesheet" type="text/css">
<link href="https://semantic-ui.com/dist/components/transition.css" rel="stylesheet" type="text/css">

<style type="text/css">
.hidden.menu {
	display: none;
}

.masthead.segment {
	min-height: 700px;
	padding: 1em 0em;
}

.masthead .logo.item img {
	margin-right: 1em;
}

.masthead .ui.menu .ui.button {
	margin-left: 0.5em;
}

.masthead h1.ui.header {
	margin-top: 3em;
	margin-bottom: 0em;
	font-size: 4em;
	font-weight: normal;
}

.masthead h2 {
	font-size: 1.7em;
	font-weight: normal;
}

.ui.vertical.stripe {
	padding: 8em 0em;
}

.ui.vertical.stripe h3 {
	font-size: 2em;
}

.ui.vertical.stripe .button+h3, .ui.vertical.stripe p+h3 {
	margin-top: 3em;
}

.ui.vertical.stripe .floated.image {
	clear: both;
}

.ui.vertical.stripe p {
	font-size: 1.33em;
}

.ui.vertical.stripe .horizontal.divider {
	margin: 3em 0em;
}

.quote.stripe.segment {
	padding: 0em;
}

.quote.stripe.segment .grid .column {
	padding-top: 5em;
	padding-bottom: 5em;
}

.footer.segment {
	padding: 5em 0em;
}

.secondary.pointing.menu .toc.item {
	display: none;
}

@media only screen and (max-width: 700px) {
	.ui.fixed.menu {
		display: none !important;
	}
	.secondary.pointing.menu .item, .secondary.pointing.menu .menu {
		display: none;
	}
	.secondary.pointing.menu .toc.item {
		display: block;
	}
	.masthead.segment {
		min-height: 350px;
	}
	.masthead h1.ui.header {
		font-size: 2em;
		margin-top: 1.5em;
	}
	.masthead h2 {
		margin-top: 0.5em;
		font-size: 1.5em;
	}
}
</style>
<title>${title}</title>
<script type="text/javascript" src="/js/HZRecorder.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

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
            button.hidden = true;
            button.nextElementSibling.disabled = false;
            button.nextElementSibling.hidden = false;
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
            button.hidden = true;
            button.previousElementSibling.disabled = false;
            button.previousElementSibling.hidden = false;
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
<body class="ui container">
	<form id="questions">
		<div>
			<h1>语音识别演示</h1>
		</div>
		<input type="hidden" name="records[0].question" id="audioCommit"
			value="开始测试">
		<div>
			<h3>请用语音审批(通过/可以/同意)，被触发的按钮会变成灰色:</h3>
		</div>
		<div>
			<button onclick="startRecording(this)">录音</button>
			<button onclick="uploadAudio(this,1)" disabled hidden="true">批复</button>
			<div id="recordingslist1"></div>
		</div>
		<textarea id="audioText1" name="records[0].answer" rows="3" cols="50"
			style="font-size: 18px">${result} </textarea>
	</form>

	<form method="post" enctype="multipart/form-data">
		<h2>财务审批</h2>
		<br />
		<table>
			<tr>
				<td><input type="text" id="parsedData" name="audioData" /><br /></td>
			</tr>
			<tr>
				<td><button class="ui blue button" id="approveBtn" name="approveBtn"
					value="同意" onclick="popmsg(this)" >同意</button></td>
				<td><button class="ui black button" id="rejectBtn" name="rejectBtn"
					value="拒绝" onclick="popmsg(this)" >拒绝</button></td>
			</tr>
		</table>
	</form>


</body>
</html>