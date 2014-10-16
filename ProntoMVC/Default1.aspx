<%@ Page Language="C#" 
 
 CodeBehind="Default1.aspx.cs" Inherits="MixingBothWorldsExample.Default1"

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<script runat="server">

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="http://code.jquery.com/jquery-1.10.0.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
        rel="stylesheet">
    <%--     <link href="@Url.Content("~/Content/bootstrap.css")" rel="stylesheet" type="text/css" />--%>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <title>Informes </title>
</head>
<body style="background-color: rgb(138, 138, 138); background-image: url('http://www.bootstrapcdn.com/img/bootstrap-bkg.jpg');
    background-repeat: no-repeat;">
    <form id="form1" runat="server">
    <div class="navbar navbar-fixed-top ">
        <div class="navbar-inner">
            <div class="container-fluid" style="padding-right: 0px; padding-left: 0px;">
                <ul class="nav nav-pills   row-fluid " id="navigation2" style="vertical-align: middle;
                    background: rgb(248, 248, 248); border-bottom: 1px solid #e8e8e8;">
                    <style>
                        .nav
                        {
                            font-size: 12px;
                        }
                        .navbar .nav .dropdown-toggle .caret
                        {
                            margin-top: 10px;
                        }
                        
                        .nav-tabs > li > a, .nav-pills > li > a
                        {
                            line-height: 25px; /*  font-size: 12px; */
                        }
                    </style>
                    <li class="span2" style="padding: 0px; margin: 0;" id="LogoEmpresa"><a href="" class="pull-left"
                        style="padding: 0px">
                        <img src="/Pronto2/Content/Images/Empresas/DemoPronto.png" alt="" style="text-align: left;
                            margin-top: 3px; margin-left: 20px; width: ; height: 42px;" />
                    </a></li>
                    <div id="spanDelSuperbuscador" class="span3 input-append pull-left" style="">
                        <input id="SuperBuscador2" type="text" class="pull-left" style="margin-top: 9px;"
                            placeholder="Buscar">
                        <button type="button" class="btn" style="margin-top: 9px;">
                            <i class="icon-search"></i>
                        </button>
                    </div>
                </ul>
            </div>
        </div>
    </div>
    <div>
    <br /><br /><br /><br />
        <%--http://stackoverflow.com/questions/6144513/how-can-i-use-a-reportviewer-control-in-an-asp-net-mvc-3-razor-view?lq=1--%>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        sss
        <rsweb:ReportViewer ID="ReportViewerRemoto" runat="server" Height="500" Width="500" AsyncRendering="false">
            <ServerReport ReportPath="informes/sss" ReportServerUrl="http://localhost/ReportServer" />
        </rsweb:ReportViewer>
        aaaa
        <%--        <iframe id="IFRAME1" src="http://bdlconsultores.dyndns.org:81/ReportServer/Pages/ReportViewer.aspx?%2fPronto+informes%2fPosicion+Financiera&rs:Command=Render"
        runat="server" height="1200px" width="100%" frameborder="0" />--%>
        <%--    <iframe id="Iframe2" src="http://192.168.66.6/Reports/Pages/Folder.aspx" runat="server"
        height="1200px" width="100%" frameborder="0" />--%>
        <iframe id="Iframe1" src="http://201.231.168.164:5001/Reports/Pages/Report.aspx?ItemPath=%2fOrdenes+Pago+en+Caja&rc:Zoom=Whole+Page"
            runat="server" height="1200px" width="1200px" frameborder="0" />
        <%--SAFÉ haciendo un segundo proxy para acceder al reportserver--%>
        <%--  <rsweb:reportviewer id="ReportViewerRemoto" runat="server" font-names="Verdana" font-size="8pt"
            width="100%" visible="true" zoommode="PageWidth" sizetoreportcontent="false"
            height="600px" processingmode="Remote">
            
             <ServerReport   ReportPath="Ordenes Pago en Caja" ReportServerUrl="http://localhost/ReportServer"   />
        </rsweb:reportviewer>--%>
        <%--Una caja de texto para escribir el Codigo a buscar--%>
        <br />
        <br />
        <br />
        <br />
        <input type="text" name="txtContactID" id="txtContactID" />
        <%--Boton que invoca a la funcion para visualizar el reporte--%>
        <input id="btnVerReporte" type="button" value="Ver Reporte" onclick="InvocarReporte();" />
        <br />
        <%--span para que dibuje el iframe generado en el ReporteController--%>
        <span id="reporte"></span>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function InvocarReporte() {
        //Almacenamos el valor en una variable
        var id = '333'; //  $('#txtContactID').val();
        //Verificamos que sea diferente de vacio

        if (id != '')
        //Invocamos al getJSON
            $.getJSON("/Pronto2/PaginaWebForm/VerReporte/" + id, function (data) {
                //Muestra el iframe 

                $('#reporte').html(data);
            });

    };        
</script>
