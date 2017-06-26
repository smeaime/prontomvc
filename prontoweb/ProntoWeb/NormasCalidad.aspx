<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="NormasCalidad.aspx.vb" Inherits="NormasCalidad"
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
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.4/i18n/grid.locale-es.js" target></script>
    <link href="//cdn.jsdelivr.net/jqgrid/4.5.2/css/ui.jqgrid.css" rel="stylesheet">
    <script src="//cdn.jsdelivr.net/jqgrid/4.5.2/jquery.jqGrid.js"></script>
    <%--/////////////////////////////////////////////////////////////--%>
    <%--/////////////////////////////////////////////////////////////--%>
    <br />

    <div class="titulos" style="color: white">
        Normas
    </div>
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


        <asp:Button ID="informe" Text="VER INFORME" runat="server" Visible="false" CssClass="btn btn-primary"
            Width="150" Height="40"  />




        <asp:UpdatePanel ID="UpdatePanelResumen" runat="server" Visible="false">
            <ContentTemplate>

                <table>
                    <tr>

                        <td class="EncabezadoCell" style="width: 160px; height: 18px;">Período descarga</td>
                        <td class="EncabezadoCell" style="width: 400px; height: 18px;">
                            <asp:DropDownList ID="cmbPeriodo" runat="server" AutoPostBack="true" Height="22px" 
                                Visible="true">
                                <asp:ListItem Text="Hoy" />
                                <asp:ListItem Text="Ayer" />
                                <%--<asp:ListItem Text="Esta semana" />
                        <asp:ListItem Text="Semana pasada" />--%>
                                <asp:ListItem Text="Este mes" Selected="True" />
                                <asp:ListItem Text="Mes anterior" />
                                <asp:ListItem Text="Cualquier fecha" />
                                <%--    <asp:ListItem Text="Filtrar por Mes/Año" />--%>
                                <asp:ListItem Text="Personalizar" />
                            </asp:DropDownList>
                            <asp:TextBox ID="txtFechaDesde" runat="server" Width="100px" MaxLength="1" autocomplete="off"
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
                            <asp:TextBox ID="txtFechaHasta" runat="server" Width="100px" MaxLength="1" TabIndex="2"
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
                    <tr>
                        <td class="EncabezadoCell" style="width: 160px; height: 18px;">Punto venta
                        </td>
                        <td class="EncabezadoCell">
                            <asp:DropDownList ID="cmbPuntoVenta" runat="server" CssClass="CssTextBox" Width="128px" />
                        </td>

                    </tr>

                    <tr>
                        <td class="EncabezadoCell" style="width: 100px; height: 18px;">Destino
                        </td>
                        <td class="EncabezadoCell" style="width: 250px; height: 18px;">
                            <asp:TextBox ID="txtDestino" runat="server" Text='<%# Bind("DestinoDesc") %>' AutoPostBack="false"
                                autocomplete="off" CssClass="CssTextBox" Width="200px"></asp:TextBox>
                            <cc1:AutoCompleteExtender CompletionInterval="100" ID="AutoCompleteExtender26" runat="server"
                                 OnClientItemSelected="RefrescaGrilla()"
                                CompletionSetCount="12" TargetControlID="txtDestino" MinimumPrefixLength="1"
                                ServiceMethod="GetCompletionList" ServicePath="WebServiceWilliamsDestinos.asmx"
                                UseContextKey="True" FirstRowSelected="True" CompletionListCssClass="AutoCompleteScroll"
                                DelimiterCharacters="" Enabled="True">
                            </cc1:AutoCompleteExtender>
                    </tr>

                </table>

            </ContentTemplate>
        </asp:UpdatePanel>

        <br />
        <%--<input type="text" class="span4" id="text1" name="agent" value=""  "/>--%>


        <table id="Lista" class="scroll" cellpadding="0" cellspacing="0" style="font-size: 16px;">
        </table>
        <div id="ListaPager" class="scroll" style="text-align: center; height: 30px">
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
        <%--<script type="text/javascript">
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
                    colNames: ['Acciones', 'IdPedido', 'Fecha', 'Destino', 'Kilos', 'Oficina'

                    ],
                    colModel: [

                                { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, frozen: true, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                                { name: 'IdCartasDePorteControlDescarga', index: 'IdCartasDePorteControlDescarga', align: 'left', width: 100, editable: false, hidden: true },
                                { name: 'Fecha', index: 'Fecha', width: 120, align: 'center', sorttype: 'date', editable: true, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                                { name: 'WilliamsDestino', index: 'WilliamsDestino', align: 'right', width: 240, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                                { name: 'TotalDescargaDia', index: 'TotalDescargaDia', align: 'right', width: 70, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                                { name: 'IdPuntoVenta', index: 'IdPuntoVenta', align: 'right', width: 50, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } }


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

        </script>--%>





        <script type="text/javascript">

            "use strict";







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


                datos.IdCartasDePorteControlDescarga = gridId;
                datos.Fecha = dataFromTheRow.Fecha;
                datos.IdWilliamsDestino = dataFromTheRow.IdWilliamsDestino;
                //datos.Cotizacion = dataFromTheRow.Cotizacion;
                datos.TotalDescargaDia = dataFromTheRow.TotalDescargaDia;
                datos.IdPuntoVenta = dataFromTheRow.IdPuntoVenta;


                err = ""
                if (datos.Fecha == "" || datos.Fecha == undefined) err = err + "Falta definir la fecha.\n"
                if (datos.IdWilliamsDestino == "" || datos.IdWilliamsDestino == undefined) err = err + "Falta el destino.\n"
                if (datos.TotalDescargaDia == "" || datos.TotalDescargaDia == undefined) err = err + "Faltan los kilos de descarga\n"

                if (err != "") {
                    alert('No se pudo grabar el registro.\n' + err);
                } else {
                    //$('html, body').css('cursor', 'wait');
                    $.ajax({
                        type: 'POST',
                        contentType: 'application/json; charset=utf-8',
                        url: "WebServiceClientes.asmx/NormaCalidadBatchUpdate",
                        dataType: 'json',
                        data: JSON.stringify({ o: datos }),
                        success: function (result) {
                            if (result) {
                                $grid.jqGrid('setRowData', gridId, { act: "" });
                                var rowid = $('#Lista').getGridParam('selrow');
                                var valor = result.IdCartasDePorteControlDescarga;
                                if (valor == "") { valor = "0"; }
                                $('#Lista').jqGrid('setCell', rowid, ' IdCartasDePorteControlDescarga', valor);
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
                var se = "<input style='height:22px;width:100px;' type='button' value='Grabar' onclick=\"GrabarFila('" + Id + "');\"  />";
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

                $('#Lista').jqGrid({


                    // si se queja de que no le estas pasando el filters https://stackoverflow.com/questions/20091730/jqgrid-toolbar-filter-parameters-in-link-with-asmx-web-service

                    //url: 'WebServiceClientes.asmx/NormasCalidad_DynamicGridData',
                    url: 'HandlerNormas.ashx', //sigo teniendo problemas si quiero reemplazar el ASHX por un ASMX (probablemente por el wrapper ".d" con el que se vuelve del ASMX) 
                    
                    
                    datatype: 'json',
                    mtype: 'POST',
                    //contentType: 'application/json; charset=utf-8',
                    //ajaxGridOptions: { contentType: 'application/json; charset=utf-8' },


                    /*serializeGridData: function (postData) {
                        if (postData.filters === undefined) postData.filters = null;
                        return JSON.stringify(postData); // no usar este si usas xml
                        //return postData; 
                    },*/
                    //xmlReader: { root: "rows", row: "jqGridRowJson", cell: "string" }, // ahi enganchó. una bronca q no me esté andando con json (al usar ASMX. con el ASHX sí anduvo, sin tener que especificar el jsonReader)
/*
                    jsonReader: {
                        root: "d.rows",
                        page: "d.page",
                        total: "d.total",
                        records: "d.records",
                        repeatitems: true,
                        //cell: "cell",
                        id: "id",

                        ////id: "id",
                        ////cell: "",
                        //root: function (obj) {
                        //    //return JSON.parse(obj.d); 
                        //    return obj.d;
                        //},
                        //page: function () { return 1; },
                        //total: function () { return 3; },
                        //records: function (obj) {
                        //    return 3;
                        //    //return JSON.parse(obj.d).records;
                        //    //return obj.d.records;
                        //},
                        //repeatitems: true
                    },*/
                    //jsonReader: {
                    //    root: "rows",
                    //    page: "page",
                    //    total: "total",
                    //    records: "records",
                    //    repeatitems: true,
                    //    cell: "cell",
                    //    id: "id",
                    //    userdata: "userdata",
                    //    subgrid: {
                    //        root: "rows",
                    //        repeatitems: true,
                    //        cell: "cell"
                    //    }
                    //},



                    colNames: ['', 'Id', 'Fecha', 'Destino', 'IdDestino', 'TOTAL Puerto', 'Sucursal'

                    ],



                    colModel: [
                                {
                                    name: 'act', index: 'act', align: 'center', width: 110, editable: false, hidden: false,
                                    search: false,
                                },
                                { name: ' IdCartasDePorteControlDescarga', index: ' IdCartasDePorteControlDescarga', align: 'left', width: 100, editable: false, hidden: true },
                                {
                                    name: 'Fecha', index: 'Fecha', width: 200, sortable: false, align: 'right', editable: true,
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
                                        sopt: ['eq', 'ne'],
                                        dataInit: function (elem) {
                                            $(elem).datepicker({
                                                dateFormat: 'dd/mm/yy',
                                                showButtonPanel: true
                                            })
                                        }
                                    }
                                },





                                 {
                                     name: 'WilliamsDestino.Descripcion', index: 'WilliamsDestino.Descripcion',
                                     formoptions: { rowpos: 5, colpos: 2, label: "Descripción" }, align: 'left', width: 450, hidden: false, editable: true, edittype: 'text',
                                     editoptions: {
                                         rows: '1', cols: '1',
                                         dataInit: function (elem) {
                                             var NoResultsLabel = "No se encontraron resultados";


                                             $(elem).autocomplete({
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


                                                         success: function (data2) {
                                                             var data = JSON.parse(data2.d) // por qué tengo que usar parse?

                                                             if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                                                 var ui = data[0];

                                                                 if (ui.id == "") {
                                                                     alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                                                     $("#Descripcion").val("");
                                                                     return;
                                                                 }
                                                                 $("#IdWilliamsDestino").val(ui.id);

                                                                 UltimoIdArticulo = ui.id;
                                                             }
                                                             else {
                                                                 alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                                             }

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

                                                  ,
                                                 select: function (e, ui) {
                                                     //http://stackoverflow.com/questions/27635689/jqgrid-autocomplete-cannot-post-id-column
                                                     // Oleg
                                                     //UPDATED: It's really important to know which editing mode you use because 
                                                     //id of input fields will be set based on different rules. The below code detect
                                                     //whether form editing, inline editing or toolbar filter will be used which to choose the corresponding id.

                                                     try {
                                                         var id;
                                                         if ($(elem).hasClass("FormElement")) {
                                                             // form editing
                                                             id = "IdWilliamsDestino";
                                                         } else if ($(elem).closest(".ui-search-toolbar").length > 0) {
                                                             // filter foolbar
                                                             id = "gs_IdWilliamsDestino";
                                                         } else if ($(elem).closest("tr.jqgrow").length > 0) {
                                                             //id = $(elem).closest("tr.jqgrow").attr("id") + "_IdWilliamsDestino";

                                                             var rowId = $("#Lista").jqGrid('getGridParam', 'selrow');
                                                             var rowData = $("#Lista").jqGrid('getRowData', rowId);
                                                             rowData.Descripcion = ui.item.value;
                                                             rowData.IdWilliamsDestino = ui.item.id;
                                                             // $("#Lista").jqGrid('setRowData', rowId, rowData);

                                                             $("#Lista").jqGrid("setCell", rowId, "IdWilliamsDestino", rowData.IdWilliamsDestino);
                                                         }
                                                         //$("#" + id).val(ui.item.id);

                                                     } catch (e) {

                                                     }
                                                 }
                                             });






                                         }


                                     },
                                     editrules: { required: true }
                                 },


            { name: 'IdWilliamsDestino', index: 'IdWilliamsDestino', align: 'left', width: 10, editable: false, hidden: true, label: 'TB' },
            {
                name: 'TotalDescargaDia', index: 'TotalDescargaDia', width: 100, align: 'right', sorttype: "number"
                , editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',

                searchoptions: { sopt: ['eq'] },

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
            }
                                ,
            {
                name: 'IdPuntoVenta', index: 'IdPuntoVenta',

                width: 100, resizable: true,
                align: "left", sorttype: "number", editable: true, edittype: "select", hidden: true,
                editoptions: { value: "1:1;2:2;3:3;4:4" }, // { value: "1:Buenos Aires;2:San Lorenzo;3:Arroyo Seco;4:Bahía Blanca" },
                searchoptions: { sopt: ['eq'] },
                editrules: { required: true }
            }





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
                        var se = "<input style='height:22px;width:100px;' type='button' value='Grabar' onclick=\"GrabarFila('" + id + "');\"  />";
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
                    rowList: [10, 20, 50, 100],
                    sortname: 'IdCartaPorteNormaCalidad',
                    sortorder: 'desc',
                    viewrecords: true,
                    multiselect: true,
                    shrinkToFit: true,
                    width: 'auto',
                    height: $(window).height() - 300, // '100%'
                    altRows: false,
                    footerrow: false,
                    userDataOnFooter: true,
                    //caption: '<b>Control de Descargas</b>',
                    cellEdit: true,
                    cellsubmit: 'clientArray',
                    dataUrl: "WebServiceClientes.asmx/EmpleadoEditGridData",

                    toppager: true,

                    gridview: true
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

                //jQuery("#Lista").jqGrid('navGrid', '#ListaPager',
                //    { search: false, refresh: false, add: false, edit: false, del: false }, {}, {}, {}, {});



                jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
                                                {
                                                    caption: "", buttonicon: "ui-icon-plus", title: "Agregar",
                                                    onClickButton: function () {
                                                        AgregarItemVacio(jQuery("#Lista"));
                                                    },
                                                });
                jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
                                                {
                                                    caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                                    onClickButton: function () {
                                                        MarcarSeleccionadosParaEliminar(jQuery("#Lista"));
                                                    },
                                                });
                jQuery("#Lista").filterToolbar({
                    stringResult: true, searchOnEnter: true,
                    defaultSearch: 'cn',
                    enableClear: false
                }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/


            });



            $(window).resize(function () {
                //RefrescaAnchoJqgrids();
            });

        </script>
    </div>

    <%--   /////////////////////////////////////////////////////////////////////        
 /////////////////////////////////////////////////////////////////////    --%>
    <%--  campos hidden --%>
    <asp:HiddenField ID="HFSC" runat="server" />
    <asp:HiddenField ID="HFIdObra" runat="server" />
    <asp:HiddenField ID="HFTipoFiltro" runat="server" />
</asp:Content>
