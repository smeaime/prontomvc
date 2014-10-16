﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reporte.aspx.cs" Inherits="ProntoMVC.Reportes.Reporte" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<script runat="server">

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="SHORTCUT ICON" href="~/Content/images/favicon.png" />
    <script src="http://code.jquery.com/jquery-1.10.0.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css"
        rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>



  <link href="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.min.css"
            rel="stylesheet" type="text/css" />
        
  <script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.1/js/bootstrap-transition.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.1/js/bootstrap-collapse.js"></script>


    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <link id="Link1" runat="server" href="~/Content/jquery.treeview.css" rel="stylesheet"
        type="text/css" />
    <script src="Scripts/TreeView/jquery.treeview.js" type="text/javascript"></script>
    <script src="Scripts/TreeView/jquery.treeview.edit.js" type="text/javascript"></script>
    <script src="Scripts/TreeView/jquery.cookie.js" type="text/javascript"></script>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <title>Informes </title>
</head>
<body style="background-color: ; background-repeat: no-repeat;">
    <form id="form1" runat="server">
    <div class="navbar navbar-fixed-top ">
        <div class="">
            <div class="container-fluid" style="padding-right: 0px; padding-left: 0px;">
                <ul class="nav nav-pills   row-fluid " id="navigation2" style="vertical-align: middle;
                    background: rgb(234, 234, 234); border-bottom: 1px solid lightgray;">
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
                        
                        
                        div.test
                        {
                            margin-left: 13px;
                            overflow: hidden !important;
                            overflow-y: hidden !important;
                        }
                        
                        div.test:hover
                        {
                            text-overflow: inherit; /*            overflow: auto !important; */
                            overflow-y: auto !important;
                            overflow-x: hidden !important;
                        }
                    </style>
                    <li class="span2" style="padding: 0px; margin: 0;" id="LogoEmpresa"><a href="<%=Page.ResolveUrl("~/")%>"
                        class="pull-left" style="padding: 0px">
                        <img src="<%=Page.ResolveUrl("~/")%>Content/Images/Empresas/<%=  (( Session["BasePronto"].ToString() ?? "") =="" )? "DemoPronto" : Session["BasePronto"].ToString()   %>.png"
                            alt="" style="text-align: left; margin-top: 3px; margin-left: 20px; width: ;
                            height: 42px;" />
                    </a></li>
                    <div id="spanDelSuperbuscador" class="span3 " style="padding: 0px; margin: 0;">
                        <div class="span10">
                            <div class="input-prepend input-append">
                                <input id="SuperBuscador2" type="text" class="" style="margin-top: 9px;" placeholder="">
                            </div>
                        </div>
                    </div>
                    <li class="span1"><a href=""></a></li>
                    <div id="navigation3" class="pull-left collapse">
                    </div>
                    <div class="pull-right nav nav-pills collapse">
                        <li class="pull-right "><a runat="server" href="~/Account/ElegirBase">
                            <%=Session["BasePronto"] %></a> </li>
                        <li class="pull-right"><a href=""><i class="icon-user "></i>&nbsp;<%=User.Identity.Name %></a>
                        </li>
                        <li class="pull-right "><a runat="server" href="~/Account/Logoff">Salir</a></li>
                    </div>
                </ul>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="padding-right: 0px; padding-left: 0px;">
        >
        <div class="row-fluid">
            <div class="span2" style="background: rgb(234, 234, 234); font-size: 13px; overflow-y: scroll;
                min-height: 1000px">
                <br />
                <br />
                <br />
                <%-- <a   title="fdasdasd"  href="Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores"    >... </a>--%>
                <br />
                <div id="Accord1" class="test link-class" style="background: none; font-size: 12px;
                    color: Gray; overflow-y: scroll">
                </div>
            </div>
            <div class="span9" style="background: /*  rgba(255, 255, 255, 0.58) */; /* background-image: url('http://www.bootstrapcdn.com/img/bootstrap-bkg.jpg') */">
                <br />
                <br />
                <br />
                <asp:TextBox ID="txtDebug" runat="server" TextMode="MultiLine"></asp:TextBox>
                <br />
                <%--http://stackoverflow.com/questions/6144513/how-can-i-use-a-reportviewer-control-in-an-asp-net-mvc-3-razor-view?lq=1--%>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <rsweb:ReportViewer ID="ReportViewerRemoto" runat="server" Height="1500" Width="100%"
                    ZoomMode="PageWidth" OnReportRefresh="RefrescaInforme" AsyncRendering="false">
                    <%--sizetoreportcontent="false"--%>
                    <ServerReport ReportPath="informes/sss" ReportServerUrl="http://localhost/ReportServer" />
                    <%-- <ServerReport ReportPath="informes/sss" ReportServerUrl="http://localhost/ReportServer" />--%>
                </rsweb:ReportViewer>
                <%--        <iframe id="IFRAME1" src="http://bdlconsultores.dyndns.org:81/ReportServer/Pages/ReportViewer.aspx?%2fPronto+informes%2fPosicion+Financiera&rs:Command=Render"
        runat="server" height="1200px" width="100%" frameborder="0" />--%>
                <%--    <iframe id="Iframe2" src="http://192.168.66.6/Reports/Pages/Folder.aspx" runat="server"
        height="1200px" width="100%" frameborder="0" />--%>
                <%--        <iframe id="Iframe1" src="http://201.231.168.164:5001/Reports/Pages/Report.aspx?ItemPath=%2fOrdenes+Pago+en+Caja&rc:Zoom=Whole+Page"
            runat="server" height="1200px" width="1200px" frameborder="0" />--%>
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
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">

    var ROOT = <%=Page.ResolveUrl("~/")  %>;     //  =Url.Content("~")  ;


    function InvocarReporte() {
        //Almacenamos el valor en una variable
        var id = '333'; //  $('#txtContactID').val();
        //Verificamos que sea diferente de vacio

        if (id != '')
        //Invocamos al getJSON
            $.getJSON(ROOT + "PaginaWebForm/VerReporte/" + id, function (data) {
                //Muestra el iframe 

                $('#reporte').html(data);
            });

    };


    function armarArbol() {


        $.post(ROOT + "Home/Arbol", null, function (data) {
            var menu_html = '<ul id="Tablas1" class="filetree treeview-famfamfam treeview"  >';
            var longitud = 0
            for (var i = 0; i < data.length; i++) {
                if (longitud > 0) {
                    if (longitud - data[i].IdItem.length == 3) { menu_html += '</ul></li>' }
                    if (longitud - data[i].IdItem.length == 6) { menu_html += '</ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.length == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
                    // if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li>' }
                }
                if (data[i].EsPadre == "SI" && longitud - data[i].IdItem.length < 12) {

                    if (data[i].Link.length > 0) {
                        menu_html += '<li><span class="folder" id="' + data[i].Clave + '"><strong>' + data[i].Link + '</strong></span><ul>'
                    }
                    else {
                        menu_html += '<li><span class="folder" id="' + data[i].Clave + '">' + data[i].Descripcion + '</span><ul>'
                    }

                }
                else {
                    if (data[i].Link.length > 0) {
                        menu_html += '<li><span class="leaf country" id="' + data[i].Clave + '">' + data[i].Link + '</span>' + '</li>'
                    }
                    else {
                        menu_html += '<li><span class="leaf country" id="' + data[i].Clave + '">' + data[i].Descripcion + '</span></li>'
                    }
                }
                longitud = data[i].IdItem.length;
            }
            if (longitud > 0) {
                if (longitud - 2 == 3) { menu_html += '</ul></li>' }
                if (longitud - 2 == 6) { menu_html += '</ul></li></ul></li>' }
                if (longitud - 2 == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
                //                    if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li>' }
            }
            menu_html += '</ul>';
            $("#Accord1").empty().append(menu_html);


            //ReestableceScroll();


            $("#Tablas1").treeview({
                collapsed: true,
                //unique: true,  // to have only one item expanded at a time.
                animated: "fast", //  "medium",
                control: "#sidetreecontrol",

                //persist: "location"
                persist: "cookie",

                //////////////////////////////////////////////////////////////////////////
                // dejar de usar este treeview y pasar al jsTree o a lo nuevo que salga de jqueryUI 
                //http://bassistance.de/jquery-plugins/jquery-plugin-treeview/ 
                //////////////////////////////////////////////////////////////////////////
                cookieOptions: { path: ROOT}   // ahi funcionó!!! poniendo el ROOT (de hecho, el tipo decía de usar una constante)
                // cookieOptions: { path: '/'}, // http://forum.jquery.com/topic/jquery-treeview-plugin-for-navigation-solution
                //////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////

                //                    toggle: function (args) { //http://stackoverflow.com/questions/2412517/jquery-treeview-plugin-cookie-path
                //                        // get cookie
                //                        cookieId = "treeview"; // "MycookieId";
                //                        data = $.cookie(cookieId);
                //                        // remove cookie
                //                        $.cookie(cookieId, null);
                //                        // add with path
                //                        $.cookie(cookieId, data, { path: ROOT });  //  { path: "/"  });
                //                    }
            });


            //  $("#Ppal").remove(); // si lo saco así, hay conflictos con el cookie, creo





            //                $.post(ROOT + "Home/Menu", null, function (data) {
            //                    var menu_html = '<ul class="sf-menu">';
            //                    var longitud = 0
            //                    for (var i = 0; i < data.length; i++) {
            //                        if (longitud > 0) {
            //                            if (longitud - data[i].IdItem.length == 3) { menu_html += '</ul></li>' }
            //                            if (longitud - data[i].IdItem.length == 6) { menu_html += '</ul></li></ul></li>' }
            //                            if (longitud - data[i].IdItem.length == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
            //                            if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
            //                        }
            //                        if (data[i].EsPadre == "SI") {
            //                            menu_html += '<li><a href="#">>' + data[i].Descripcion + '</a><ul>'
            //                        }
            //                        else {
            //                            if (data[i].Link.length > 0) {
            //                                menu_html += '<li>' + data[i].Link + '</li>'
            //                            }
            //                            else {
            //                                menu_html += '<li><a href="#">' + data[i].Descripcion + '</a></li>'
            //                            }
            //                        }
            //                        longitud = data[i].IdItem.length;
            //                    }
            //                    if (longitud > 0) {
            //                        if (longitud - 2 == 3) { menu_html += '</ul></li>' }
            //                        if (longitud - 2 == 6) { menu_html += '</ul></li></ul></li>' }
            //                        if (longitud - 2 == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
            //                        if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
            //                    }
            //                    menu_html += '</ul>'
            //                    $("#navigation").empty().append(menu_html);
            //                });

        });




    }


    function armarMenu() {

        // https: //github.com/twitter/bootstrap/issues/160
        //                http: //stackoverflow.com/questions/9758587/twitter-bootstrap-multilevel-dropdown-menu
        // http: //wiki.pixelpress.com.au/2012/07/23/bootstrap-3rd-level-navbar-dropdowns/
        $.post(ROOT + "Home/Menu", null, function (data) {
            var menu_html = '';

            // menu_html += '   <li class="pull-left">  &nbsp  </li>'; // para agregar un margen a la izquierda

            var longitud = 0
            for (var i = 0; i < data.length; i++) {
                if (longitud > 0) {
                    if (longitud - data[i].IdItem.length == 3) { menu_html += '</ul></li>' }
                    if (longitud - data[i].IdItem.length == 6) { menu_html += '</ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.length == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                }
                if (data[i].EsPadre == "SI") {
                    if (data[i].ParentId == "") {
                        menu_html += '<li class="dropdown pull-left " name="MenusesPronto" ><a href="#" data-toggle="dropdown" class="dropdown-toggle  pull-left ">' + data[i].Descripcion + ' <b class="caret"></b></a><ul class="dropdown-menu" id="444' + i + '">'
                    }
                    else {
                        menu_html += '<li class="dropdown-submenu " name="MenusesPronto"><a href="#">' + data[i].Descripcion + '</a><ul class="dropdown-menu" id="444' + i + '">'
                    }
                }
                else {
                    if (data[i].Link.length > 0) {
                        menu_html += '<li>' + data[i].Link + '</li>'
                    }
                    else {
                        menu_html += '<li><a href="#">' + data[i].Descripcion + '</a></li>'
                    }
                }
                longitud = data[i].IdItem.length;
            }
            if (longitud > 0) {
                if (longitud - 2 == 3) { menu_html += '</ul></li>' }
                if (longitud - 2 == 6) { menu_html += '</ul></li></ul></li>' }
                if (longitud - 2 == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
                if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
            }
            menu_html += ''
            //                    $("#navigation2").empty().append(menu_html);
            //$("#navigation2").append(menu_html);
            //$("#navigation3").empty().append(menu_html);
            $("#navigation3").empty().replaceWith(menu_html);

        });
    }



    armarArbol();
    armarMenu();

</script>
