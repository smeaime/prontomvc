$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", mTotalImputaciones, mTotalConceptos, mImporteIva1, mPercepcionIIBB1, mPercepcionIIBB2, mPercepcionIIBB3, mPercepcionIVA;
    var mImporteTotal, mIVANoDiscriminado, mPorcentajePercepcionIIBB1, mPorcentajePercepcionIIBB2, mPorcentajePercepcionIIBB3;

    if ($("#Anulada").val() == "SI") {
        $("#grabar2").prop("disabled", true);
        $("#anular").prop("disabled", true);
    }

    idaux = $("#IdCliente").val();
    if (idaux.length > 0) {
        MostrarDatosCliente(idaux);
    }
    TraerCotizacion()
    TraerNumeroComprobante()

    var getColumnIndexByName = function (grid, columnName) {
        var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
        for (i = 0; i < l; i++) {
            if (cm[i].name === columnName) {
                return i;
            }
        }
        return -1;
    }

    $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');

    $.extend($.jgrid.inlineEdit, { keys: true });

    window.parent.document.body.onclick = saveEditedCell; // attach to parent window if any
    document.body.onclick = saveEditedCell; // attach to current document.
    function saveEditedCell(evt) {
        var target = $(evt.target);

        if ($grid) {
            var isCellClicked = $grid.find(target).length; // check if click is inside jqgrid
            if (gridCellWasClicked && !isCellClicked) // check if a valid click
            {
                gridCellWasClicked = false;
                $grid.jqGrid("saveCell", lastSelectediRow2, lastSelectediCol2);
            }
        }

        $grid = "";
        gridCellWasClicked = false;

        if (jQuery("#Lista").find(target).length) {
            $grid = $('#Lista');
            grillaenfoco = true;
        }
        
        if (jQuery("#ListaConceptos").find(target).length) {
            $grid = $('#ListaConceptos');
            grillaenfoco = true;
        }

        if (grillaenfoco) {
            gridCellWasClicked = true; // flat to check if there is a cell been edited.
            lastSelectediRow2 = lastSelectediRow;
            lastSelectediCol2 = lastSelectediCol;
        }
    };

    function EliminarSeleccionados(grid) {
        var selectedIds = grid.jqGrid('getGridParam', 'selarrrow');
        var i;
        for (i = selectedIds.length - 1; i >= 0; i--) {
            grid.jqGrid('delRowData', selectedIds[i]);
        }
    };

    function AgregarItemVacio(grid) {
        var colModel = grid.jqGrid('getGridParam', 'colModel');
        var dataIds = grid.jqGrid('getDataIDs');
        var Id = grid.jqGrid('getGridParam', 'records') * -1;
        var data, j, cm;

        data = '{';
        for (j = 1; j < colModel.length; j++) {
            cm = colModel[j];
            data = data + '"' + cm.index + '":' + '"",';
        }
        data = data.substring(0, data.length - 1) + '}';
        data = data.replace(/(\r\n|\n|\r)/gm, "");
        grid.jqGrid('addRowData', Id, data);
    };

    var ControlImportes = function (value, colname) {
        if (colname === "A pagar") {
            var rowid = $('#Lista').getGridParam('selrow');
            value = Number(value);
            var IdTipoComprobante = $("#Lista").getCell(rowid, "IdTipoComp");
            if (IdTipoComprobante == false) { IdTipoComprobante = 0; }
            var IdComprobante = $("#Lista").getCell(rowid, "IdComprobante");
            if (IdComprobante == false) { IdComprobante = 0; }
        }
        return [true];
        //if (colname === "A pagar") {
        //    var rowid = $('#Lista').getGridParam('selrow');
        //    var SinImpuestos = $("#Lista").getCell(rowid, "SinImpuestos");
        //    SinImpuestos = Number(SinImpuestos.replace(",", "."));
        //    value = Number(value);
        //    if (value < SinImpuestos) {
        //        return [false, "El monto a pagar no puede ser inferior al importe sin impuestos"];
        //    }
        //}
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'NotaCredito/DetNotaCreditoImputaciones/',
        postData: { 'IdNotaCredito': function () { return $("#IdNotaCredito").val(); } },
        editurl: ROOT + 'NotaCredito/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleNotaCreditoImputaciones', 'IdImputacion', 'CotizacionMoneda', 'IdTipoComp', 'IdComprobante', 'Tipo', 'Numero ', 'Fecha', 'Imp. Orig.', 'Saldo', 'A acreditar'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleNotaCreditoImputaciones', index: 'IdDetalleNotaCreditoImputaciones', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdImputacion', index: 'IdImputacion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'CotizacionMoneda', index: 'CotizacionMoneda', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdTipoComp', index: 'IdTipoComp', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdComprobante', index: 'IdComprobante', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'Tipo', index: 'Tipo', width: 40, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Numero', index: 'Numero', width: 110, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Fecha', index: 'Fecha', width: 80, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteOriginal', index: 'ImporteOriginal', width: 70, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Saldo', index: 'Saldo', width: 70, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    {
                        name: 'Importe', index: 'Importe', width: 70, align: 'right', editable: true, editrules: { custom: true, custom_func: ControlImportes, required: false, number: true }, edittype: 'text', label: 'TB',
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
                            },
                            {
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        }
                    }
        ],
        gridComplete: function () {
            calculaTotalImputaciones();
            //CalcularTotales()
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterSaveCell: function (rowid) {
            calculaTotalImputaciones();
        },
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdImputacion',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '150px', // 'auto',
        rownumbers: true,
        multiselect: true,
        altRows: false,
        footerrow: true,
        userDataOnFooter: true,
        pgbuttons: false,
        viewrecords: false,
        pgtext: "",
        pginput: false,
        rowList: "",
        caption: '<b>DETALLE IMPUTACIONES EN CUENTA CORRIENTE</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar sin imputacion",
                                     onClickButton: function () {
                                         AgregarAnticipo(jQuery("#Lista"));
                                     },
                                 });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#Lista"));
                                     },
                                 });


    $('#ListaConceptos').jqGrid({
        url: ROOT + 'NotaCredito/DetNotaCredito/',
        postData: { 'IdNotaCredito': function () { return $("#IdNotaCredito").val(); } },
        editurl: ROOT + 'NotaCredito/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleNotaCredito', 'IdConcepto', 'IdCuentaBancaria', 'IdCaja', 'IdDiferenciaCambio', 'Concepto', 'Cuenta bancaria', 'Caja', 'Iva?', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleNotaCredito', index: 'IdDetalleNotaCredito', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdConcepto', index: 'IdConcepto', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdCaja', index: 'IdCaja', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDiferenciaCambio', index: 'IdDiferenciaCambio', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'Concepto', index: 'Concepto', align: 'left', width: 120, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Concepto/GetConceptos',
                            dataInit: function (elem) {
                                $(elem).width(110);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaConceptos').getGridParam('selrow');
                                    $('#ListaConceptos').jqGrid('setCell', rowid, 'IdConcepto', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'CuentaBancaria', index: 'CuentaBancaria', align: 'left', width: 100, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetCuentasBancariasPorIdCuenta2?IdCuenta=0',
                            dataInit: function (elem) {
                                $(elem).width(90);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaConceptos').getGridParam('selrow');
                                    $('#ListaConceptos').jqGrid('setCell', rowid, 'IdCuentaBancaria', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Caja', index: 'Caja', align: 'left', width: 100, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Caja/GetCajasPorIdCuenta2?IdCuenta=0',
                            dataInit: function (elem) {
                                $(elem).width(90);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaConceptos').getGridParam('selrow');
                                    $('#ListaConceptos').jqGrid('setCell', rowid, 'IdCaja', this.value);
                                }
                            }]
                        },
                    },
                    { name: 'Gravado', index: 'Gravado', width: 40, align: 'left', editable: true, editrules: { required: false }, editoptions: { value: "SI:NO" }, edittype: 'checkbox', label: 'TB' },
                    {
                        name: 'Importe', index: 'Importe', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaConceptos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        afterSaveCell: function (rowid) {
            calculaTotalConceptos();
        },
        gridComplete: function () {
            calculaTotalConceptos();
        },
        pager: $('#ListaPager2'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleNotaCredito',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '150px', // 'auto',
        rownumbers: true,
        multiselect: true,
        altRows: false,
        footerrow: true,
        userDataOnFooter: true,
        pgbuttons: false,
        viewrecords: false,
        pgtext: "",
        pginput: false,
        rowList: "",
        caption: '<b>DETALLE DE CONCEPTOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaConceptos").jqGrid('navGrid', '#ListaPager2', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaConceptos").jqGrid('navButtonAdd', '#ListaPager2',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaConceptos"));
                                     },
                                 });
    jQuery("#ListaConceptos").jqGrid('navButtonAdd', '#ListaPager2',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaConceptos"));
                                     },
                                 });
    jQuery("#ListaConceptos").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $("#ListaDrag").jqGrid({
        url: ROOT + 'CuentaCorriente/CuentaCorrienteDeudoresPendientePorCliente',
        postData: { 'IdCliente': function () { return $("#IdCliente").val(); } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'IdCtaCte', 'IdImputacion', 'IdTipoComp', 'IdComprobante', 'Cabeza', 'Tipo', 'Nro.Cmp.', 'Fecha', 'Fecha Vto.', 'Mon.', 'Imp.Orig.', 'Saldo', 'Sdo.Trs.', 'Observaciones'],
        colModel: [
                                { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: true },
                        { name: 'IdCtaCte', index: 'IdCtaCte', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'IdImputacion', index: 'IdImputacion', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'IdTipoComp', index: 'IdTipoComp', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'IdComprobante', index: 'IdComprobante', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Cabeza', index: 'Cabeza', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Comp', index: 'Comp', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Numero', index: 'Numero', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn,eq'] } },

                          {
                              name: 'Fecha', index: 'Fecha', width: 80, align: 'center',
                              sorttype: 'date', hidden: false, editable: false,
                              formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                              search: true,
                              searchrules: {
                                  date: true
                              },
                              searchoptions: { // http://stackoverflow.com/questions/14632735/jqgrid-searching-dates
                                  sopt: ['ge', 'le'],
                                  dataInit: function (elem) {
                                      $(elem).datepicker({
                                          dateFormat: 'dd/mm/yy',
                                          changeYear: true,
                                          changeMonth: true,
                                          showButtonPanel: true,
                                          onSelect: function () {
                                              $(this).keydown();
                                          }
                                      });
                                  }
                              }


                          },

                        { name: 'Fechavt', index: 'Fechavt', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Monorigen', index: 'Monorigen', align: 'left', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                        { name: 'Imporig', index: 'Imporig', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'SaldoComp', index: 'SaldoComp', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'SaldoTrs', index: 'SaldoTrs', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } }
        ],
        ondblClickRow: function (id) {
            CopiarCtaCte(id, "Dbl");
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'IdImputacion,Cabeza,Fecha,Numero',
        sortorder: "asc",
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: $(window).height() - ALTOLISTADO, // '100%'
        //height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
    })
    
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager',
     { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
     {

         //sopt: ["cn"]
         //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
         width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
     }
    );


    jQuery("#ListaDrag").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/
    //myGrid.filterToolbar({  });
    jQuery("#ListaDrag").jqGrid('navButtonAdd', '#ListaDragPager',
            {
                caption: "Filter", title: "Toggle Searching Toolbar",
                buttonicon: 'ui-icon-pin-s',
                onClickButton: function () { myGrid[0].toggleToolbar(); }
            });







    ////////////////////////////////////////////////////////// DRAG DROP //////////////////////////////////////////////////////////
    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Cuenta corriente');
    //$('a#a_panel_este_tab5').remove();  //    

    ConectarGrillas1();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });

    function ConectarGrillas1() {
        $("#ListaDrag").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                CopiarCtaCte($(ui.draggable).attr("id"), "DnD");
                //var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                //var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
            }
        });
    }

    function CopiarCtaCte(IdCtaCte, Origen) {
        var acceptId = IdCtaCte;
        var $gridOrigen = $("#ListaDrag"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;
        //var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');

        dataIds = $gridDestino.jqGrid('getDataIDs');
        for (i = 1; i < dataIds.length; i++) {
            data2 = $gridDestino.jqGrid('getRowData', dataIds[i]);
            if (data2.IdImputacion == IdCtaCte) {
                if (Origen == "DnD") $gridDestino.jqGrid('delRowData', dataIds[0]);
                alert("Ya existe el registro");
                return;
            }
        };
        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;
        try {
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'CuentaCorriente/TraerUnoDeudor/',
                data: { IdCtaCte: IdCtaCte },
                dataType: "Json",
                success: function (data) {
                    for (i = 0; i < data.length; i++) {
                        data2 = data[i]
                        data2.IdDetalleNotaCreditoImputaciones = Id2;

                        date = new Date(parseInt(data[i].Fecha.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        data2.Fecha = displayDate;
                        date = new Date(parseInt(data[i].FechaVencimiento.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        data2.FechaVencimiento = displayDate;

                        if (Origen == "DnD") {
                            Id = dataIds[0];
                            $gridDestino.jqGrid('setRowData', Id, data2);
                        } else {
                            Id = Id2
                            $gridDestino.jqGrid('addRowData', Id, data2, "first");
                        };
                        calculaTotalImputaciones();
                        //ar new_id = 39; //for example
                        //aftersavefunc: function( old_id ) {

                        //    //get data param
                        //    var row = grid.jqGrid('getLocalRow', old_id);
                        //    console.log(row); //use for firefox test
                        //    row._id_ = new_id;

                        //    grid.jqGrid('setRowData',old_id,{my_id:new_id});
                        //    $("#"+response).attr("id", new_id); //change TR element in DOM

                        //    //very important to change the _index, some functions using the                  
                        //    var _index = grid.jqGrid('getGridParam', '_index');
                        //    var valueTemp = _index[old_id];
                        //    delete _index[old_id];
                        //    _index[new_id] = valueTemp;
                        //}
                    }
                }
            });
        } catch (e) { }
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    $("#IdPuntoVenta").change(function () {
        TraerNumeroComprobante()
    });

    $("#IdIBCondicion").change(function () {
        CalcularTotales()
    });

    $("#IdIBCondicion2").change(function () {
        CalcularTotales()
    });

    $("#IdIBCondicion3").change(function () {
        CalcularTotales()
    });

    $("input[name=CtaCte]:radio").change(function () {
        TraerNumeroComprobante();
        CalcularTotales();
    })

    $("#IdMoneda").change(function () {
        TraerCotizacion()
    })

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo, CtaCte = "";

        CtaCte = $("input[name='CtaCte']:checked").val();

        var cabecera = $("#formid").serializeObject();

        cabecera.NumeroNotaCredito = $("#NumeroNotaCredito").val();
        cabecera.CAE = $("#CAE").val();
        cabecera.FechaVencimientoORechazoCAE = $("#FechaVencimientoORechazoCAE").val();
        cabecera.IdPuntoVenta = $("#IdPuntoVenta").val();
        cabecera.PuntoVenta = $("#IdPuntoVenta").find('option:selected').text();
        cabecera.CotizacionMoneda = $("#CotizacionMoneda").val();
        cabecera.CotizacionDolar = $("#CotizacionDolar").val();
        cabecera.FechaNotaCredito = $("#FechaNotaCredito").val();
        cabecera.IdMoneda = $("#IdMoneda").val();
        cabecera.CtaCte = CtaCte;
        cabecera.Cliente = "";
        cabecera.Provincia = "";

        if (CtaCte == "SI") {
            cabecera.IdPuntoVenta = $("#IdPuntoVenta").val();
            cabecera.PuntoVenta = $("#IdPuntoVenta").find('option:selected').text();
        } else {
            cabecera.IdPuntoVenta = 0;
            cabecera.PuntoVenta = 0;
        }

        var chk = $('#AplicarEnCtaCte').is(':checked');
        if (chk) {
            cabecera.AplicarEnCtaCte = "SI";
        } else {
            cabecera.AplicarEnCtaCte = "NO";
        };

        cabecera.DetalleNotasCreditoes = [];
        $grid = $('#ListaConceptos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleNotaCredito'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleNotaCredito":"' + iddeta + '",';
                data1 = data1 + '"IdNotaCredito":"' + $("#IdNotaCredito").val() + '",';
                for (j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') {
                        valor = data[cm.name];
                        data1 = data1 + '"' + cm.index + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetalleNotasCreditoes.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleNotasCreditoImputaciones = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleNotaCreditoImputaciones'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleNotaCreditoImputaciones":"' + iddeta + '",';
                data1 = data1 + '"IdNotaCredito":"' + $("#IdNotaCredito").val() + '",';
                for (j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') {
                        valor = data[cm.name];
                        data1 = data1 + '"' + cm.index + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetalleNotasCreditoImputaciones.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        return cabecera;
    }

    $('#grabar2').click(function () {
        CalcularTotales()

        var cabecera = SerializaForm();

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'NotaCredito/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ NotaCredito: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "NotaCredito/Edit/" + result.IdNotaCredito);
                } else {
                    alert('No se pudo grabar el registro.');
                    $('.loading').html('');
                    $('html, body').css('cursor', 'auto');
                    $('#grabar2').attr("disabled", false).val("Aceptar");
                }
            },
            beforeSend: function () {
                $("#loading").show();
                $('#grabar2').attr("disabled", true).val("Espere...");
            },
            complete: function () {
                $("#loading").hide();
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
    });

    idaux = $("#IdNotaCredito").val();
    if (idaux <= 0) {
        ActivarControles(true);
    } else {
        ActivarControles(false);
    }
});

function ActualizarDatos() {
    var IdCodigoIva = 0, Letra = "B", id = 0;

    id = $("#IdCliente").val();
    if (id.length > 0) {
        MostrarDatosCliente(id);
    }

    IdCodigoIva = $("#IdCodigoIva").val();

    if (IdCodigoIva == 1) { Letra = "A" }
    if (IdCodigoIva == 2) { Letra = "B" }
    if (IdCodigoIva == 3) { Letra = "E" }
    if (IdCodigoIva == 8) { Letra = "B" }
    if (IdCodigoIva == 9) { Letra = "A" }
    $("#TipoABC").val(Letra)

    calculaTotalConceptos();

    $.ajax({
        type: "GET",
        async: false,
        url: ROOT + 'PuntoVenta/GetPuntosVenta2/',
        data: { IdTipoComprobante: 4, Letra: Letra },
        contentType: "application/json",
        dataType: "json",
        success: function (result) {
            $("#IdPuntoVenta").empty();
            $.each(result, function () {
                $("#IdPuntoVenta").append($("<option></option>").val(this['IdPuntoVenta']).html(this['PuntoVenta']));
            });
            TraerNumeroComprobante();
        }
    });
}

calculaTotalConceptos = function () {
    var imp = 0, imp2 = 0, grav = "", letra = "", porciva = 0, ivaitem = 0;

    letra = $("#TipoABC").val();
    porciva = parseFloat($("#PorcentajeIva1").val().replace(",", ".") || 0) || 0;
    mIVANoDiscriminado = 0;
    mImporteIva1 = 0;

    var dataIds = $('#ListaConceptos').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaConceptos').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        grav = data['Gravado'];
        if (grav == "SI") {
            if (letra == "B") {
                ivaitem = imp - (imp / (1 + (porciva / 100)));
                mIVANoDiscriminado = mIVANoDiscriminado + ivaitem;
            } else {
                mImporteIva1 = mImporteIva1 + (imp * (porciva / 100));
            }
        }
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalConceptos = imp2;
    $("#ListaConceptos").jqGrid('footerData', 'set', { Caja: 'TOTALES', Importe: imp2.toFixed(2) });
    $("#ImporteIva1").val(mImporteIva1.toFixed(2));
    $("#IVANoDiscriminado").val(mIVANoDiscriminado.toFixed(2));

    CalcularTotales()
};

calculaTotalImputaciones = function () {
    //var totalCantidad = $('#Lista').jqGrid('getCol', 'Importe', false, 'sum')
    var imp = 0, imp2 = 0;
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalImputaciones = imp2;
    $("#Lista").jqGrid('footerData', 'set', { Fecha: 'TOTALES', Importe: imp2.toFixed(2) });
    $("#Imputado").val(imp2.toFixed(2));

    CalcularTotales()
};

function CalcularTotales() {
    var mSubtotal = 0, mIdNotaCredito = 0, mIdCliente = 0, mIdMoneda = 0, mIdIBCondicion1 = 0, mIdIBCondicion2 = 0, mIdIBCondicion3 = 0, mDiferencia = 0, mFecha, datos1, CtaCte = "";

    mIdNotaCredito = $("#IdNotaCredito").val();

    if (typeof mTotalConceptos == "undefined") { mTotalConceptos = 0; }
    if (typeof mTotalImputaciones == "undefined") { mTotalImputaciones = 0; }

    mSubtotal = mTotalConceptos;

    mImporteIva1 = parseFloat($("#ImporteIva1").val().replace(",", ".") || 0) || 0;

    mIdCliente = $("#IdCliente").val();
    mIdMoneda = $("#IdMoneda").val();
    mIdIBCondicion1 = parseInt($("#IdIBCondicion").val() || 0) || 0;
    mIdIBCondicion2 = parseInt($("#IdIBCondicion2").val() || 0) || 0;
    mIdIBCondicion3 = parseInt($("#IdIBCondicion3").val() || 0) || 0;
    mFecha = $("#FechaNotaCredito").val();
    CtaCte = $("input[name='CtaCte']:checked").val();

    mPorcentajePercepcionIIBB1 = 0;
    mPorcentajePercepcionIIBB2 = 0;
    mPorcentajePercepcionIIBB3 = 0;

    if (CtaCte != "SI") {
        $("#RetencionIBrutos1").val(0);
        $("#RetencionIBrutos2").val(0);
        $("#RetencionIBrutos3").val(0);
        $("#PercepcionIVA").val(0);
    }

    if (mIdNotaCredito <= 0 && mIdCliente > 0 && CtaCte == "SI") {
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Cliente/CalcularPercepciones',
            dataType: 'json',
            async: false,
            data: JSON.stringify({ IdCliente: mIdCliente, TotalGravado: mSubtotal, IdMoneda: mIdMoneda, IdIBCondicion1: mIdIBCondicion1, IdIBCondicion2: mIdIBCondicion2, IdIBCondicion3: mIdIBCondicion3, Fecha: mFecha }),
            //data: { IdCliente: mIdCliente, TotalGravado: mSubtotal, IdMoneda: mIdMoneda, IdIBCondicion1: mIdIBCondicion1, IdIBCondicion2: mIdIBCondicion2, IdIBCondicion3: mIdIBCondicion3, Fecha: mFecha },
            success: function (result) {
                if (result) {
                    datos = JSON.parse(result);
                    datos1 = datos.campo1;
                    mPercepcionIIBB1 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo2;
                    mPercepcionIIBB2 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo3;
                    mPercepcionIIBB3 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo4;
                    mPorcentajePercepcionIIBB1 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo5;
                    mPorcentajePercepcionIIBB2 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo6;
                    mPorcentajePercepcionIIBB3 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo7;
                    mPercepcionIVA = parseFloat(datos1.replace(",", ".") || 0) || 0;
                } else { alert('No se pudo calcular el comprobante.'); }
            },
            beforeSend: function () {
            },
            error: function (xhr, textStatus, exceptionThrown) {
                try {
                    var errorData = $.parseJSON(xhr.responseText);
                    var errorMessages = [];
                    for (var key in errorData) { errorMessages.push(errorData[key]); }
                    $("#textoMensajeAlerta").html(errorData.Errors.join("<br />"));
                    $("#mensajeAlerta").show();
                } catch (e) {
                    $("#textoMensajeAlerta").html(xhr.responseText);
                    $("#mensajeAlerta").show();
                }
            }
        });
    } else {
        mPercepcionIIBB1 = parseFloat($("#RetencionIBrutos1").val().replace(",", ".") || 0) || 0;
        mPercepcionIIBB2 = parseFloat($("#RetencionIBrutos2").val().replace(",", ".") || 0) || 0;
        mPercepcionIIBB3 = parseFloat($("#RetencionIBrutos3").val().replace(",", ".") || 0) || 0;
        mPorcentajePercepcionIIBB1 = parseFloat($("#PorcentajeIBrutos1").val().replace(",", ".") || 0) || 0;
        mPorcentajePercepcionIIBB2 = parseFloat($("#PorcentajeIBrutos2").val().replace(",", ".") || 0) || 0;
        mPorcentajePercepcionIIBB3 = parseFloat($("#PorcentajeIBrutos3").val().replace(",", ".") || 0) || 0;
        mPercepcionIVA = parseFloat($("#PercepcionIVA").val().replace(",", ".") || 0) || 0;
    }

    mImporteTotal = mSubtotal + mImporteIva1 + mPercepcionIIBB1 + mPercepcionIIBB2 + mPercepcionIIBB3 + mPercepcionIVA;
    mDiferencia = mImporteTotal - mTotalImputaciones;

    $("#Subtotal").val(mSubtotal.toFixed(2));
    $("#RetencionIBrutos1").val(mPercepcionIIBB1.toFixed(2));
    $("#RetencionIBrutos2").val(mPercepcionIIBB2.toFixed(2));
    $("#RetencionIBrutos3").val(mPercepcionIIBB3.toFixed(2));
    $("#PorcentajeIBrutos1").val(mPorcentajePercepcionIIBB1.toFixed(2));
    $("#PorcentajeIBrutos2").val(mPorcentajePercepcionIIBB2.toFixed(2));
    $("#PorcentajeIBrutos3").val(mPorcentajePercepcionIIBB3.toFixed(2));
    $("#PercepcionIVA").val(mPercepcionIVA.toFixed(2));
    $("#ImporteTotal").val(mImporteTotal.toFixed(2));
    $("#Diferencia").val(mDiferencia.toFixed(2));
};

function pickdates(id) {
    jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
}

function unformatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(",", ".");
}

function formatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(".", ",");
}

// Para usar en la edicion de una fila afterSubmit:processAddEdit,
function processAddEdit(response, postdata) {
    var success = true;
    var message = ""
    var json = eval('(' + response.responseText + ')');
    if (json.errors) {
        success = false;
        for (i = 0; i < json.errors.length; i++) {
            message += json.errors[i] + '<br/>';
        }
    }
    var new_id = "1";
    return [success, message, new_id];
}

initDateEdit = function (elem) {
    setTimeout(function () {
        $(elem).datepicker({
            dateFormat: 'dd/mm/yy',
            autoSize: true,
            showOn: 'button', // it dosn't work in searching dialog
            changeYear: true,
            changeMonth: true,
            showButtonPanel: true,
            showWeek: true
        });
        //$(elem).focus();
    }, 100);
};

function getValidationSummary() {
    var el = $(".validation-summary-errors");
    if (el.length == 0) {
        $(".title-separator").after("<div><ul class='validation-summary-errors ui-state-error'></ul></div>");
        el = $(".validation-summary-errors");
    }
    return el;
}

function getResponseValidationObject(response) {
    if (response && response.Tag && response.Tag == "ValidationError")
        return response;
    return null;
}

function CheckValidationErrorResponse(response, form, summaryElement) {
    var data = getResponseValidationObject(response);
    if (!data) return;

    var list = summaryElement || getValidationSummary();
    list.html('');
    $.each(data.State, function (i, item) {
        list.append("<li>" + item.Errors.join("</li><li>") + "</li>");
        if (form && item.Name.length > 0)
            $(form).find("*[name='" + item.Name + "']").addClass("ui-state-error");
    });
}

function AgregarAnticipo(grid) {
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Importe sin imputacion", bSubmit: "Aceptar", bCancel: "Cancelar", width: 400, reloadAfterSubmit: false,
                closeOnEscape: true,
                closeAfterAdd: true,
                closeAfterEdit: true,
                recreateForm: true,
                afterShowForm: function (form) {
                    $("#sData").attr("class", "btn btn-primary");
                    $("#sData").css("color", "white");
                    $("#sData").css("margin-right", "20px");
                    $("#cData").attr("class", "btn");
                },
                beforeShowForm: function (form) {
                    PopupCentrar(grid);
                    $('#tr_IdDetalleNotaCreditoImputaciones', form).hide();
                    $('#tr_IdImputacion', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleNotaCreditoImputaciones', form).val(0);
                    $('#Importe', form).val("");
                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    postdata.Tipo = "PA"
                    postdata.IdImputacion = -1
                    return [true, ''];
                }
            });
};

function PopupCentrar(grid) {
    var dlgDiv = $("#editmod" + grid[0].id);
    //$("#editmod" + grid[0].id).find('.ui-datepicker-trigger').attr("class", "btn btn-primary");
    //$("#editmod" + grid[0].id).find('#FechaPosible').width(160);
    //$("#editmod" + grid[0].id).find('.ui-datepicker-trigger').attr("class", "btn btn-primary");
    $("#sData").attr("class", "btn btn-primary");
    $("#sData").css("color", "white");
    $("#sData").css("margin-right", "20px");
    $("#cData").attr("class", "btn");
    $("#editmod" + grid[0].id).find('.ui-icon-disk').remove();
    $("#editmod" + grid[0].id).find('.ui-icon-close').remove();
    var parentDiv = dlgDiv.parent();
    var dlgWidth = dlgDiv.width();
    var parentWidth = parentDiv.width();
    var dlgHeight = dlgDiv.height();
    var parentHeight = parentDiv.height();
    var left = (screen.width / 2) - (dlgWidth / 2) + "px";
    var top = (screen.height / 2) - (dlgHeight / 2) + "px";
    dlgDiv[0].style.top = top; // 500; // Math.round((parentHeight - dlgHeight) / 2) + "px";
    dlgDiv[0].style.left = left; //Math.round((parentWidth - dlgWidth) / 2) + "px";
};

function MostrarDatosCliente(Id) {
    var Entidad = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Cliente/GetClientePorId/',
        data: { Id: Id },
        success: function (result) {
            if (result.length > 0) {
                Entidad = result[0].value;
                $("#Cliente").val(Entidad);
                $("#CondicionIva").val(result[0].DescripcionIva);
                $("#Cuit").val(result[0].Cuit);
                $("#Direccion").val(result[0].Direccion);
                $("#Localidad").val(result[0].Localidad);
                $("#Provincia").val(result[0].Provincia);
                $("#CodigoPostal").val(result[0].CodigoPostal);
                $("#Email").val(result[0].Email);
                $("#Telefono").val(result[0].Telefono);
                $("#PorcentajePercepcionIVA").val(result[0].PorcentajePercepcionIVA);
                $("#BaseMinimaParaPercepcionIVA").val(result[0].BaseMinimaParaPercepcionIVA);
                $("#EsAgenteRetencionIVA").val(result[0].EsAgenteRetencionIVA);
                $("#IdIBCondicion").val(result[0].IdIBCondicionPorDefecto);
                $("#IdIBCondicion2").val(result[0].IdIBCondicionPorDefecto2);
                $("#IdIBCondicion3").val(result[0].IdIBCondicionPorDefecto3);
                $("#IdCodigoIva").val(result[0].IdCodigoIva);
            }
        }
    });
    return Entidad;
}

function TraerCotizacion() {
    var fecha, IdMoneda, datos1, mIdMonedaPrincipal = 1, mIdMonedaDolar = 2, mCotizacionDolar = 0;
    fecha = $("#FechaNotaCredito").val();
    IdMoneda = $("#IdMoneda").val();
    $.ajax({
        type: "GET",
        async: false,
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'Moneda/CotizacionesPorFecha',
        data: { fecha: fecha },
        dataType: "json",
        success: function (result) {
            if (result) {
                datos = JSON.parse(result);
                mIdMonedaPrincipal = datos.campo1;
                mIdMonedaDolar = datos.campo2;
                datos1 = datos.campo3;
                mCotizacionDolar = parseFloat(datos1.replace(",", ".") || 0) || 0;
            } else { alert('No se pudo completar la operacion.'); }
        },
        error: function (xhr, textStatus, exceptionThrown) {
            alert('No hay cotizacion, ingresela manualmente');
            $('#CotizacionMoneda').val("");
        }
    });

    if (IdMoneda == mIdMonedaPrincipal) {
        $('#CotizacionMoneda').val("1");
        if (mCotizacionDolar != 0) { $("#CotizacionDolar").val(mCotizacionDolar.toFixed(2)); }
    }
    else {
        if (IdMoneda == mIdMonedaDolar) {
            $("#CotizacionMoneda").val(mCotizacionDolar.toFixed(2));
            $("#CotizacionDolar").val(mCotizacionDolar.toFixed(2));
        }
    }
};

function TraerNumeroComprobante() {
    var IdNotaCredito = $("#IdNotaCredito").val();
    var IdPuntoVenta = $("#IdPuntoVenta").val();
    var CtaCte = $("input[name='CtaCte']:checked").val();

    if (IdNotaCredito <= 0) {
        if (CtaCte == "SI") {
            $("#IdPuntoVenta").prop("disabled", false);
            $.ajax({
                type: "GET",
                async: false,
                url: ROOT + 'PuntoVenta/GetPuntosVentaPorId/',
                data: { IdPuntoVenta: IdPuntoVenta },
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.length > 0) {
                        var ProximoNumero = result[0]["ProximoNumero"];
                        var CAEManual = result[0]["CAEManual"];
                        $("#NumeroNotaCredito").val(ProximoNumero);
                        if (CAEManual == "SI") {
                            $("#CAE").prop("disabled", false);
                            $("#FechaVencimientoORechazoCAE").prop("disabled", false);
                        } else {
                            $("#CAE").val("");
                            $("#FechaVencimientoORechazoCAE").val("");
                            $("#CAE").prop("disabled", true);
                            $("#FechaVencimientoORechazoCAE").prop("disabled", true);
                        }
                    }
                }
            });
        } else {
            $("#IdPuntoVenta").val("");
            $("#IdPuntoVenta").prop("disabled", true);
            $("#CAE").val("");
            $("#FechaVencimientoORechazoCAE").val("");
            $("#CAE").prop("disabled", true);
            $("#FechaVencimientoORechazoCAE").prop("disabled", true);
            $.ajax({
                type: "GET",
                async: false,
                url: ROOT + 'Parametro/Parametros/',
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.length > 0) {
                        var ProximoNumero = result[0]["ProximaNotaCreditoInterna"];
                        $("#NumeroNotaCredito").val(ProximoNumero);
                    }
                }
            });
        }
    } else {
        $("#IdPuntoVenta").prop("disabled", true);
        $("#CAE").prop("disabled", true);
        $("#FechaVencimientoORechazoCAE").prop("disabled", true);
    }
}

function ActivarControles(Activar) {
    var $td;
    if (Activar) {
        pageLayout.show('east');
        pageLayout.close('east');

        $("#Lista").unblock({ message: "", theme: true, });
        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Agregar sin imputacion"]');
        $td.show();
        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.show();

        $("#ListaConceptos").unblock({ message: "", theme: true, });
        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Agregar item"]');
        $td.show();
        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.show();
    } else {
        pageLayout.hide('east');

        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Agregar sin imputacion"]');
        $td.hide();
        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.hide();

        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Agregar item"]');
        $td.hide();
        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.hide();

        $("#ListaConceptos").block({ message: "", theme: true, });
        $("#Cliente").prop("disabled", true);
        $("#FechaNotaCredito").prop("disabled", true);
        $("#IdMoneda").prop("disabled", true);
        $("#CotizacionMoneda").prop("disabled", true);
        $("#CotizacionDolar").prop("disabled", true);
        $("#AplicarEnCtaCte").prop("disabled", true);
        jQuery("input[name='CtaCte']").each(function (i) {
            jQuery(this).prop("disabled", true);
        })
    }
}
