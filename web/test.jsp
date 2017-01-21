<%-- 
    Document   : test
    Created on : Jul 12, 2016, 1:57:35 PM
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 
Transitional//EN"> <HTML> <HEAD> 
<TITLE> New Document </TITLE> </HEAD>

<script language=javascript>
function closemyself() {
 window.opener=self;
 window.close();
 //self.close();
}
</script>

<BODY background="vwConfig/Image1/$File/bg-logo.gif" onLoad="setTimeout('closemyself()',2000);" >

<table border="0">
 <tr>
  <td>
   <img src="vwConfig/Image1/$File/homepage-logo2.gif"> 
  </td>
 </tr>
</table>
<p>  </p>
<table border="0" width="100%">
 <tr>
  <td align="center"><font color=#330066 
size="4"><strong>
   Thank you for something</strong></font>
  </td>
 </tr>
 <tr>
  <td align="center">
    
  </td>
 </tr>
 <tr>
  <td align="center"><font color=#330066>
   (This window will close automatically)</font>
  </td>
 </tr>
</table>

</BODY>
</HTML> 