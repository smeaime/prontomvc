<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reporte.aspx.cs" Inherits="ProntoMVC.Reportes.Reporte"
    Title="Informe" %>




<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">




<script>
    var ROOT ="<% =Page.ResolveUrl("~/")  %>" ;  
    <%--var ROOT = <% =Url.Content("~") %>;    ;--%>

</script>

<script runat="server">

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="SHORTCUT ICON" href="~/Content/images/favicon.png" />
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%//////////////////////////////// JQUERY  ////////////////////////////////////////%>
    <%-- <script src="http://code.jquery.com/jquery-1.10.0.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>--%>


    <script crossorigin="anonymous" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.0/jquery.min.js"></script>
    <script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script crossorigin="anonymous" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>


    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <link href="<%=Page.ResolveUrl("~/")%>Content/jquery-grid/css/custom-theme/jquery-ui-1.10.3.custom.css"
        rel="stylesheet" type="text/css" />
    <%--<link href="<%=Page.ResolveUrl("~/")%>Content/Site.css" rel="stylesheet" type="text/css" /> --%>
    <%--si uso esto se me llena de bordes el reportviewer -sí, pero si no lo usas, perdes colores en el arbol--%>
    <link href="<%=Page.ResolveUrl("~/")%>Content/themes/base/jquery.ui.autocomplete.css"
        rel="stylesheet" type="text/css" />
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%/////////////////////BOOTSTRAP       ////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <link href="<%=Page.ResolveUrl("~/")%>Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <%--si uso esto se hace mas ancho el reportviewer --%>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////  JQUERY-UI ESTILOS////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <link href="<%=Page.ResolveUrl("~/")%>Content/jquery-ui-layout/layout-default-latest.css"
        rel="stylesheet" type="text/css" />
    <link href="<%=Page.ResolveUrl("~/")%>Content/jquery.treeview.css" rel="stylesheet"
        type="text/css" />
    <link href="<%=Page.ResolveUrl("~/")%>Content/jquery.alerts.css" rel="stylesheet"
        type="text/css" />
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%//////////////// JQGRID ////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/jquery-grid/grid.locale-es.js" type="text/javascript"></script>
    <link href="http://cdn.jsdelivr.net/jqgrid/4.5.4/css/ui.jqgrid.css" rel="stylesheet"
        type="text/css" />
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/jquery.jqGrid.min.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/grid.addons.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/grid.postext.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/grid.setcolumns.js"></script>
    <script src=" http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/jquery.contextmenu.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/jquery.searchFilter.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/jquery.tablednd.js"></script>
    <script src="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/ui.multiselect.js"></script>
    <link href="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/searchFilter.css" rel="stylesheet"
        type="text/css" />
    <link href="http://cdn.jsdelivr.net/jqgrid/4.5.4/plugins/ui.multiselect.css" rel="stylesheet"
        type="text/css" />
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/TreeView/jquery.treeview.js" type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/TreeView/jquery.treeview.edit.js"
        type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/TreeView/jquery.cookie.js" type="text/javascript"></script>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/jquery.cookies.2.2.0.js" type="text/javascript"></script>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/jquery-layout/jquery.layout-latest.min.js"
        type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/jquery-layout/jquery.layout.resizePaneAccordions.min-1.0.js"
        type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/jquery-layout/jquery.layout.resizeTabLayout.min-1.1.js"
        type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/jquery-layout/jquery.layout.state.js"
        type="text/javascript"></script>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <%////////////////////////////////////////////////////////////////////////////////%>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/pronto.js?1611" type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/")%>Scripts/jsLayout.js?1611" type="text/javascript"></script>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////////////////////////////--%>
</head>
<style>
    /* http://stackoverflow.com/questions/1195374/jqgrid-change-theme */
    /* estilos de grilla transparentes para el arbol. se asignan por jquery en el jsLayout.js */
    /*.jqgrid-widget { ... override widget styles ... }*/
    /* .jqgrid-widget input, .jqgrid-widget select ... */
    .jqgrid-widget-content {
        /*  uso este estilo a traves de la funcion estiloArbol()  */
        background: transparent;
        color: Gray;
    }

    /*//////////////////////////////////////////////////////////////////*/
    /*////////////////////////LA PAPA //////////////////////////////////*/

    .ui-jqgrid .ui-jqgrid-view {
        font-size: 14px; /* tamaño de letra de la grilla, incluyendo encabezado */
        font-family: 'Segoe UI','Lucida Grande',Verdana,Arial,Helvetica,sans-serif;
    }

    label {
        /*//////////////////////////////////////////////////////////////////*/
        /*////////////////////////LA PAPA //////////////////////////////////*/
        /* font-size: 10pt; */
        font-size: 10pt;
        /*//////////////////////////////////////////////////////////////////*/
        /*//////////////////////////////////////////////////////////////////*/
        line-height: 14px;
        /* font-family: 'Helvetica Narrow', 'Arial Narrow',Tahoma,Arial,Helvetica,sans-serif;*/
        font-family: 'Segoe UI','Lucida Grande',Verdana,Arial,Helvetica,sans-serif;
        color: #9C0000 !important;
        vertical-align: middle;
        display: inline;
        /* para que al achicar el ancho, no ocupe más de un renglon */
        white-space: nowrap;
        overflow: hidden;
    }




    .ui-widget {
        /* font-family: 'Helvetica Narrow', 'Arial Narrow',Tahoma,Arial,Helvetica,sans-serif;*/
        font-family: 'Segoe UI','Lucida Grande',Verdana,Arial,Helvetica,sans-serif;
    }

        .ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button {
            /* font-family: 'Helvetica Narrow', 'Arial Narrow',Tahoma,Arial,Helvetica,sans-serif;*/
            font-family: 'Segoe UI','Lucida Grande',Verdana,Arial,Helvetica,sans-serif;
            font-size: 1em;
        }

    input, button, select, textarea {
        font-size: 11pt;
        /* font-family: 'Helvetica Narrow', 'Arial Narrow',Tahoma,Arial,Helvetica,sans-serif;*/
        font-family: 'Segoe UI','Lucida Grande',Verdana,Arial,Helvetica,sans-serif;
    }

    body {
        /* font-family: 'Helvetica Narrow', 'Arial Narrow',Tahoma,Arial,Helvetica,sans-serif;*/
        font-family: 'Segoe UI','Lucida Grande',Verdana,Arial,Helvetica,sans-serif;
        font-size: 16px !important;
    }

    .nav {
        font-size: 14px !important;
    }
</style>
<style>
    /* jqGrid builds some additional divs over the main grid table. The outer div has the class ui-jqgrid. So if you need to remove right and left border existing over the whole grid you can use the following CSS: */



    .ui-widget-content {
        border: 1px solid #E4E4E4;
        padding: 2px;
    }


    .ui-jqgrid {
        border-width: 1px;
    }


        /* If you need to remove all grid's borders you can use

If you want additionally remove vertical border between the cells in the grid you can use */



        /* el pie */ /* el pie */
        .ui-jqgrid tr.footrow-ltr {
            border: 0;
        }

            .ui-jqgrid tr.footrow-ltr td {
                border-right-color: #E4E4E4 !important;
            }

        /*To remove horizontal border between the rows you can use */

        .ui-jqgrid tr.ui-row-ltr td {
            border-bottom-color: #E4E4E4;
            border-color: rgb(234, 234, 234) /* para zafar del borde del arbol de la izquierda  -no me funciona*/;
        }

    /*To remove vertical borders between the column headers you can use */

    th.ui-th-column {
        border-right-color: #E4E4E4 !important;
    }
    /* or alternatively (without the usage of !important) */

    .ui-jqgrid-labels .ui-th-column {
        border-right-color: #E4E4E4;
    }
</style>
<style>
    /* fix the size of the pager */
    input.ui-pg-input {
        width: auto;
    }
    /* Este es para hacer wrap en los encabezados del jqgrid */
    th.ui-th-column div {
        white-space: normal !important;
        height: auto !important;
        padding: 2px;
    }



    /* para sacar el wrap en los renglones comunes    */
    .ui-jqgrid tr.jqgrow td {
        white-space: nowrap;
        padding-left: 8px;
        padding-right: 8px;
    }




    /* http://www.trirand.com/blog/?page_id=393/bugs/jquery-ui-1-10-2-autocomplete-drop-down-renders-behind-jqgird-form */

    .ui-front {
        z-index: 1000;
    }

    .ui-layout-west {
        z-index: 1 !important;
    }


    /* http://stackoverflow.com/questions/4305223/selected-row-background-color */


    .ui-jqgrid-btable .ui-state-highlight {
        background: #33333;
    }

    .ui-jqgrid-btable .ui-state-hover {
        background: rgb(234, 234, 234);
    }
</style>
<body style="background-color: ; background-repeat: no-repeat;">
    <form id="form1" runat="server">
        <div class="navbar navbar-fixed-top ">
            <div class="">
                <div class="container-fluid" style="padding-right: 0px; padding-left: 0px;">
                    <ul class="nav nav-pills   row-fluid " id="navigation2" style="vertical-align: middle; background: rgb(234, 234, 234); border-bottom: 1px solid lightgray;">
                        <style>
                            .nav {
                                font-size: 12px;
                            }

                            .navbar .nav .dropdown-toggle .caret {
                                margin-top: 10px;
                            }

                            .nav-tabs > li > a, .nav-pills > li > a {
                                line-height: 25px; /*  font-size: 12px; */
                            }


                            div.test {
                                margin-left: 13px;
                                overflow: hidden !important;
                                overflow-y: hidden !important;
                            }

                                div.test:hover {
                                    text-overflow: inherit; /*            overflow: auto !important; */
                                    overflow-y: auto !important;
                                    overflow-x: hidden !important;
                                }


                            input[type="text"] {
                                border-color: #e2e2e2;
                            }
                        </style>
                        <li class="span2" style="padding: 0px; margin: 0; width: 196px" id="LogoEmpresa"><a
                            href="<%=Page.ResolveUrl("~/")%>" class="pull-left" style="padding: 0px">
                            <img src="<%=Page.ResolveUrl("~/")%>Content/Images/Empresas/<%=  (( Session["BasePronto"].NullSafeToString() ?? "") =="" )? "DemoPronto" : Session["BasePronto"].NullSafeToString()   %>.png"
                                alt="" style="text-align: left; margin-top: 2px; margin-left: 27px; width: ; height: 42px;" />
                        </a></li>

<%--                        <div id="spanDelSuperbuscador" class="span3 " style="padding: 0px; margin: 0; margin-top: 9px; width: 322px">
                            <div class="span10">
                                <div class="input-prepend input-append">
                                    <input id="SuperBuscador2" type="text" class="" style="width: 322px"
                                        placeholder="">
                                    <button type="submit" class="btn" style="padding-bottom: 4px;"><i class=" icon-search"></i></button>

                                </div>
                            </div>
                        </div>--%>

                        <li class="span1"><a href=""></a></li>
                        <div id="navigation3" class="pull-left ">
                        </div>
                        <div class="pull-right nav nav-pills ">
                            <li class="pull-right "><a runat="server" href="~/Account/ElegirBase">
                                <%=Session["BasePronto"] %></a> </li>
                            <li class="pull-right"><a href=""><i class="icon-user "></i>&nbsp;<%=User.Identity.Name %></a>
                            </li>

                            <li class="pull-right "><a href="MvcMembership\UserAdministration" class="pull-right"
                                onclick="" title="Seguridad"><i class="icon-lock"></i></a></li>

                            <li class="pull-right ">
                                <a href="" class="pull-right" onclick="" title="Notificaciones y Firmas">
                                    <i class="icon-bell"></i>
                                    <span class="badge badge-info" title="Notificaciones y Firmas"></span>
                                </a>
                            </li>


                            <li class="pull-right "><a href="MvcMembership\UserAdministration\Configuracion\"
                                class="pull-right" onclick="" title="Configuración"><i class="icon-cog"></i></a>
                            </li>
                            <%--<li class="pull-right "><a runat="server" href="~/Account/Logoff">Salir</a></li>--%>
                        </div>
                    </ul>
                </div>
            </div>
        </div>
        <br />
        <br />




        <%--   
       <table id="addtree">
                </table>
                <div id="paddtree">
                </div>
               
                <script>

                    var mydata = [
                    { id: "1", name: "Cash", num: "100", debit: "400.00", credit: "250.00", balance: "150.00", enbl: "1", level: "0", parent: "null", isLeaf: false, expanded: true, loaded: true, icon: "ui-icon-carat-1-e,ui-icon-carat-1-s" },
                    { id: "2", name: "Cash 1", num: "1", debit: "300.00", credit: "200.00", balance: "100.00", enbl: "0", level: "1", parent: "1", isLeaf: false, expanded: true, loaded: true },
                    { id: "3", name: "Sub Cash 1", num: "1", debit: "300.00", credit: "200.00", balance: "100.00", enbl: "1", level: "2", parent: "2", isLeaf: true, expanded: false, loaded: true, icon: "ui-icon-star" },
                    { id: "4", name: "Cash 2", num: "2", debit: "100.00", credit: "50.00", balance: "50.00", enbl: "0", level: "1", parent: "1", isLeaf: true, expanded: false, loaded: true, icon: "ui-icon-flag" },
                    { id: "5", name: "Bank\'s", num: "200", debit: "1500.00", credit: "1000.00", balance: "500.00", enbl: "1", level: "0", parent: "null", isLeaf: false, expanded: false, loaded: true, icon: "ui-icon-carat-1-e,ui-icon-carat-1-s" },
                    { id: "6", name: "Bank 1", num: "1", debit: "500.00", credit: "0.00", balance: "500.00", enbl: "0", level: "1", parent: "5", isLeaf: true, expanded: false, loaded: true, icon: "ui-icon-home" },
                    { id: "7", name: "Bank 2", num: "2", debit: "1000.00", credit: "1000.00", balance: "0.00", enbl: "1", level: "1", parent: "5", isLeaf: true, expanded: false, loaded: true, icon: "ui-icon-suitcase" },
                    { id: "8", name: "Fixed asset", num: "300", debit: "0.00", credit: "1000.00", balance: "-1000.00", enbl: "0", level: "0", parent: "null", isLeaf: true, expanded: false, loaded: true, icon: "ui-icon-lightbulb" }
                ];


                    //                    jQuery("#addtree").jqGrid({
                    //                      //  url: ROOT + "Home/ArbolJqgridTree",

                    ////                        url: ROOT + "Home/TreeGrid",

                    //                        //url: ROOT + "Requerimiento/Requerimientos",
                    ////                        postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); },
                    ////                            'FechaFinal': function () { return $("#FechaFinal").val(); },
                    ////                            'IdObra': function () { return $("#IdObra").val(); }
                    ////                        },


                    //    //                 treedatatype: 'json',
                    //                   treedatatype: "local",
                    //                jsonReader: {
                    //                    repeatitems: false,
                    //                    root: function (obj) { return obj; },
                    //                    page: function () { return 1; },
                    //                    total: function () { return 1; },
                    //                    records: function (obj) { return obj.length; }
                    //                },
                    //                datastr: mydata,

                    //                datatype: "jsonstring",
                    //                //datatype: 'json',

                    //                        treeGridModel: 'adjacency',
                    //     ExpandColumn: 'name',
                    //                    


                    //                        mtype: "POST",
                    ////                        //columns names
                    ////                        colNames: ['Name', 'Id', 'Role'],
                    ////                        //columns model
                    ////                        colModel: [
                    ////                { name: 'Name', index: 'Name', align: 'left' },
                    ////                { name: 'Id', index: 'Id', width: 1, hidden: true, key: true },
                    ////                { name: 'Role', index: 'Role', width: 1, hidden: true },
                    ////            ],


                    //                        colNames: ["Account", "Acc Num", "Debit", "Credit", "Balance", "Enabled"],
                    //                        colModel: [
                    //                    { name: "name", index: "name", width: 180 },
                    //                    { name: "num", index: "acc_num", width: 80, formatter: "integer", sorttype: "int", align: "center" },
                    //                    { name: "debit", index: "debit", width: 80, formatter: "number", sorttype: "number", align: "right" },
                    //                    { name: "credit", index: "credit", width: 80, formatter: "number", sorttype: "number", align: "right" },
                    //                    { name: "balance", index: "balance", width: 80, formatter: "number", sorttype: "number", align: "right" },
                    //                    { name: "enbl", index: "enbl", width: 60, align: "center", formatter: "checkbox", editoptions: { value: "1:0"} }
                    //                ],

                    //                        gridview: true,
                    //                        height: 'auto',
                    //                        pager: "#paddtree",
                    //                        treeGrid: true,
                    //                        rowNum: 100,
                    //                        ExpandColumn: 'name',
                    //                        editurl: 'server.php?q=dummy',
                    //                        caption: "Add Tree node example"
                    //                    });
                    //                    jQuery("#addtree").jqGrid('navGrid', "#paddtree");





                    $("#addtree").jqGrid({
                        datatype: "jsonstring",
                        datastr: mydata,
                        colNames: ["Account", "Acc Num", "Debit", "Credit", "Balance", "Enabled"],
                        colModel: [
                                { name: "name", index: "name", width: 180 },
                                { name: "num", index: "acc_num", width: 80, formatter: "integer", sorttype: "int", align: "center" },
                                { name: "debit", index: "debit", width: 80, formatter: "number", sorttype: "number", align: "right" },
                                { name: "credit", index: "credit", width: 80, formatter: "number", sorttype: "number", align: "right" },
                                { name: "balance", index: "balance", width: 80, formatter: "number", sorttype: "number", align: "right" },
                                { name: "enbl", index: "enbl", width: 60, align: "center", formatter: "checkbox", editoptions: { value: "1:0"} }
                            ],
                   
                        height: "auto",
                        gridview: true,
                        rowNum: 10000,
                        sortname: "",
                        treeGrid: true,
                        treeGridModel: "adjacency",
                        treedatatype: "local",
                        ExpandColumn: "name",
                        jsonReader: {
                            repeatitems: false,
                            root: function (obj) { return obj; },
                            page: function () { return 1; },
                            total: function () { return 1; },
                            records: function (obj) { return obj.length; }
                        }
                    });


                </script>
        --%>
        <div class="row-fluid" style="margin-top: 10px;">
            <div class="span2" style="background: rgb(234, 234, 234); font-size: 13px; overflow-y: scroll; min-height: 1000px; width: ">
                <%--196px http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=12643--%>
                <br />
                <%-- <a   title="fdasdasd"  href="Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores"    >... </a>--%>

                  <%                                   
                      if (Roles.IsUserInRole(Membership.GetUser().UserName, "AdminExterno")
                       || Roles.IsUserInRole(Membership.GetUser().UserName, "Externo")
                       || Roles.IsUserInRole(Membership.GetUser().UserName, "ExternoOrdenesPagoListas")
                       || Roles.IsUserInRole(Membership.GetUser().UserName, "ExternoCuentaCorrienteProveedor")
                       || Roles.IsUserInRole(Membership.GetUser().UserName, "ExternoCuentaCorrienteCliente")
                       || Roles.IsUserInRole(Membership.GetUser().UserName, "ExternoCotizaciones")
                       )
                      { %>
                  <div class="alert alert-error fade in span12 " id="asdasd" style="width: 200px; font-size: 16px">
                      Solo estarán disponibles para retirar las ordenes de pago que estén en Caja
                  </div>
                  <% } %>


                <table id="addtree" class="test link-class" style="background: transparent; font-size: 14px; color: Gray; overflow-y: scroll; overflow-x: hidden; background: rgb(234, 234, 234);">
                </table>
                <div id="paddtree">
                </div>
                <table id="addtree2">
                </table>
                <br />
                <br />
                <a id="lnkBDL" class="linkHoverSubrayado" href="http://www.bdlconsultores.com.ar/"
                    style="text-shadow: 0 1px 0 white; color: rgb(184, 172, 172); font-size: 12px; font-weight: normal; bottom: 3px; text-align: center; width: 100%; text-decoration: none; margin-left: 60px">©2015 BDL</a>
                <style>
                    .filetree li {
                        padding: 0px 0 2px 0px;
                    }
                </style>
                <div id="Accord1" class="test link-class" style="background: none; font-size: 12px; margin-top: 12px; color: Gray; overflow-y: scroll">
                </div>
            </div>
            <div class="span9" style="background: /*  rgba(255, 255, 255, 0.58) */; /* background-image: url('http://www.bootstrapcdn.com/img/bootstrap-bkg.jpg') */">
                <br />
                <div class="container-fluid" style="padding-right: 0px; padding-left: 0px;">
                    <div class="" style='font-size: 34px; margin-top: 5px; height: 6px; font-weight: 400; margin-left: 0px; text-shadow: 0 1px 0  lightgray; font-family: "Segoe UI Web Regular", "Segoe UI", "Lucida", Tahoma, Arial,"sans-serif"'>
                    </div>
                    <asp:Label ID="info" runat="server" />
                    <asp:TextBox ID="txtDebug" runat="server" TextMode="MultiLine" Height="16px"></asp:TextBox>
                    <rsweb:ReportViewer ID="ReportViewerRemoto" runat="server" Height="800" Width="100%"
                        ZoomMode="Percent" ZoomPercent="100" OnReportRefresh="RefrescaInforme" AsyncRendering="false">
                        <%--sizetoreportcontent="false"--%>
                        <ServerReport ReportPath="informes/sss" ReportServerUrl="http://localhost/ReportServer" />
                        <%-- <ServerReport ReportPath="informes/sss" ReportServerUrl="http://localhost/ReportServer" />--%>
                    </rsweb:ReportViewer>
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <br />
                    <%--               
                <a href="<%=ConfigurationManager.AppSettings["ReportServer"]%>">Servidor de informes</a>
                <a href="<%=ConfigurationManager.AppSettings["ReportServer"].Replace("ReportServer","Reports") %>">
                    Interfaz web</a>

                    localhost/Reports_MSSQLSERVER2/Pages/Folder.aspx?ViewMode=Detail

                    Logs de RRSS en la base (tablas [ExecutionLogStorage] ?)
                    http://stackoverflow.com/questions/491389/where-does-reporting-services-store-its-log-files
                                        C:\Program Files\Microsoft SQL Server\MSRS10_50.BDL\Reporting Services\LogFiles

                <% if (Roles.IsUserInRole ( oStaticMembershipService.GetUser().UserName, "SuperAdmin")) %>
                <% { %}
                   
                <% } %>--%>
                    <%--http://stackoverflow.com/questions/6144513/how-can-i-use-a-reportviewer-control-in-an-asp-net-mvc-3-razor-view?lq=1--%>
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

    <%--var ROOT = <%=Page.ResolveUrl("~/")  %>;  --%>   //  =Url.Content("~")  ;


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
                    if (longitud - data[i].IdItem.split("-").length == 1) { menu_html += '</ul></li>' }
                    if (longitud - data[i].IdItem.split("-").length == 2) { menu_html += '</ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.split("-").length == 3) { menu_html += '</ul></li></ul></li></ul></li>' }
                    // if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.split("-").length >= 4) { menu_html += '</ul></li></ul></li></ul></li>' }
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
                // longitud = data[i].IdItem.length;
                longitud = data[i].IdItem.split("-").length;
            }
            if (longitud > 0) {
                if (longitud == 1) { menu_html += '</ul></li>' }
                if (longitud == 2) { menu_html += '</ul></li></ul></li>' }
                if (longitud == 3) { menu_html += '</ul></li></ul></li></ul></li>' }
                //                    if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                if (longitud >= 4) { menu_html += '</ul></li></ul></li></ul></li>' }
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




    //repito estas llamadas porque no me las llama más abajo
    //repito estas llamadas porque no me las llama más abajo
    //repito estas llamadas porque no me las llama más abajo
    //repito estas llamadas porque no me las llama más abajo
    armarMenu();

    //armarArbol(); //por qué tuve que agregar armarArbol?  -sacalo, es el viejo formato, sin jqgrid, a mano completamente

    estiloArbol();

    


</script>
<%--<script src="<%=Page.ResolveUrl("~/")%>Scripts/jsLayout.js?1611" type="text/javascript"></script>--%>
<script type="text/javascript">

    $(function () {

        // no me está llamando estas funciones, entonces repetí las llamadas más arriba
        // no me está llamando estas funciones, entonces repetí las llamadas más arriba
        // no me está llamando estas funciones, entonces repetí las llamadas más arriba
        // no me está llamando estas funciones, entonces repetí las llamadas más arriba
        // no me está llamando estas funciones, entonces repetí las llamadas más arriba

   //     armarMenu();
   //     estiloArbol();
    })
</script>
