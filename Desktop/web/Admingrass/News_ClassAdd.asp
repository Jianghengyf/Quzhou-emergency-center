﻿<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<%
Call ISPopedom(UserName,"News_Class")
ID=ReplaceBadChar(Trim(Request("ID")))
If ID="" Then
   ID=0
End If
Action=ReplaceBadChar(Trim(Request("Action")))
If Action="Save" Then
	NavTitle=ReplaceBadChar(Trim(Request("NavTitle")))
	EnNavTitle=ReplaceBadChar(Trim(Request("EnNavTitle")))
	NavRemark=ReplaceBadChar(Trim(Request("NavRemark")))
	NavLock=ReplaceBadChar(Trim(Request("NavLock")))	
	
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavOrder From NewsClass Where NavParent="&ID&" Order By NavOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavOrder=Cstr(Trim(Rs("NavOrder")))+1
	Else
		NavOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	'获取导航条的深度值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select NavLevel From NewsClass Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		NavLevel=Cstr(Trim(Rs("NavLevel")))+1
	Else
		NavLevel=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From NewsClass"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("NavTitle")=NavTitle
	Rs("EnNavTitle")=EnNavTitle
	Rs("NavRemark")=NavRemark
	Rs("NavLock")=NavLock
	Rs("NavOrder")=NavOrder
	Rs("NavParent")=ID
	Rs("NavLevel")=NavLevel
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u4fe1\u606f\u5206\u7c7b\u4fe1\u606f\u6dfb\u52a0\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='News_Class.asp?ID="&ID&"';</script>")
	Response.End()
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<link href="images/skin.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="17" valign="top" background="images/mail_leftbg.gif"><img src="images/left-top-right.gif" width="17" height="29" /></td>
    <td valign="top" background="images/content-bg.gif"><table width="100%" height="31" border="0" cellpadding="0" cellspacing="0" class="left_topbg" id="table2">
      <tr>
        <td height="31"><div class="titlebt">管理系统</div></td>
      </tr>
    </table></td>
    <td width="16" valign="top" background="images/mail_rightbg.gif"><img src="images/nav-right-bg.gif" width="16" height="29" /></td>
  </tr>
  <tr>
    <td valign="middle" background="images/mail_leftbg.gif">&nbsp;</td>
    <td valign="top" bgcolor="#F7F8F9">
    
    
    <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="News_Class.asp">信息分类维护</a> >> 添加信息分类</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下带星号(*)的均不能为空，请准确真实的填写相关信息。<br>
注意：您可以进行添加、修改、删除等操作，保存之后立即生效。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#NavTitle").val()=="")
	{
		alert("\u7c7b\u522b\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#NavTitle").focus();
		return false;
	}
	if ($("#EnNavTitle").val()=="")
	{
		alert("\u7c7b\u522b\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#EnNavTitle").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="3">添加信息分类</th>
</tr>
<tr>
  <td width="29%" align="right" class="Right">类别名称：</td>
  <td width="44%">
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="Chiness" then%>
  <div class="float_left_300txt">
    <input type="text" id="NavTitle" name="NavTitle" value="" class="Input300px"/>
    </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="English" then%>
  <div class="float_left_300txt">
    <input type="text" id="EnNavTitle" name="EnNavTitle" value="" class="Input300px"/>
    </div>
  <%end if%>
  <%if Request.Cookies("CNVP_CMS2")("SiteVersion")="CAndE" then%>
    <div class="float_left_300txt">
      <input type="text" id="NavTitle" name="NavTitle" value="" class="Input300px"/>
      </div>
    <div class="float_left_110">*中文名称，必填</div>
    <div class=" float_left_300txt">
      <input type="text" id="EnNavTitle" name="EnNavTitle" value="" class="Input300px"/>
      </div>
    <div class="float_left_110">*英文名称，必填</div>
  <%end if%>
  </td>
  <td width="27%">&nbsp;</td>
</tr>
<tr>
  <td class="Right" width="29%" align="right">类别说明：</td>
  <td colspan="2"><input type="text" id="NavRemark" name="NavRemark" value="" class="Input300px"/></td>
</tr>
<tr>
<td class="Right" width="29%" align="right">类别状态：</td>
<td colspan="2"><input type="radio" id="NavLock" name="NavLock" value="0" checked="checked"/>已发布<input type="radio" id="NavLock" name="NavLock" value="1"/>未发布</td>
</tr>
<tr>
<td class="Right" width="29%" align="right">&nbsp;</td>
<td colspan="2"><input type="submit" value="保 存" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='News_Class.asp'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
    
    </td>
    <td background="images/mail_rightbg.gif">&nbsp;</td>
  </tr>
  <tr>
    <td valign="bottom" background="images/mail_leftbg.gif"><img src="images/buttom_left2.gif" width="17" height="17" /></td>
    <td background="images/buttom_bgs.gif"><img src="images/buttom_bgs.gif" width="17" height="17"></td>
    <td valign="bottom" background="images/mail_rightbg.gif"><img src="images/buttom_right2.gif" width="16" height="17" /></td>
  </tr>
</table>

</body>
</html>