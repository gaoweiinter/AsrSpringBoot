<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<!DOCTYPE html>
<!-- <html xmlns="http://www.w3.org/1999/xhtml"> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
 <base href="<%=basePath%>">
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
            recorder.upload("<%=path%>/audio/upload", num );

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
	
	function approveOrderById(id) {
		 $.ajax({
	            type: "POST",
	            async: false,
	            dataType: "json",
	            url: "<%=path%>/applyorder/approveById",
	            data: 'id=' +id,
	            success: function (result) {
	           	 location.reload();
	            }
	        });
	}
	
	function deleteOrderById(id) {
		 $.ajax({
	            type: "POST",
	            async: false,
	            dataType: "json",
	            url: "<%=path%>/applyorder/delOrderById",
	            data: 'id=' +id,
	            success: function (result) {
	           	location.reload();
	            }
	        });
	}
</script>

<script type="text/javascript"> 
 //模拟一段JSON数据，实际要从数据库中读取 
 //var per = ${applyOrdersResult};
 
 $.ajax({
     type: "POST",
     dataType: "json",
     url: "<%=path%>/applyorder/getAll",
     success: function (per) {
    	 window.onload = function(){ 
    		   var tbody = document.getElementById('tbMainApplyOrder'); 
    		   for(var i = 0;i < per.length; i++){ //遍历一下json数据 
    		     var trow = getDataRow(per[i]); //定义一个方法,返回tr数据 
    		     tbody.appendChild(trow); 
    		    } 
    	 } 
   		 function getDataRow(h){ 
   		   var row = document.createElement('tr'); //创建行 
   		   var idCell = document.createElement('td'); //创建第一列id 
   		   idCell.innerHTML = h.id; //填充数据 
   		   row.appendChild(idCell); //加入行 ，下面类似 
   		   var nameCell = document.createElement('td');//创建第二列name 
   		   nameCell.innerHTML = h.message; 
   		   row.appendChild(nameCell); 
   		   var jobCell = document.createElement('td');//创建第三列job 
   		   jobCell.innerHTML = h.orderstatus; 
   		   row.appendChild(jobCell); 
   		   //到这里，json中的数据已经添加到表格中，下面为每行末尾添加删除按钮 
   		   var approveCell = document.createElement('td');//创建第四列，操作列 
   		   row.appendChild(approveCell); 
   		   var btnApprove = document.createElement('input'); //创建一个input控件 
   		   btnApprove.setAttribute('type','button'); //type="button" 
   		   btnApprove.setAttribute('value','批准');  
   		   //删除操作 
   		   btnApprove.onclick=function( ){ 
               $.ajax({
                   type: "POST",
                   url: "<%=path%>/applyorder/approveAll",                   
                   success: function (result) {                      
                           alert(result);   
                   },
                   error : function() {
                       alert("异常！");
                   }
               });
   		   } 
   		   approveCell.appendChild(btnApprove); //把删除按钮加入td，别忘了 
   		   return row; //返回tr数据   
   	   }   

     },
     error : function() {
         alert("异常！");
     }
 });

 /* window.onload = function(){ 
   var tbody = document.getElementById('tbMainApplyOrder'); 
   for(var i = 0;i < per.length; i++){ //遍历一下json数据 
     var trow = getDataRow(per[i]); //定义一个方法,返回tr数据 
     tbody.appendChild(trow); 
    } 
   } 
 function getDataRow(h){ 
   var row = document.createElement('tr'); //创建行 
   var idCell = document.createElement('td'); //创建第一列id 
   idCell.innerHTML = h.id; //填充数据 
   row.appendChild(idCell); //加入行 ，下面类似 
   var nameCell = document.createElement('td');//创建第二列name 
   nameCell.innerHTML = h.message; 
   row.appendChild(nameCell); 
   var jobCell = document.createElement('td');//创建第三列job 
   jobCell.innerHTML = h.orderstatus; 
   row.appendChild(jobCell); 
   //到这里，json中的数据已经添加到表格中，下面为每行末尾添加删除按钮 
   var delCell = document.createElement('td');//创建第四列，操作列 
   row.appendChild(delCell); 
   var btnDel = document.createElement('input'); //创建一个input控件 
   btnDel.setAttribute('type','button'); //type="button" 
   btnDel.setAttribute('value','删除');  
   //删除操作 
   btnDel.onclick=function(){ 
     if(confirm("确定删除这一行嘛？")){ 
       //找到按钮所在行的节点，然后删掉这一行 
       this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode); 
       //btnDel - td - tr - tbody - 删除(tr) 
       //刷新网页还原。实际操作中，还要删除数据库中数据，实现真正删除 
       } 
     } 
   delCell.appendChild(btnDel); //把删除按钮加入td，别忘了 
   return row; //返回tr数据   
   }    */
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
				<small>只要语句中包含<b>通过/可以/同意</b>，则会触发”同意“，否则触发”拒绝“</small>
			</div>
			<br /> <br />
			<div>
				<button class="btn btn-primary" onclick="startRecording(this)">录音</button>
				<button class="btn btn-primary hidden" onclick="uploadAudio(this,1)"
					disabled hidden="true">批复</button>
				<div id="recordingslist1"></div>

				<textarea id="audioText1" name="records[0].answer" rows="3" cols="50">${result} </textarea>
			</div>
		</form>
	</div>
	<div class="container">
		<form method="post" enctype="multipart/form-data" style="display: none">
			<h2>财务审批</h2>
			<br />
			<div class="table-responsive">
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>编号</th>
							<th>申请说明</th>
							<th>状态</th>
							<th>申请日期</th>
						</tr>
					</thead>
					<tbody>
						<tr class="success">
							<td>1</td>
							<td><input type="text" id="parsedData" name="audioData" /><br /></td>
							<td>new</td>
							<td>20/03/2019</td>
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
	
	<div class="container">
		<form method="post" enctype="multipart/form-data" >
			<div class="table-responsive">			
				<table class="table table-striped table-bordered" style="display: none">
					<thead>
						<tr>
							<th>编号</th>
							<th>申请说明</th>
							<th>状态</th>
						</tr>
					</thead>
				    <tbody id="tbMainApplyOrder"></tbody> 
				</table>
			</div>
		</form>
	</div>	

<div class="container">
<form enctype="multipart/form-data">
	<div class="table-responsive">	
	<table class="table table-striped table-bordered" id="tApplyOrders">
	    <h6><a href="<%=basePath%>/applyorder/approveAll" >一键批准</a></h6>
		<tbody>
			<tr>
	            <th>编号</th>
				<th>申请说明</th>
				<th>状态</th>
				<th>申请日期</th>
				<th>编辑</th>
				<th>删除</th>
			</tr>
			<c:if test="${!empty orders}">
				<c:forEach items="${ orders }" var="order">
					<tr>
						<td>${order.id}</td>
						<td>${order.message}</td>
						<td>${order.orderstatus}</td>
						<td>${order.createdate}</td>
						<td><a href="#" onclick = "approveOrderById(${order.id})">同意</a></td>	
						<td><a href="#" onclick = "deleteOrderById(${order.id})">删除</a></td>										
					</tr>				
				</c:forEach>
			</c:if>
		</tbody>		 
	</table>	
	</div>
	</form>
</div>	
</body>
</html>