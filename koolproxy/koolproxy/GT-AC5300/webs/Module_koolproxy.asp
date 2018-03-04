﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<meta HTTP-EQUIV="Expires" CONTENT="-1"/>
<link rel="shortcut icon" href="images/favicon.png"/>
<link rel="icon" href="images/favicon.png"/>
<title>软件中心 - koolproxy</title>
<link rel="stylesheet" type="text/css" href="index_style.css"/>
<link rel="stylesheet" type="text/css" href="form_style.css"/>
<link rel="stylesheet" type="text/css" href="usp_style.css"/>
<link rel="stylesheet" type="text/css" href="css/element.css">
<link rel="stylesheet" type="text/css" href="/device-map/device-map.css">
<link rel="stylesheet" type="text/css" href="/res/softcenter.css">
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/validator.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
<script type="text/javascript" src="/client_function.js"></script>
<script type="text/javascript" src="/res/softcenter.js"></script>
<style>
.cloud_/koolshare_radius h2 { border-bottom:1px #AAA dashed;}
.cloud_main_radius h3 { font-size:12px;color:#FFF;font-weight:normal;font-style: normal;}
.cloud_main_radius h4 { font-size:12px;color:#FC0;font-weight:normal;font-style: normal;}
.cloud_main_radius h5 { color:#FFF;font-weight:normal;font-style: normal;}
.kp_btn {
	border: 1px solid #222;
	background: linear-gradient(to bottom, #003333  0%, #000000 100%); /* W3C */
	background: linear-gradient(to bottom, #91071f  0%, #700618 100%); /* W3C */
	font-size:10pt;
	color: #fff;
	padding: 5px 5px;
	border-radius: 5px 5px 5px 5px;
	width:14%;
}
.kp_btn:hover {
	border: 1px solid #222;
	background: linear-gradient(to bottom, #27c9c9  0%, #279fd9 100%); /* W3C */
	background: linear-gradient(to bottom, #cf0a2c  0%, #91071f 100%); /* W3C */
	font-size:10pt;
	color: #fff;
	padding: 5px 5px;
	border-radius: 5px 5px 5px 5px;
	width:14%;
}
#log_content3, #loading_block2, #log_content1 {line-height:1.5}
#log_content3, #log_content1 { -ms-overflow-style: none; overflow: auto; } /* for IE hide scrollbar on ss node ta */
#log_content3::-webkit-scrollbar, #log_content1::-webkit-scrollbar {
    width: 0px;  /* remove scrollbar space */
    background: transparent;  /* optional: just make scrollbar invisible */
}
#log_content3:focus, #log_content1:focus {
	outline: none;
}

#log_content3, #log_content1 {overflow: -moz-scrollbars-none;}
.contentM_qis {
	position: absolute;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius:10px;
	z-index: 10;
	/*background-color:#2B373B;*/
	margin-left: -215px;
	top: 240px;
	width:980px;
	return height:auto;
	box-shadow: 3px 3px 10px #000;
	background: rgba(0,0,0,0.85);
	display:none;
}

.user_title{
	text-align:center;
	font-size:18px;
	color:#99FF00;
	padding:10px;
	font-weight:bold;
}
.input_option_2{
	height:25px;
	background-color:#475a5f;
	border: 0px solid #222;
	color:#FFFFFF;
	font-family: Lucida Console;
	font-size:13px;
	border:1px solid #91071f;
	background-color: #3e030d;
}

.input_option_2:hover{
	height:25px;
	background-color:#576D73;
	border: 0px solid #222;
	color:#FFFFFF;
	font-family: Lucida Console;
	font-size:13px;
	border:1px solid #91071f;
	background-color: #3e030d;
}
</style>
<script>
var dbus = {};
var _responseLen;
var noChange = 0;
var reload = 0;
function init() {
	show_menu(menu_hook);
	get_dbus_data();
	generate_options();
	refresh_acl_table();
	update_visibility();
	get_user_rule();
	hook_event();
	get_run_status();
    showDropdownClientList('setClientIP', 'ip', 'all', 'ClientList_Block', 'pull_arrow', 'online');
}

function get_dbus_data(){
	$.ajax({
	  	type: "GET",
	 	url: "/_api/koolproxy_",
	  	dataType: "json",
	  	async:false,
	 	success: function(data){
	 	 	dbus = data.result[0];
			conf2obj();
	  	}
	});
}

function hook_event(){
	$("#log_content2").click(
		function() {
		x = -10;
	});
	$("#download_cert").click(
	function() {
		location.href = "http://110.110.110.110";
	});
	$("#koolproxy_github").click(
		function() {
		window.open("https://github.com/koolproxy/koolproxy_rules");
	});
	$("#koolproxy_enable").click(
		function(){
		if(E('koolproxy_enable').checked){
			dbus["koolproxy_enable"] = "1";
			dbus["koolproxy_basic_action"] = "1";
			E("policy_tr").style.display = "";
			E("kp_status").style.display = "";
			E("auto_reboot_switch").style.display = "";
			E("rule_update_switch").style.display = "";
			E("cert_download_tr").style.display = "";
			E("klloproxy_com").style.display = "";
			E("acl_method_tr").style.display = "";
			E("ACL_table").style.display = "";
			E("ACL_note").style.display = "";
		}else{
			dbus["koolproxy_enable"] = "0";
			dbus["koolproxy_basic_action"] = "0";
			E("policy_tr").style.display = "none";
			E("kp_status").style.display = "none";
			E("auto_reboot_switch").style.display = "none";
			E("rule_update_switch").style.display = "none";
			E("cert_download_tr").style.display = "none";
			E("klloproxy_com").style.display = "none";
			E("acl_method_tr").style.display = "none";
			E("ACL_table").style.display = "none";
			E("ACL_note").style.display = "none";
		}
	});
}

function generate_options(){
	for(var i = 0; i < 24; i++) {
		$("#koolproxy_reboot_hour").append("<option value='"  + i + "'>" + i + "点</option>");
		$("#koolproxy_reboot_hour").val(3);
		$("#koolproxy_reboot_inter_hour").append("<option value='"  + i + "'>" + i + "时</option>");
		$("#koolproxy_reboot_inter_hour").val(12);
	}
	for(var i = 0; i < 60; i++) {
		$("#koolproxy_reboot_min").append("<option value='"  + i + "'>" + i + "分</option>");
		$("#koolproxy_reboot_inter_min").append("<option value='"  + i + "'>" + i + "分</option>");
		$("#koolproxy_reboot_min").val(30);
		$("#koolproxy_reboot_inter_min").val(0);
	}
}

function get_run_status(){
	var id = parseInt(Math.random() * 100000000);
	var postData = {"id": id, "method": "KoolProxy_status.sh", "params":[2], "fields": ""};
	$.ajax({
		type: "POST",
		cache:false,
		url: "/_api/",
		data: JSON.stringify(postData),
		dataType: "json",
		success: function(response){
			E("koolproxy_status").innerHTML = response.result.split("@@")[0];
			E("koolproxy_rule_status").innerHTML = response.result.split("@@")[1];
			setTimeout("get_run_status();", 10000);
		},
		error: function(){
			E("koolproxy_status").innerHTML = "获取运行状态失败！";
			E("koolproxy_rule_status").innerHTML = "获取规则状态失败！";
			setTimeout("get_run_status();", 5000);
		}
	});
}

function get_user_rule() {
	$.ajax({
		url: '/_temp/user.txt',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(res) {
			$('#usertxt').val(res);
		}
	});
}

function menu_hook() {
	tabtitle[tabtitle.length -1] = new Array("", "koolproxy", "__INHERIT__");
	tablink[tablink.length -1] = new Array("", "Module_koolproxy.asp", "NULL");
}

function conf2obj(){
	var params = ["koolproxy_mode", "koolproxy_reboot", "koolproxy_reboot_hour", "koolproxy_reboot_min", "koolproxy_reboot_inter_hour", "koolproxy_reboot_inter_min", "koolproxy_acl_method"];
	E("koolproxy_enable").checked = dbus["koolproxy_enable"] == "1";
	for (var i = 0; i < params.length; i++) {
    	if(dbus[params[i]]){
			E(params[i]).value = dbus[params[i]];
	    }
	}
}

function reload_Soft_Center(){
	location.href = "/Module_Softcenter.asp";
}

function update_visibility(){
	if(dbus["koolproxy_enable"] == "1"){
		E("policy_tr").style.display = "";
		E("kp_status").style.display = "";
		E("auto_reboot_switch").style.display = "";
		E("rule_update_switch").style.display = "";
		E("cert_download_tr").style.display = "";
		E("klloproxy_com").style.display = "";
		E("acl_method_tr").style.display = "";
		E("ACL_table").style.display = "";
		E("ACL_note").style.display = "";
	}else{
		E("policy_tr").style.display = "none";
		E("kp_status").style.display = "none";
		E("auto_reboot_switch").style.display = "none";
		E("rule_update_switch").style.display = "none";
		E("cert_download_tr").style.display = "none";
		E("klloproxy_com").style.display = "none";
		E("acl_method_tr").style.display = "none";
		E("ACL_table").style.display = "none";
		E("ACL_note").style.display = "none";
	}
	showhide("koolproxy_reboot_hour_span", (E("koolproxy_reboot").value == 1));
	showhide("koolproxy_reboot_interval_span", (E("koolproxy_reboot").value == 2));
}

function get_log(){
	$.ajax({
		url: '/_temp/kp_log.txt',
		type: 'GET',
		cache:false,
		dataType: 'text',
		success: function(response) {
			var retArea = E("log_content3");
			if (response.search("XU6J03M6") != -1) {
				retArea.value = response.replace("XU6J03M6", " ");
				E("ok_button").style.display = "";
				retArea.scrollTop = retArea.scrollHeight;
				if (reload == 1){
					x = 6;
					count_down_close();
					return true;
				}else{
					E("ok_button").style.display = "";
					return true;
				}
			}
			if (_responseLen == response.length) {
				noChange++;
			} else {
				noChange = 0;
			}
			if (noChange > 1000) {
				return false;
			} else {
				setTimeout("get_log();", 50);
			}
			retArea.value = response.replace("XU6J03M6", " ");
			retArea.scrollTop = retArea.scrollHeight;
			_responseLen = response.length;
		}
	});
}

function showKPLoadingBar(seconds){
	if(window.scrollTo)
		window.scrollTo(0,0);

	disableCheckChangedStatus();
	
	htmlbodyforIE = document.getElementsByTagName("html");  //this both for IE&FF, use "html" but not "body" because <!DOCTYPE html PUBLIC.......>
	htmlbodyforIE[0].style.overflow = "hidden";	  //hidden the Y-scrollbar for preventing from user scroll it.
	
	winW_H();

	var blockmarginTop;
	var blockmarginLeft;
	if (window.innerWidth)
		winWidth = window.innerWidth;
	else if ((document.body) && (document.body.clientWidth))
		winWidth = document.body.clientWidth;
	
	if (window.innerHeight)
		winHeight = window.innerHeight;
	else if ((document.body) && (document.body.clientHeight))
		winHeight = document.body.clientHeight;

	if (document.documentElement  && document.documentElement.clientHeight && document.documentElement.clientWidth){
		winHeight = document.documentElement.clientHeight;
		winWidth = document.documentElement.clientWidth;
	}

	if(winWidth >1050){
	
		winPadding = (winWidth-1050)/2;	
		winWidth = 1105;
		blockmarginLeft= (winWidth*0.3)+winPadding-150;
	}
	else if(winWidth <=1050){
		blockmarginLeft= (winWidth)*0.3+document.body.scrollLeft-160;

	}
	
	if(winHeight >660)
		winHeight = 660;
	
	blockmarginTop= winHeight*0.3-140		
	E("loadingBarBlock").style.marginTop = blockmarginTop+"px";
	E("loadingBarBlock").style.marginLeft = blockmarginLeft+"px";
	E("loadingBarBlock").style.width = 770+"px";
	E("LoadingBar").style.width = winW+"px";
	E("LoadingBar").style.height = winH+"px";
	loadingSeconds = seconds;
	progress = 100/loadingSeconds;
	y = 0;
	LoadingKPProgress(seconds);
}

function LoadingKPProgress(seconds){
	E("LoadingBar").style.visibility = "visible";
	if (E("koolproxy_enable").checked == false){
		E("loading_block3").innerHTML = "koolproxy关闭中 ..."
		$("#loading_block2").html("<li><font color='#ffcc00'><a href='http://www.koolshare.cn' target='_blank'></font>koolproxy工作有问题？请来我们的<font color='#ffcc00'>论坛www.koolshare.cn</font>反应问题...</font></li>");
	} else {
		$("#loading_block2").html("<font color='#ffcc00'>----------------------------------------------------------------------------------------------------------------------------------");
		if (dbus["koolproxy_basic_action"] == 1){
			E("loading_block3").innerHTML = "开启koolproxy ..."
		}else if (dbus["koolproxy_basic_action"] == 2){
			E("loading_block3").innerHTML = "更新koolproxy规则列表 ..."
		}else if (dbus["koolproxy_basic_action"] == 3){
			E("loading_block3").innerHTML = "上传证书 ..."
		}else if (dbus["koolproxy_basic_action"] == 4){
			E("loading_block3").innerHTML = "保存user.txt ..."
		}
	}
}

function hideKPLoadingBar(){
	x = -1;
	E("LoadingBar").style.visibility = "hidden";
	refreshpage();
}

var x = 6;
function count_down_close() {
	if (x == "0") {
		hideKPLoadingBar();
	}
	if (x < 0) {
		E("ok_button1").value = "手动关闭"
		return false;
	}
	E("ok_button1").value = "自动关闭（" + x + "）"
		--x;
	setTimeout("count_down_close();", 1000);
}
	var acl_node_max = 0;

function getACLConfigs() {
	var dict = {};
	for (var field in dbus) {
		names = field.split("_");
		dict[names[names.length - 1]] = 'ok';
	}
	acl_confs = {};
	var p = "koolproxy_acl";
	var params = ["ip", "name", "mode"];
	for (var field in dict) {
		var obj = {};
		if (typeof dbus[p + "_mac_" + field] == "undefined") {
			obj["mac"] = '';
		} else {
			obj["mac"] = dbus[p + "_mac_" + field];
		}
		for (var i = 0; i < params.length; i++) {
			var ofield = p + "_" + params[i] + "_" + field;
			if (typeof dbus[ofield] == "undefined") {
				obj = null;
				break;
			}
			obj[params[i]] = dbus[ofield];
		}
		if (obj != null) {
			var node_a = parseInt(field);
			if (node_a > acl_node_max) {
				acl_node_max = node_a;
			}
			obj["acl_node"] = field;
			acl_confs[field] = obj;
		}
	}
	return acl_confs;
}

function addTr() {
	var acls = {};
	var p = "koolproxy_acl";
	acl_node_max += 1;
	var params = ["ip", "name", "mac", "mode"];
	for (var i = 0; i < params.length; i++) {
		acls[p + "_" + params[i] + "_" + acl_node_max] = $('#' + p + "_" + params[i]).val();
	}

	var id = parseInt(Math.random() * 100000000);
	var postData = {"id": id, "method": "dummy_script.sh", "params":[2], "fields": acls};
	$.ajax({
		type: "POST",
		cache:false,
		url: "/_api/",
		data: JSON.stringify(postData),
		dataType: "json",
		success: function(response) {
			if (response.result == id){
				refresh_acl_table();
				E("koolproxy_acl_name").value = "";
				E("koolproxy_acl_ip").value = "";
				E("koolproxy_acl_mac").value = "";
				E("koolproxy_acl_mode").value = "1";
			}
		}
	});
	aclid = 0;
}

function delTr(o) {
	var id = $(o).attr("id");
	var ids = id.split("_");
	var p = "koolproxy_acl";
	id = ids[ids.length - 1];
	var acls = {};
	var params = ["ip", "name", "mac", "mode"];
	for (var i = 0; i < params.length; i++) {
		acls[p + "_" + params[i] + "_" + id] = "";
	}
	var id = parseInt(Math.random() * 100000000);
	var postData = {"id": id, "method": "dummy_script.sh", "params":[2], "fields": acls};
	$.ajax({
		type: "POST",
		cache:false,
		url: "/_api/",
		data: JSON.stringify(postData),
		dataType: "json",
		success: function(response) {
			refresh_acl_table();
		}
	});
}

function refresh_acl_table() {
	$.ajax({
		type: "GET",
		url: "/_api/koolproxy_",
		dataType: "json",
		async:false,
		success: function(response){
			dbus=response.result[0];
			$("#ACL_table").find("tr:gt(2)").remove();
			$('#ACL_table tr:last').after(refresh_acl_html());
			for (var i = 1; i < acl_node_max + 1; i++) {
				$('#koolproxy_acl_mode_' + i).val(dbus["koolproxy_acl_mode_" + i]);
				$('#koolproxy_acl_name_' + i).val(dbus["koolproxy_acl_name_" + i]);
			}
			if (typeof dbus["koolproxy_acl_default"] !== "undefined"){
				$('#koolproxy_acl_default').val(dbus["koolproxy_acl_default"]);
			}else{
				$('#koolproxy_acl_default').val("1");
			}
	  	}
	});
}

function refresh_acl_html() {
	acl_confs = getACLConfigs();
	var n = 0;
	for (var i in acl_confs) {
		n++;
	}
	var code = '';
	for (var field in acl_confs) {
		var ac = acl_confs[field];
		code = code + '<tr>';
		code = code + '<td>';
		code = code + '<input type="text" placeholder="" id="koolproxy_acl_ip_' + ac["acl_node"] + '" name="koolproxy_acl_ip_' + ac["acl_node"] + '" class="input_option_2" maxlength="50" style="width:140px;" value="' + ac["ip"] + '" />';
		code = code + '</td>';
		code = code + '<td>';
		code = code + '<input type="text" placeholder="" id="koolproxy_acl_mac_' + ac["acl_node"] + '" name="koolproxy_acl_mac_' + ac["acl_node"] + '" class="input_option_2" maxlength="50" style="width:140px;" value="' + ac["mac"] + '" />';
		code = code + '</td>';
		code = code + '<td>';
		code = code + '<input type="text" placeholder="" id="koolproxy_acl_name_' + ac["acl_node"] + '" name="koolproxy_acl_name_' + ac["acl_node"] + '" class="input_option_2" maxlength="50" style="width:140px;" placeholder="" />';
		code = code + '</td>';
		code = code + '<td>';
		code = code + '<select id="koolproxy_acl_mode_' + ac["acl_node"] + '" name="koolproxy_acl_mode_' + ac["acl_node"] + '" style="width:160px;margin:0px 0px 0px 2px;" class="input_option_2">';
		code = code + '<option value="1">http only</option>';
		code = code + '<option value="2">http + https</option>';
		code = code + '<option value="0">不过滤</option>';
		code = code + '</select>'
		code = code + '</td>';
		code = code + '<td>';
		code = code + '<input style="margin: -3px 0px -5px 6px;" id="acl_node_' + ac["acl_node"] + '" class="remove_btn" type="button" onclick="delTr(this);" value="">'
		code = code + '</td>';
		code = code + '</tr>';
	}
	code = code + '<tr>';
	if (n == 0) {
		code = code + '<td>所有主机</td>';
	} else {
		code = code + '<td>其它主机</td>';
	}
	code = code + '<td>缺省规则</td>';
	code = code + '<td>缺省规则</td>';
	code = code + '<td>';
	code = code + '<select id="koolproxy_acl_default" name="koolproxy_acl_default" style="width:160px;margin:0px 0px 0px 2px;" class="input_option_2";">';
	code = code + '<option value="1" selected>http only</option>';
	code = code + '<option value="2">http + https</option>';
	code = code + '<option value="0">不过滤</option>';
	code = code + '</select>';
	code = code + '</td>';
	code = code + '<td>';
	code = code + '</td>';
	code = code + '</tr>';
	return code;
}

function setClientIP(ip , name, mac){
	E("koolproxy_acl_ip").value = ip;
	E("koolproxy_acl_name").value = name;
	E("koolproxy_acl_mac").value = mac;
	hideClients_Block();
}

function pullLANIPList(obj){
	var element = E('ClientList_Block');
	var isMenuopen = element.offsetWidth > 0 || element.offsetHeight > 0;
	if(isMenuopen == 0){
		obj.src = "/images/arrow-top.gif"
		element.style.display = 'block';
	}
	else
		hideClients_Block();
}

function hideClients_Block(){
	E("pull_arrow").src = "/images/arrow-down.gif";
	E('ClientList_Block').style.display='none';
	validator.validIPForm(E("koolproxy_acl_ip"), 0);
}


function showDropdownClientList(_callBackFun, _callBackFunParam, _interfaceMode, _containerID, _pullArrowID, _clientState) {
	document.body.addEventListener("click", function(_evt) {control_dropdown_client_block(_containerID, _pullArrowID, _evt);})
	if(clientList.length == 0){
		setTimeout(function() {
			genClientList();
			showDropdownClientList(_callBackFun, _callBackFunParam, _interfaceMode, _containerID, _pullArrowID);
		}, 500);
		return false;
	}

	var htmlCode = "";
	htmlCode += "<div id='" + _containerID + "_clientlist_online'></div>";
	htmlCode += "<div id='" + _containerID + "_clientlist_dropdown_expand' class='clientlist_dropdown_expand' onclick='expand_hide_Client(\"" + _containerID + "_clientlist_dropdown_expand\", \"" + _containerID + "_clientlist_offline\");' onmouseover='over_var=1;' onmouseout='over_var=0;'>Show Offline Client List</div>";
	htmlCode += "<div id='" + _containerID + "_clientlist_offline'></div>";
	E(_containerID).innerHTML = htmlCode;

	var param = _callBackFunParam.split(">");
	var clientMAC = "";
	var clientIP = "";
	var getClientValue = function(_attribute, _clienyObj) {
		var attribute_value = "";
		switch(_attribute) {
			case "mac" :
				attribute_value = _clienyObj.mac;
				break;
			case "ip" :
				if(clientObj.ip != "offline") {
					attribute_value = _clienyObj.ip;
				}
				break;
			case "name" :
				attribute_value = (clientObj.nickName == "") ? clientObj.name.replace(/'/g, "\\'") : clientObj.nickName.replace(/'/g, "\\'");
				break;
			default :
				attribute_value = _attribute;
				break;
		}
		return attribute_value;
	};

	var genClientItem = function(_state) {
		var code = "";
		var clientName = (clientObj.nickName == "") ? clientObj.name : clientObj.nickName;
		
		code += '<a id=' + clientList[i] + ' title=' + clientList[i] + '>';
		if(_state == "online")
			code += '<div onclick="' + _callBackFun + '(\'';
		else if(_state == "offline")
			code += '<div style="color:#A0A0A0" onclick="' + _callBackFun + '(\'';
		for(var j = 0; j < param.length; j += 1) {
			if(j == 0) {
				code += getClientValue(param[j], clientObj);
			}
			else {
				code += '\', \'';
				code += getClientValue(param[j], clientObj);
			}
		}
		code += '\''
		code += ', '
		code += '\''
		code += clientName;
		code += '\''
		code += ', '
		code += '\''
		code += clientList[i];
		code += '\');">';
		for(var j = 0; j < param.length; j += 1) {
			if(j == 0) {
				code += "【" + getClientValue(param[j], clientObj) + "】 ";
			}
			else {
				code += '\', \'';
				code += "【" + getClientValue(param[j], clientObj) + "】 ";
			}
		}
		
		if(clientName.length > 32) {
			code += clientName.substring(0, 30) + "..";
		}
		else {
			code += clientName;
		}
		if(_state == "offline")
			code += '<strong title="Remove this client" style="float:right;margin-right:5px;cursor:pointer;" onclick="removeClient(\'' + clientObj.mac + '\', \'' + _containerID  + '_clientlist_dropdown_expand\', \'' + _containerID  + '_clientlist_offline\')">×</strong>';
		code += '</div><!--[if lte IE 6.5]><iframe class="hackiframe2"></iframe><![endif]--></a>';
		return code;
	};

	for(var i = 0; i < clientList.length; i +=1 ) {
		var clientObj = clientList[clientList[i]];
		switch(_clientState) {
			case "all" :
				if(_interfaceMode == "wl" && (clientList[clientList[i]].isWL == 0)) {
					continue;
				}
				if(_interfaceMode == "wired" && (clientList[clientList[i]].isWL != 0)) {
					continue;
				}
				if(clientObj.isOnline) {
					E("" + _containerID + "_clientlist_online").innerHTML += genClientItem("online");
				}
				else if(clientObj.from == "nmpClient") {
					E("" + _containerID + "_clientlist_offline").innerHTML += genClientItem("offline");
				}
				break;
			case "online" :
				if(_interfaceMode == "wl" && (clientList[clientList[i]].isWL == 0)) {
					continue;
				}
				if(_interfaceMode == "wired" && (clientList[clientList[i]].isWL != 0)) {
					continue;
				}
				if(clientObj.isOnline) {
					E("" + _containerID + "_clientlist_online").innerHTML += genClientItem("online");
				}
				break;
			case "offline" :
				if(_interfaceMode == "wl" && (clientList[clientList[i]].isWL == 0)) {
					continue;
				}
				if(_interfaceMode == "wired" && (clientList[clientList[i]].isWL != 0)) {
					continue;
				}
				if(clientObj.from == "nmpClient") {
					E("" + _containerID + "_clientlist_offline").innerHTML += genClientItem("offline");
				}
				break;
		}		
	}
	
	if(E("" + _containerID + "_clientlist_offline").childNodes.length == "0") {
		if(E("" + _containerID + "_clientlist_dropdown_expand") != null) {
			removeElement(E("" + _containerID + "_clientlist_dropdown_expand"));
		}
		if(E("" + _containerID + "_clientlist_offline") != null) {
			removeElement(E("" + _containerID + "_clientlist_offline"));
		}
	}
	else {
		if(E("" + _containerID + "_clientlist_dropdown_expand").innerText == "Show Offline Client List") {
			E("" + _containerID + "_clientlist_offline").style.display = "none";
		}
		else {
			E("" + _containerID + "_clientlist_offline").style.display = "";
		}
	}
	if(E("" + _containerID + "_clientlist_online").childNodes.length == "0") {
		if(E("" + _containerID + "_clientlist_online") != null) {
			removeElement(E("" + _containerID + "_clientlist_online"));
		}
	}

	if(E(_containerID).childNodes.length == "0")
		E(_pullArrowID).style.display = "none";
	else
		E(_pullArrowID).style.display = "";
}

function open_user_rule(){
	$("#vpnc_settings").fadeIn(200);
}
function close_user_rule(){
	$("#vpnc_settings").fadeOut(200);
}

function save(){
	showKPLoadingBar();
	reload=1;
	setTimeout("get_log();", 600);
	// collect basic data
	var params = ["koolproxy_mode", "koolproxy_reboot", "koolproxy_reboot_hour", "koolproxy_reboot_min", "koolproxy_reboot_inter_hour", "koolproxy_reboot_inter_min", "koolproxy_acl_method", "koolproxy_acl_default"];
	dbus["koolproxy_enable"] = E("koolproxy_enable").checked ? "1" : "0";
	for (var i = 0; i < params.length; i++) {
    	dbus[params[i]] = E(params[i]).value;
	}
	// collect value in user rule textarea
	dbus["koolproxy_custom_rule"] = Base64.encode(E("usertxt").value);
	// collect data from acl pannel
	maxid = parseInt($("#ACL_table > tbody > tr:eq(-2) > td:nth-child(1) > input").attr("id").split("_")[3]);
	for ( var i = 1; i <= maxid; ++i ) {
		if (E("koolproxy_acl_ip_" + i)){
			dbus["koolproxy_acl_ip_" + i] = E("koolproxy_acl_ip_" + i).value;
			dbus["koolproxy_acl_mac_" + i] = E("koolproxy_acl_mac_" + i).value;
			dbus["koolproxy_acl_name_" + i] = E("koolproxy_acl_name_" + i).value;
			dbus["koolproxy_acl_mode_" + i] = E("koolproxy_acl_mode_" + i).value;
		}
	}
	//console.log(dbus)
	// post data
	var id3 = parseInt(Math.random() * 100000000);
	var postData3 = {"id": id3, "method": "KoolProxy_config.sh", "params":[1], "fields": dbus};
	//showMsg("msg_warring","正在提交数据！","<b>等待后台运行完毕，请不要刷新本页面！</b>");
	$.ajax({
		url: "/_api/",
		cache:false,
		type: "POST",
		dataType: "json",
		data: JSON.stringify(postData3)
	});
}

</script>
</head>
<body onload="init();">
	<div id="TopBanner"></div>
	<div id="Loading" class="popup_bg"></div>
	<div id="LoadingBar" class="popup_bar_bg">
	<table cellpadding="5" cellspacing="0" id="loadingBarBlock" class="loadingBarBlock"  align="center">
		<tr>
			<td height="100">
				<div id="loading_block3" style="margin:10px auto;margin-left:10px;width:85%; font-size:12pt;"></div>
				<div id="loading_block2" style="margin:10px auto;width:95%;"></div>
				<div id="log_content2" style="margin-left:15px;margin-right:15px;margin-top:10px;overflow:hidden">
					<textarea cols="63" rows="21" wrap="on" readonly="readonly" id="log_content3" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" style="border:1px solid #000;width:99%; font-family:'Courier New', Courier, mono; font-size:11px;background:#000;color:#FFFFFF;"></textarea>
				</div>
				<div id="ok_button" class="apply_gen" style="background: #000;display: none;">
					<input id="ok_button1" class="button_gen" type="button" onclick="hideKPLoadingBar()" value="确定">
				</div>
			</td>
		</tr>
	</table>
	</div>
	<table class="content" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="17">&nbsp;</td>
			<td valign="top" width="202">
				<div id="mainMenu"></div>
				<div id="subMenu"></div>
			</td>
			<td valign="top">
				<div id="tabMenu" class="submenuBlock"></div>
				<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
					<tr>
						<td align="left" valign="top">
							<table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3" class="FormTitle" id="FormTitle" style="border: 0px solid transparent;">
								<tr>
									<td bgcolor="#4D595D" colspan="3" valign="top" style="border-radius: 8px">
										<div>&nbsp;</div>
                                       	<div class="formfonttitle"><em>软件中心 - koolproxy</em></div>
                                       	<div style="float:right; width:15px; height:25px;margin-top:-20px">
                                       	    <img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor:pointer;position:absolute;margin-left:-30px;margin-top:-25px;" title="返回软件中心" src="/images/backprev.png" onMouseOver="this.src='/images/backprevclick.png'" onMouseOut="this.src='/images/backprev.png'"></img>
                                       	</div>
                                       	<div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
                                       	<div class="SimpleNote">
                                       	   <li id="push_content1" style="margin-top:-5px;">
                                       	       koolproxy是能识别adblock规则的代理软件，可以用于去除网页静广告和视频广告，并且支持https！
                                       	   </li>
                                       	   <li id="koolproxy_rule_status">
	                                   	       <i>koolproxy静态规则：</i>
	                                   	       <span id="rule_date_web"></span>
	                                   	       &nbsp;&nbsp;&nbsp;&nbsp;
	                                   	       <i>koolproxy视频规则：</i>
                                       	   	   <span id="video_date_web"></span>
                                       	   </li>
                                       	</div>
										<!-- this is the popup area for user rules -->
										<div id="vpnc_settings"  class="contentM_qis" style="box-shadow: 3px 3px 10px #000;margin-top: -65px;">
											<div class="user_title">koolproxy自定义规则</div>
											<div style="margin-left:15px"><i>1&nbsp;&nbsp;点击【保存文件】按钮，文本框内的内容会保存到/koolshare/koolproxy/data/user.txt。</i></div>
											<div style="margin-left:15px"><i>2&nbsp;&nbsp;如果你更改了user.txt，你需要重新重启koolproxy插件才，新加入的规则才能生效。</i></div>
											<div style="margin-left:15px"><i>3&nbsp;&nbsp;虽然koolproxy支持adblock规则，但是我们一点都不建议你直接使用他们的规则内容，因为这极可能导致规则冲突。</i></div>
											<div id="user_tr" style="margin: 10px 10px 10px 10px;width:98%;text-align:center;">
												<textarea cols="63" rows="36" wrap="off" id="usertxt" style="width:97%;padding-left:10px;padding-right:10px;border:1px solid #222;font-family:'Courier New', Courier, mono; font-size:11px;background:transparent;color:#FFFFFF;border:1px solid #91071f;" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false"></textarea>
											</div>
											<div style="margin-top:5px;padding-bottom:10px;width:100%;text-align:center;">
												<input id="edit_node" class="button_gen" type="button" onclick="save();" value="保存文件">	
												<input id="edit_node" class="button_gen" type="button" onclick="close_user_rule();" value="返回主界面">	
											</div>
										</div>
										<!-- end of the popouparea -->
										<div style="margin:-1px 0px 0px 0px;border:1px solid #91071f;">
											<table style="margin:-1px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" id="routing_table">
												<thead>
												<tr>
													<td colspan="2">基础设置</td>
												</tr>
												</thead>
												<tr id="switch_tr">
													<th>
														<label>开启koolproxy</label>
													</th>
													<td colspan="2">
														<div class="switch_field" style="display:table-cell">
															<label for="koolproxy_enable">
																<input id="koolproxy_enable" class="switch" type="checkbox" style="display: none;">
																<div class="switch_container" >
																	<div class="switch_bar"></div>
																	<div class="switch_circle transition_style">
																		<div></div>
																	</div>
																</div>
															</label>
														</div>
														<div id="koolproxy_install_show" style="padding-top:5px;margin-left:80px;margin-top:-30px;float: left;"></div>	
													</td>
												</tr>
												<tr id="kp_status">
													<th>koolproxy运行状态</th>
													<td><span id="koolproxy_status"></span></td>
												</tr>
												<tr id="policy_tr">
													<th>选择过滤模式</th>
													<td>
														<select name="koolproxy_mode" id="koolproxy_mode" class="input_option" onchange="update_visibility();" style="width:auto;margin:0px 0px 0px 2px;">
															<option value="1" selected>全局模式</option>
															<option value="2">ipset模式</option>
															<option value="3">视频模式</option>
														</select>
													</td>
												</tr>
												<tr id="auto_reboot_switch">
													<th>插件自动重启</th>
													<td>
														<select name="koolproxy_reboot" id="koolproxy_reboot" class="input_option" style="width:auto;margin:0px 0px 0px 2px;" onchange="update_visibility();">
															<option value="1">定时</option>
															<option value="2">间隔</option>
															<option value="0" selected>关闭</option>
														</select>
														<span id="koolproxy_reboot_hour_span">
															&nbsp;&nbsp;&nbsp;&nbsp;
															每天
															<select id="koolproxy_reboot_hour" name="koolproxy_reboot_hour" class="ssconfig input_option" >
															</select>
															<select id="koolproxy_reboot_min" name="koolproxy_reboot_min" class="ssconfig input_option" >
															</select>
															重启
															&nbsp;&nbsp;&nbsp;&nbsp;
														</span>
														
														<span id="koolproxy_reboot_interval_span">
															&nbsp;&nbsp;&nbsp;&nbsp;
															每隔
															<select id="koolproxy_reboot_inter_hour" name="koolproxy_reboot_inter_hour" class="ssconfig input_option" >
															</select>
															<select id="koolproxy_reboot_inter_min" name="koolproxy_reboot_inter_min" class="ssconfig input_option" >
															</select>
															重启koolproxy
															&nbsp;&nbsp;&nbsp;&nbsp;
														</span>
													</td>
												</tr>
												<tr id="acl_method_tr">
													<th>访问控制匹配方法</th>
													<td>
														<select name="koolproxy_acl_method" id="koolproxy_acl_method" class="input_option" style="width:127px;margin:0px 0px 0px 2px;" onchange="update_visibility();">
															<option value="1" selected>IP + MAC匹配</option>
															<option value="2">仅IP匹配</option>
															<option value="3">仅MAC匹配</option>
														</select>
													</td>
												</tr>
												<tr id="rule_update_switch">
													<th>自定义规则</th>
													<td>
														<input class="kp_btn" onclick="open_user_rule()" style="cursor:pointer;" type="button" value="自定规则" />
														<input class="kp_btn" id="koolproxy_github" style="cursor:pointer;" type="button" value="规则反馈" />
													</td>
												</tr>								
												<tr id="cert_download_tr">
													<th width="35%">证书下载（用于https过滤）</th>
													<td>
														<input type="button" id="download_cert" class="kp_btn" style="cursor:pointer" value="证书下载">
														<a class="kp_btn" href="http://koolshare.cn/thread-80430-1-1.html" target="_blank">https过滤使用教程</a>
													</td>
												</tr>
												<tr id="klloproxy_com">
													<th width="35%">koolproxy交流</th>
													<td>
														<a type="button" class="kp_btn" target="_blank" href="//shang.qq.com/wpa/qunwpa?idkey=d6c8af54e6563126004324b5d8c58aa972e21e04ec6f007679458921587db9b0">加入QQ群①</a>
														<a type="button" class="kp_btn" target="_blank" href="https://jq.qq.com/?_wv=1027&k=49tpIKb">加入QQ群②</a>
														<a type="button" class="kp_btn" target="_blank" href="https://t.me/joinchat/AAAAAD-tO7GPvfOU131_vg">加入电报群</a>
													</td>
												</tr>
                                    		</table>
                                    	</div>
										<div style="margin:10px 0px 0px 0px;border:1px solid #91071f;">
											<table id="ACL_table" style="margin:-1px 0px 0px 0px;" width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable" >
												<thead>
												<tr>
													<td colspan="6">访问控制</td>
												</tr>
												</thead>
												<tr>
													<th style="width:180px;">主机IP地址</th>
													<th style="width:160px;">mac地址</th>
													<th style="width:160px;">主机别名</th>
													<th style="width:160px;">访问控制</th>
													<th style="width:60px;">添加/删除</th>
												</tr>
												<tr>
													<td>
														<input type="text" maxlength="15" class="input_ss_table" id="koolproxy_acl_ip" name="koolproxy_acl_ip" align="left" onkeypress="return validator.isIPAddr(this, event)" style="float:left;width:113px" autocomplete="off" onClick="hideClients_Block();" autocorrect="off" autocapitalize="off">
														<img id="pull_arrow" height="14px;" src="images/arrow-down.gif" align="right" onclick="pullLANIPList(this);" title="<#select_IP#>">
														<div id="ClientList_Block" class="clientlist_dropdown" style="margin-left:2px;margin-top:25px;width:auto"></div>
													</td>
													<td>
														<input type="text" id="koolproxy_acl_mac" name="koolproxy_acl_mac" class="input_ss_table" style="width:130px" maxlength="50" style="width:140px;" placeholder="" />
													</td>
													<td>
														<input type="text" id="koolproxy_acl_name" name="koolproxy_acl_name" class="input_ss_table" style="width:130px" maxlength="50" style="width:140px;" placeholder="" />
													</td>
													<td>
														<select id="koolproxy_acl_mode" name="koolproxy_acl_mode" style="width:160px;margin:0px 0px 0px 2px;" class="input_option">
															<option value="1">http only</option>
															<option value="2">http + https</option>
															<option value="0">不过滤</option>
														</select>
													</td>
													<td style="width:66px">
														<input style="margin-left: 6px;margin: -3px 0px -5px 6px;" type="button" class="add_btn" onclick="addTr()" value="" />
													</td>
												</tr>
											</table>
										</div>
										<div id="ACL_note" style="margin-top: 5px;">
											<div><i>1&nbsp;&nbsp;过滤https站点需要为相应设备安装证书，并启用http + https过滤！</i></div>
											<div><i>2&nbsp;&nbsp;在路由器下的设备，不管是电脑，还是移动设备，都可以在浏览器中输入<u><font color='#66FF00'>110.110.110.110</font></u>来下载证书。</i></div>
											<div><i>3&nbsp;&nbsp;如果想在多台装有koolroxy的路由设备上使用一个证书，请用winscp软件备份/koolshare/koolproxy/data文件夹，并上传到另一台路由。</i></div>
										</div>
										<div class="apply_gen">
											<input type="button" id="cmdBtn" class="button_gen" onclick="save();" value="提交"/>
										</div>
									</td>
								</tr>
							</table>
						</td>
						<td width="10" align="center" valign="top"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div id="footer"></div>
</body>
</html>


