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
            button.nextElementSibling.disabled = false;
            HZRecorder.get(function (rec) {
                recorder = rec;
                recorder.start();
            });
        }
        
        // 播放录音
        function playRecording() {
            recorder.play(audio);
        }
        
        // 转换录音
        function uploadAudio(button,num) {
            button.disabled = true;
            button.previousElementSibling.disabled = false;
            recorder.stop();
            recorder.upload("<%=path%>
	/audio/upload", num);

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
</script>
</head>
<body>
	<div>
		<b>${name} </b>
	</div>

	<form id="questions">
		<div>
			<h1>回答问题</h1>
		</div>
		<input type="hidden" name="records[0].question" id="audioCommit"
			value="开始测试">
		<div>
			<h3>问题一：开始测试</h3>
		</div>
		<div>
			<button onclick="startRecording(this)">录音</button>
			<button onclick="uploadAudio(this,1)" disabled>转换</button>
			<div id="recordingslist1"></div>
		</div>
		<textarea id="audioText1" name="records[0].answer" rows="3" cols="50"
			style="font-size: 18px">${result} </textarea>

		<input type="hidden" name="records[1].question"
			value="BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB">
		<div>
			<h3>问题二：BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB</h3>
		</div>
		<div>
			<button onclick="startRecording(this)">录音</button>
			<button onclick="uploadAudio(this,2)" disabled>转换</button>
			<div id="recordingslist2"></div>
		</div>
		<textarea id="audioText2" name="records[1].answer" rows="3" cols="50"
			style="font-size: 18px"></textarea>

		<input type="hidden" name="records[2].question"
			value="CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC">
		<div>
			<h3>问题三：CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC</h3>
		</div>
		<div>
			<button onclick="startRecording(this)">录音</button>
			<button onclick="uploadAudio(this,3)" disabled>转换</button>
			<div id="recordingslist3"></div>
		</div>
		<textarea id="audioText3" name="records[2].answer" rows="3" cols="50"
			style="font-size: 18px"></textarea>
		<br> <input id="saveBtn" type="button" onclick="save()"
			value="保存录音" />
	</form>
	<a href="<%=path%>/audio/getAllRecord">查看记录详情</a>

	<form action="<%=path%>/audio/getaudio" method="post"
		enctype="multipart/form-data">
		<h2>文件上传</h2>
		文件:<input type="file" name="audioData" /><br /> <br /> <input
			type="submit" value="上传" />
	</form>


</body>
</html>