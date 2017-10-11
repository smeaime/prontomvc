<%@ Page Language="VB" AutoEventWireup="false" EnableEventValidation="false"
    CodeFile="SituacionCalidadMovil.aspx.vb" Inherits="SituacionCalidadMovil"
    Title="Informes" %>




<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>









<head runat="server">


    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>




    <title>BDL Consultores</title>

    <%--  <link id="Link1" href="Css/Styles.css" rel="stylesheet" type="text/css" runat="server" />--%>

    <link rel="shortcut icon" type="image/ico" href="favicon.png" />


    <%--    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        //ga('create', 'UA-31129433-2', 'auto');
        ga('create', 'UA-31129433-2', { 'siteSpeedSampleRate': 100 });
        ga('send', 'pageview');

    </script>--%>
</head>


<%--https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag--%>
<meta name="viewport" content="width=350, initial-scale=1.0, maximum-scale=1.0">

<body style="width: 350px; max-width: 350px; background-color: #9ec3e8" class="">



    <%--/////////////////////////////////////////////////////////////--%>
    <%--//////////       jquery    /////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--///////////     bootstrap    /////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--////////////    jqgrid     //////////////////////////////////--%>
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.4/i18n/grid.locale-es.js"></script>
    <link href="//cdn.jsdelivr.net/jqgrid/4.5.2/css/ui.jqgrid.css" rel="stylesheet">
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.2/jquery.jqGrid.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>

    <%--  <div class="titulos" style="color: white">
        Situación de CPs
    </div>--%>







    <form id="form1" runat="server" defaultfocus="txtSuperbuscador" autocomplete="off">

        <ajaxToolkit:ToolkitScriptManager ID="ScriptManager1" runat="server" LoadScriptsBeforeUI="False"
            EnablePageMethods="true" AsyncPostBackTimeout="360000" ScriptMode="Release">
            <CompositeScript>
                <Scripts>
                    <%--<asp:ScriptReference Path="~/JavaScript/jquery-1.4.2.min.js" />--%>
                    <asp:ScriptReference Path="~/JavaScript/bdl.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamDragAndDrop.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamCore.js" />
                    <asp:ScriptReference Path="~/JavaScript/jsamSearchComboBox.js" />
                    <asp:ScriptReference Path="~/JavaScript/firmas.js" />
                    <asp:ScriptReference Path="~/JavaScript/dragAndDrop.js" />
                </Scripts>
            </CompositeScript>
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
        </ajaxToolkit:ToolkitScriptManager>


        <style>
            /* Start by setting display:none to make this hidden.
   Then we position it in relation to the viewport window
   with position:fixed. Width, height, top and left speak
   speak for themselves. Background we set to 80% white with
   our animation centered, and no-repeating */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                top: 0;
                left: 0;
                height: 100%;
                width: 100%;
                /*background: rgba( 255, 255, 255, .8 ) url('~/Content/images/fhhrx.gif') 50% 50% no-repeat;*/
            }

            /* When the body has the loading class, we turn
   the scrollbar off with overflow:hidden */
            body.loading {
                /* overflow: hidden; */
            }

                /* Anytime the body has the loading class, our
   modal element will be visible */
                body.loading .modal {
                    display: block;
                }
        </style>

        <div class="modal" id="loading">
            Cargando...
       
        </div>

        <%--   <div style="visibility:hidden;display:none">--%>


        <div style="margin-left: ">
            <%--   <table id="list9">
        </table>
        <div id="pager9">
        </div>
        <br />
        <a href="javascript:void(0)" id="m1">Get Selected id's</a> <a href="javascript:void(0)"
            id="m1s">Select(Unselect) row 13</a>--%>

            <asp:UpdatePanel ID="UpdatePanelResumen" runat="server" Visible="true">
                <ContentTemplate>

                    <table style="color: black; width: 350px; vertical-align: bottom !important;">
                        <tr>
                            <td class="" style="width: ; height: 18px;"></td>
                            <td class="" style="width: ; height: ; vertical-align: bottom !important;">
                                <asp:Image ID="LogoImage" runat="server" ImageUrl="~/Imagenes/williamsmini.gif" CssClass="" Height="50px" ImageAlign="AbsBottom" />

                                <asp:DropDownList ID="cmbEstado" runat="server" Style="text-align: right; margin-left: 0px;"
                                    CssClass="CssCombo" ToolTip="Estado de la carta de porte" Font-Size="14" Height="40" Width="150" Enabled="false">
                                    <%--dejo el combito deshablitado porque las funciones no tienen todavia el parametro de "estado", estan harcodeadas en "11" --%>

                                    <asp:ListItem Text="DESC de hoy + POSIC filt" Value="DescargasDeHoyMasTodasLasPosicionesEnRangoFecha"
                                        Selected="True" />

                                    <asp:ListItem Text="Todas (menos las rechazadas)" Value="TodasMenosLasRechazadas" />
                                    <asp:ListItem Text="Incompletas" Value="Incompletas" />
                                    <asp:ListItem Text="Posición" Value="Posición" />
                                    <asp:ListItem Text="Descargas" Value="Descargas" />
                                    <asp:ListItem Text="Facturadas" Value="Facturadas" />
                                    <asp:ListItem Text="No facturadas" Value="NoFacturadas" />
                                    <asp:ListItem Text="Rechazadas" Value="Rechazadas" />
                                    <asp:ListItem Text="sin liberar en Nota de crédito" Value="EnNotaCredito" />
                                </asp:DropDownList>

                                <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="" Width="70px" Font-Size="14" Style="color: black;" Height="40" />

                            </td>
                        </tr>
                        <tr>
                            <td class="" style="width: ; height: 18px;"></td>
                            <td class="" style="width: ; height: 18px;">
                                <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="40" Width="120px" Font-Size="14" Style="color: black;"
                                    Visible="true">
                                    <asp:ListItem Text="Hoy" Selected="True" />
                                    <asp:ListItem Text="Ayer" />
                                    <%--<asp:ListItem Text="Esta semana" />
                        <asp:ListItem Text="Semana pasada" />--%>
                                    <asp:ListItem Text="Este mes" />
                                    <asp:ListItem Text="Mes anterior" />
                                    <asp:ListItem Text="Cualquier fecha" />
                                    <%--    <asp:ListItem Text="Filtrar por Mes/Año" />--%>
                                    <asp:ListItem Text="Personalizar" />
                                </asp:DropDownList>
                                <asp:TextBox ID="txtFechaDesde" runat="server" Width="100px" MaxLength="1" autocomplete="off" Style="color: black;" Font-Size="14" Enabled="true" Height="40"
                                    TabIndex="2" AutoPostBack="false"></asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaDesde"
                                    Enabled="True">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" ErrorTooltipEnabled="True"
                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaDesde" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtFechaDesde"
                                    WatermarkText="desde" WatermarkCssClass="watermarked" />
                                <asp:TextBox ID="txtFechaHasta" runat="server" Width="100px" MaxLength="1" TabIndex="2" Style="color: black;" Font-Size="14" Enabled="true" Height="40"
                                    AutoPostBack="false"></asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaHasta"
                                    Enabled="True">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" ErrorTooltipEnabled="True"
                                    Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaHasta" CultureAMPMPlaceholder=""
                                    CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                    CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                    Enabled="True">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtFechaHasta"
                                    WatermarkText="hasta" WatermarkCssClass="watermarked" />
                            </td>

                        </tr>

                        <tr style="visibility: hidden; display: none">
                            <td class="" style="width: ; height: 18px;"></td>
                            <td class="" style="width: ; height: 18px;">


                                <asp:TextBox ID="txtDestino" runat="server" Text='<%# Bind("DestinoDesc") %>' AutoPostBack="false" Style="color: black;" Visible="false"
                                    autocomplete="off" CssClass="CssTextBox" Width="200px"></asp:TextBox>
                                <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender26" runat="server"
                                    OnClientItemSelected="RefrescaGrilla()"
                                    CompletionSetCount="12" TargetControlID="txtDestino" MinimumPrefixLength="1"
                                    ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                    UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                    DelimiterCharacters="" Enabled="True">
                                </cc1:AutoCompleteExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtDestino"
                                    WatermarkText="destino" WatermarkCssClass="watermarked" />
                        </tr>

                    </table>

                </ContentTemplate>
            </asp:UpdatePanel>

            <div style="visibility: hidden; display: none">

                <asp:Button ID="btnExportarGrilla" Text="EXCEL" runat="server" Visible="false" CssClass="btn btn-primary"
                    Width="150" Height="40" />

                <input type="button" id="btnExportarGrillaAjax2" value="Excel" class="btn btn-primary" />

                <input type="button" id="btnExportarGrillaAjax" value="BLD demor" class="btn btn-primary" />


                <input type="button" id="btnPanelInformeAjax" value="Resumen" class="btn btn-primary" />

                <asp:Button ID="btnPanelInforme" Text="RESUMEN" runat="server" Visible="false" CssClass="btn btn-primary" />



                <%--<input type="button" id="btnLog" value="Log" class="btn btn-primary" />--%>
                <input type="button" id="btnMostrarMenu" value="->" class="btn btn-primary" />

                <div id="Salida2"></div>
                <asp:Literal ID="salida" runat="server"></asp:Literal>
            </div>


                                    <h1 id="bigOne"></h1>




            <%--<input type="text" class="span4" id="text1" name="agent" value=""  "/>--%>
            <style>
                .ui-pg-table {
                    font-size: 12px !important;
                }
                /*
                .ui-paging-info {
                    font-size: 12px !important;
                }
                    */
                .ui-jqgrid {
                    font-size: 15px
                }

                    .ui-jqgrid .ui-jqgrid-htable th {
                        height: 2em !important;
                    }

                    .ui-jqgrid tr.jqgrow td {
                        height: 2em !important;
                    }


                ui-jqgrid > .ui-jqgrid-view > .ui-jqgrid-hdiv {
                    overflow: hidden;
                }


                .ui-jqgrid .ui-jqgrid-pager .ui-pg-div span.ui-icon {
                    margin: 10px; /* botones del pager*/
                }
            </style>




            <table id="Lista" class="scroll" cellpadding="0" cellspacing="0" style="font-size: 23px;" width="400px">
            </table>

            <div id="ListaPager" class="scroll" style="text-align: center; height: 50px;">
            </div>



            <input type="button" id="vale" style="height: 40px" value="cambiar situacion" />
            <input type="button" id="jpg" value="jpg" />
            <input type="button" id="tif" value="tif" />








            <div>
                <a href="CartaDePorteInformesAccesoClientesMovil.aspx">Informe </a>| version original |
                           
                <b>Situación</b> |
                           
                <asp:Label ID="lblRazonSocial" runat="server" Font-Size="10" Font-Bold="false" Visible="false" />
                <asp:LoginView ID="LoginView" runat="server">
                    <LoggedInTemplate>
                        <asp:LoginName ID="LoginName1" runat="server" Font-Bold="false" CssClass="margender" />
                        |
                                   
                        <asp:LoginStatus ID="LoginStatus1" runat="server" Font-Bold="false" ForeColor=""
                            LogoutAction="RedirectToLoginPage" LogoutPageUrl="~/Login.aspx" OnLoggedOut="LoginStatus1_LoggedOut"
                            TabIndex="-1" LogoutText="Salir" Font-Underline="False" CssClass="margender" />
                    </LoggedInTemplate>
                </asp:LoginView>

            </div>


            <div>

                <br />
                Llamanos<br />

                <%--       OFICINAS: Buenos Aires Moreno 584 P. 12 Of A / (011) 5278-8800 - 4322-4805 / buenosaires@williamsentregas.com.ar 
     // San Lorenzo (Sta. Fe) - Sgo. del Estero 1177 / (03476) 430-234 - 426-855 / sanlorenzo@williamsentregas.com.ar
Arroyo Seco (Sta. Fe) - René Favaloro 726 / (03402) 421-426 - 429-676 / arroyoseco@williamsentregas.com.ar 
     // Bahía Blanca Ruta 252 km 0.5 - Playa el Triangulo / (0291) 400-7928 - 481-6778 / bahiablanca@williamsentregas.com.ar--%>


                <a href="tel:5278-8800">BsAs</a>

                <a href="tel:(03476) 430-234">S.Lorenzo</a>

                <a href="tel: (03402) 421-426">Arroyo</a>

                <a href="tel:0291-400-7928">B.Blanca </a>


            </div>


            <%--<script>


            jQuery("#list9").jqGrid({
                url: 'Handler.ashx',
                datatype: "json",
                colNames: ['Inv No'
                , 'Date', 'Client', 'Amount',
                'Tax', 'Total', 'Notes'
                ],
                colModel: [
   		{ name: 'id', index: 'id', width: 55 },
   		{ name: 'invdate', index: 'invdate', width: 90 },
   		{ name: 'name', index: 'name', width: 100 },
   		{ name: 'amount', index: 'amount', width: 80, align: "right" },
   		{ name: 'tax', index: 'tax', width: 80, align: "right" },
   		{ name: 'total', index: 'total', width: 80, align: "right" },
   		{ name: 'note', index: 'note', width: 150, sortable: false }
                ],



                rowNum: 10,
                rowList: [10, 20, 30],
                //  pager: '#pager9', // http://stackoverflow.com/questions/16717794/jqgrid-undefined-integer-pager-not-loading
                sortname: 'id',
                recordpos: 'left',
                viewrecords: true,
                sortorder: "desc",
                multiselect: true,
                caption: "Multi Select Example",
                loadonce: true
            });
            jQuery("#list9").jqGrid('navGrid', '#pager9', { add: false, del: false, edit: false, position: 'right' });
            jQuery("#m1").click(function () {
                var s;
                s = jQuery("#list9").jqGrid('getGridParam', 'selarrrow');
                alert(s);
            });
            jQuery("#m1s").click(function () {
                jQuery("#list9").jqGrid('setSelection', "13");
            });
        </script>--%>
        </div>








        <style type="text/css">
            .myAltRowClassDemorado {
                background-color: red;
                background-image: none;
            }

            .myAltRowClassAutorizado {
                background-color: lightgreen;
                background-image: none;
            }

            .myAltRowClassRechazado {
                background-color: violet;
                background-image: none;
            }
        </style>
        <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
        <%--  campos hidden --%>
        <asp:HiddenField ID="HFSC" runat="server" />
        <asp:HiddenField ID="HFIdObra" runat="server" />
        <asp:HiddenField ID="HFTipoFiltro" runat="server" />
    </form>
</body>





<script type="text/javascript">




    "use strict";

    $(function () {
        //$('#MenuPrincipal').fadeOut(); 


        $('#MasterPrimerRenglon').hide();
        $('#MenuPrincipal').hide();

        $("#searchmodfbox_Lista").parent().css('z-index', 50);


    });


    $('#btnMostrarMenu').click(function () {
        $('#MenuPrincipal').show();
    })



    $('#btnExportarGrillaAjax3').click(function () {

        var d = {
            filters: jQuery('#Lista').getGridParam("postData").filters,  // si viene en undefined es porque no se puso ningun filtro
            fechadesde: $("#ctl00_ContentPlaceHolder1_txtFechaDesde").val(),
            fechahasta: $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(),
            destino: $("#ctl00_ContentPlaceHolder1_txtDestino").val()
        }

        if (typeof d.filters === "undefined") d.filters = "";

        $.ajax({
            type: "POST",
            //method: "POST",
            url: "SituacionCalidad.aspx/ExportarGrillaNormal3",
            dataType: "json",
            contentType: "application/json; charset=utf-8",

            data: JSON.stringify(d),

            success: function (data) {
                //alert(data.d);
                window.open(data.d);
            }


            ,
            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $("#loading").show();
                $('#grabar2').attr("disabled", true).val("Espere...");

            },
            complete: function () {
                $("#loading").hide();
            }


        })


    })


    $('#btnExportarGrillaAjax2').click(function () {

        var d = {
            filters: jQuery('#Lista').getGridParam("postData").filters,  // si viene en undefined es porque no se puso ningun filtro
            fechadesde: $("#ctl00_ContentPlaceHolder1_txtFechaDesde").val(),
            fechahasta: $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(),
            destino: $("#ctl00_ContentPlaceHolder1_txtDestino").val()
        }

        if (typeof d.filters === "undefined") d.filters = "";

        $.ajax({
            type: "POST",
            //method: "POST",
            url: "SituacionCalidad.aspx/ExportarGrillaNormal",
            dataType: "json",
            contentType: "application/json; charset=utf-8",

            data: JSON.stringify(d),

            success: function (data) {
                //alert(data.d);
                window.open(data.d);
            }


            ,
            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $("#loading").show();
                $('#grabar2').attr("disabled", true).val("Espere...");

            },
            complete: function () {
                $("#loading").hide();
            }


        })


    })

    $('#btnExportarGrillaAjax').click(function () {

        var d = {
            filters: jQuery('#Lista').getGridParam("postData").filters,  // si viene en undefined es porque no se puso ningun filtro
            fechadesde: $("#ctl00_ContentPlaceHolder1_txtFechaDesde").val(),
            fechahasta: $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(),
            destino: $("#ctl00_ContentPlaceHolder1_txtDestino").val()
        }

        if (typeof d.filters === "undefined") d.filters = "";

        $.ajax({
            type: "POST",
            //method: "POST",
            url: "SituacionCalidad.aspx/ExportarGrilla",
            dataType: "json",
            contentType: "application/json; charset=utf-8",

            data: JSON.stringify(d),

            success: function (data) {
                //alert(data.d);
                window.open(data.d);
            }


            ,
            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $("#loading").show();
                $('#grabar2').attr("disabled", true).val("Espere...");

            },
            complete: function () {
                $("#loading").hide();

            }


        })


    })


    $('#btnPanelInformeAjax').click(function () {

        var d = {
            filters: jQuery('#Lista').getGridParam("postData").filters,  // si viene en undefined es porque no se puso ningun filtro
            fechadesde: $("#ctl00_ContentPlaceHolder1_txtFechaDesde").val(),
            fechahasta: $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(),
            destino: $("#ctl00_ContentPlaceHolder1_txtDestino").val()
        }

        if (typeof d.filters === "undefined") d.filters = "";

        $.ajax({
            type: "POST",
            //method: "POST",
            url: "SituacionCalidad.aspx/PanelInforme",
            dataType: "json",
            contentType: "application/json; charset=utf-8",

            data: JSON.stringify(d),

            success: function (data) {
                // http://stackoverflow.com/questions/10439798/how-to-laod-raw-html-using-jquery-ajax-call-to-asp-net-webmethod
                $("#Salida2").html("").append(data.d)

                $('#titDemorado').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "1" });
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "5" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })

                $('#titAutorizado').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "0" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })

                $('#titPosicion').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "2" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })



                $('#titADescargar').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "4" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })

                $('#titDescargado').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "3" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })


                $('#titDesviado').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "6" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })


                $('#titCPcambiar').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "7" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })

                $('#titSinCupo').click(function () {
                    //modificar el filtro para que incluya demorado y rechazado
                    var myfilter = { groupOp: "OR", rules: [] };
                    myfilter.rules.push({ field: "Situacion", op: "eq", data: "8" });

                    jqGridFilter(JSON.stringify(myfilter), $('#Lista'));
                })
                //alert(data.d);

            }


            ,
            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $("#loading").show();
                $('#grabar2').attr("disabled", true).val("Espere...");

            },
            complete: function () {
                $("#loading").hide();
            }


        })


    })






    function filtrarArticulosDefault_35603() {
        var myfilter = { groupOp: "OR", rules: [] };
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Maiz" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Soja" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Trigo Pan" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Trigo Duro" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Sorgo Granifero" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Girasol" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Girasol Alto Oleico" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Girasol Confitero" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Cebada Forrajera" });
        myfilter.rules.push({ field: "Producto", op: "eq", data: "Cebada Cervecera" });

        jqGridFilter(JSON.stringify(myfilter), $('#Lista'));


        //Los aceites y Pellets y Harinas dejar como están.

    }


    function jqGridFilter(filtersparam, grid) {
        grid.setGridParam({
            postData: {
                filters: filtersparam,
                'FechaInicial': function () { return $("#ctl00_ContentPlaceHolder1_txtFechaDesde").val(); },
                'FechaFinal': function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); },
                'puntovent': function () { return $("#ctl00_ContentPlaceHolder1_cmbPuntoVenta").val(); },
                'destino': function () { return $("#ctl00_ContentPlaceHolder1_txtDestino").val(); }
            },
            search: true
        });
        grid.trigger("reloadGrid");
    }


    $("#text1").autocomplete({
        source: function (request, response) {
            $.ajax({
                type: "POST",
                url: "WebServiceClientes.asmx/WilliamsDestinoGetWilliamsDestinos",
                dataType: "json",
                contentType: "application/json; charset=utf-8",

                data: JSON.stringify({ term: request.term }),

                success: function (data) {
                    //check what data contains. it should contain a string like "['val1','val2','val3','val4']"
                    //the next line should use $.map(data and not $.map(response
                    var a = $.parseJSON(data.d);
                    response($.map(a, function (item) {
                        return {
                            label: item.value,
                            value: item.id
                        }
                    }));
                }

            })
        }
    });


    function jsAcopiosPorCliente(textbox, combo) {
        //var txttitular = getObj("ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtTitular");

        var $txttitular = $("#" + textbox.id + "")
        var $select = $("#" + combo.id + "")



        var myJSONString = JSON.stringify($("#ctl00_ContentPlaceHolder1_HFSC").val());
        var myEscapedJSONString = myJSONString.escapeSpecialChars();

        var aaa = addslashes($("#ctl00_ContentPlaceHolder1_HFSC").val())







        $.ajax({
            // url: "/CartaDePorte.aspx/AcopiosPorCliente",
            url: "WebServiceClientes.asmx/AcopiosPorCliente",
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            //dataType: "xml",
            data: "{'NombreCliente':'" +
            addslashes($txttitular.val()) +
            "', 'SC':'" + aaa + "' }",


            //data: {
            //    NombreCliente: 'asdfasdf',
            //    SC:  'asdfsadfsa' // $("#HFSC").val()
            //},
            success: function (data) {

                var x = data.d;

                //var $select= $('select#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta');

                var guardoelactualId = $select.val()
                $select.find('option').remove();



                $.each(x, function (i, val) {


                    $select.append('<option value=' + val.idacopio + '>' + val.desc + '</option>');

                    //$('select#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_optDivisionSyngenta').append(
                    //$("<option></option>")
                    //    .val(val.idacopio).text(val.desc));

                });

                $select.val(guardoelactualId)

                if (x.length > 1) combo.style.visibility = "visible";
                else combo.style.visibility = "hidden";

            },
            error: function (xhr) {
                // alert("Something seems Wrong");
            }
        });

    }





    var $grid = "";
    var lastSelectedId;
    var lastSelectediCol;
    var lastSelectediRow;
    var lastSelectediCol2;
    var lastSelectediRow2;
    var inEdit;
    var selICol;
    var selIRow;
    var gridCellWasClicked = false;
    var grillaenfoco = false;
    var getColumnIndexByName = function (grid, columnName) {
        var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
        for (i = 0; i < l; i++) {
            if (cm[i].name === columnName) {
                return i; // return the index
            }
        }
        return -1;
    };
    var saveIcon = '<span class="ui-state-default" style="border:0"><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span></span>'

    $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');

    $.extend($.jgrid.inlineEdit, {
        keys: true
    });




    function sacarDeEditMode() {

        // grabando o deshaciendo???
        //jQuery('#Lista').jqGrid('restoreCell', lastRowIndex, lastColIndex, true);
        try {
            jQuery('#Lista').jqGrid('saveCell', lastSelectediRow, lastSelectediCol);

        } catch (e) {

        }

        // jQuery('#Lista').jqGrid('editCell', lastRowIndex, lastColIndex);
        // jQuery('#Lista').jqGrid("setCell", rowid, "amount", val, "");



        var ids = $('#Lista').getDataIDs();
        for (var i = 0, il = ids.length; i < il; i++) {
            $('#Lista').jqGrid('restoreRow', ids[i]);
        }



        //        var $this = $('#Lista'), ids = $this.jqGrid('getDataIDs'), i, l = ids.length;
        //        for (i = l - 1; i >= 0; i--) {
        //                $('#Lista').jqGrid('restoreRow', ids[i]);
        //        }


    }

    function RefrescarFondoRenglon(grilla) {

        var iCol = getColumnIndexByName($(grilla), 'Situacion'),
            cRows = grilla.rows.length, iRow, row, className;

        for (iRow = 0; iRow < cRows; iRow++) {
            row = grilla.rows[iRow];
            className = row.className;
            if ($.inArray('jqgrow', className.split(' ')) > 0) {
                var x = ($(row.cells[iCol]))[0].childNodes[0].data; //.children("input:checked");

                //Autorizado: verde        Demorado: rojo            Rechazado: Violeta 
                if (x == "Autorizado") {
                    if ($.inArray('myAltRowClassAutorizado', className.split(' ')) === -1) {
                        row.className = className + ' myAltRowClassAutorizado';
                    }
                }
                else if (x == "Demorado") {
                    if ($.inArray('myAltRowClassDemorado', className.split(' ')) === -1) {
                        row.className = className + ' myAltRowClassDemorado';
                    }
                }
                else if (x == "Rechazado") {
                    if ($.inArray('myAltRowClassRechazado', className.split(' ')) === -1) {
                        row.className = className + ' myAltRowClassRechazado';
                    }
                }


            }
        }

    }









    $("#vale").click(function () {

        //alert('aaa')

        var $grid = $("#Lista");
        var lista = $grid.jqGrid("getGridParam", "selarrrow");
        if ((lista == null) || (lista.length == 0)) {
            // http://stackoverflow.com/questions/11762757/how-to-retrieve-the-cell-information-for-mouseover-event-in-jqgrid

            //como no hay renglones tildados, tomo el renglon sobre el que está el cursor
            lista = [rowIdContextMenu];
            // lista = $grid.jqGrid('getGridParam', 'selrow')

            if ((lista == null) || (lista.length == 0)) {
                alert("No hay cartas elegidas " + rowIdContextMenu);
                return;
            }

        }


        generarvale(lista, "administrador", "",
            function () {
                $("#loading").hide();
                $('#Lista').trigger('reloadGrid');
            })





    })




    function generarvale(ids, user, pass, callback) {
        //juntar los ids y mandarlos?


        $("#loading").show();


        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: "WebServiceCartas.asmx/GrabarSituaciones",

            data: JSON.stringify({
                idscartas: ids,
                idsituacion: 2,
                sObservacionesSituacion: ''
            }),
        }).done(function () {
            //if (typeof callback == "function") callback();
            $("#loading").hide();
            //alert("Vale creado")
            $('#Lista').trigger('reloadGrid');
        }).fail(function () {
            $("#loading").hide();
            alert("No se pudo crear el vale")
        });
    }





    function GrabarFila(gridId) {

        $grid = $('#Lista');

        var saveparameters = {
            "successfunc": null,
            "url": 'clientArray',
            "extraparam": {},
            //                "aftersavefunc": function (response) {
            //                    alert('saved');
            //                },
            "errorfunc": null,
            "afterrestorefunc": null,
            "restoreAfterError": true,
            "mtype": "POST"
        }

        //jQuery('#Lista').jqGrid('restoreCell', lastRowIndex, lastColIndex, true);
        //$('#Lista').jqGrid('saveRow', gridId, saveparameters, 'clientArray'); //si esta en inline mode, quizas salta un error!

        sacarDeEditMode();
        var dataFromTheRow = $grid.jqGrid('getRowData', gridId), i;

        //var dataIds = $('#Lista').jqGrid('getDataIDs');
        //for (i = 0; i < dataIds.length; i++) {
        //    try {
        //        //Save row only to the grid
        //        //$('#Lista').jqGrid('saveRow', dataIds[i], false, 'clientArray');
        //        $('#Lista').jqGrid('restoreRow', dataIds[i]);
        //    }
        //    catch (ex) {
        //        //If you are using editRules it might end up with exception
        //        $('#Lista').jqGrid('restoreRow', dataIds[i]);
        //    }
        //}

        var datos = {}; //= $("#formid").serializeObject();
        var err;


        datos.idcarta = gridId;
        datos.idsituacion = dataFromTheRow.Situacion;
        if (datos.idsituacion == "") datos.idsituacion = -1;
        datos.sObservacionesSituacion = dataFromTheRow.ObservacionesSituacion;


        err = ""
        //if (datos.Fecha == "" || datos.Fecha == undefined) err = err + "Falta definir la fecha.\n"
        //if (datos.IdWilliamsDestino == "" || datos.IdWilliamsDestino == undefined) err = err + "Falta el destino.\n"
        //if (datos.TotalDescargaDia == "" || datos.TotalDescargaDia == undefined) err = err + "Faltan los kilos de descarga\n"

        if (err != "") {
            alert('No se pudo grabar el registro.\n' + err);
        } else {
            //$('html, body').css('cursor', 'wait');






            $.ajax({
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                url: "WebServiceCartas.asmx/GrabarSituacion",
                dataType: 'json',
                data: JSON.stringify({
                    idcarta: gridId,
                    idsituacion: datos.idsituacion,
                    sObservacionesSituacion: dataFromTheRow.ObservacionesSituacion
                }),
                success: function (result) {
                    if (result) {
                        $grid.jqGrid('setRowData', gridId, { act: "" });
                        var rowid = $('#Lista').getGridParam('selrow');
                        var valor = result.IdCartasDePorteControlDescarga;
                        if (valor == "") { valor = "0"; }
                        $('#Lista').jqGrid('setCell', rowid, ' IdCartasDePorteControlDescarga', valor);

                        RefrescarFondoRenglon(document.getElementById('Lista'));
                    } else {
                        alert('No se pudo grabar el registro.');
                    }
                },
                error: function (xhr, textStatus, exceptionThrown) {
                    try {
                        var errorData = $.parseJSON(xhr.responseText);
                        var errorMessages = [];
                        for (var key in errorData) { errorMessages.push(errorData[key]); }
                        $('html, body').css('cursor', 'auto');
                        $('#grabar2').attr("disabled", false).val("Aceptar");
                        $("#textoMensajeAlerta").html(errorData.Errors.join("<br />"));
                        $("#mensajeAlerta").show();
                        alert(errorData.Errors.join("\n").replace(/<br\/>/g, '\n'));
                    } catch (e) {
                        $('html, body').css('cursor', 'auto');
                        $('#grabar2').attr("disabled", false).val("Aceptar");
                        $("#textoMensajeAlerta").html(xhr.responseText);
                        $("#mensajeAlerta").show();
                    }
                },
                beforeSend: function () {
                    //$('.loading').html('some predefined loading img html');
                    $("#loading").show();
                    $('#grabar2').attr("disabled", true).val("Espere...");

                },
                complete: function () {
                    $("#loading").hide();
                }

            });
        };
    };

    function EliminarFila(gridId) {
        $grid = $('#Lista');
        var dataFromTheRow = $grid.jqGrid('getRowData', gridId);
        var idprincipal = dataFromTheRow[' IdCartasDePorteControlDescarga'];
        if (idprincipal <= 0) {
            $grid.jqGrid('delRowData', gridId);
        } else {
            $.ajax({
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                url: "WebServiceClientes.asmx/DestinoDelete",
                dataType: 'json',
                data: JSON.stringify({ id: idprincipal }),
                success: function (result) {
                    if (result) {
                        $grid.jqGrid('delRowData', gridId);
                    } else {
                        alert('No se pudo eliminar el registro.');
                    }
                },
            });
        };
    };




    //window.parent.document.body.onclick = saveEditedCell; // attach to parent window if any
    //document.body.onclick = saveEditedCell; // attach to current document.

    //function saveEditedCell(evt) {
    //    var target = $(evt.target);

    //    if ($grid) {
    //        var isCellClicked = $grid.find(target).length; // check if click is inside jqgrid
    //        if (gridCellWasClicked && !isCellClicked) // check if a valid click
    //        {
    //            gridCellWasClicked = false;
    //            $grid.jqGrid("saveCell", lastSelectediRow2, lastSelectediCol2);
    //        }
    //    }

    //    //$grid = "";
    //    gridCellWasClicked = false;

    //    if (jQuery("#Lista").find(target).length) {
    //        $grid = $('#Lista');
    //        grillaenfoco = true;
    //    }
    //    if (grillaenfoco) {
    //        gridCellWasClicked = true;
    //        lastSelectediRow2 = lastSelectediRow;
    //        lastSelectediCol2 = lastSelectediCol;
    //    }
    //};



    function MarcarSeleccionadosParaEliminar(grid) {
        var selectedIds = grid.jqGrid('getGridParam', 'selarrrow');
        var i, Id;
        for (i = selectedIds.length - 1; i >= 0; i--) {
            Id = selectedIds[i];
            var se = "<input style='height:22px;width:20px;' type='button' value='B' onclick=\"EliminarFila('" + Id + "');\"  />";
            grid.jqGrid('setRowData', Id, { act: se });
            //grid.jqGrid('delRowData', selectedIds[i]);
        }
    };

    function AgregarItemVacio(grid) {
        var colModel = grid.jqGrid('getGridParam', 'colModel');
        var dataIds = grid.jqGrid('getDataIDs');
        var Id = (grid.jqGrid('getGridParam', 'records') + 1) * -1;
        var se = "<input style='height:22px;width:60px;' type='button' value='Grabar' onclick=\"GrabarFila('" + Id + "');\"  />";
        var data, j, cm;

        if (lastSelectediRow2 != undefined) { lastSelectediRow2 = lastSelectediRow2 + 1; }

        if (false) {
            data = '{';
            for (j = 1; j < colModel.length; j++) {
                cm = colModel[j];
                data = data + '"' + cm.index + '":' + '"",';
            }
            data = data.substring(0, data.length - 1) + '}';
        }
        else {

            data = " { \"act\": \"\" , \"IdCartasDePorteControlDescarga\": \"0\", \"Fecha\": \"\" , \"Descripcion\": \"\"   , \"IdWilliamsDestino\": \"0\", \"TotalDescargaDia\": \"0\" , \"IdPuntoVenta\": \"1\" } ";

        }
        //  grid.jqGrid("addRowData", "empty_" + i, );

        data = data.replace(/(\r\n|\n|\r)/gm, "");
        grid.jqGrid('addRowData', Id, data, "last");
        grid.jqGrid('setRowData', Id, { act: se });
    };





    function AgregarRenglonesEnBlanco(renglonVacio, nombregrilla) {


        nombregrilla = nombregrilla || "#Lista";
        var grid = jQuery(nombregrilla)
        var pageSize = parseInt(grid.jqGrid("getGridParam", "rowNum"))

        var rows = grid.getGridParam("reccount") || 0;


        // jQuery("#Lista").jqGrid('getGridParam', 'records')
        var emptyRows;       // -data.rows.length; // pageSize - data.rows.length;

        //alert(rows)
        if (rows < 3) emptyRows = 3 - rows;
        else emptyRows = 1;


        //pasa q tengo q ver cuántos de los renglones existentes ya están vacíos!!!
        //pasa q tengo q ver cuántos de los renglones existentes ya están vacíos!!!
        //pasa q tengo q ver cuántos de los renglones existentes ya están vacíos!!!
        //pasa q tengo q ver cuántos de los renglones existentes ya están vacíos!!!
        //pasa q tengo q ver cuántos de los renglones existentes ya están vacíos!!!

        var rowsLlenas = 0;

        var dataIds = grid.jqGrid('getDataIDs');
        for (var i = 0; i < dataIds.length; i++) {

            var data = grid.jqGrid('getRowData', dataIds[i]);


            var desc = data['Descripcion'];
            // alert(desc);
            if (desc == "") continue;

            if (data['NumeroItem'] == "") {
                data['NumeroItem'] = ProximoNumeroItem();
                grid.jqGrid('setRowData', dataIds[i], data);
            }

            rowsLlenas++;
        }




        // alert(rowsLlenas);
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////


        if (!renglonVacio) {
            //    alert('ssss');
            renglonVacio = {};
        }


        var gridceil

        if (emptyRows > 0 && (rowsLlenas == rows || rows < 3)) {
            //   alert(emptyRows);
            for (var i = 1; i <= emptyRows; i++) {
                //                    // adjust the counts at lower right
                //                    grid.jqGrid("setGridParam", {
                //                        reccount: grid.jqGrid("getGridParam", "reccount") - emptyRows,
                //                        records: grid.jqGrid("getGridParam", "records") - emptyRows
                //                    });
                //                    grid[0].updatepager();




                // grid.jqGrid("addRowData", "empty_" + i, {});



                gridceil = Math.ceil(Math.random() * 1000000); // ojo con esto, si usas el mismo id, la edicion de un renglon se va a pasar a otro al instante!, y no vas a entender q está pasando 


                grid.jqGrid("addRowData", "empty_" + gridceil, renglonVacio);
                //  grid.jqGrid("addRowData", "empty_" + i, { "IdDetalleComprobanteProveedor": "0", "IdCuenta": "0", "Precio": "0", "Descripcion": "" });

            }

        }
        rows = grid.getGridParam("reccount");


        //alert(rows);

        grid.jqGrid('setGridHeight', Math.max(140, rows * 45), true);
    }


    // Esto es para obtener el contenido de una celda en modo edicion. Ojo que las funciones estan como declarativas (,)
    //getColumnIndexByName = function (grid, columnName) {
    //    var cm = grid.jqGrid('getGridParam', 'colModel');
    //    for (var i = 0, l = cm.length; i < l; i++) {
    //        if (cm[i].name === columnName) {
    //            return i; // return the index
    //        }
    //    }
    //    return -1;
    //},
    //getTextFromCell = function (cellNode) {
    //    return cellNode.childNodes[0].nodeName === "INPUT" ?
    //            cellNode.childNodes[0].value :
    //            cellNode.textContent || cellNode.innerText;
    //},
    //calculateTotal = function () {
    //    var totalAmount = 0, totalTax = 0,
    //        i = getColumnIndexByName(grid, 'amount'); // nth-child need 1-based index so we use (i+1) below
    //    $("tbody > tr.jqgrow > td:nth-child(" + (i + 1) + ")", grid[0]).each(function () {
    //        totalAmount += Number(getTextFromCell(this));
    //    });

    //    i = getColumnIndexByName(grid, 'tax');
    //    $("tbody > tr.jqgrow > td:nth-child(" + (i + 1) + ")", grid[0]).each(function () {
    //        totalTax += Number(getTextFromCell(this));
    //    });

    //    grid.jqGrid('footerData', 'set', { name: 'TOTAL', amount: totalAmount, tax: totalTax });
    //};





    $('#ctl00_ContentPlaceHolder1_cmbPuntoVenta').change(function () {
        $('#Lista').trigger("reloadGrid")
    });


    $('#ctl00_ContentPlaceHolder1_txtDestino').change(function () {
        $('#Lista').trigger("reloadGrid")
    });


    $('#ctl00_ContentPlaceHolder1_txtFechaDesde').change(function () {
        $('#Lista').trigger("reloadGrid")
    });


    $('#ctl00_ContentPlaceHolder1_txtFechaHasta').change(function () {
        $('#Lista').trigger("reloadGrid")
    });

    $('#ctl00_ContentPlaceHolder1_cmbPeriodo').change(function () {
        $('#Lista').trigger("reloadGrid")
    });


    function RefrescaGrilla() {
        $('#Lista').trigger("reloadGrid");
    }


    $().ready(function () {
        'use strict';

        var UltimoIdArticulo;









        var hoy = new Date();
        var desde = new Date();

        desde.setDate(hoy.getDate() - 1000);


        $("#txtFechaDesde").val(desde.getDate() + '/' + (desde.getMonth() + 1) + '/' + desde.getFullYear())
        $("#txtFechaHasta").val(hoy.getDate() + '/' + (hoy.getMonth() + 1) + '/' + hoy.getFullYear())


        //alert (hoy + ' ' +  desde)


        $('#Lista').jqGrid({
            //url: ROOT + 'CotizacionWilliamsDestino/Cotizaciones/',
            url: 'HandlerCartaPorte.ashx',
            //postData: {},
            postData: {
                'FechaInicial': function () { return $("#txtFechaDesde").val(); },
                'FechaFinal': function () { return $("#txtFechaHasta").val(); },
                'puntovent': function () { return $("#cmbPuntoVenta").val(); },
                'destino': function () { return $("txtDestino").val(); }
            },
            datatype: 'json',
            mtype: 'POST',




            // CP	TURNO	SITUACION	MERC	TITULAR_CP	INTERMEDIARIO	RTE CIAL	CORREDOR	DESTINATARIO	DESTINO	ENTREGADOR	PROC	KILOS	OBSERVACION


            colNames: ['', 'Id', 'Nro CP', 'Turno', 'Situacion',
                'Producto', 'Titular', 'Intermediario', 'R Comercial', 'Corredor',
                'Destinatario', 'Destino', 'IdDestino', 'Entregador', 'Procedencia',
                'Kilos Procedencia', 'Obs Situacion', 'Arribo', 'Descarga', 'Punto Venta',
                'Fecha actualizacion', 'Patente', 'Kilos Descargados'
            ],

            colModel: [
                {
                    name: 'act', index: 'act', align: 'center', width: 60, editable: false, hidden: true, sortable: false, frozen: true, search: false
                },

                { name: ' IdCartasDePorte', index: ' IdCartasDePorte', align: 'left', width: 100, editable: false, hidden: true, frozen: true },

                {
                    name: 'NumeroCartaEnTextoParaBusqueda', index: 'NumeroCartaEnTextoParaBusqueda', width: 100, align: 'left', sorttype: "text", sortable: false, frozen: true
                    , editable: false, editrules: { required: false, number: true }, edittype: 'text',

                    searchoptions: { sopt: ['bw', 'cn', 'eq'] },


                    editoptions: {
                        maxlength: 20, defaultValue: '0.00',
                        dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#Lista').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                    }
                },

                { name: 'Turno', index: ' Turno', align: 'left', width: 20, editable: false, hidden: false, edittype: 'text', searchoptions: { sopt: ['bw', 'cn', 'eq'] }, },

                {
                    name: 'Situacion', index: 'Situacion', align: 'left', width: 120, hidden: false, editable: true, edittype: 'select', sortable: false,
                    editoptions: {
                        //defaultValue: OrigenDescripcionDefault,
                        //value: "0:Autorizado; 6:Desviado" 
                        value: "0:Autorizado; 1:Demorado; 2:Posicion; 3:Descargado; 4:A Descargar; 5:Rechazado;6:Desviado;7:CP p/cambiar;8:Sin Cupo;9:Calado"
                    },
                    // http://stackoverflow.com/questions/5328072/can-jqgrid-support-dropdowns-in-the-toolbar-filter-fields
                    formatter: 'select', stype: 'select',
                    searchoptions: {
                        sopt: ['eq'],
                        value: ":Todos; 0:Autorizado; 1:Demorado; 2:Posicion; 3:Descargado; 4:A Descargar; 5:Rechazado;6:Desviado;7:CP p/cambiar;8:Sin Cupo;9:Calado"
                    }


                },


                {
                    name: 'Producto', index: 'Producto', align: 'left', width: 60, hidden: false, editable: false, edittype: 'text', sortable: false

                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetProductos",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}

                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }

                },
                {
                    name: 'TitularDesc', index: 'TitularDesc', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false


                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetClientes",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}

                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }

                },
                {
                    name: 'IntermediarioDesc', index: 'IntermediarioDesc', align: 'left', width: 60, hidden: false, editable: false, edittype: 'text', sortable: false

                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetClientes",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}

                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }
                },
                {
                    name: 'RComercialDesc', index: 'RComercialDesc', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false


                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetClientes",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}

                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }

                },


                {
                    name: 'CorredorDesc', index: 'CorredorDesc', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false

                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetCorredores",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}

                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }
                },


                {
                    name: 'DestinatarioDesc', index: 'DestinatarioDesc', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false


                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetClientes",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}

                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }

                },

                {
                    name: 'DestinoDesc', index: 'DestinoDesc',
                    formoptions: { rowpos: 5, colpos: 2, label: "Descripción" }, align: 'left', width: 100, hidden: false, editable: true, edittype: 'text', sortable: false,
                    searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/WilliamsDestinoGetWilliamsDestinos",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        //success: function (data2) {
                                        //    var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                        //    if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                        //        var ui = data[0];

                                        //        if (ui.id == "") {
                                        //            alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                        //            $("#Descripcion").val("");
                                        //            return;
                                        //        }
                                        //        $("#IdWilliamsDestino").val(ui.id);

                                        //        UltimoIdArticulo = ui.id;
                                        //    }
                                        //    else {
                                        //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                        //    }

                                        //    response($.map(data, function (item) {
                                        //        return {
                                        //            label: item.value,
                                        //            value: item.value //item.id
                                        //            , id: item.id
                                        //        }
                                        //    }));

                                        //}



                                    })


                                }


                            });






                        }
                    }

                },
                { name: 'Destino', index: 'Destino', align: 'left', width: 100, hidden: true, editable: false, edittype: 'text', sortable: false },


                {
                    name: 'EntregadorDesc', index: 'EntregadorDesc', align: 'left', width: 50, hidden: false, editable: false, edittype: 'text', sortable: false


                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).trigger('change');
                                },


                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetClientes",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}

                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }

                },

                {
                    name: 'ProcedenciaDesc', index: 'ProcedenciaDesc', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false


                    , searchoptions: {
                        //    sopt:['eq'], 
                        dataInit: function (elem) {
                            var NoResultsLabel = "No se encontraron resultados";


                            $(elem).autocomplete({

                                select: function (event, ui) {
                                    $(elem).val(ui.item.value);
                                    $(elem).trigger('change');
                                },

                                source: function (request, response) {
                                    $.ajax({
                                        type: "POST",
                                        url: "WebServiceClientes.asmx/GetLocalidades",
                                        dataType: "json",
                                        contentType: "application/json; charset=utf-8",

                                        data: JSON.stringify({
                                            term: request.term
                                            //, idpuntoventa: function () { return $("#ctl00_ContentPlaceHolder1_txtFechaHasta").val(); }
                                        }),


                                        success: function (data2) {
                                            var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                            //if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                            //    var ui = data[0];

                                            //    if (ui.id == "") {
                                            //        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //        $("#Descripcion").val("");
                                            //        return;
                                            //    }
                                            //    $("#IdWilliamsDestino").val(ui.id);

                                            //    UltimoIdArticulo = ui.id;
                                            //}
                                            //else {
                                            //    alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            //}




                                            response($.map(data, function (item) {
                                                return {
                                                    label: item.value,
                                                    value: item.value //item.id
                                                    , id: item.id
                                                }
                                            }));

                                        }



                                    })


                                }


                            });






                        }
                    }
                },

                { name: 'NetoPto', index: 'NetoPto', align: 'left', width: 60, hidden: false, editable: false, edittype: 'text', sortable: false },

                { name: 'ObservacionesSituacion', index: 'ObservacionesSituacion', align: 'left', width: 100, editable: true, hidden: false, sortable: false },

                {
                    name: 'FechaArribo', index: 'FechaArribo', width: 100, sortable: true, align: 'right', editable: false, sortable: false,
                    editoptions: {
                        size: 10,
                        maxlengh: 10,
                        dataInit: function (element) {
                            $(element).datepicker({
                                dateFormat: 'dd/mm/yy',
                                constrainInput: false,
                                showOn: 'button',
                                buttonText: '...'
                            });
                        }
                    },
                    formatoptions: { newformat: "dd/mm/yy" }, datefmt: 'dd/mm/yy'
                    //, formatter: 'date'
                    , sorttype: 'date'


                    , searchoptions: {
                        sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge'],
                        dataInit: function (elem) {
                            $(elem).datepicker({
                                dateFormat: 'dd/mm/yy',
                                showButtonPanel: true
                            })
                        }
                    }
                },



                {
                    name: 'FechaDescarga', index: 'FechaDescarga', width: 100, sortable: true, align: 'right', editable: false, sortable: false,
                    editoptions: {
                        size: 10,
                        maxlengh: 10,
                        dataInit: function (element) {
                            $(element).datepicker({
                                dateFormat: 'dd/mm/yy',
                                constrainInput: false,
                                showOn: 'button',
                                buttonText: '...'
                            });
                        }
                    },
                    formatoptions: { newformat: "dd/mm/yy" }, datefmt: 'dd/mm/yy'
                    //, formatter: 'date'
                    , sorttype: 'date'


                    , searchoptions: {
                        sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge'],
                        dataInit: function (elem) {
                            $(elem).datepicker({
                                dateFormat: 'dd/mm/yy',
                                showButtonPanel: true
                            })
                        }
                    }
                },




                { name: 'PuntoVenta', index: 'PuntoVenta', align: 'left', width: 50, hidden: false, editable: false, edittype: 'text', sortable: false },



                {
                    name: 'FechaActualizacionAutomatica', index: 'FechaActualizacionAutomatica', width: 150, sortable: true, align: 'right', editable: false, sortable: false,
                    editoptions: {
                        size: 10,
                        maxlengh: 10,
                        dataInit: function (element) {
                            $(element).datepicker({
                                dateFormat: 'dd/mm/yy',
                                constrainInput: false,
                                showOn: 'button',
                                buttonText: '...'
                            });
                        }
                    },
                    formatoptions: { newformat: "dd/mm/yy" }, datefmt: 'dd/mm/yy'
                    //, formatter: 'date'
                    , sorttype: 'date'


                    , searchoptions: {
                        sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge'],
                        dataInit: function (elem) {
                            $(elem).datepicker({
                                dateFormat: 'dd/mm/yy',
                                showButtonPanel: true
                            })
                        }
                    }
                },


                { name: 'Patente', index: 'Patente', align: 'left', width: 100, hidden: false, editable: false, edittype: 'text', sortable: false },

                { name: 'NetoProc', index: 'NetoProc', align: 'left', width: 60, hidden: false, editable: false, edittype: 'text', sortable: false }


            ],

            gridComplete: function () {
                //    var ids = jQuery("#Lista").jqGrid('getDataIDs');
                //    for (var i = 0; i < ids.length; i++) {
                //        var cl = ids[i];
                //        var se = "<input style='height:22px;width:20px;' type='button' value='G' onclick=\"GrabarFila('" + cl + "'); \"  />";
                //        jQuery("#Lista").jqGrid('setRowData', ids[i], { act: se });
                //    }
                //jQuery("#Lista").jqGrid('addRowData', Id, data, "last");
                //AgregarItemVacio(grid)


            },



            loadComplete: function () {
                // http://stackoverflow.com/questions/6575192/jqgrid-change-background-color-of-row-based-on-row-cell-value-by-column-name

                $("#ListaPager_center").width(150);


                RefrescarFondoRenglon(this);


            },




            onCellSelect: function (rowid, iCol, cellcontent, e) {
                var $this = $(this);
                var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
                lastSelectedId = rowid;
                lastSelectediCol = iCol;
                lastSelectediRow = iRow;
            },
            afterEditCell: function (id, name, val, iRow, iCol) {
                //if (name == 'Fecha') {
                //    jQuery("#" + iRow + "_Fecha", "#Lista").datepicker({ dateFormat: "dd/mm/yy" });
                //}
                var se = "<input style='height:22px;width:55px;' type='button' value='Grabar' onclick=\"GrabarFila('" + id + "');\"  />";
                jQuery("#Lista").jqGrid('setRowData', id, { act: se });
            },
            //beforeSelectRow: function (rowid, e) {
            //var $this = $(this),
            //    $td = $(e.target).closest('td'),
            //    $tr = $td.closest('tr'),
            //    iRow = $tr[0].rowIndex,
            //    iCol = $.jgrid.getCellIndex($td);

            //if (typeof lastSelectediRow !== "undefined" && typeof lastSelectediCol !== "undefined" &&
            //        (iRow !== lastSelectediRow || iCol !== lastSelectediCol)) {
            //    $this.jqGrid('setGridParam', {cellEdit: true});
            //    $this.jqGrid('restoreCell', lastSelectediRow, lastSelectediCol, true);
            //    $this.jqGrid('setGridParam', {cellEdit: false});
            //    $(this.rows[lastSelectediRow].cells[lastSelectediCol])
            //        .removeClass("ui-state-highlight");
            //}
            //return true;
            //},

            pager: $('#ListaPager'),
            rowNum: 10,
            rowList: [10, 20, 50, 100, 500, 1000],
            sortname: 'IdCartaDePorte',  //'FechaDescarga', //'NumeroCartaDePorte',
            sortorder: 'desc',
            viewrecords: true,
            multiselect: true,
            shrinkToFit: false,

            width: 340,//'auto',
            height: $(window).height() - 300, // '100%'
            altRows: false,
            footerrow: false,
            userDataOnFooter: true,
            //caption: '<b>Control de Descargas</b>',
            cellEdit: false, // si usas frozencolumns, estas obligado a sacar el cellEdit!!!
            cellsubmit: 'clientArray',
            dataUrl: "WebServiceClientes.asmx/EmpleadoEditGridData",

            recordtext: "{2} cartas</span>",
            pgtext: "Pag. {0} de {1}",
            //toppager: true,

            gridview: true
            , multiboxonly: true
            , multipleSearch: true

        });



        jQuery('#Lista').jqGrid('gridResize');

        jQuery("#Lista").jqGrid('bindKeys');

        jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
            { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
            {
                //sopt: ["cn"]
                //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
                zIndex: 50, //width: 700, 
                closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false

            }
            // http://stackoverflow.com/questions/11228764/jqgrid-setting-zindex-for-alertmod
        );

        //jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
        //    { search: false, refresh: false, add: false, edit: false, del: false }, {}, {}, {}, {});



        //jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
        //                                {
        //                                    caption: "", buttonicon: "ui-icon-plus", title: "Agregar",
        //                                    onClickButton: function () {
        //                                        AgregarItemVacio(jQuery("#Lista"));
        //                                    },
        //                                });
        //jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
        //                                {
        //                                    caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
        //                                    onClickButton: function () {
        //                                        MarcarSeleccionadosParaEliminar(jQuery("#Lista"));
        //                                    },
        //                                });



        jQuery("#Lista").filterToolbar({
            stringResult: true, searchOnEnter: true,
            defaultSearch: 'cn',
            enableClear: false
        }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/


        jQuery("#Lista").jqGrid('setFrozenColumns'); // si usas frozencolumns, estas obligado a sacar el cellEdit!!!


        //$('#Lista').jqGrid('setGridWidth', '1000');
        //$('#Lista').jqGrid('setGridWidth', $(window).width() - 40);

    });



    $(window).resize(function () {
        //$('#Lista').jqGrid('setGridWidth', $(window).width() - 40);
        //RefrescaAnchoJqgrids();
    });


    var getColumnIndexByName = function (grid, columnName) {
        var cm = grid.jqGrid('getGridParam', 'colModel'), i = 0, l = cm.length;
        for (; i < l; i++) {
            if (cm[i].name === columnName) {
                return i; // return the index
            }
        }
        return -1;
    };



    



        </script>



  <script src="https://www.gstatic.com/firebasejs/4.5.0/firebase.js"></script>
    <script>
        // Initialize Firebase
        var config = {
            apiKey: "AIzaSyD_KzMypOaPPCUl42hvR3BEkB9ZHCU9Nuc",
            authDomain: "pronto-f87bf.firebaseapp.com",
            databaseURL: "https://pronto-f87bf.firebaseio.com",
            projectId: "pronto-f87bf",
            storageBucket: "",
            messagingSenderId: "741177410808"
        };
        firebase.initializeApp(config);



        var bigOne = document.getElementById('bigOne');
        var dbRef = firebase.database().ref().child('text');
        dbRef.on('value',snap => bigOne.innerText=snap.val())

    </script>


