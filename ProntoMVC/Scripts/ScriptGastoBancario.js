$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", mTotalImputaciones, mImporteTotal;

    //if ($("#IdValor").val() > 0) {
    //    $("#grabar2").prop("disabled", true);
    //}

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

        if (jQuery("#ListaRubrosContables").find(target).length) {
            $grid = $('#ListaRubrosContables');
            grillaenfoco = true;
        }
        if (jQuery("#ListaProvincias").find(target).length) {
            $grid = $('#ListaProvincias');
            grillaenfoco = true;
        }
        if (jQuery("#ListaContable").find(target).length) {
            $grid = $('#ListaContable');
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
        var Id = (grid.jqGrid('getGridParam', 'records') + 1) * -1;
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

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaRubrosContables').jqGrid({
        url: ROOT + 'Valor/DetValoresRubrosContables/',
        postData: { 'IdValor': function () { return $("#IdValor").val(); } },
        editurl: ROOT + 'Valor/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleValorRubrosContables', 'IdRubroContable', 'Rubro contable', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleValorRubrosContables', index: 'IdDetalleValorRubrosContables', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRubroContable', index: 'IdRubroContable', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    {
                        name: 'RubroContable', index: 'RubroContable', align: 'left', width: 400, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'RubroContable/GetRubrosContables',
                            dataInit: function (elem) {
                                $(elem).width(390);
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
                        name: 'Importe', index: 'Importe', width: 120, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleValorRubrosContables',
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
        caption: '<b>DETALLE RUBROS CONTABLES</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaRubrosContables").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaRubrosContables").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaRubrosContables"));
                                     },
                                 });
    jQuery("#ListaRubrosContables").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaRubrosContables"));
                                     },
                                 });


    $('#ListaProvincias').jqGrid({
        url: ROOT + 'Valor/DetValoresProvincias/',
        postData: { 'IdValor': function () { return $("#IdValor").val(); } },
        editurl: ROOT + 'Valor/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleValorProvincias', 'IdProvincia', 'Provincia', 'Porcentaje'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleValorProvincias', index: 'IdDetalleValorProvincias', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdProvincia', index: 'IdProvincia', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    {
                        name: 'Provincia', index: 'Provincia', align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Provincia/GetProvincias',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaProvincias').getGridParam('selrow');
                                    $('#ListaProvincias').jqGrid('setCell', rowid, 'IdProvincia', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Porcentaje', index: 'Porcentaje', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaProvincias').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    }
        ],
        gridComplete: function () {
            calculaTotalProvincias();
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterSaveCell: function (rowid) {
            calculaTotalProvincias();
        },
        pager: $('#ListaPager2'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleValorProvincias',
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
        caption: '<b>DETALLE PROVINCIAS (SIRCREB)</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaProvincias").jqGrid('navGrid', '#ListaPager2', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaProvincias").jqGrid('navButtonAdd', '#ListaPager2',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaProvincias"));
                                     },
                                 });
    jQuery("#ListaProvincias").jqGrid('navButtonAdd', '#ListaPager2',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaProvincias"));
                                     },
                                 });


    $('#ListaContable').jqGrid({
        url: ROOT + 'Valor/DetValoresCuentas/',
        postData: { 'IdValor': function () { return $("#IdValor").val(); } },
        editurl: ROOT + 'Valor/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleValorCuentas', 'IdCuenta', 'IdObra', 'IdCuentaGasto', 'IdCuentaBancaria', 'IdCaja', 'IdMoneda', 'CotizacionMonedaDestino', 'IdTipoCuentaGrupo',
                   'Codigo', 'Cuenta', 'Debe', 'Haber', 'Cuenta bancaria', 'Caja', 'Obra', 'Cuenta de gasto', 'Grupo cuenta'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleValorCuentas', index: 'IdDetalleValorCuentas', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdCuenta', index: 'IdCuenta', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdObra', index: 'IdObra', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCuentaGasto', index: 'IdCuentaGasto', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdCaja', index: 'IdCaja', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }, label: 'TB' },
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

                                                //newOptions = TraerTarjetasCredito(IdCuenta);
                                                //var form = $(e.target).closest('form.FormGrid');
                                                //$("select#TarjetaCredito.FormElement", form[0]).html(newOptions);

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

                                        //newOptions = TraerTarjetasCredito(IdCuenta);
                                        //var form = $(e.target).closest('form.FormGrid');
                                        //$("select#TarjetaCredito.FormElement", form[0]).html(newOptions);

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
        pager: $('#ListaPager3'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleValorCuentas',
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
        caption: '<b>REGISTRO CONTABLE</b>',
        cellEdit: true,
        cellsubmit: 'clientArray',
        loadonce: true
    });
    jQuery("#ListaContable").jqGrid('navGrid', '#ListaPager3', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaContable").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-home", title: "Agregar item",
                                        onClickButton: function () {
                                            AgregarCuenta(jQuery("#ListaContable"));
                                        },
                                    });
    jQuery("#ListaContable").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                        onClickButton: function () {
                                            EliminarSeleccionados(jQuery("#ListaContable"));
                                        },
                                    });


    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    //$("#Aprobo").change(function () {
    //    var IdAprobo = $("#Aprobo > option:selected").attr("value");
    //    var Aprobo = $("#Aprobo > option:selected").html();
    //    $("#Aux1").val(IdAprobo);
    //    $("#Aux2").val(Aprobo);
    //    $("#Aux3").val("");
    //    $("#Aux10").val("");
    //    $('#dialog-password').data('Combo', 'Aprobo');
    //    $('#dialog-password').dialog('open');
    //    $('#mySelect').focus(); 
    //});

    $('select#IdCuentaContable').change(function () {
        DatosCuenta($(this).val(), "p", 0, "Codigo", "");
    });
    $('#CodigoCuenta').change(function () {
        var CodigoCuenta = $(this).val();
        var IdCuenta = TraerCuentaPorCodigo(CodigoCuenta);
        $('select#IdCuentaContable').val(IdCuenta);

        newOptions = TraerCuentaPorCodigo2(CodigoCuenta);
        if (newOptions.length > 0) {
            $("select#IdCuentaContable").empty();
            $("select#IdCuentaContable").append(newOptions);
        }
    });
    $('select#IdObra').change(function () {
        IdObra = $(this).val();
        IdCuentaGasto = $('select#IdCuentaGasto').val() || 0;
        $("#CodigoCuenta").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "");
        if (newOptions.length > 0) {
            $("select#IdCuentaContable").empty();
            $("select#IdCuentaContable").append(newOptions);
        }
    });
    $('select#IdCuentaGasto').change(function () {
        IdCuentaGasto = $(this).val();
        IdObra = $('select#IdObra').val() || 0;
        $("#CodigoCuenta").val("");

        newOptions = TraerCuentasPorIdObraIdCuentaGasto(IdObra, IdCuentaGasto, "p", "");
        if (newOptions.length > 0) {
            $("select#IdCuentaContable").empty();
            $("select#IdCuentaContable").append(newOptions);
        }
    });
    $('select#IdTipoCuentaGrupo').change(function () {
        IdTipoCuentaGrupo = $(this).val();
        $("#CodigoCuenta").val("");

        newOptions = TraerCuentasPorIdTipoCuentaGrupo(IdTipoCuentaGrupo, "p", "");
        if (newOptions.length > 0) {
            $("select#IdCuentaContable").empty();
            $("select#IdCuentaContable").append(newOptions);
        }
    });

    $("#AsientoManual").change(function () {
        ActivarAsientoManual($("#AsientoManual").is(':checked'));
    });

    $("#IdMoneda").change(function () {
        TraerCotizacion()
    })

    function ActualizarTodo() {
        ActualizarDatosContables();
    }

    $('#ActualizarDatos').click(function () {
        $('#ActualizarDatos').attr("disabled", true).val("Espere...");
        $('html, body').css('cursor', 'wait');
        ActualizarTodo();
        $('html, body').css('cursor', 'auto');
        $('#ActualizarDatos').attr("disabled", false).val("Recalcular");
    });

    function ActualizarDatosContables() {
        var datos = "";
        var cabecera = SerializaForm();
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Valor/CalcularAsiento',
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
        var chk = $('#AsientoManual').is(':checked');
        if (chk) {
            cabecera.AsientoManual = "SI";
        } else {
            cabecera.AsientoManual = "NO";
        };

        cabecera.DetalleValoresRubrosContables = [];
        $grid = $('#ListaRubrosContables');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleValorRubrosContables'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleValorRubrosContables":"' + iddeta + '",';
                data1 = data1 + '"IdValor":"' + $("#IdValor").val() + '",';
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
                cabecera.DetalleValoresRubrosContables.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleValoresProvincias = [];
        $grid = $('#ListaProvincias');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleValorProvincias'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleValorProvincias":"' + iddeta + '",';
                data1 = data1 + '"IdValor":"' + $("#IdValor").val() + '",';
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
                cabecera.DetalleValoresProvincias.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleValoresCuentas = [];
        $grid = $('#ListaContable');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleValorCuentas'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleValorCuentas":"' + iddeta + '",';
                data1 = data1 + '"IdValor":"' + $("#IdValor").val() + '",';
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
                cabecera.DetalleValoresCuentas.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        return cabecera;
    }

    $('#grabar2').click(function () {
        ActualizarTodo()

        var cabecera = SerializaForm();

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Valor/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Valor: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "Valor/Edit/" + result.IdValor);
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

});

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

calculaTotalProvincias = function () {
    var imp = 0, imp2 = 0;
    var dataIds = $('#ListaProvincias').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaProvincias').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Porcentaje'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    $("#ListaProvincias").jqGrid('footerData', 'set', { Provincia: 'TOTAL', Porcentaje: imp2.toFixed(2) });
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
                    $("#IdCuentaContable" + indice).val(IdCuenta);
                    if (campo == "Codigo") { $("#CodigoCuenta" + indice).val(data[0].codigo); }
                    if (indice.length > 0) {
                        $("#IdObra" + indice).val(data[0].IdObra);
                        $("#IdCuentaGasto" + indice).val(data[0].IdCuentaGasto);
                        $("#IdTipoCuentaGrupo" + indice).val(data[0].IdTipoCuentaGrupo);
                    }
                } else {
                    //$("#ListaContable").setColProp('CuentaBancaria', { editoptions: { dataUrl: ROOT + 'Banco/GetCuentasBancariasPorIdCuenta2?IdCuenta=' + IdCuenta } });
                    //$("#ListaContable").setColProp('Caja', { editoptions: { dataUrl: ROOT + 'Banco/GetCajasPorIdCuenta2?IdCuenta=' + IdCuenta } });
                    //$("#ListaContable").setColProp('TarjetaCredito', { editoptions: { dataUrl: ROOT + 'Banco/GetTarjetasCreditoPorIdCuenta2?IdCuenta=' + IdCuenta } });

                    if (origen == "f") {
                        if (campo == "Codigo") { $("#Codigo").val(data[0].codigo); }
                        if (campo == "Cuenta") { $("#Cuenta").val(data[0].descripcion); }
                    } else {
                        //if (campo == "Codigo") { $('#ListaContable').jqGrid('setCell', rowid, 'Codigo', data[0].codigo); }
                        //if (campo == "Cuenta") { $('#ListaContable').jqGrid('setCell', rowid, 'Cuenta', data[0].descripcion); }
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
                        //if (campo == "Codigo") { $('#ListaContable').jqGrid('setCell', rowid, 'Codigo', ""); }
                        //if (campo == "Cuenta") { $('#ListaContable').jqGrid('setCell', rowid, 'Cuenta', ""); }
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

function TraerCotizacion() {
    var fecha, IdMoneda, datos1, mIdMonedaPrincipal = 1, mIdMonedaDolar = 2, mCotizacionDolar = 0, mCotizacionEuro = 0;
    fecha = $("#FechaComprobante").val();
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
        //$("#CotizacionDolar").val(mCotizacionDolar.toFixed(2));
        //$("#CotizacionEuro").val(mCotizacionEuro.toFixed(2));
    }
    else {
        if (IdMoneda == mIdMonedaDolar) {
            $("#CotizacionMoneda").val(mCotizacionDolar.toFixed(2));
            //$("#CotizacionDolar").val(mCotizacionDolar.toFixed(2));
            //$("#CotizacionEuro").val(mCotizacionEuro.toFixed(2));
        }
    }
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
                    $('#tr_IdDetalleValorCuentas', form).hide();
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
                    $('#IdDetalleValorCuentas', form).val(0);
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

                    //SelectOpcional = $("#TarjetaCredito").children("option").filter(":selected");
                    //if (SelectOpcional.length > 0) {
                    //    postdata.TarjetaCredito = SelectOpcional.text();
                    //    postdata.IdTarjetaCredito = SelectOpcional.val();
                    //}

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
