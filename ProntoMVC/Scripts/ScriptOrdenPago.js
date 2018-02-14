$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic
    var headerRow, rowHight, resizeSpanHeight, mTotalImputaciones, mTotalValores, mRetencionIva, mRetencionGanancias, mRetencionIIBB, mRetencionSUSS, mTotalDiferenciaBalanceo, mTotalGastosFF, idaux;

    idaux = $("#IdComprobanteProveedor").val();
    if (idaux <= 0) {
        TraerCotizacion()
    } else {
        pageLayout.close('east');
    }

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
        if (jQuery("#ListaContable").find(target).length) {
            $grid = $('#ListaContable');
            grillaenfoco = true;
        }
        if (jQuery("#ListaValores").find(target).length) {
            $grid = $('#ListaValores');
            grillaenfoco = true;
        }
        if (jQuery("#ListaImpuestos").find(target).length) {
            $grid = $('#ListaImpuestos');
            grillaenfoco = true;
        }
        if (jQuery("#ListaRubrosContables").find(target).length) {
            $grid = $('#ListaRubrosContables');
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

    //Esto es para analizar los parametros de entrada via querystring
    var querystring = location.search.replace('?', '').split('&');
    var queryObj = {};
    for (var i = 0; i < querystring.length; i++) {
        var name = querystring[i].split('=')[0];
        var value = querystring[i].split('=')[1];
        queryObj[name] = value;
    }
    if (queryObj["code"] === "1") {
        $(":input").attr("disabled", "disabled");
        $(".boton").hide();
    }

    var ControlImportes = function (value, colname) {
        if (colname === "A pagar") {
            var rowid = $('#Lista').getGridParam('selrow');
            value = Number(value);
            var IdTipoComprobante = $("#Lista").getCell(rowid, "IdTipoComp");
            if (IdTipoComprobante == false) { IdTipoComprobante = 0; }
            var IdComprobante = $("#Lista").getCell(rowid, "IdComprobante");
            if (IdComprobante == false) { IdComprobante = 0; }
            var ImportePagadoSinImpuestos = CalcularImportePagadoSinImpuestos(IdTipoComprobante, IdComprobante, value);
            //$('#ImportePagadoSinImpuestos').val(ImportePagadoSinImpuestos.toFixed(2));
            $('#Lista').jqGrid('setCell', rowid, 'ImportePagadoSinImpuestos', ImportePagadoSinImpuestos[0].toFixed(2));
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
        url: ROOT + 'OrdenPago/DetOrdenesPago/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPago', 'IdImputacion', 'IdTipoRetencionGanancia', 'IdIBCondicion', 'BaseCalculoIIBB', 'CotizacionMoneda', 'IdTipoComp', 'IdComprobante',
                   'Tipo', 'Numero ', 'Fecha', 'Imp. Original', 'Saldo', 'A pagar', 'Imp.s/Impuestos', 'Iva total', 'Total comp.', 'B/S', 'Imp.Ret.Iva', 'Nro.OP Ret.Iva', 'Imp.Gravado',
                   '% Iva Mono', 'Certif.Poliza', 'Nro.Endoso Poliza', 'Fecha Vto.', 'Fecha Comp.', 'Categoria IIBB', 'Categoria ganancias'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPago', index: 'IdDetalleOrdenPago', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdImputacion', index: 'IdImputacion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdTipoRetencionGanancia', index: 'IdTipoRetencionGanancia', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdIBCondicion', index: 'IdIBCondicion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'BaseCalculoIIBB', index: 'BaseCalculoIIBB', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'CotizacionMoneda', index: 'CotizacionMoneda', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdTipoComp', index: 'IdTipoComp', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdComprobante', index: 'IdComprobante', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'Tipo', index: 'Tipo', width: 50, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Numero', index: 'Numero', width: 120, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Fecha', index: 'Fecha', width: 85, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteOriginal', index: 'ImporteOriginal', width: 120, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Saldo', index: 'Saldo', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    {
                        name: 'Importe', index: 'Importe', width: 85, align: 'right', editable: true, editrules: { custom: true, custom_func: ControlImportes, required: false, number: true }, edittype: 'text', label: 'TB',
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
                                        var ImportePagadoSinImpuestos = CalcularImportePagadoSinImpuestos(0, 0, this.value);
                                        $('#ImportePagadoSinImpuestos').val(ImportePagadoSinImpuestos[0].toFixed(2));
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
                    },
                    {
                        name: 'ImportePagadoSinImpuestos', index: 'ImportePagadoSinImpuestos', width: 85, align: 'right', editable: true, editrules: { custom: true, custom_func: ControlImportes, required: false, number: true }, edittype: 'text', label: 'TB',
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
                    { name: 'IvaTotal', index: 'IvaTotal', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'TotalComprobante', index: 'TotalComprobante', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'BienesYServicios', index: 'BienesYServicios', width: 30, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteRetencionIVA', index: 'ImporteRetencionIVA', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'NumeroOrdenPagoRetencionIVA', index: 'NumeroOrdenPagoRetencionIVA', width: 100, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'GravadoIVA', index: 'GravadoIVA', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'PorcentajeIVAParaMonotributistas', index: 'PorcentajeIVAParaMonotributistas', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'CertificadoPoliza', index: 'CertificadoPoliza', width: 120, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroEndosoPoliza', index: 'NumeroEndosoPoliza', width: 120, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'FechaVencimiento', index: 'FechaVencimiento', width: 85, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 120, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    {
                        name: 'CategoriaIIBB', index: 'CategoriaIIBB', align: 'left', width: 150, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'IBCondicion/GetCategoriasIIBB',
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdIBCondicion').val(this.value);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#Lista').getGridParam('selrow');
                                            $('#Lista').jqGrid('setCell', rowid, 'IdIBCondicion', this.value);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'CategoriaGanancias', index: 'CategoriaGanancias', align: 'left', width: 150, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'TipoRetencionGanancia/GetCategoriasGanancia',
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdTipoRetencionGanancia').val(this.value);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#Lista').getGridParam('selrow');
                                            $('#Lista').jqGrid('setCell', rowid, 'IdTipoRetencionGanancia', this.value);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
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
            if (jQuery("#Lista").jqGrid('getCell', rowid, 'Tipo') != 'PA') {
                jQuery("#Lista").jqGrid('setCell', rowid, 'CategoriaIIBB', '', 'not-editable-cell');
                jQuery("#Lista").jqGrid('setCell', rowid, 'CategoriaGanancias', '', 'not-editable-cell');
            }
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
        height: '200px', // 'auto',
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
        caption: 'IMPUTACIONES',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar anticipo",
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
    

    $('#ListaValores').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoValores/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoValores', 'IdTipoValor', 'IdBanco', 'IdValor ', 'IdCuentaBancaria', 'IdBancoChequera', 'IdCaja', 'IdTarjetaCredito',
                    'Tipo', 'Nro.Int.', 'Nro.Valor', 'Fecha Vto.', 'Banco / Caja', 'Importe', 'Chequera', 'Anulado', 'Cheque a la orden de', 'No a la orden'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoValores', index: 'IdDetalleOrdenPagoValores', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdTipoValor', index: 'IdTipoValor', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdBanco', index: 'IdBanco', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdValor', index: 'IdValor', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdBancoChequera', index: 'IdBancoChequera', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdCaja', index: 'IdCaja', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdTarjetaCredito', index: 'IdTarjetaCredito', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    {
                        name: 'Tipo', index: 'Tipo', formoptions: { rowpos: 3, colpos: 1 }, align: 'left', width: 30, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Valor/GetTiposValores',
                            dataInit: function(elem) {
                                $(elem).width(25);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdTipoValor').val(this.value);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaValores').getGridParam('selrow');
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdTipoValor', this.value);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'NumeroInterno', index: 'NumeroInterno', formoptions: { rowpos: 2, colpos: 1 }, width: 40, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaValores').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'NumeroValor', index: 'NumeroValor', formoptions: { rowpos: 2, colpos: 2 }, width: 60, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0',
                            dataEvents: [
                            {   type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaValores').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'FechaValor', index: 'FechaValor', formoptions: { rowpos: 3, colpos: 2 }, width: 100, sortable: false, align: 'right', editable: true, label: 'TB',
                        editoptions: {
                            size: 10,
                            maxlengh: 10,
                            dataInit: function (elem) {
                                $(elem).width(90);
                            },
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
                    },

                    {
                        name: 'Entidad', index: 'Entidad', formoptions: { rowpos: 4, colpos: 1 }, align: 'left', width: 250, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetBancosPropios',
                            dataInit: function (elem) {
                                $(elem).width(240);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td, IdCaja, IdCuentaBancaria, SelectOpcional, newOptions;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        IdCaja = $('#IdCaja').val();
                                        IdCuentaBancaria = 0;
                                        if (IdCaja == -1 || IdCaja > 0) {
                                            IdCaja = this.value;
                                            $('#IdCaja').val(IdCaja);
                                            $('#IdBanco').val("");
                                            $('#IdCuentaBancaria').val("");
                                            $('#IdBancoChequera').val("");
                                        } else {
                                            IdCuentaBancaria = this.value;
                                            $('#IdCuentaBancaria').val(IdCuentaBancaria);
                                            AsignarBancoPorIdCuentaBancaria(IdCuentaBancaria);
                                            $('#IdCaja').val("");

                                            newOptions = TraerChequerasPorIdCuentaBancaria(IdCuentaBancaria);
                                            if (newOptions.length > 0) {
                                                $("select#Chequera.FormElement").removeAttr('disabled');
                                                var form = $(e.target).closest('form.FormGrid');
                                                $("select#Chequera.FormElement", form[0]).html(newOptions);

                                                SelectOpcional = $("#Chequera").children("option").filter(":selected");
                                                if (SelectOpcional.length > 0) {
                                                    AsignarNumeroValor(SelectOpcional.val());
                                                }
                                            } else {
                                                $("select#Chequera.FormElement").val('');
                                                $("select#Chequera.FormElement").attr('disabled', 'disabled');
                                            }
                                        }
                                    } else {
                                        $td = $this.closest("td");
                                        var rowid = $('#ListaValores').getGridParam('selrow');
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var idcaja = $("#ListaValores").getRowData(rowid)['IdCaja'];
                                            IdCuentaBancaria = 0;
                                            if (idcaja != "") {
                                                IdCaja = this.value;
                                                $('#ListaValores').jqGrid('setCell', rowid, 'IdCaja', IdCaja);
                                            } else {
                                                IdCuentaBancaria = this.value;
                                                $('#ListaValores').jqGrid('setCell', rowid, 'IdCuentaBancaria', IdCuentaBancaria);
                                            }
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'Importe', index: 'Importe', formoptions: { rowpos: 4, colpos: 2 }, width: 60, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaValores').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'Chequera', index: 'Chequera', formoptions: { rowpos: 5, colpos: 1 }, align: 'left', width: 100, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetChequerasPorIdCuentaBancaria2?IdCuentaBancaria=0',
                            dataInit: function (elem) {
                                $(elem).width(90);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td, IdBancoChequera, newOptions;
                                    IdBancoChequera = this.value;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdBancoChequera').val(IdBancoChequera);
                                        IdCuentaGasto = $('#IdCuentaGasto').val();
                                        AsignarNumeroValor(IdBancoChequera);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdBancoChequera', IdBancoChequera);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    { name: 'Anulado', index: 'Anulado', width: 40, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'ChequesALaOrdenDe', index: 'ChequesALaOrdenDe', formoptions: { rowpos: 6, colpos: 1 }, width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'NoALaOrden', index: 'NoALaOrden', formoptions: { rowpos: 6, colpos: 2 }, width: 50, align: 'left', editable: true, editrules: { required: false }, edittype: "checkbox", editoptions: { value: "SI:NO" }, formatter: "checkbox", formatoptions: { disabled: false }, label: 'TB' }
        ],
        gridComplete: function () {
            calculaTotalValores();
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
            if (jQuery("#ListaValores").jqGrid('getCell', rowid, 'Tipo') == 'CE') {
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'Tipo', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'NumeroInterno', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'NumeroValor', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'FechaValor', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'ChequesALaOrdenDe', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'NoALaOrden', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'Chequera', '', 'not-editable-cell');
            }
            var cm = jQuery("#ListaValores").jqGrid("getGridParam", "colModel");
            if (cm[iCol].name == "Entidad") {
                var TipoEntidad, TipoEntidad1;
                TipoEntidad = $("#ListaValores").getRowData(rowid)['IdCaja'];
                TipoEntidad1 = 1
                if (TipoEntidad != "") { TipoEntidad1 = 4 }
                $("#ListaValores").setColProp('Entidad', { editoptions: { dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=' + TipoEntidad1 } });
            }
        },
        afterSaveCell: function (rowid, name, val, iRow, iCol) {
            calculaTotalValores();

            var cm = jQuery("#ListaValores").jqGrid("getGridParam", "colModel");
            if (cm[iCol].name == "Entidad") {
                var IdCuentaBancaria, newOptions;
                IdCuentaBancaria = $("#ListaValores").getRowData(rowid)['IdCuentaBancaria'];
                $('#ListaValores').jqGrid('setCell', rowid, 'Chequera', " ");
                $("#ListaValores").setColProp('Chequera', { editoptions: { dataUrl: ROOT + 'Banco/GetChequerasPorIdCuentaBancaria2?IdCuentaBancaria=' + IdCuentaBancaria } });
            }
        },
        pager: $('#ListaPager3'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleOrdenPagoValores',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', 
        autowidth: true,
        shrinkToFit: false,
        height: '200px',
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
        caption: 'VALORES',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaValores").jqGrid('navGrid', '#ListaPager3', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //$("#ListaValores").setFrozenColumns();
    jQuery("#ListaValores").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-home", title: "Agregar valor", 
                                        onClickButton: function () {
                                            AgregarValor(jQuery("#ListaValores"));
                                        },
                                    });
    jQuery("#ListaValores").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-clipboard", title: "Agregar caja",
                                        onClickButton: function () {
                                            AgregarCaja(jQuery("#ListaValores"));
                                        },
                                    });
    jQuery("#ListaValores").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                        onClickButton: function () {
                                            EliminarSeleccionados(jQuery("#ListaValores"));
                                        },
                                    });


    $('#ListaContable').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoCuentas/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoCuentas', 'IdCuenta', 'IdObra', 'IdCuentaGasto', 'IdCuentaBancaria', 'IdCaja', 'IdTarjetaCredito', 'IdMoneda', 'CotizacionMonedaDestino', 'IdTipoCuentaGrupo',
                   'Codigo', 'Cuenta', 'Debe', 'Haber', 'Cuenta bancaria', 'Caja', 'Tarjeta credito', 'Obra', 'Cuenta de gasto', 'Grupo cuenta'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoCuentas', index: 'IdDetalleOrdenPagoCuentas', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdCuenta', index: 'IdCuenta', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdObra', index: 'IdObra', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCuentaGasto', index: 'IdCuentaGasto', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCaja', index: 'IdCaja', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdTarjetaCredito', index: 'IdTarjetaCredito', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdMoneda', index: 'IdMoneda', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'CotizacionMonedaDestino', index: 'CotizacionMonedaDestino', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdTipoCuentaGrupo', index: 'IdTipoCuentaGrupo', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    {
                        name: 'Codigo', index: 'Codigo', formoptions: { rowpos: 5, colpos: 1 }, align: 'center', width: 100, editable: true, hidden: false, edittype: 'text', editrules: { edithidden: false, required: true },
                        editoptions: {
                            dataInit: function (elem) {
                                $(elem).width(95);
                            },
                            dataEvents: [{
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaContable').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                },
                                type: 'change',
                                fn: function (e) {
                                    $.post(ROOT + 'Cuenta/GetCodigosCuentasAutocomplete',
                                    { term: this.value },
                                    function (data) {
                                        if (data.length == 1 || data.length > 1) { 
                                            var ui = data[0];
                                            var $this = $(e.target), $td, newOptions;
                                            var IdCuenta = ui.id;

                                            if ($this.hasClass("FormElement")) {
                                                // form editing
                                                $("#IdCuenta").val(IdCuenta);
                                                $("#Cuenta").val(IdCuenta);

                                                newOptions = TraerCuentasBancarias(IdCuenta);
                                                var form = $(e.target).closest('form.FormGrid');
                                                $("select#CuentaBancaria.FormElement", form[0]).html(newOptions);

                                                newOptions = TraerCajas(IdCuenta);
                                                var form = $(e.target).closest('form.FormGrid');
                                                $("select#Caja.FormElement", form[0]).html(newOptions);

                                                newOptions = TraerTarjetasCredito(IdCuenta);
                                                var form = $(e.target).closest('form.FormGrid');
                                                $("select#TarjetaCredito.FormElement", form[0]).html(newOptions);

                                                DatosCuenta(IdCuenta, "f", "0", "Codigo");
                                            } else {
                                                $td = $this.closest("td");
                                                if ($td.hasClass("edit-cell")) {
                                                    // cell editing
                                                    var rowid = $('#ListaContable').getGridParam('selrow');
                                                    $('#ListaContable').jqGrid('setCell', rowid, 'IdCuenta', IdCuenta);
                                                    $('#ListaContable').jqGrid('setCell', rowid, 'Cuenta', ui.value);
                                                    DatosCuenta(IdCuenta, "c", rowid, "Codigo");
                                                } else {
                                                    // inline editing
                                                }
                                            }
                                        }
                                        else {
                                            alert("No existe el código");
                                            $("#Codigo").val("");
                                            $("#Cuenta").val("");
                                            return false;
                                        }
                                    }
                                    );
                                }
                            }]
                        }
                    },
                    {
                        name: 'Cuenta', index: 'Cuenta', formoptions: { rowpos: 5, colpos: 2 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: true },
                        editoptions: {
                            dataUrl: ROOT + 'Cuenta/GetCuentas',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td, newOptions;
                                    var IdCuenta = this.value;

                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdCuenta').val(IdCuenta);

                                        newOptions = TraerCuentasBancarias(IdCuenta);
                                        var form = $(e.target).closest('form.FormGrid');
                                        $("select#CuentaBancaria.FormElement", form[0]).html(newOptions);

                                        newOptions = TraerCajas(IdCuenta);
                                        var form = $(e.target).closest('form.FormGrid');
                                        $("select#Caja.FormElement", form[0]).html(newOptions);

                                        newOptions = TraerTarjetasCredito(IdCuenta);
                                        var form = $(e.target).closest('form.FormGrid');
                                        $("select#TarjetaCredito.FormElement", form[0]).html(newOptions);

                                        DatosCuenta(IdCuenta, "f", "0", "Codigo");
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdCuenta', IdCuenta);
                                            DatosCuenta(IdCuenta, "c", rowid, "Codigo");
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'Debe', index: 'Debe', formoptions: { rowpos: 8, colpos: 1 }, width: 90, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaContable').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'Haber', index: 'Haber', formoptions: { rowpos: 8, colpos: 2 }, width: 90, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaContable').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'CuentaBancaria', index: 'CuentaBancaria', formoptions: { rowpos: 6, colpos: 1 }, align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=0',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdCuentaBancaria').val(this.value);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdCuentaBancaria', this.value);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'Caja', index: 'Caja', formoptions: { rowpos: 7, colpos: 1 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=0',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdCaja').val(this.value);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdCaja', this.value);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'TarjetaCredito', index: 'TarjetaCredito', formoptions: { rowpos: 7, colpos: 2 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=0',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdTarjetaCredito').val(this.value);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdTarjetaCredito', this.value);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'Obra', index: 'Obra', formoptions: { rowpos: 2, colpos: 1 }, align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Obra/GetObras',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td, IdObra, IdCuentaGasto, newOptions;
                                    IdObra = this.value;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdObra').val(IdObra);
                                        IdCuentaGasto = $('#IdCuentaGasto').val();

                                        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "f");
                                        if (newOptions.length > 0) {
                                            var form = $(e.target).closest('form.FormGrid');
                                            $("select#Cuenta.FormElement", form[0]).html(newOptions);
                                        }
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdObra', IdObra);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'CuentaGasto', index: 'CuentaGasto', formoptions: { rowpos: 3, colpos: 1 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'CuentaGasto/GetCuentasGasto',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td, IdObra, IdCuentaGasto, newOptions;
                                    IdCuentaGasto = this.value;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdCuentaGasto').val(IdCuentaGasto);
                                        IdObra = $('#IdObra').val();

                                        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "f");
                                        if (newOptions.length > 0) {
                                            var form = $(e.target).closest('form.FormGrid');
                                            $("select#Cuenta.FormElement", form[0]).html(newOptions);
                                        }
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdCuentaGasto', IdCuentaGasto);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'TipoCuentaGrupo', index: 'TipoCuentaGrupo', formoptions: { rowpos: 3, colpos: 2 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'TiposCuentaGrupos/GetTiposCuentaGrupos',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td, IdTipoCuentaGrupo, newOptions;
                                    IdTipoCuentaGrupo = this.value;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdTipoCuentaGrupo').val(IdTipoCuentaGrupo);

                                        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "f");
                                        if (newOptions.length > 0) {
                                            var form = $(e.target).closest('form.FormGrid');
                                            $("select#Cuenta.FormElement", form[0]).html(newOptions);
                                        }
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdTipoCuentaGrupo', IdTipoCuentaGrupo);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    }
        ],
        gridComplete: function () {
            calculaTotalContable();
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterSaveCell: function (rowid) {
            calculaTotalContable();
        },
        pager: $('#ListaPager2'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleOrdenPagoCuentas',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
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
        caption: 'REGISTRO CONTABLE',
        cellEdit: true,
        cellsubmit: 'clientArray',
        loadonce: true
    });
    jQuery("#ListaContable").jqGrid('navGrid', '#ListaPager2', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaContable").jqGrid('navButtonAdd', '#ListaPager2',
                                    {
                                        caption: "", buttonicon: "ui-icon-home", title: "Agregar item",
                                        onClickButton: function () {
                                            AgregarCuenta(jQuery("#ListaContable"));
                                        },
                                    });
    jQuery("#ListaContable").jqGrid('navButtonAdd', '#ListaPager2',
                                    {
                                        caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                        onClickButton: function () {
                                            EliminarSeleccionados(jQuery("#ListaContable"));
                                        },
                                    });


    $('#ListaImpuestos').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoImpuestos/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoImpuestos', 'IdTipoRetencionGanancia', 'IdIBCondicion', 'IdTipoImpuesto', 'Tipo', 'Categoria', 'Imp.Pag.S/Imp.', 'Imp.Retenido', 'Pagos mes', 'Retenc.Mes',
                   'Minimo IIBB', 'Alicuota', 'Alic.Conv.', '% Adic.', 'Impuesto ad.', 'Cert.Ret.Gan.', 'Cert.Ret.IIBB', 'Fact.M a Ret.'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoImpuestos', index: 'IdDetalleOrdenPagoImpuestos', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdTipoRetencionGanancia', index: 'IdTipoRetencionGanancia', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdIBCondicion', index: 'IdIBCondicion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdTipoImpuesto', index: 'IdTipoImpuesto', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'TipoImpuesto', index: 'TipoImpuesto', width: 70, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'Categoria', index: 'Categoria', width: 200, align: 'left', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImportePagado', index: 'ImportePagado', width: 100, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'ImpuestoRetenido', index: 'ImpuestoRetenido', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'PagosMes', index: 'PagosMes', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'RetencionesMes', index: 'RetencionesMes', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'MinimoIIBB', index: 'MinimoIIBB', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'AlicuotaAplicada', index: 'AlicuotaAplicada', width: 60, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'AlicuotaConvenioAplicada', index: 'AlicuotaConvenioAplicada', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'PorcentajeAdicional', index: 'PorcentajeAdicional', width: 50, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'ImpuestoAdicional', index: 'ImpuestoAdicional', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'NumeroCertificadoRetencionGanancias', index: 'NumeroCertificadoRetencionGanancias', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'NumeroCertificadoRetencionIIBB', index: 'NumeroCertificadoRetencionIIBB', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' },
                    { name: 'ImporteTotalFacturasMPagadasSujetasARetencion', index: 'ImporteTotalFacturasMPagadasSujetasARetencion', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }, label: 'TB' }
        ],
        gridComplete: function () {
            //calculaTotalContable();
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        pager: $('#ListaPager4'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'Tipo,Categoria',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
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
        caption: 'IMPUESTOS CALCULADOS',
        cellEdit: true,
        cellsubmit: 'clientArray',
        loadonce: true
    });
    jQuery("#ListaImpuestos").jqGrid('navGrid', '#ListaPager4', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    $("#ListaPager4").find("table.navtable").hide();


    $('#ListaRubrosContables').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoRubrosContables/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoRubrosContables', 'IdRubroContable', 'Rubro contable', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoRubrosContables', index: 'IdDetalleOrdenPagoRubrosContables', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRubroContable', index: 'IdRubroContable', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    {
                        name: 'RubroContable', index: 'RubroContable', align: 'left', width: 150, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'RubroContable/GetRubrosContables',
                            dataInit: function (elem) {
                                $(elem).width(140);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaRubrosContables').getGridParam('selrow');
                                    $('#ListaRubrosContables').jqGrid('setCell', rowid, 'IdRubroContable', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Importe', index: 'Importe', width: 60, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaRubrosContables').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    }
        ],
        gridComplete: function () {
            calculaTotalRubroContable();
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterSaveCell: function (rowid) {
            calculaTotalRubroContable();
        },
        pager: $('#ListaPager5'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleOrdenPagoRubrosContables',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
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
        caption: 'RUBROS CONTABLES',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaRubrosContables").jqGrid('navGrid', '#ListaPager5', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaRubrosContables").jqGrid('navButtonAdd', '#ListaPager5',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar rubro contable",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaRubrosContables"));
                                     },
                                 });
    jQuery("#ListaRubrosContables").jqGrid('navButtonAdd', '#ListaPager5',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaRubrosContables"));
                                     },
                                 });


    $('#ListaGastos').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoGastosFF/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); }, 'IdOPComplementariaFF': function () { return $("#IdOPComplementariaFF").val(); }, 'IdMonedaOP': function () { return $("#IdMoneda").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdComprobanteProveedor', 'Tipo', 'Ref.', 'Numero', 'Fecha', 'Vto.', 'Nro.Rend.', 'Subtotal', 'Iva', 'Total', 'Cuenta', 'Obra'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdComprobanteProveedor', index: 'IdComprobanteProveedor', editable: false, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'TipoComprobante', index: 'TipoComprobante', width: 30, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroReferencia', index: 'NumeroReferencia', width: 50, align: 'left', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Numero', index: 'Numero', width: 110, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 75, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'FechaVencimiento', index: 'FechaVencimiento', width: 75, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'NumeroRendicionFF', index: 'NumeroRendicionFF', width: 70, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Subtotal', index: 'Subtotal', align: 'right', width: 70, editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Iva', index: 'Iva', align: 'right', width: 70, editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Total', index: 'Total', align: 'right', width: 70, editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Cuenta', index: 'Cuenta', width: 120, align: 'left', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Obra', index: 'Obra', width: 100, align: 'left', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } }
        ],
        gridComplete: function () {
            calculaTotalGastosFF();
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterSaveCell: function (rowid) {
            calculaTotalGastosFF();
        },
        pager: $('#ListaPager6'),
        rowNum: 10000,
        rowList: [10, 20, 50, 100],
        sortname: 'IdComprobanteProveedor',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
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
        caption: '<b>DETALLE COMPROBANTES DE GASTOS FONDO FIJO</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaGastos").jqGrid('navGrid', '#ListaPager6', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, {});
    jQuery("#ListaGastos").jqGrid('navButtonAdd', '#ListaPager6',
                                 {
                                     caption: "", buttonicon: "ui-icon-circle-arrow-s", title: "Traer gastos pendientes",
                                     onClickButton: function () {
                                         TraerGastosPendientes(jQuery("#ListaGastos"));
                                     },
                                 });
    jQuery("#ListaGastos").jqGrid('navButtonAdd', '#ListaPager6',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaGastos"));
                                     },
                                 });


    $("#ListaDrag").jqGrid({
        url: ROOT + 'CuentaCorriente/CuentaCorrienteAcreedorPendientePorProveedor',
        postData: { 'IdProveedor': function () { return $("#IdProveedor").val(); } },
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
                        { name: 'Tipo', index: 'Tipo', align: 'center', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Numero', index: 'Numero', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                        { name: 'Fecha', index: 'Fecha', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'FechaVencimiento', index: 'FechaVencimiento', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Moneda', index: 'Moneda', align: 'left', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                        { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Saldo', index: 'Saldo', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
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
        rowList: [10, 20, 50, 100],
        sortname: 'IdImputacion,Cabeza,Fecha,Numero',
        sortorder: "asc",
        viewrecords: true,
        emptyrecords: 'No hay registros para mostrar', //,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: $(window).height() - ALTOLISTADO, // '100%'
        altRows: false,
        footerrow: false, //true,
        userDataOnFooter: true,
        gridview: true,
        multiboxonly: true,
        multipleSearch: true
    })
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
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
        
    

    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Valor/ValoresEnCartera',
        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'IdValor', 'Tipo', 'Nro.Int.', 'Nro.Valor', 'Fecha valor', 'Banco', 'Importe', 'T.Cmp.', 'Nro.Comprob.', 'Fecha Cmp.', 'Cliente'],
        colModel: [
                        { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: true },
                        { name: 'IdValor', index: 'IdValor', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Tipo', index: 'Tipo', align: 'center', width: 40, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'NumeroInterno', index: 'NumeroInterno', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                        { name: 'NumeroValor', index: 'NumeroValor', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                        { name: 'FechaValor', index: 'FechaValor', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Banco', index: 'Banco', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                        { name: 'Importe', index: 'Importe', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'TipoComprobante', index: 'TipoComprobante', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'NumeroComprobante', index: 'NumeroComprobante', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                        { name: 'FechaComprobante', index: 'FechaComprobante', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Cliente', index: 'Cliente', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } }
        ],
        ondblClickRow: function (id) {
            CopiarValorTercero(id, "Dbl");
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag2 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },

        pager: $('#ListaDragPager2'),

        rowNum: 15,
        rowList: [10, 20, 50, 100],
        sortname: 'FechaValor',
        sortorder: 'desc',
        viewrecords: true,
        emptyrecords: 'No hay registros para mostrar', //,

        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////

        height: $(window).height() - ALTOLISTADO, // '100%'
        altRows: false,
        footerrow: false, //true,
        userDataOnFooter: true,
        gridview: true,
        multiboxonly: true,
        multipleSearch: true
    })
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2',
        { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
        {
            //sopt: ["cn"]
            //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
            width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
        }
    );
    jQuery("#ListaDrag2").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/
        

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Cuenta corriente');
    $('a#a_panel_este_tab2').text('Cartera de valores');
    //$('a#a_panel_este_tab5').remove();  //    

    ConectarGrillas1();
    ConectarGrillas2();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });
    $('#a_panel_este_tab2').click(function () {
        ConectarGrillas2();
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

    function ConectarGrillas2() {
        $("#ListaDrag2").jqGrid('gridDnD', {
            connectWith: '#ListaValores',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                CopiarValorTercero($(ui.draggable).attr("id"), "DnD");
            }
        });
    }

    function CopiarCtaCte(IdCtaCte, Origen) {
        var acceptId = IdCtaCte;
        var $gridOrigen = $("#ListaDrag"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate, mPrimerItem = true;
        //var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');

        dataIds = $gridDestino.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
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
                url: ROOT + 'CuentaCorriente/TraerUno/',
                data: { IdCtaCte: IdCtaCte },
                dataType: "Json",
                success: function (data) {
                    for (i = 0; i < data.length; i++) {
                        tmpdata['IdDetalleOrdenPago'] = Id2;
                        tmpdata['IdImputacion'] = data[i].IdImputacion;
                        tmpdata['IdTipoRetencionGanancia'] = data[i].IdTipoRetencionGanancia;
                        tmpdata['IdIBCondicion'] = data[i].IdIBCondicion;
                        tmpdata['BaseCalculoIIBB'] = data[i].BaseCalculoIIBB;
                        tmpdata['CotizacionMoneda'] = data[i].CotizacionMoneda;
                        tmpdata['IdTipoComp'] = data[i].IdTipoComp;
                        tmpdata['IdComprobante'] = data[i].IdComprobante;
                        tmpdata['Tipo'] = data[i].Tipo;
                        tmpdata['Numero'] = data[i].Numero;
                        tmpdata['ImporteOriginal'] = data[i].ImporteOriginal;
                        tmpdata['Saldo'] = data[i].Saldo;
                        tmpdata['Importe'] = data[i].Importe;
                        tmpdata['ImportePagadoSinImpuestos'] = data[i].ImportePagadoSinImpuestos;
                        tmpdata['IvaTotal'] = data[i].IvaTotal;
                        tmpdata['TotalComprobante'] = data[i].TotalComprobante;
                        tmpdata['BienesYServicios'] = data[i].BienesYServicios;
                        tmpdata['GravadoIVA'] = data[i].GravadoIVA;
                        tmpdata['PorcentajeIVAParaMonotributistas'] = data[i].PorcentajeIVAParaMonotributistas;
                        tmpdata['CertificadoPoliza'] = data[i].CertificadoPoliza;
                        tmpdata['NumeroEndosoPoliza'] = data[i].NumeroEndosoPoliza;

                        date = new Date(parseInt(data[i].Fecha.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        tmpdata['Fecha'] = displayDate;
                        date = new Date(parseInt(data[i].FechaVencimiento.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        tmpdata['FechaVencimiento'] = displayDate;
                        if (data[i].FechaComprobante != null) {
                            date = new Date(parseInt(data[i].FechaComprobante.substr(6)));
                            displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                            tmpdata['FechaComprobante'] = displayDate;
                        }

                        getdata = tmpdata;

                        if (Origen == "DnD") {
                            if (mPrimerItem) {
                                dataIds = $gridDestino.jqGrid('getDataIDs');
                                Id = dataIds[0];
                                $gridDestino.jqGrid('setRowData', Id, getdata);
                                mPrimerItem = false;
                            } else {
                                Id = Id2
                                $gridDestino.jqGrid('addRowData', Id, getdata, "first");
                            }
                        } else {
                            Id = Id2
                            $gridDestino.jqGrid('addRowData', Id, getdata, "first");
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

    function CopiarValorTercero(IdValor, Origen) {
        var acceptId = IdValor;
        var $gridOrigen = $("#ListaDrag2"), $gridDestino = $("#ListaValores");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;
        //var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');

        dataIds = $gridDestino.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            data2 = $gridDestino.jqGrid('getRowData', dataIds[i]);
            if (data2.IdValor == IdValor) {
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
                url: ROOT + 'Valor/TraerUno/',
                data: { IdValor: IdValor },
                dataType: "Json",
                success: function (data) {
                    for (i = 0; i < data.length; i++) {
                        data2 = data[i]
                        data2.IdDetalleOrdenPagoValores = Id2;

                        date = new Date(parseInt(data[i].FechaValor.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        data2.FechaValor = displayDate;

                        if (Origen == "DnD") {
                            Id = dataIds[0];
                            $gridDestino.jqGrid('setRowData', Id, data2);
                        } else {
                            Id = Id2
                            $gridDestino.jqGrid('addRowData', Id, data2, "first");
                        };
                    }
                }
            });
        } catch (e) { }
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    //////////////////////////////////// CHANGES ///////////////////////////////////////////////

    $("#AsientoManual").change(function () {
        ActivarAsientoManual($("#AsientoManual").is(':checked'));
    });

    $("#BuscadorPanelDerecho").change(function () {
        var grid = jQuery("#ListaDrag");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                searchField: 'NumeroValor', // Codigo
                searchOper: 'eq',
                searchString: $("#BuscadorPanelDerecho").val()
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);
    });

    //No se usa
    $("input[name=Tipo]:radio").change(function () {
        var tipo = $(this).val();
    });

    $("#IdMoneda").change(function () {
        TraerCotizacion()
    })

    function ActualizarTodo() {
        var cabecera = SerializaForm();

        ActualizarDatosRetenciones(cabecera);

        var importe = 0, totalganancias = 0, totaliibb = 0, i;
        var dataIds = $('#ListaImpuestos').jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            var data = $('#ListaImpuestos').jqGrid('getRowData', dataIds[i]);
            importe = parseFloat(data['ImpuestoRetenido'].replace(",", ".") || 0) || 0;
            if (data['Tipo'] == "Ganancias") {
                totalganancias = totalganancias + importe;
            } else {
                totaliibb = totaliibb + importe;
            }
        }
        $("#RetencionGanancias").val(totalganancias.toFixed(2));
        $("#RetencionIBrutos").val(totaliibb.toFixed(2));

        CalcularRetencionSUSS(cabecera);
        CalcularRetencionIva(cabecera);

        ActualizarDatosContables();

        CalcularTotales()
    }

    $('#ActualizarDatos').click(function () {
        $('#ActualizarDatos').attr("disabled", true).val("Espere...");
        $('html, body').css('cursor', 'wait');
        ActualizarTodo();
        $('html, body').css('cursor', 'auto');
        $('#ActualizarDatos').attr("disabled", false).val("Recalcular");
    });

    function ActualizarDatosRetenciones(cabecera) {
        var datos = "";
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'OrdenPago/CalcularRetenciones',
            dataType: 'json',
            async: false,
            data: JSON.stringify(cabecera),
            success: function (result) {
                if (result) {
                    datos = JSON.parse(result);
                    $("#ListaImpuestos").jqGrid("clearGridData", true)
                    $("#ListaImpuestos").jqGrid().setGridParam({ data: datos }).trigger("reloadGrid");
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
    };

    function TraerGastosPendientes(grid) {
        var datos = "", IdOrdenPago = 0, IdOPComplementariaFF = 0, IdMoneda = 0, NumeroRendicionFF = 0, IdCuentaFF = 0;
        IdOrdenPago = $("#IdOrdenPago").val();
        IdOPComplementariaFF = $("#IdOPComplementariaFF").val();
        IdMoneda = $("#IdMoneda").val();
        NumeroRendicionFF = $("#NumeroRendicionFF").val();
        IdCuentaFF = $('select#IdCuenta').val();
        if (IdCuentaFF.length == 0) {
            alert("Debe ingresar la cuenta de fondo fijo")
            return
        }
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'OrdenPago/GastosFFPendientes',
            data: JSON.stringify({ IdOrdenPago: IdOrdenPago, IdOPComplementariaFF: IdOPComplementariaFF, IdMonedaOP: IdMoneda, NumeroRendicionFF: NumeroRendicionFF, IdCuentaFF: IdCuentaFF }),
            dataType: 'json',
            async: false,
            success: function (result) {
                if (result) {
                    datos = JSON.parse(result);
                    $("#ListaGastos").jqGrid("clearGridData", true)
                    $("#ListaGastos").jqGrid().setGridParam({ datatype: "local" });
                    $("#ListaGastos").jqGrid().setGridParam({ data: datos }).trigger("reloadGrid");
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
    };

    function CalcularRetencionSUSS(cabecera) {
        var datos = "", imp;
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'OrdenPago/CalcularRetencionSUSS',
            dataType: 'json',
            async: false,
            data: JSON.stringify(cabecera),
            success: function (result) {
                if (result) {
                    datos = JSON.parse(result);
                    imp = parseFloat(datos.replace(",", ".") || 0) || 0;
                    $("#RetencionSUSS").val(imp.toFixed(2));
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
    };

    function CalcularRetencionIva(cabecera) {
        var datos = "", imp;
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'OrdenPago/CalcularRetencionIva',
            dataType: 'json',
            async: false,
            data: JSON.stringify(cabecera),
            success: function (result) {
                if (result) {
                    datos = JSON.parse(result);
                    var datos1 = datos.campo1;
                    imp = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    $("#RetencionIVA").val(imp.toFixed(2));
                    $("#IdsComprobanteProveedorRetenidosIva").val(datos.campo2);
                    $("#TotalesImportesRetenidosIva").val(datos.campo3);
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
    };

    function ActualizarDatosContables() {
        var datos = "";
        var cabecera = SerializaForm();
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'OrdenPago/CalcularAsiento',
            dataType: 'json',
            async: false,
            data: JSON.stringify(cabecera),
            success: function (result) {
                if (result) {
                    datos = JSON.parse(result);
                    $("#ListaContable").jqGrid("clearGridData", true)
                    $("#ListaContable").jqGrid().setGridParam({ data: datos }).trigger("reloadGrid");
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
    };

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");
        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();
        cabecera.IdProveedor = $("#IdProveedor").val();
        cabecera.IdCuenta = $("#IdCuenta").val();
        cabecera.DiferenciaBalanceo = $("#Diferencia").val();
        cabecera.IdEmpleadoFF = $("#IdEmpleadoFF").val();

        var chk = $('#AsientoManual').is(':checked');
        if (chk) {
            cabecera.AsientoManual = "SI";
        } else {
            cabecera.AsientoManual = "NO";
        };
        var chk = $('#OPInicialFF').is(':checked');
        if (chk) {
            cabecera.OPInicialFF = "SI";
        } else {
            cabecera.OPInicialFF = "NO";
        };

        cabecera.DetalleOrdenesPagoes = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleOrdenPago'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleOrdenPago":"' + iddeta + '",';
                data1 = data1 + '"IdOrdenPago":"' + $("#IdOrdenPago").val() + '",';
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
                cabecera.DetalleOrdenesPagoes.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleOrdenesPagoValores = [];
        $grid = $('#ListaValores');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleOrdenPagoValores'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleOrdenPagoValores":"' + iddeta + '",';
                data1 = data1 + '"IdOrdenPago":"' + $("#IdOrdenPago").val() + '",';
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
                cabecera.DetalleOrdenesPagoValores.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleOrdenesPagoImpuestos = [];
        $grid = $('#ListaImpuestos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleOrdenPagoImpuestos'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleOrdenPagoImpuestos":"' + iddeta + '",';
                data1 = data1 + '"IdOrdenPago":"' + $("#IdOrdenPago").val() + '",';
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
                cabecera.DetalleOrdenesPagoImpuestos.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleOrdenesPagoCuentas = [];
        $grid = $('#ListaContable');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleOrdenPagoCuentas'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleOrdenPagoCuentas":"' + iddeta + '",';
                data1 = data1 + '"IdOrdenPago":"' + $("#IdOrdenPago").val() + '",';
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
                cabecera.DetalleOrdenesPagoCuentas.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleOrdenesPagoRubrosContables = [];
        $grid = $('#ListaRubrosContables');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleOrdenPagoRubrosContables'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleOrdenPagoRubrosContables":"' + iddeta + '",';
                data1 = data1 + '"IdOrdenPago":"' + $("#IdOrdenPago").val() + '",';
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
                cabecera.DetalleOrdenesPagoRubrosContables.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        return cabecera;
    }

    $('#grabar2').click(function () {
        ActualizarTodo();

        var cabecera = SerializaForm();

        var IdsGastosFF, colModel, dataIds, data, data1, iddeta, i;
        $grid = $('#ListaGastos');
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        data1 = "";
        for (i = 0; i < dataIds.length; i++) {
            data = $grid.jqGrid('getRowData', dataIds[i]);
            iddeta = data['IdComprobanteProveedor'];
            data1 = data1 + iddeta + ',';
        };
        data1 = data1.substring(0, data1.length - 1);
        data1 = data1.replace(/(\r\n|\n|\r)/gm, "");

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'OrdenPago/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ OrdenPago: cabecera, IdsGastosFF: data1 }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    if ($('#Anulada').val() != "") {
                        window.location = (ROOT + "OrdenPago/index");
                    } else {
                        if ($('#Tipo').val() == "CC") { window.location = (ROOT + "OrdenPago/EditCC/" + result.IdOrdenPago); }
                        if ($('#Tipo').val() == "FF") { window.location = (ROOT + "OrdenPago/EditFF/" + result.IdOrdenPago); }
                        if ($('#Tipo').val() == "OT") { window.location = (ROOT + "OrdenPago/EditOT/" + result.IdOrdenPago); }
                    }
                } else {
                    alert('No se pudo grabar el comprobante.');
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

});

function pickdates(id) {
    jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
}

function unformatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(",", ".");
}

function formatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(".", ",");
}

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
    CalcularTotales()
};

calculaTotalValores = function () {
    var imp = 0, imp2 = 0;
    var dataIds = $('#ListaValores').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaValores').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalValores = imp2;
    $("#ListaValores").jqGrid('footerData', 'set', { Entidad: 'TOTALES', Importe: imp2.toFixed(2) });
    CalcularTotales()
};

calculaTotalContable = function () {
    var imp = 0, imp2 = 0, imp3 = 0;
    var dataIds = $('#ListaContable').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaContable').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Debe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
        imp = parseFloat(data['Haber'].replace(",", ".") || 0) || 0;
        imp3 = imp3 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    imp3 = Math.round((imp3) * 10000) / 10000;
    $("#ListaContable").jqGrid('footerData', 'set', { Cuenta: 'TOTALES', Debe: imp2.toFixed(2), Haber: imp3.toFixed(2) });
};

calculaTotalRubroContable = function () {
    var imp = 0, imp2 = 0;
    var dataIds = $('#ListaRubrosContables').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaRubrosContables').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    $("#ListaRubrosContables").jqGrid('footerData', 'set', { RubroContable: 'TOTAL', Importe: imp2.toFixed(2) });
};

calculaTotalGastosFF = function () {
    var imp = 0, imp2 = 0, imp3 = 0, imp4 = 0;
    var dataIds = $('#ListaGastos').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaGastos').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Subtotal'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
        imp = parseFloat(data['Iva'].replace(",", ".") || 0) || 0;
        imp3 = imp3 + imp;
        imp = parseFloat(data['Total'].replace(",", ".") || 0) || 0;
        imp4 = imp4 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    imp3 = Math.round((imp3) * 10000) / 10000;
    imp4 = Math.round((imp4) * 10000) / 10000;
    mTotalGastosFF = imp4;
    $("#ListaGastos").jqGrid('footerData', 'set', { NumeroRendicionFF: 'TOTALES', Subtotal: imp2.toFixed(2), Iva: imp3.toFixed(2), Total: imp4.toFixed(2) });
    CalcularTotales()
};

function CalcularTotales() {
    if (typeof mTotalImputaciones == "undefined") { mTotalImputaciones = 0; }
    if (typeof mTotalValores == "undefined") { mTotalValores = 0; }
    if (typeof mTotalGastosFF == "undefined") { mTotalGastosFF = 0; }

    var mSubtotal = 0, mTotalOPComplementaria = 0;
    mRetencionGanancias = parseFloat($("#RetencionGanancias").val().replace(",", ".") || 0) || 0;
    mRetencionIIBB = parseFloat($("#RetencionIBrutos").val().replace(",", ".") || 0) || 0;
    mRetencionIva = parseFloat($("#RetencionIVA").val().replace(",", ".") || 0) || 0;
    mRetencionSUSS = parseFloat($("#RetencionSUSS").val().replace(",", ".") || 0) || 0;
    mTotalOPComplementaria = parseFloat($("#TotalOPComplementaria").val().replace(",", ".") || 0) || 0;
    mSubtotal = mTotalImputaciones + mTotalGastosFF;

    $("#Valores").val(mTotalValores.toFixed(2));
    $("#Acreedores").val(mTotalImputaciones.toFixed(2));
    $("#Subtotal").val(mSubtotal.toFixed(2));
    mTotalDiferenciaBalanceo = (mSubtotal + mTotalOPComplementaria) - (mTotalValores + mRetencionIva + mRetencionGanancias + mRetencionIIBB + mRetencionSUSS);
    $("#Diferencia").val(mTotalDiferenciaBalanceo.toFixed(2));
};

function CalcularImportePagadoSinImpuestos(IdTipoComprobante, IdComprobante, Pagado) {
    var respuesta;
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'OrdenPago/CalcularImportePagadoSinImpuestos',
        data: { IdTipoComprobante: IdTipoComprobante, IdComprobante: IdComprobante, Pagado: Pagado },
        dataType: "json",
        async: false,
        success: function (result) {
            if (result) {
                datos = JSON.parse(result);
                respuesta = parseFloat(datos.replace(",", ".") || 0) || 0;
            } else { alert('No se pudo calcular el comprobante.'); }
        },
        error: function (xhr, textStatus, exceptionThrown) {
            respuesta = "0";
        }
    });
    return [respuesta];
};

function TraerCotizacion() {
    var fecha, IdMoneda, datos1, mIdMonedaPrincipal = 1, mIdMonedaDolar = 2, mCotizacionDolar = 0, mCotizacionEuro = 0;
    fecha = $("#FechaOrdenPago").val();
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
                datos1 = datos.campo5;
                mCotizacionEuro = parseFloat(datos1.replace(",", ".") || 0) || 0;
            } else { alert('No se pudo completar la operacion.'); }
        },
        error: function (xhr, textStatus, exceptionThrown) {
            alert('No hay cotizacion, ingresela manualmente');
            $('#CotizacionMoneda').val("");
        }
    });

    if (IdMoneda == mIdMonedaPrincipal) {
        $('#CotizacionMoneda').val("1");
        $("#CotizacionDolar").val(mCotizacionDolar.toFixed(2));
        $("#CotizacionEuro").val(mCotizacionEuro.toFixed(2));
    }
    else {
        if (IdMoneda == mIdMonedaDolar) {
            $("#CotizacionMoneda").val(mCotizacionDolar.toFixed(2));
            $("#CotizacionDolar").val(mCotizacionDolar.toFixed(2));
            $("#CotizacionEuro").val(mCotizacionEuro.toFixed(2));
        }
    }
};

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

function DatosCuenta(IdCuenta, origen, rowid, campo) {
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'Cuenta/TraerUna/',
        data: { IdCuenta: IdCuenta },
        dataType: "json",
        success: function (data) {
            if (data.length > 0) {
                var EsCajaBanco = data[0].EsCajaBanco;
                if (origen == "p") {
                    $("#IdCuenta").val(IdCuenta);
                    if (campo == "Codigo") { $("#CodigoCuenta").val(data[0].codigo); }
                } else {
                    $("#ListaContable").setColProp('CuentaBancaria', { editoptions: { dataUrl: ROOT + 'Banco/GetCuentasBancariasPorIdCuenta2?IdCuenta=' + IdCuenta } });
                    $("#ListaContable").setColProp('Caja', { editoptions: { dataUrl: ROOT + 'Caja/GetCajasPorIdCuenta2?IdCuenta=' + IdCuenta } });
                    $("#ListaContable").setColProp('TarjetaCredito', { editoptions: { dataUrl: ROOT + 'Banco/GetTarjetasCreditoPorIdCuenta2?IdCuenta=' + IdCuenta } });

                    if (origen == "f") {
                        if (campo == "Codigo") { $("#Codigo").val(data[0].codigo); }
                        if (campo == "Cuenta") { $("#Cuenta").val(data[0].descripcion); }
                    } else {
                        if (campo == "Codigo") { $('#ListaContable').jqGrid('setCell', rowid, 'Codigo', data[0].codigo); }
                        if (campo == "Cuenta") { $('#ListaContable').jqGrid('setCell', rowid, 'Cuenta', data[0].descripcion); }
                    }
                }
            }
            else {
                if (origen == "p") {
                    if (campo == "Codigo") { $("#CodigoCuenta").val(""); }
                } else {
                    if (origen == "f") {
                        if (campo == "Codigo") { $("#Codigo").val(""); }
                        if (campo == "Cuenta") { $("#Cuenta").val(""); }
                    } else {
                        if (campo == "Codigo") { $('#ListaContable').jqGrid('setCell', rowid, 'Codigo', ""); }
                        if (campo == "Cuenta") { $('#ListaContable').jqGrid('setCell', rowid, 'Cuenta', ""); }
                    }
                }
            }
        }
    });
}

function TraerCuentaPorCodigo(CodigoCuenta) {
    var IdCuenta = 0;
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Cuenta/GetCuentaPorCodigo/',
        data: { CodigoCuenta: CodigoCuenta },
        success: function (result) {
            if (result.length > 0) {
                datos = result[0].id;
            }
        }
    });
    return IdCuenta;
}

function TraerIdOrdenPagoPorNumero(NumeroOrdenPago) {
    var datos, IdOrdenPago = 0, Tipo = "", Valores = 0;
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'OrdenPago/GetIdOrdenPagoPorNumero/',
        data: { NumeroOrdenPago: NumeroOrdenPago },
        success: function (result) {
            if (result.length > 0) {
                datos = result[0]
                //datos = result[0].id;
                //Tipo = result[0].Tipo;
                //Valores = result[0].Valores;
                //IdOrdenPago = parseInt(datos || 0) || 0;
            }
        }
    });
    return datos;
}

function TraerCuentasBancarias(IdCuenta) {
    var OpcionesSelect = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Banco/GetCuentasBancariasPorIdCuenta/?IdCuenta=' + IdCuenta + '&Filler="' + IdCuenta + '"',
        success: function (result) {
            for (var i = 0; i < result.length; i++) {
                var data = result[i]
                OpcionesSelect += '<option value="' + data.id + '">' + data.value + '</option>';
            }
        }
    });
    return OpcionesSelect;
}

function TraerCajas(IdCuenta) {
    var OpcionesSelect = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Banco/GetCajasPorIdCuenta/?IdCuenta=' + IdCuenta + '&Filler="' + IdCuenta + '"',
        success: function (result) {
            for (var i = 0; i < result.length; i++) {
                var data = result[i]
                OpcionesSelect += '<option value="' + data.id + '">' + data.value + '</option>';
            }
        }
    });
    return OpcionesSelect;
}

function TraerTarjetasCredito(IdCuenta) {
    var OpcionesSelect = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Banco/GetTarjetasCreditoPorIdCuenta/?IdCuenta=' + IdCuenta + '&Filler="' + IdCuenta + '"',
        success: function (result) {
            for (var i = 0; i < result.length; i++) {
                var data = result[i]
                OpcionesSelect += '<option value="' + data.id + '">' + data.value + '</option>';
            }
        }
    });
    return OpcionesSelect;
}

function TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, Origen) {
    var OpcionesSelect = "", IdCuenta = 0;
    if (IdObra.length == 0) { IdObra = 0 };
    if (IdCuentaGasto.length == 0) { IdCuentaGasto = 0 };
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Cuenta/GetCuentasPorIdObraIdCuentaGasto/', 
        data: { IdObra: IdObra, IdCuentaGasto: IdCuentaGasto },
        success: function (result) {
            var a = result;
            for (var i = 0; i < result.length; i++) {
                var data = result[i]
                OpcionesSelect += '<option value="' + data.id + '">' + data.value + '</option>';
                if (IdCuenta == 0) { IdCuenta = data.id };
            }
            DatosCuenta(IdCuenta, Origen, 0, "Codigo");
        }
    });
    return OpcionesSelect;
}

function TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, Origen) {
    var OpcionesSelect = "", IdCuenta = 0;
    if (IdTipoCuentaGrupo.length == 0) { IdTipoCuentaGrupo = 0 };
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Cuenta/GetCuentasPorIdTipoCuentaGrupo/', 
        data: { IdTipoCuentaGrupo: IdTipoCuentaGrupo },
        success: function (result) {
            var a = result;
            for (var i = 0; i < result.length; i++) {
                var data = result[i]
                OpcionesSelect += '<option value="' + data.id + '">' + data.value + '</option>';
                if (IdCuenta == 0) { IdCuenta = data.id };
            }
            DatosCuenta(IdCuenta, Origen, 0, "Codigo");
        }
    });
    return OpcionesSelect;
}

function TraerChequerasPorIdCuentaBancaria(IdCuentaBancaria) {
    var OpcionesSelect = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Banco/GetChequerasPorIdCuentaBancaria/',
        data: { IdCuentaBancaria: IdCuentaBancaria },
        success: function (result) {
            for (var i = 0; i < result.length; i++) {
                var data = result[i]
                OpcionesSelect += '<option value="' + data.id + '">' + data.value + '</option>';
            }
        }
    });
    return OpcionesSelect;
}

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
                addCaption: "Datos anticipo", bSubmit: "Aceptar", bCancel: "Cancelar", width: 400, reloadAfterSubmit: false,
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
                    $('#tr_IdDetalleOrdenPago', form).hide();
                    $('#tr_IdImputacion', form).hide();
                    $('#tr_IdTipoRetencionGanancia', form).hide();
                    $('#tr_IdIBCondicion', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleOrdenPago', form).val(0);
                    $('#Importe', form).val(0);
                    $('#SinImpuestos', form).val(0);
                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    postdata.CategoriaIIBB = $("#CategoriaIIBB").children("option").filter(":selected").text()
                    postdata.CategoriaGanancias = $("#CategoriaGanancias").children("option").filter(":selected").text()
                    postdata.Tipo = "PA"
                    postdata.IdImputacion = -1
                    return [true, ''];
                }
            });
};

function AgregarValor(grid) {
    $("#ListaValores").setColProp('Entidad', { editoptions: { dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=1' }, formoptions: { label: 'Banco - Cuenta' } });
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Ingreso de valores", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,
                closeOnEscape: true,
                closeAfterAdd: true,
                recreateForm: true,
                afterShowForm: function (form) {
                    $("#sData").attr("class", "btn btn-primary");
                    $("#sData").css("color", "white");
                    $("#sData").css("margin-right", "20px");
                    $("#cData").attr("class", "btn");
                },
                beforeShowForm: function (form) {
                    PopupCentrar(grid);
                    $('#tr_IdDetalleOrdenPagoValores', form).hide();
                    $('#tr_IdTipoValor', form).hide();
                    $('#tr_IdBanco', form).hide();
                    $('#tr_IdValor', form).hide();
                    $('#tr_IdCuentaBancaria', form).hide();
                    $('#tr_IdBancoChequera', form).hide();
                    $('#tr_IdCaja', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleOrdenPagoValores', form).val(0);
                    $('#NumeroValor', form).val(0);
                    $('#Importe', form).val(0);
                    var now = new Date();
                    var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                    $('#FechaValor', form).val(currentDate);
                    AsignarNumeroInterno(form);
                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    var SelectOpcional;

                    SelectOpcional = $("#Tipo").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.Tipo = SelectOpcional.text();
                    }

                    SelectOpcional = $("#Entidad").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.Entidad = SelectOpcional.text();
                    }

                    SelectOpcional = $("#Chequera").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.Chequera = SelectOpcional.text();
                        postdata.IdBancoChequera = SelectOpcional.val();
                    }
                    return [true, ''];
                }
            });
};

function AgregarCaja(grid) {
    $("#ListaValores").setColProp('Entidad', { editoptions: { dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=4' }, formoptions: { label: 'Caja' } });
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Pago con caja", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,
                closeOnEscape: true,
                closeAfterAdd: true,
                recreateForm: true,
                afterShowForm: function (form) {
                    $("#sData").attr("class", "btn btn-primary");
                    $("#sData").css("color", "white");
                    $("#sData").css("margin-right", "20px");
                    $("#cData").attr("class", "btn");
                },
                beforeShowForm: function (form) {
                    PopupCentrar(grid);
                    $('#tr_IdDetalleOrdenPagoValores', form).hide();
                    $('#tr_IdTipoValor', form).hide();
                    $('#tr_IdBanco', form).hide();
                    $('#tr_IdValor', form).hide();
                    $('#tr_IdCuentaBancaria', form).hide();
                    $('#tr_IdBancoChequera', form).hide();
                    $('#tr_IdCaja', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();
                    $('#tr_Tipo', form).hide();
                    $('#tr_NumeroInterno', form).hide();
                    $('#tr_NumeroValor', form).hide();
                    $('#tr_FechaValor', form).hide();
                    $('#tr_ChequesALaOrdenDe', form).hide();
                    $('#tr_Chequera', form).hide();
                    $('#tr_NoALaOrden', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleOrdenPagoValores', form).val(0);
                    $('#Importe', form).val(0);
                    $('#IdCaja').val(-1);

                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: ROOT + 'Parametro/Parametros/',
                        async: false,
                        dataType: "Json",
                        success: function (data) {
                            var data2 = data[0]
                            $('#IdTipoValor', form).val(data2.IdTipoComprobanteCajaEgresos);
                        }
                    });

                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    postdata.Tipo = "CE";
                    postdata.Entidad = $("#Entidad").children("option").filter(":selected").text();
                    postdata.NumeroInterno = "";
                    postdata.NumeroValor = "";
                    return [true, ''];
                }
            });
};

function AgregarCuenta(grid) {
    //grid.setColProp('Cuenta', { editoptions: { dataUrl: ROOT + 'Cuenta/GetCuentas2' }, formoptions: { label: 'Cuenta' } });
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Ingreso de item contable", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,
                closeOnEscape: true,
                closeAfterAdd: true,
                recreateForm: true,
                afterShowForm: function (form) {
                    $("#sData").attr("class", "btn btn-primary");
                    $("#sData").css("color", "white");
                    $("#sData").css("margin-right", "20px");
                    $("#cData").attr("class", "btn");
                },
                beforeShowForm: function (form) {
                    PopupCentrar(grid);
                    $('#tr_IdDetalleOrdenPagoCuentas', form).hide();
                    $('#tr_IdCuenta', form).hide();
                    $('#tr_IdObra', form).hide();
                    $('#tr_IdCuentaGasto', form).hide();
                    $('#tr_IdCuentaBancaria', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();
                    $('#tr_IdMoneda', form).hide();
                    $('#tr_CotizacionMonedaDestino', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleOrdenPagoCuentas', form).val(0);
                    $('#Debe', form).val(0);
                    $('#Haber', form).val(0);
                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    var SelectOpcional;
                    postdata.Cuenta = $("#Cuenta").children("option").filter(":selected").text();

                    SelectOpcional = $("#CuentaBancaria").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.CuentaBancaria = SelectOpcional.text();
                        postdata.IdCuentaBancaria = SelectOpcional.val();
                    }

                    SelectOpcional = $("#Caja").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.Caja = SelectOpcional.text();
                        postdata.IdCaja = SelectOpcional.val();
                    }

                    SelectOpcional = $("#TarjetaCredito").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.TarjetaCredito = SelectOpcional.text();
                        postdata.IdTarjetaCredito = SelectOpcional.val();
                    }

                    SelectOpcional = $("#Obra").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.Obra = SelectOpcional.text();
                        postdata.IdObra = SelectOpcional.val();
                    }

                    SelectOpcional = $("#CuentaGasto").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.CuentaGasto = SelectOpcional.text();
                        postdata.IdCuentaGasto = SelectOpcional.val();
                    }

                    SelectOpcional = $("#TipoCuentaGrupo").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.TipoCuentaGrupo = SelectOpcional.text();
                        postdata.IdTipoCuentaGrupo = SelectOpcional.val();
                    }
                    return [true, ''];
                }
            });
};

function AsignarNumeroInterno(form) {
    var NumeroInterno, $grid, dataIds, data, valor, i;
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'Parametro/Parametros/',
        async: false,
        dataType: "Json",
        success: function (data) {
            var data2 = data[0]
            NumeroInterno = data2.ProximoNumeroInternoChequeEmitido;
            $grid = $('#ListaValores');
            dataIds = $grid.jqGrid('getDataIDs');
            for (i = 0; i < dataIds.length; i++) {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                valor = data["NumeroInterno"];
                if (valor >= NumeroInterno) { NumeroInterno = parseInt(valor) + 1; }
            };
            $('#NumeroInterno', form).val(NumeroInterno);
        }
    });
}

function AsignarNumeroValor(IdBancoChequera) {
    var NumeroValor, $grid, dataIds, data, valor, valor2, i;
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'Banco/GetChequerasPorId/',
        data: { IdBancoChequera: IdBancoChequera },
        async: false,
        dataType: "Json",
        success: function (data) {
            var data2 = data[0]
            NumeroValor = data2.value;
            $grid = $('#ListaValores');
            dataIds = $grid.jqGrid('getDataIDs');
            for (i = 0; i < dataIds.length; i++) {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                valor = data["NumeroValor"];
                valor2 = data["IdBancoChequera"];
                if (valor >= NumeroValor && valor2 == IdBancoChequera) { NumeroValor = parseInt(valor) + 1; }
            };
            $('#NumeroValor').val(NumeroValor);
        }
    });
}

function AsignarBancoPorIdCuentaBancaria(IdCuentaBancaria) {
    var IdBanco, $grid, dataIds, data, valor, i;
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'Banco/GetCuentasBancariasPorId/',
        data: { IdCuentaBancaria: IdCuentaBancaria },
        async: false,
        dataType: "Json",
        success: function (data) {
            var data2 = data[0]
            IdBanco = data2.IdBanco;
            $('#IdBanco').val(IdBanco);
        }
    });
}

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

function deshabilitar() {
    $("#formid *").not("#Lista").not(".ui-jqgrid").attr("disabled", "disabled");
    $.blockUI.defaults.css.cursor = 'default';
    $.blockUI.defaults.overlayCSS.cursor = 'default';

    $("#Lista").block({ // para que solo bloquee el contenido y me deje scrollear, saqué el 'closest'
        message: "",
        theme: true,
        themedCSS: {
            width: "35%",
            left: "30%"
        }
    });
    var $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Agregar anticipo"]');
    $td.hide();
    var $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
    $td.hide();

    $("#ListaContable").block({
        message: "",
        theme: true,
    });

    $("#ListaValores").block({
        message: "",
        theme: true,
    });
    var $td = $($("#ListaValores")[0].p.pager + '_left ' + 'td[title="Agregar valor"]');
    $td.hide();
    var $td = $($("#ListaValores")[0].p.pager + '_left ' + 'td[title="Agregar caja"]');
    $td.hide();
    var $td = $($("#ListaValores")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
    $td.hide();

    $("#ListaRubrosContables").block({
        message: "",
        theme: true,
    });
    var $td = $($("#ListaRubrosContables")[0].p.pager + '_left ' + 'td[title="Agregar rubro contable"]');
    $td.hide();
    var $td = $($("#ListaRubrosContables")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
    $td.hide();

    $("#ListaImpuestos").block({
        message: "",
        theme: true,
    });

    $("#ListaDrag").block({
        message: "",
        theme: true,
    });

    $("#ListaDrag2").block({
        message: "",
        theme: true,
    });
};

function ActivarAsientoManual(Activar) {
    var $td;
    if (Activar) {
        $("#ListaContable").unblock({
            message: "",
            theme: true,
        });

        $td = $($("#ListaContable")[0].p.pager + '_left ' + 'td[title="Agregar item"]');
        $td.show();
        $td = $($("#ListaContable")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.show();
    } else {
        $td = $($("#ListaContable")[0].p.pager + '_left ' + 'td[title="Agregar item"]');
        $td.hide();
        $td = $($("#ListaContable")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.hide();

        $("#ListaContable").block({
            message: "",
            theme: true,
        });
    }
};
