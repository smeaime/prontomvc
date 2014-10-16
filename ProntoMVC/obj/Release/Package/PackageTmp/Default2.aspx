<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<script runat="server">

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
        <title>Informes </title>
</head>
<body style="background-color: rgb(138, 138, 138); background-image: url('http://www.bootstrapcdn.com/img/bootstrap-bkg.jpg');
    background-repeat: no-repeat;">
    <form id="form1" runat="server">
    
    <div>
    <br /><br /><br /><br />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        sss
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="500" Width="500" AsyncRendering="false">
           <ServerReport ReportPath="/informes/sss" ReportServerUrl="http://localhost/ReportServer" />
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>


