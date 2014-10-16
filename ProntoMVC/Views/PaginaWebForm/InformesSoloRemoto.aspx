<%@ Page Language="C#" AutoEventWireup="false" 
      CodeBehind="InformesSoloRemoto.aspx.cs" Inherits="Overkill.Views.Home.Products" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>






<body>
    <div style="background-color: #FFFFFF; width: 100%; table-layout: fixed">
        <rsweb:ReportViewer ID="ReportViewerRemoto" runat="server" Font-Names="Verdana" Font-Size="8pt"
            Width="100%" Visible="true" ZoomMode="PageWidth" SizeToReportContent="false"
            Height="600px" ProcessingMode="Remote">
            <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
            --%>
            <%-- <ServerReport   ReportPath="Pronto informes/Balance" ReportServerUrl="http://bdlconsultores.dyndns.org:81/ReportServer"   />--%>
        </rsweb:ReportViewer>
        <span>
            <%--<div>--%>
            <%--botones de alta y excel--%>
            <%--</div>--%>
        </span>
        <div style="background-color: #FFFFFF; width: 95%; table-layout: fixed">
            <rsweb:ReportViewer ID="ReportViewerLocal" runat="server" Font-Names="Verdana" Font-Size="8pt"
                Width="100%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True">
                <%--        <LocalReport ReportPath="ProntoWeb\Informes\prueba2.rdl">

        </LocalReport>
        
                --%>
            </rsweb:ReportViewer>
            <span>
                <%--<div>--%>
                <%--botones de alta y excel--%>
                <%--</div>--%>
            </span>
        </div>
    </div>
    <iframe id="frame1" src="http://bdlconsultores.dyndns.org:81/ReportServer?%2fPronto+informes&rs:Command=ListChildren"
        runat="server" height="1200px" width="100%" frameborder="0" />
    <iframe id="IFRAME1" src="http://bdlconsultores.dyndns.org:81/ReportServer/Pages/ReportViewer.aspx?%2fPronto+informes%2fPosicion+Financiera&rs:Command=Render"
        runat="server" height="1200px" width="100%" frameborder="0" />
    <iframe id="Iframe2" src="http://192.168.66.6/Reports/Pages/Folder.aspx" runat="server"
        height="1200px" width="100%" frameborder="0" />

</body>
