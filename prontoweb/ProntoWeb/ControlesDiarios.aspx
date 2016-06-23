<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="ControlesDiarios.aspx.vb" Inherits="ControlesDiarios"
    Title="Informes" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, 
Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--/////////////////////////////////////////////////////////////--%>
    <%--//////////       jquery    /////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--///////////     bootstrap    /////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--////////////    jqgrid     //////////////////////////////////--%>
    <link href="//cdn.jsdelivr.net/jqgrid/4.5.2/css/ui.jqgrid.css" rel="stylesheet">
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.2/jquery.jqGrid.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <br />
    <br />
    <div>
     <%--   <table id="list9">
        </table>
        <div id="pager9">
        </div>
        <br />
        <a href="javascript:void(0)" id="m1">Get Selected id's</a> <a href="javascript:void(0)"
            id="m1s">Select(Unselect) row 13</a>--%>

        <table id="Lista" class="scroll" cellpadding="0" cellspacing="0" style="font-size: 16px;">
        </table>
        <div id="ListaPager" class="scroll" style="text-align: center; background: ; height: 30px">
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


    <div>
        <script type="text/javascript">
            $(document).ready(function () {
                var lastSelectedId;
                var inEdit;
                grid = $("#Lista");

                //Para que haga wrap en las celdas
                $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');




                $('#Lista').jqGrid({
                    //url: '@Url.Action("Pedidos_DynamicGridData", "Pedido")',
                    url: 'Handler.ashx',

                    postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); } },
                    datatype: 'json',
                    mtype: 'POST',
                    colNames: ['Acciones', 'IdPedido', 'Fecha', 'Destino' ,'Kilos', 'Oficina'

                    ],
                    colModel: [

                                { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, frozen: true, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                                { name: 'IdCartasDePorteControlDescarga', index: 'IdCartasDePorteControlDescarga', align: 'left', width: 100, editable: false, hidden: true },
                                { name: 'Fecha', index: 'Fecha', width: 100, align: 'center', sorttype: 'date', editable: true, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                                { name: 'WilliamsDestino', index: 'WilliamsDestino', align: 'right', width: 30, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                                { name: 'TotalDescargaDia', index: 'TotalDescargaDia', align: 'right', width: 70, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                                { name: 'IdPuntoVenta', index: 'IdPuntoVenta', align: 'right', width: 30, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } }
                                

                    ],
                    onSelectRow: function (id) {
                        if (id && id !== lastSelectedId) {
                            if (typeof lastSelectedId !== "undefined") {
                                grid.jqGrid('restoreRow', lastSelectedId);
                            }
                            lastSelectedId = id;
                        }
                    },
                    ondblClickRow: function (idrow) {
                        window.location.href = ROOT + 'Pedido/Edit/' + idrow;


                        // $("#edtData").click();

                        //edicion inline
                        // http://stackoverflow.com/questions/8163106/form-editing-with-inline-editing-to-same-jqgrid
                        //                if(id && id!==lastSel){ 
                        //                    jQuery('#Lista').restoreRow(lastSel); 
                        //                    lastSel=id; 
                        //                }
                        //                jQuery('#Lista').editRow(id, true); 
                        //   

                    },




                    pager: $('#ListaPager'),
                    rowNum: 15,
                    rowList: [10, 20, 50],
                    sortname: 'Fecha', // 'FechaRecibo,NumeroRecibo',
                    sortorder: 'desc',
                    viewrecords: true,
                    emptyrecords: 'No hay registros para mostrar', //,


                    ///////////////////////////////
                    width: 'auto', // 'auto',
                    autowidth: true,
                    shrinkToFit: false,
                    //////////////////////////////

                    height: $(window).height() - 500, // '100%'
                    altRows: false,
                    footerrow: false, //true,
                    userDataOnFooter: true
                    // ,caption: '<b>FACTURAS</b>'

                    , gridview: true
                    , multiboxonly: true
                    , multipleSearch: true





                });

                jQuery("#Lista").jqGrid('bindKeys');

                jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
                 { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
                 {
                     //sopt: ["cn"]
                     //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
                     width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
                 }
                );

                $("#Lista").jqGrid("inlineNav", "#ListaPager", { addParams: { position: "last" } });

                jQuery("#Lista").filterToolbar({
                    stringResult: true, searchOnEnter: true,
                    defaultSearch: 'cn',
                    enableClear: false
                }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/

            })

        </script>
    </div>

    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
