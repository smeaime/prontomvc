<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CartaPorteDescargarArchivo.aspx.vb"
    Inherits="CartaPorteDescargarArchivo" Title="Williams Entregas" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>BDL Consultores</title>
    <link id="Link1" href="Css/Styles.css" rel="stylesheet" type="text/css" runat="server" />
    <link rel="shortcut icon" type="image/png" href="../favicon.png" />

    <%--google analytics--%>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-12882984-2']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

    </script>
</head>
<body class="bodyMasterPage">
    <form id="form1" runat="server" defaultfocus="txtSuperbuscador" autocomplete="off"
        class="bodyMasterPage">
        <%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
        <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
            EnablePageMethods="False" AsyncPostBackTimeout="360000" ScriptMode="Release">
            <%--         el asunto de ScriptMode="Release", en los informes con el spinning, y como algo que te hace lento todo
         http://ajaxcontroltoolkit.codeplex.com/workitem/26778?ProjectName=ajaxcontroltoolkit
         http://weblogs.asp.net/lorenh/archive/2008/02/15/speed-up-load-time-of-ajax-control-toolkit-controls-while-debugging.aspx
            --%>
            <CompositeScript>
                <Scripts>
                    <%-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>--%>
                    <%--<asp:ScriptReference Path="~/JavaScript/jquery-1.4.2.min.js" />--%>
                    <asp:ScriptReference Path="~/JavaScript/bdl.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamDragAndDrop.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamCore.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamSearchComboBox.js" />
                    <asp:ScriptReference Path="~/JavaScript/firmas.js" />
                    <asp:ScriptReference Path="~/JavaScript/dragAndDrop.js" />
                </Scripts>
            </CompositeScript>
            <%--   <Scripts>
            <asp:ScriptReference Path="~/JavaScript/bdl.js" />
            <asp:ScriptReference Path="~/JavaScript/jsamDragAndDrop.js" />
            <asp:ScriptReference Path="~/JavaScript/jsamCore.js" />
            <asp:ScriptReference Path="~/JavaScript/jsamSearchComboBox.js" />
            <asp:ScriptReference Path="~/JavaScript/firmas.js" />
            <asp:ScriptReference Path="~/JavaScript/dragAndDrop.js" />
        </Scripts>--%>
            <%--COMBINAR EN UN SOLO SCRIPT?--%>
            <%-- http://p2p.wrox.com/content/articles/aspnet-35-ajax-script-combining --%>
            <%--para usarlo en con Master/Content, usa <asp:ScriptManagerProxy>--%>
            <Services>
                <%--
           QUE PASO??????????!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           QUE PASO??????????!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           QUE PASO??????????!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           comenté los ServiceReference a los webservice, y va más rapido, y siguen andando...

                --%>
                <%-- <asp:ServiceReference Path="~/ProntoWeb/WebServiceArticulos.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceProveedores.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceClientes.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceLocalidades.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceChoferes.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceTransportistas.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceVendedores.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceWilliamsDestinos.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceCalidades.asmx" />
            <asp:ServiceReference Path="~/ProntoWeb/WebServiceSuperbuscador.asmx" />--%>
            </Services>
            <%--                        <CompositeScript>
                            <Scripts>
                                <asp:ScriptReference Name="”MicrosoftAjax.js”" />
                                <asp:ScriptReference Name="”MicrosoftAjaxWebForms.js”" />
                            </Scripts>
                        </CompositeScript>--%>
        </ajaxToolkit:ToolkitScriptManager>
        <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

        <span><a id="linkimagenlabel" runat="server" href=" ">
            <asp:Image ID="imgFotoCarta" runat="server" Style="max-width: 40%" Height="500px" />
        </a>
            <asp:HyperLink ID="linkImagen" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
            <a id="linkimagenlabel2" runat="server" href=" ">
                <asp:Image ID="imgFotoCarta2" runat="server" Style="max-width: 40%" Height="500px" />
            </a>
            <asp:HyperLink ID="linkImagen_2" Target="_blank" runat="server" Text="" Visible="false"></asp:HyperLink>
        </span>
        <br />
        <asp:Button ID="btnDescargaPDF" Text="Descargar PDF" runat="server" Height="50px" />

        <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="background-color: #FFFFFF; width: 800px">
                <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
                    Width="95%" Visible="true" ZoomMode="PageWidth" Height="1200px" SizeToReportContent="True" >
                    
                </rsweb:ReportViewer>
                <span>
                    
                </span>
            </div>
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>--%>
    </form>
</body>
</html>
