var MARGENSUPERIOR = 50;

$(function () {

    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, mTotalImputaciones, mTotalValores, mRetencionIva, mRetencionGanancias, mOtrosConceptos, mTotalDiferenciaBalanceo, IdObra, IdCuentaGasto, newOptions;

    pageLayout.show('east');
    pageLayout.close('east');

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
    TraerCodigosCuentas()

    //$('.collapse').on('shown.bs.collapse', function () {
    //    $(this).parent().find(".glyphicon-plus").removeClass("glyphicon-plus").addClass("glyphicon-minus");
    //}).on('hidden.bs.collapse', function () {
    //    $(this).parent().find(".glyphicon-minus").removeClass("glyphicon-minus").addClass("glyphicon-plus");
    //});

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
        if (colname === "Cobrado") {
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
        url: ROOT + 'Recibo/DetRecibosImputaciones/',
        postData: { 'IdRecibo': function () { return $("#IdRecibo").val(); } },
        editurl: ROOT + 'Recibo/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleRecibo', 'IdImputacion', 'CotizacionMoneda', 'IdTipoComp', 'IdComprobante', 'Tipo', 'Numero ', 'Fecha', 'Imp. Orig.', 'Saldo', 'Cobrado'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleRecibo', index: 'IdDetalleRecibo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdImputacion', index: 'IdImputacion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'CotizacionMoneda', index: 'CotizacionMoneda', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdTipoComp', index: 'IdTipoComp', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdComprobante', index: 'IdComprobante', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'Tipo', index: 'Tipo', width: 35, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Numero', index: 'Numero', width: 110, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Fecha', index: 'Fecha', width: 75, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteOriginal', index: 'ImporteOriginal', width: 75, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Saldo', index: 'Saldo', width: 75, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    {
                        name: 'Importe', index: 'Importe', width: 80, align: 'right', editable: true, editrules: { custom: true, custom_func: ControlImportes, required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#Lista').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 45 && key !== 8 && key !== 37 && key !== 39) { return false; }
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
        caption: 'IMPUTACIONES',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar pago anticipado",
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
        url: ROOT + 'Recibo/DetRecibosValores/',
        postData: { 'IdRecibo': function () { return $("#IdRecibo").val(); } },
        editurl: ROOT + 'Recibo/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleReciboValores', 'IdTipoValor', 'IdBanco', 'IdCuentaBancariaTransferencia', 'IdCaja', 'IdTarjetaCredito',
                    'Tipo', 'Fecha Vto.', 'Nro. int.', 'Nro. valor', 'Importe', 'Banco', 'Cuit librador', 'Cuenta bancaria (transferencias)', 'Nro. transf.', 'Caja',
                    'Tarjeta de credito', 'Nro. tarjeta', 'Exp. tarjeta', 'Cuotas'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleReciboValores', index: 'IdDetalleReciboValores', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdTipoValor', index: 'IdTipoValor', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdBanco', index: 'IdBanco', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdCuentaBancariaTransferencia', index: 'IdCuentaBancariaTransferencia', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdCaja', index: 'IdCaja', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    { name: 'IdTarjetaCredito', index: 'IdTarjetaCredito', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }, label: 'TB' },
                    {
                        name: 'Tipo', index: 'Tipo', formoptions: { rowpos: 2, colpos: 1 }, align: 'left', width: 50, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Valor/GetTiposValores',
                            dataInit: function (elem) {
                                $(elem).width(40);
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
                        name: 'FechaVencimiento', index: 'FechaVencimiento', formoptions: { rowpos: 2, colpos: 2 }, width: 100, sortable: false, align: 'right', editable: true, label: 'TB',
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
                        name: 'NumeroInterno', index: 'NumeroInterno', formoptions: { rowpos: 3, colpos: 1 }, width: 70, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                        name: 'NumeroValor', index: 'NumeroValor', formoptions: { rowpos: 3, colpos: 2 }, width: 100, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                        name: 'Importe', index: 'Importe', formoptions: { rowpos: 9, colpos: 1 }, width: 90, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                        name: 'Banco', index: 'Banco', formoptions: { rowpos: 4, colpos: 1 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetBancos',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdBanco').val(this.value);
                                        $('#IdCuentaBancariaTransferencia').val("");
                                        $('#IdCaja').val("");
                                        $('#IdTarjetaCredito').val("");
                                        $('#CuentaBancaria').val("");
                                        $('#Caja').val("");
                                        $('#TarjetaCredito').val("");
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaValores').getGridParam('selrow');
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdBanco', this.value);
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCuentaBancariaTransferencia', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCaja', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdTarjetaCredito', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'CuentaBancaria', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'Caja', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'TarjetaCredito', "");
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    { name: 'CuitLibrador', index: 'CuitLibrador', formoptions: { rowpos: 4, colpos: 2 }, width: 90, align: 'left', editable: true, editrules: { required: false }, edittype: "text", label: 'TB' },
                    {
                        name: 'CuentaBancariaTransferencia', index: 'CuentaBancariaTransferencia', formoptions: { rowpos: 5, colpos: 1 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetCuentasBancariasPorIdCuenta2',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdBanco').val("");
                                        $('#IdCuentaBancariaTransferencia').val(this.value);
                                        $('#IdCaja').val("");
                                        $('#IdTarjetaCredito').val("");
                                        $('#Banco').val("");
                                        $('#Caja').val("");
                                        $('#TarjetaCredito').val("");
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaValores').getGridParam('selrow');
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdBanco', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCuentaBancariaTransferencia', this.value);
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCaja', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdTarjetaCredito', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'Banco', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'Caja', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'TarjetaCredito', "");
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'NumeroTransferencia', index: 'NumeroTransferencia', formoptions: { rowpos: 5, colpos: 2 }, width: 100, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                        name: 'Caja', index: 'Caja', formoptions: { rowpos: 6, colpos: 1 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Caja/GetCajasPorIdCuenta2',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdBanco').val("");
                                        $('#IdCuentaBancariaTransferencia').val("");
                                        $('#IdCaja').val(this.value);
                                        $('#IdTarjetaCredito').val("");
                                        $('#Banco').val("");
                                        $('#CuentaBancaria').val("");
                                        $('#TarjetaCredito').val("");
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaValores').getGridParam('selrow');
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdBanco', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCuentaBancariaTransferencia', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCaja', this.value);
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdTarjetaCredito', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'Banco', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'CuentaBancaria', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'TarjetaCredito', "");
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'TarjetaCredito', index: 'TarjetaCredito', formoptions: { rowpos: 7, colpos: 1 }, align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetTarjetasCreditoPorIdCuenta2',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdBanco').val("");
                                        $('#IdCuentaBancariaTransferencia').val("");
                                        $('#IdCaja').val("");
                                        $('#IdTarjetaCredito').val(this.value);
                                        $('#Banco').val("");
                                        $('#CuentaBancaria').val("");
                                        $('#Caja').val("");
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaValores').getGridParam('selrow');
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdBanco', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCuentaBancariaTransferencia', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdCaja', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdTarjetaCredito', this.value);
                                            $('#ListaValores').jqGrid('setCell', rowid, 'Banco', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'CuentaBancaria', "");
                                            $('#ListaValores').jqGrid('setCell', rowid, 'Caja', "");
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'NumeroTarjetaCredito', index: 'NumeroTarjetaCredito', formoptions: { rowpos: 7, colpos: 2 }, width: 120, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                    { name: 'FechaExpiracionTarjetaCredito', index: 'FechaExpiracionTarjetaCredito', formoptions: { rowpos: 8, colpos: 1 }, width: 80, align: 'center', editable: true, editrules: { required: false }, edittype: "text", label: 'TB' },
                    {
                        name: 'CantidadCuotas', index: 'CantidadCuotas', formoptions: { rowpos: 8, colpos: 2 }, width: 50, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                    }
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
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'NumeroTransferencia', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'NumeroTarjetaCredito', '', 'not-editable-cell');
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'FechaVencimiento', '', 'not-editable-cell');
            }
        },
        afterSaveCell: function (rowid) {
            calculaTotalValores();
        },
        pager: $('#ListaPager3'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleReciboValores',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '150px',
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
                                        caption: "", buttonicon: "ui-icon-contact", title: "Agregar tarjeta",
                                        onClickButton: function () {
                                            AgregarTarjeta(jQuery("#ListaValores"));
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
        url: ROOT + 'Recibo/DetRecibosCuentas/',
        postData: { 'IdRecibo': function () { return $("#IdRecibo").val(); } },
        editurl: ROOT + 'Recibo/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleReciboCuentas', 'IdCuenta', 'IdObra', 'IdCuentaGasto', 'IdCuentaBancaria', 'IdCaja', 'IdMoneda', 'CotizacionMonedaDestino', 'IdTipoCuentaGrupo',
                   'Codigo', 'Cuenta', 'Debe', 'Haber', 'Cuenta bancaria', 'Caja', 'Obra', 'Cuenta de gasto', 'Grupo cuenta'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleReciboCuentas', index: 'IdDetalleReciboCuentas', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdCuenta', index: 'IdCuenta', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdObra', index: 'IdObra', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCuentaGasto', index: 'IdCuentaGasto', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCaja', index: 'IdCaja', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdMoneda', index: 'IdMoneda', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'CotizacionMonedaDestino', index: 'CotizacionMonedaDestino', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdTipoCuentaGrupo', index: 'IdTipoCuentaGrupo', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    {
                        name: 'Codigo', index: 'Codigo', formoptions: { rowpos: 5, colpos: 1 }, align: 'center', width: 80, editable: true, hidden: false, edittype: 'text', editrules: { edithidden: false, required: true },
                        editoptions: {
                            dataInit: function (elem) {
                                $(elem).width(75);
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

                                                DatosCuenta(IdCuenta, "f", "0", "Codigo","");
                                            } else {
                                                $td = $this.closest("td");
                                                if ($td.hasClass("edit-cell")) {
                                                    // cell editing
                                                    var rowid = $('#ListaContable').getGridParam('selrow');
                                                    $('#ListaContable').jqGrid('setCell', rowid, 'IdCuenta', IdCuenta);
                                                    $('#ListaContable').jqGrid('setCell', rowid, 'Cuenta', ui.value);
                                                    DatosCuenta(IdCuenta, "c", rowid, "Codigo","");
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
                                $(elem).width(195);
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

                                        DatosCuenta(IdCuenta, "f", "0", "Codigo","");
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaContable').getGridParam('selrow');
                                            $('#ListaContable').jqGrid('setCell', rowid, 'IdCuenta', IdCuenta);
                                            DatosCuenta(IdCuenta, "c", rowid, "Codigo","");
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'Debe', index: 'Debe', formoptions: { rowpos: 8, colpos: 1 }, width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                        name: 'Haber', index: 'Haber', formoptions: { rowpos: 8, colpos: 2 }, width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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

                                        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "f", "");
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

                                        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "f", "");
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
        sortname: 'IdDetalleReciboCuentas',
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
    jQuery("#ListaContable").jqGrid('navButtonAdd', '#ListaPager2',
                                    {
                                        caption: "", buttonicon: "ui-icon-refresh", title: "Recalcular",
                                        onClickButton: function () {
                                            ActualizarDatosContables();
                                        },
                                    });


    $('#ListaRubrosContables').jqGrid({
        url: ROOT + 'Recibo/DetRecibosRubrosContables/',
        postData: { 'IdRecibo': function () { return $("#IdRecibo").val(); } },
        editurl: ROOT + 'Recibo/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleReciboRubrosContables', 'IdRubroContable', 'Rubro contable', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleReciboRubrosContables', index: 'IdDetalleReciboRubrosContables', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRubroContable', index: 'IdRubroContable', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    {
                        name: 'RubroContable', index: 'RubroContable', align: 'left', width: 250, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'RubroContable/GetRubrosContables',
                            dataInit: function (elem) {
                                $(elem).width(245);
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
                        name: 'Importe', index: 'Importe', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
        sortname: 'IdDetalleReciboRubrosContables',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '100px', // 'auto',
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


    $("#ListaDrag").jqGrid({
        url: ROOT + 'CuentaCorriente/CuentaCorrienteDeudoresPendientePorCliente_DynamicGridData',
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
    


        
        ///////////////////////////////
        ///////////////////////////////

     pager: $('#ListaDragPager'),
    rowNum: 15,
    rowList: [10, 20, 50],
    sortname: 'Fecha',//,NumeroOrdenCompra',
    sortorder: "desc",
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
    userDataOnFooter: true
    // ,caption: '<b>PEDIDOS</b>'

    , gridview: true
    , multiboxonly: true
    , multipleSearch: true



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
                        data2.IdDetalleRecibo = Id2;

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

    //////////////////////////////////// CHANGES ///////////////////////////////////////////////

    $("#IdPuntoVenta").change(function () {
        TraerNumeroComprobante()
    });

    $("#AsientoManual").change(function () {
        ActivarAsientoManual($("#AsientoManual").is(':checked'));
    });

    $('select#IdCuenta').change(function () {
        DatosCuenta($(this).val(), "p", 0, "Codigo","");
    });
    $('select#IdCuenta1').change(function () {
        DatosCuenta($(this).val(), "p", 0, "Codigo", "1");
    });
    $('select#IdCuenta2').change(function () {
        DatosCuenta($(this).val(), "p", 0, "Codigo", "2");
    });
    $('select#IdCuenta3').change(function () {
        DatosCuenta($(this).val(), "p", 0, "Codigo", "3");
    });
    $('select#IdCuenta4').change(function () {
        DatosCuenta($(this).val(), "p", 0, "Codigo", "4");
    });
    $('select#IdCuenta5').change(function () {
        DatosCuenta($(this).val(), "p", 0, "Codigo", "5");
    });

    $('#CodigoCuenta').change(function () {
        var CodigoCuenta = $(this).val();
        var IdCuenta = TraerCuentaPorCodigo(CodigoCuenta);
        $('select#IdCuenta').val(IdCuenta);

        newOptions = TraerCuentaPorCodigo2(CodigoCuenta);
        if (newOptions.length > 0) {
            $("select#IdCuenta").empty();
            $("select#IdCuenta").append(newOptions);
        }
    });
    $('#CodigoCuenta1').change(function () {
        var CodigoCuenta = $(this).val();
        var IdCuenta = TraerCuentaPorCodigo(CodigoCuenta);
        $('select#IdCuenta1').val(IdCuenta);

        newOptions = TraerCuentaPorCodigo2(CodigoCuenta);
        if (newOptions.length > 0) {
            $("select#IdCuenta1").empty();
            $("select#IdCuenta1").append(newOptions);
        }
    });
    $('#CodigoCuenta2').change(function () {
        var CodigoCuenta = $(this).val();
        var IdCuenta = TraerCuentaPorCodigo(CodigoCuenta);
        $('select#IdCuenta2').val(IdCuenta);

        newOptions = TraerCuentaPorCodigo2(CodigoCuenta);
        if (newOptions.length > 0) {
            $("select#IdCuenta2").empty();
            $("select#IdCuenta2").append(newOptions);
        }
    });
    $('#CodigoCuenta3').change(function () {
        var CodigoCuenta = $(this).val();
        var IdCuenta = TraerCuentaPorCodigo(CodigoCuenta);
        $('select#IdCuenta3').val(IdCuenta);

        newOptions = TraerCuentaPorCodigo2(CodigoCuenta);
        if (newOptions.length > 0) {
            $("select#IdCuenta3").empty();
            $("select#IdCuenta3").append(newOptions);
        }
    });
    $('#CodigoCuenta4').change(function () {
        var CodigoCuenta = $(this).val();
        var IdCuenta = TraerCuentaPorCodigo(CodigoCuenta);
        $('select#IdCuenta4').val(IdCuenta);

        newOptions = TraerCuentaPorCodigo2(CodigoCuenta);
        if (newOptions.length > 0) {
            $("select#IdCuenta4").empty();
            $("select#IdCuenta4").append(newOptions);
        }
    });
    $('#CodigoCuenta5').change(function () {
        var CodigoCuenta = $(this).val();
        var IdCuenta = TraerCuentaPorCodigo(CodigoCuenta);
        $('select#IdCuenta5').val(IdCuenta);

        newOptions = TraerCuentaPorCodigo2(CodigoCuenta);
        if (newOptions.length > 0) {
            $("select#IdCuenta5").empty();
            $("select#IdCuenta5").append(newOptions);
        }
    });

    $('select#IdObra').change(function () {
        IdObra = $(this).val();
        IdCuentaGasto = $('select#IdCuentaGasto').val() || 0;
        $("#CodigoCuenta").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "");
        if (newOptions.length > 0) {
            $("select#IdCuenta").empty();
            $("select#IdCuenta").append(newOptions);
        }
    });
    $('select#IdObra1').change(function () {
        IdObra = $(this).val();
        IdCuentaGasto = $('select#IdCuentaGasto1').val() || 0;
        $("#CodigoCuenta1").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "1");
        if (newOptions.length > 0) {
            $("select#IdCuenta1").empty();
            $("select#IdCuenta1").append(newOptions);
        }
    });
    $('select#IdObra2').change(function () {
        IdObra = $(this).val();
        IdCuentaGasto = $('select#IdCuentaGasto2').val() || 0;
        $("#CodigoCuenta2").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "2");
        if (newOptions.length > 0) {
            $("select#IdCuenta2").empty();
            $("select#IdCuenta2").append(newOptions);
        }
    });
    $('select#IdObra3').change(function () {
        IdObra = $(this).val();
        IdCuentaGasto = $('select#IdCuentaGasto3').val() || 0;
        $("#CodigoCuenta3").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "3");
        if (newOptions.length > 0) {
            $("select#IdCuenta3").empty();
            $("select#IdCuenta3").append(newOptions);
        }
    });
    $('select#IdObra4').change(function () {
        IdObra = $(this).val();
        IdCuentaGasto = $('select#IdCuentaGasto4').val() || 0;
        $("#CodigoCuenta4").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "4");
        if (newOptions.length > 0) {
            $("select#IdCuenta4").empty();
            $("select#IdCuenta4").append(newOptions);
        }
    });
    $('select#IdObra5').change(function () {
        IdObra = $(this).val();
        IdCuentaGasto = $('select#IdCuentaGasto5').val() || 0;
        $("#CodigoCuenta5").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "5");
        if (newOptions.length > 0) {
            $("select#IdCuenta5").empty();
            $("select#IdCuenta5").append(newOptions);
        }
    });

    $('select#IdCuentaGasto').change(function () {
        IdCuentaGasto = $(this).val();
        IdObra = $('select#IdObra').val() || 0;
        $("#CodigoCuenta").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "");
        if (newOptions.length > 0) {
            $("select#IdCuenta").empty();
            $("select#IdCuenta").append(newOptions);
        }
    });
    $('select#IdCuentaGasto1').change(function () {
        IdCuentaGasto = $(this).val();
        IdObra = $('select#IdObra1').val() || 0;
        $("#CodigoCuenta1").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "1");
        if (newOptions.length > 0) {
            $("select#IdCuenta1").empty();
            $("select#IdCuenta1").append(newOptions);
        }
    });
    $('select#IdCuentaGasto2').change(function () {
        IdCuentaGasto = $(this).val();
        IdObra = $('select#IdObra2').val() || 0;
        $("#CodigoCuenta2").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "2");
        if (newOptions.length > 0) {
            $("select#IdCuenta2").empty();
            $("select#IdCuenta2").append(newOptions);
        }
    });
    $('select#IdCuentaGasto3').change(function () {
        IdCuentaGasto = $(this).val();
        IdObra = $('select#IdObra3').val() || 0;
        $("#CodigoCuenta3").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "3");
        if (newOptions.length > 0) {
            $("select#IdCuenta3").empty();
            $("select#IdCuenta3").append(newOptions);
        }
    });
    $('select#IdCuentaGasto4').change(function () {
        IdCuentaGasto = $(this).val();
        IdObra = $('select#IdObra4').val() || 0;
        $("#CodigoCuenta4").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "4");
        if (newOptions.length > 0) {
            $("select#IdCuenta4").empty();
            $("select#IdCuenta4").append(newOptions);
        }
    });
    $('select#IdCuentaGasto5').change(function () {
        IdCuentaGasto = $(this).val();
        IdObra = $('select#IdObra5').val() || 0;
        $("#CodigoCuenta5").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "5");
        if (newOptions.length > 0) {
            $("select#IdCuenta5").empty();
            $("select#IdCuenta5").append(newOptions);
        }
    });

    $('select#IdTipoCuentaGrupo').change(function () {
        IdTipoCuentaGrupo = $(this).val();
        $("#CodigoCuenta").val("");

        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "p", "");
        if (newOptions.length > 0) {
            $("select#IdCuenta").empty();
            $("select#IdCuenta").append(newOptions);
        }
    });
    $('select#IdTipoCuentaGrupo1').change(function () {
        IdTipoCuentaGrupo = $(this).val();
        $("#CodigoCuenta1").val("");

        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "p", "1");
        if (newOptions.length > 0) {
            $("select#IdCuenta1").empty();
            $("select#IdCuenta1").append(newOptions);
        }
    });
    $('select#IdTipoCuentaGrupo2').change(function () {
        IdTipoCuentaGrupo = $(this).val();
        $("#CodigoCuenta2").val("");

        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "p", "2");
        if (newOptions.length > 0) {
            $("select#IdCuenta2").empty();
            $("select#IdCuenta2").append(newOptions);
        }
    });
    $('select#IdTipoCuentaGrupo3').change(function () {
        IdTipoCuentaGrupo = $(this).val();
        $("#CodigoCuenta3").val("");

        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "p", "3");
        if (newOptions.length > 0) {
            $("select#IdCuenta3").empty();
            $("select#IdCuenta3").append(newOptions);
        }
    });
    $('select#IdTipoCuentaGrupo4').change(function () {
        IdTipoCuentaGrupo = $(this).val();
        $("#CodigoCuenta4").val("");

        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "p", "4");
        if (newOptions.length > 0) {
            $("select#IdCuenta4").empty();
            $("select#IdCuenta4").append(newOptions);
        }
    });
    $('select#IdTipoCuentaGrupo5').change(function () {
        IdTipoCuentaGrupo = $(this).val();
        $("#CodigoCuenta5").val("");

        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "p", "5");
        if (newOptions.length > 0) {
            $("select#IdCuenta5").empty();
            $("select#IdCuenta5").append(newOptions);
        }
    });

    $('#Otros1').change(function () { CalcularTotales(); });
    $('#Otros2').change(function () { CalcularTotales(); });
    $('#Otros3').change(function () { CalcularTotales(); });
    $('#Otros4').change(function () { CalcularTotales(); });
    $('#Otros5').change(function () { CalcularTotales(); });
    
    $('#RetencionIVA').change(function () { CalcularTotales(); });
    $('#RetencionGanancias').change(function () { CalcularTotales(); });

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var TipoOperacionOtros = $("input[name='TipoOperacionOtros']:checked").val();

        var cabecera = $("#formid").serializeObject();
        cabecera.IdCliente = $("#IdCliente").val();
        cabecera.IdCuenta = $("#IdCuenta").val();
        cabecera.GastosGenerales = $("#Diferencia").val() || 0;
        cabecera.IdPuntoVenta = $("#IdPuntoVenta").val();
        cabecera.PuntoVenta = $("#IdPuntoVenta").find('option:selected').text();
        cabecera.Cliente = "";

        var chk = $('#AsientoManual').is(':checked');
        if (chk) {
            cabecera.AsientoManual = "SI";
        } else {
            cabecera.AsientoManual = "NO";
        };

        cabecera.DetalleRecibosImputaciones = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleRecibo'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleRecibo":"' + iddeta + '",';
                data1 = data1 + '"IdRecibo":"' + $("#IdRecibo").val() + '",';
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
                cabecera.DetalleRecibosImputaciones.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleRecibosValores = [];
        $grid = $('#ListaValores');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleReciboValores'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleReciboValores":"' + iddeta + '",';
                data1 = data1 + '"IdRecibo":"' + $("#IdRecibo").val() + '",';
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
                cabecera.DetalleRecibosValores.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleRecibosCuentas = [];
        $grid = $('#ListaContable');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleReciboCuentas'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleReciboCuentas":"' + iddeta + '",';
                data1 = data1 + '"IdRecibo":"' + $("#IdRecibo").val() + '",';
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
                cabecera.DetalleRecibosCuentas.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleRecibosRubrosContables = [];
        $grid = $('#ListaRubrosContables');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleReciboRubrosContables'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleReciboRubrosContables":"' + iddeta + '",';
                data1 = data1 + '"IdRecibo":"' + $("#IdRecibo").val() + '",';
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
                cabecera.DetalleRecibosRubrosContables.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        return cabecera;
    }

    $('#grabar2').click(function () {
        ActualizarDatosContables();

        var cabecera = SerializaForm();

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Recibo/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Recibo: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    if ($('#Anulado').val() != "") {
                        window.location = (ROOT + "Recibo/index");
                    } else {
                        if ($('#Tipo').val() == "CC") { window.location = (ROOT + "Recibo/EditCC/" + result.IdRecibo); }
                        if ($('#Tipo').val() == "OT") { window.location = (ROOT + "Recibo/EditOT/" + result.IdRecibo); }
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

    function ActualizarDatosContables() {
        var AsientoManual = $("input[name='AsientoManual']:checked").val();
        if (AsientoManual != "true") {
            var datos = "";
            var cabecera = SerializaForm();
            $.ajax({
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                url: ROOT + 'Recibo/CalcularAsiento',
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
        }
    };

    $('#ActualizarDatos').click(function () {
        $('#ActualizarDatos').attr("disabled", true).val("Espere...");
        $('html, body').css('cursor', 'wait');
        ActualizarDatosContables();
        $('html, body').css('cursor', 'auto');
        $('#ActualizarDatos').attr("disabled", false).val("Recalcular");
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

function CalcularTotales() {
    var imp = 0;

    if (typeof mTotalImputaciones == "undefined") { mTotalImputaciones = 0; }
    if (typeof mTotalValores == "undefined") { mTotalValores = 0; }
    if (typeof mOtrosConceptos == "undefined") { mOtrosConceptos = 0; }

    mOtrosConceptos = 0;
    for (var i = 1; i <= 5; i++) {
        imp = parseFloat($("#Otros" + i).val().replace(",", ".") || 0) || 0;
        mOtrosConceptos += imp;
    }

    var mSubtotal = 0;
    mRetencionIva = parseFloat($("#RetencionIVA").val().replace(",", ".") || 0) || 0;
    mRetencionGanancias = parseFloat($("#RetencionGanancias").val().replace(",", ".") || 0) || 0;
    mSubtotal = mTotalImputaciones;

    $("#Valores").val(mTotalValores.toFixed(2));
    $("#Deudores").val(mTotalImputaciones.toFixed(2));
    $("#Subtotal").val(mSubtotal.toFixed(2));
    $("#OtrosConceptos").val(mOtrosConceptos.toFixed(2));
    mTotalDiferenciaBalanceo = mSubtotal - (mTotalValores + mRetencionIva + mRetencionGanancias + mOtrosConceptos);
    $("#Diferencia").val(mTotalDiferenciaBalanceo.toFixed(2));
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

function ActualizarDatos() {
    var id = 0;

    id = $("#IdCliente").val();
    if (id.length > 0) {
        MostrarDatosCliente(id);
    }

    $.ajax({
        type: "GET",
        async: false,
        url: ROOT + 'PuntoVenta/GetPuntosVenta2/',
        data: { IdTipoComprobante: 2, Letra: "X" },
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

function DatosCuenta(IdCuenta, origen, rowid, campo, indice) {
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
                    $("#IdCuenta" + indice).val(IdCuenta);
                    if (campo == "Codigo") { $("#CodigoCuenta" + indice).val(data[0].codigo); }
                    if (indice.length > 0) {
                        $("#IdObra" + indice).val(data[0].IdObra);
                        $("#IdCuentaGasto" + indice).val(data[0].IdCuentaGasto);
                        $("#IdTipoCuentaGrupo" + indice).val(data[0].IdTipoCuentaGrupo);
                    }
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
                    if (campo == "Codigo" + indice) { $("#CodigoCuenta").val(""); }
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

function TraerCuentaPorCodigo2(CodigoCuenta) {
    var OpcionesSelect = "", IdCuenta = 0;
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Cuenta/GetCuentaPorCodigo/',
        data: { CodigoCuenta: CodigoCuenta },
        success: function (result) {
            var a = result;
            for (var i = 0; i < result.length; i++) {
                var data = result[i]
                OpcionesSelect += '<option value="' + data.id + '">' + data.value + '</option>';
                if (IdCuenta == 0) { IdCuenta = data.id };
            }
        }
    });
    return OpcionesSelect;
}

function TraerCodigosCuentas() {
    var IdCuenta = 0, indice;
    for (var i = 0; i <= 5; i++) {
        if (i == 0) { indice = ""; } else { indice = i.toString();}
        IdCuenta = $("#IdCuenta" + indice).val();
        if (Math.floor(IdCuenta) == IdCuenta && $.isNumeric(IdCuenta)) {
            $.ajax({
                type: "GET",
                async: false,
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Cuenta/TraerUna/',
                data: { IdCuenta: IdCuenta },
                dataType: "json",
                success: function (data) {
                    if (data.length > 0) {
                        $("#CodigoCuenta" + indice).val(data[0].codigo); 
                    }
                }
            });
        }
    }
}

function TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, Origen, indice) {
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
                if (result.length == 1) { IdCuenta = data.id };
            }
            DatosCuenta(IdCuenta, Origen, 0, "Codigo", indice);
        }
    });
    return OpcionesSelect;
}

function TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, Origen, indice) {
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
            DatosCuenta(IdCuenta, Origen, 0, "Codigo", indice);
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
                    $('#tr_IdDetalleRecibo', form).hide();
                    $('#tr_IdImputacion', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleRecibo', form).val(0);
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

function AgregarValor(grid) {
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
                    $('#tr_IdDetalleReciboValores', form).hide();
                    $('#tr_IdTipoValor', form).hide();
                    $('#tr_IdBanco', form).hide();
                    $('#tr_IdCuentaBancariaTransferencia', form).hide();
                    $('#tr_IdCaja', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();
                    $('#tr_Caja', form).hide();

                    $('#tr_TarjetaCredito', form).hide();
                    $('#tr_NumeroTarjetaCredito', form).hide();
                    $('#tr_FechaExpiracionTarjetaCredito', form).hide();
                    $('#tr_CantidadCuotas', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleReciboValores', form).val(0);
                    $('#NumeroValor', form).val("");
                    $('#NumeroTransferencia', form).val("");
                    $('#Importe', form).val("");
                    var now = new Date();
                    var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                    $('#FechaVencimiento', form).val(currentDate);
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

                    SelectOpcional = $("#Banco").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.Banco = SelectOpcional.text();
                    }

                    SelectOpcional = $("#CuentaBancariaTransferencia").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.CuentaBancaria = SelectOpcional.text();
                    }
                    return [true, ''];
                }
            });
};

function AgregarCaja(grid) {
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Cobranza caja", bSubmit: "Aceptar", bCancel: "Cancelar", width: 400, reloadAfterSubmit: false,
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
                    $('#tr_IdDetalleReciboValores', form).hide();
                    $('#tr_IdTipoValor', form).hide();
                    $('#tr_IdBanco', form).hide();
                    $('#tr_IdCuentaBancariaTransferencia', form).hide();
                    $('#tr_IdCaja', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();

                    $('#tr_Tipo', form).hide();
                    $('#tr_FechaVencimiento', form).hide();
                    $('#tr_NumeroInterno', form).hide();
                    $('#tr_NumeroValor', form).hide();
                    $('#tr_Banco', form).hide();
                    $('#tr_CuitLibrador', form).hide();
                    $('#tr_CuentaBancariaTransferencia', form).hide();
                    $('#tr_NumeroTransferencia', form).hide();
                    $('#tr_TarjetaCredito', form).hide();
                    $('#tr_NumeroTarjetaCredito', form).hide();
                    $('#tr_FechaExpiracionTarjetaCredito', form).hide();
                    $('#tr_CantidadCuotas', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleReciboValores', form).val(0);
                    $('#Importe', form).val("");
                    $('#IdCaja').val(-1);

                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: ROOT + 'Parametro/Parametros/',
                        async: false,
                        dataType: "Json",
                        success: function (data) {
                            var data2 = data[0]
                            $('#IdTipoValor', form).val(data2.IdTipoComprobanteCajaIngresos);
                        }
                    });

                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    var SelectOpcional;

                    postdata.Tipo = "CI";
                    //postdata.Caja = $("#Caja").children("option").filter(":selected").text();
                    SelectOpcional = $("#Caja").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.Caja = SelectOpcional.text();
                    }

                    postdata.NumeroInterno = "";
                    postdata.NumeroValor = "";
                    postdata.Banco = "";
                    postdata.CuitLibrador = "";
                    postdata.CuentaBancariaTransferencia = "";
                    postdata.NumeroTransferencia = "";
                    postdata.TarjetaCredito = "";
                    postdata.NumeroTarjetaCredito = "";
                    postdata.FechaExpiracionTarjetaCredito = "";
                    postdata.CantidadCuotas = "";
                    return [true, ''];
                }
            });
};

function AgregarTarjeta(grid) {
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Cobranza tarjeta", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,
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
                    $('#tr_IdDetalleReciboValores', form).hide();
                    $('#tr_IdTipoValor', form).hide();
                    $('#tr_IdBanco', form).hide();
                    $('#tr_IdCuentaBancariaTransferencia', form).hide();
                    $('#tr_IdCaja', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();

                    $('#tr_Tipo', form).hide();
                    $('#tr_FechaVencimiento', form).hide();
                    $('#tr_NumeroInterno', form).hide();
                    $('#tr_NumeroValor', form).hide();
                    $('#tr_Banco', form).hide();
                    $('#tr_CuitLibrador', form).hide();
                    $('#tr_CuentaBancariaTransferencia', form).hide();
                    $('#tr_NumeroTransferencia', form).hide();
                    $('#tr_Caja', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleReciboValores', form).val(0);
                    $('#Importe', form).val("");
                    $('#NumeroTarjetaCredito', form).val("");
                    $('#CantidadCuotas', form).val("1");
                    $('#IdTarjetaCredito').val(-1);

                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: ROOT + 'Parametro/Parametros/',
                        async: false,
                        dataType: "Json",
                        success: function (data) {
                            var data2 = data[0]
                            $('#IdTipoValor', form).val(data2.IdTipoComprobanteTarjetaCredito);
                        }
                    });

                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    var SelectOpcional;

                    SelectOpcional = $("#TarjetaCredito").children("option").filter(":selected");
                    if (SelectOpcional.length > 0) {
                        postdata.TarjetaCredito = SelectOpcional.text();
                    }

                    postdata.NumeroInterno = "";
                    postdata.NumeroValor = "";
                    postdata.Banco = "";
                    postdata.CuitLibrador = "";
                    postdata.CuentaBancariaTransferencia = "";
                    postdata.NumeroTransferencia = "";
                    postdata.Caja = "";
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
                    $('#tr_IdDetalleReciboCuentas', form).hide();
                    $('#tr_IdCuenta', form).hide();
                    $('#tr_IdObra', form).hide();
                    $('#tr_IdCuentaGasto', form).hide();
                    $('#tr_IdCuentaBancaria', form).hide();
                    $('#tr_IdMoneda', form).hide();
                    $('#tr_CotizacionMonedaDestino', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleReciboCuentas', form).val(0);
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
            NumeroInterno = data2.ProximoNumeroInterno;
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
    var top = MARGENSUPERIOR + (screen.height / 2) - (dlgHeight / 2) + "px";
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
            }
        }
    });
    return Entidad;
}

function TraerCotizacion() {
    var fecha, IdMoneda, datos1, mIdMonedaPrincipal = 1, mIdMonedaDolar = 2, mCotizacionDolar = 0;
    fecha = $("#FechaRecibo").val();
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
        if (mCotizacionDolar != 0) { $("#Cotizacion").val(mCotizacionDolar.toFixed(2)); }
    }
    else {
        if (IdMoneda == mIdMonedaDolar) {
            $("#CotizacionMoneda").val(mCotizacionDolar.toFixed(2));
            $("#Cotizacion").val(mCotizacionDolar.toFixed(2));
        }
    }
};

function TraerNumeroComprobante() {
    var IdRecibo = $("#IdRecibo").val();
    var IdPuntoVenta = $("#IdPuntoVenta").val();

    if (IdRecibo <= 0) {
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
                    $("#NumeroRecibo").val(ProximoNumero);
                }
            }
        });
    } else {
        $("#IdPuntoVenta").prop("disabled", true);
    }
}

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

    $("#ListaDrag").block({
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
