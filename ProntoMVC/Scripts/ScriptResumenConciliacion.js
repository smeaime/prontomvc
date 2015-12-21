$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", SumatoriaMovimientosEnExtracto = 0, SumatoriaMovimientosFueraExtracto = 0;
    var SaldoFueraDeContabilidad = 0, SaldoFueraDeContabilidad1 = 0, SaldoFueraDeContabilidad2 = 0, Diferencia2 = 0;

    pageLayout.show('east');

    if ($("#IdAprobo").val() > 0) {
        $("#grabar2").prop("disabled", true);
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

        if (jQuery("#ListaEnExtracto").find(target).length) {
            $grid = $('#ListaEnExtracto');
            grillaenfoco = true;
        }
        if (jQuery("#ListaFueraDeExtracto").find(target).length) {
            $grid = $('#ListaFueraDeExtracto');
            grillaenfoco = true;
        }
        if (jQuery("#ListaNoContable").find(target).length) {
            $grid = $('#ListaNoContable');
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

    $('#ListaEnExtracto').jqGrid({
        url: ROOT + 'ResumenConciliacion/DetConciliacionesConciliados/',
        postData: { 'IdConciliacion': function () { return $("#IdConciliacion").val(); } },
        editurl: ROOT + 'ResumenConciliacion/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleConciliacion', 'IdConciliacion', 'Tipo valor', 'IdValor', 'Numero valor', 'Numero interno', 'Fecha valor', 'Fecha deposito', 'Numero deposito',
                   'Ingresos', 'Egresos', 'Iva', 'Banco de origen', 'Tipo', 'Numero comprobante', 'Fecha comprobante', 'Cliente', 'Proveedor', 'TotalIngresos', 'TotalEgresos', 'Controlado',
                   'ControladoNoConciliado', 'Cuenta'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleConciliacion', index: 'IdDetalleConciliacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdConciliacion', index: 'IdConciliacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'TipoValor', index: 'TipoValor', align: 'center', width: 50, editable: false, hidden: false },
                    { name: 'IdValor', index: 'IdValor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'NumeroValor', index: 'NumeroValor', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'NumeroInterno', index: 'NumeroInterno', align: 'left', width: 70, editable: false, hidden: false },
                    { name: 'FechaValor', index: 'FechaValor', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'FechaDeposito', index: 'FechaDeposito', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'NumeroDeposito', index: 'NumeroDeposito', align: 'left', width: 100, editable: false, hidden: false },
                    { name: 'Ingresos', index: 'Ingresos', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Egresos', index: 'Egresos', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Iva', index: 'Iva', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'BancoOrigen', index: 'BancoOrigen', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'Tipo', index: 'Tipo', align: 'center', width: 50, editable: false, hidden: false },
                    { name: 'NumeroComprobante', index: 'NumeroComprobante', align: 'left', width: 70, editable: false, hidden: false },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Cliente', index: 'Cliente', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'Proveedor', index: 'Proveedor', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'TotalIngresos', index: 'TotalIngresos', align: 'right', width: 100, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'TotalEgresos', index: 'TotalEgresos', align: 'right', width: 100, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Controlado', index: 'Controlado', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'ControladoNoConciliado', index: 'ControladoNoConciliado', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'Cuenta', index: 'Cuenta', align: 'left', width: 250, editable: false, hidden: false }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        afterSaveCell: function (rowid) {
            calculaTotalImputaciones();
        },
        gridComplete: function () {
            calculaTotalImputaciones();
        },
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleConciliacion',
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
        caption: '<b>MOVIMIENTOS EXISTENTES EN EL EXTRACTO</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaEnExtracto").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaEnExtracto").jqGrid('navButtonAdd', '#ListaPager1',
    //                             {
    //                                 caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
    //                                 onClickButton: function () {
    //                                     AgregarItemVacio(jQuery("#ListaEnExtracto"));
    //                                 },
    //                             });
    jQuery("#ListaEnExtracto").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaEnExtracto"));
                                     },
                                 });
    jQuery("#ListaEnExtracto").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $('#ListaFueraDeExtracto').jqGrid({
        url: ROOT + 'ResumenConciliacion/DetConciliacionesNoConciliados/',
        postData: { 'IdConciliacion': function () { return $("#IdConciliacion").val(); } },
        editurl: ROOT + 'ResumenConciliacion/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleConciliacion', 'IdConciliacion', 'Tipo valor', 'IdValor', 'Numero valor', 'Numero interno', 'Fecha valor', 'Fecha deposito', 'Numero deposito',
                   'Ingresos', 'Egresos', 'Iva', 'Banco de origen', 'Tipo', 'Numero comprobante', 'Fecha comprobante', 'Cliente', 'Proveedor', 'TotalIngresos', 'TotalEgresos', 'Controlado',
                   'ControladoNoConciliado', 'Cuenta'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleConciliacion', index: 'IdDetalleConciliacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdConciliacion', index: 'IdConciliacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'TipoValor', index: 'TipoValor', align: 'center', width: 50, editable: false, hidden: false },
                    { name: 'IdValor', index: 'IdValor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'NumeroValor', index: 'NumeroValor', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'NumeroInterno', index: 'NumeroInterno', align: 'left', width: 70, editable: false, hidden: false },
                    { name: 'FechaValor', index: 'FechaValor', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'FechaDeposito', index: 'FechaDeposito', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'NumeroDeposito', index: 'NumeroDeposito', align: 'left', width: 100, editable: false, hidden: false },
                    { name: 'Ingresos', index: 'Ingresos', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Egresos', index: 'Egresos', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Iva', index: 'Iva', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'BancoOrigen', index: 'BancoOrigen', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'Tipo', index: 'Tipo', align: 'center', width: 50, editable: false, hidden: false },
                    { name: 'NumeroComprobante', index: 'NumeroComprobante', align: 'left', width: 70, editable: false, hidden: false },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Cliente', index: 'Cliente', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'Proveedor', index: 'Proveedor', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'TotalIngresos', index: 'TotalIngresos', align: 'right', width: 100, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'TotalEgresos', index: 'TotalEgresos', align: 'right', width: 100, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Controlado', index: 'Controlado', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'ControladoNoConciliado', index: 'ControladoNoConciliado', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'Cuenta', index: 'Cuenta', align: 'left', width: 250, editable: false, hidden: false }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        afterSaveCell: function (rowid) {
            calculaTotalImputaciones();
        },
        gridComplete: function () {
            calculaTotalImputaciones();
        },
        pager: $('#ListaPager2'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleConciliacion',
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
        caption: '<b>MOVIMIENTOS INEXISTENTES EN EL EXTRACTO</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaFueraDeExtracto").jqGrid('navGrid', '#ListaPager2', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaFueraDeExtracto").jqGrid('navButtonAdd', '#ListaPager2',
    //                             {
    //                                 caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
    //                                 onClickButton: function () {
    //                                     AgregarItemVacio(jQuery("#ListaFueraDeExtracto"));
    //                                 },
    //                             });
    jQuery("#ListaFueraDeExtracto").jqGrid('navButtonAdd', '#ListaPager2',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaFueraDeExtracto"));
                                     },
                                 });
    jQuery("#ListaFueraDeExtracto").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $('#ListaNoContable').jqGrid({
        url: ROOT + 'ResumenConciliacion/DetConciliacionesNoContables/',
        postData: { 'IdConciliacion': function () { return $("#IdConciliacion").val(); } },
        editurl: ROOT + 'ResumenConciliacion/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleConciliacionNoContable', 'IdConciliacion', 'Detalle', 'Ingresos', 'Egresos', 'Fecha ingreso', 'Fecha caducidad', 'Fecha reg. contable'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleConciliacionNoContable', index: 'IdDetalleConciliacionNoContable', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdConciliacion', index: 'IdConciliacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'Detalle', index: 'Detalle', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    {
                        name: 'Ingresos', index: 'Ingresos', formoptions: { rowpos: 2, colpos: 1 }, width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaNoContable').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'Egresos', index: 'Egresos', formoptions: { rowpos: 2, colpos: 2 }, width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaNoContable').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'FechaIngreso', index: 'FechaIngreso', formoptions: { rowpos: 3, colpos: 1 }, width: 100, sortable: false, align: 'right', editable: true, label: 'TB',
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
                        name: 'FechaCaducidad', index: 'FechaCaducidad', formoptions: { rowpos: 4, colpos: 1 }, width: 100, sortable: false, align: 'right', editable: true, label: 'TB',
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
                        name: 'FechaRegistroContable', index: 'FechaRegistroContable', formoptions: { rowpos: 5, colpos: 1 }, width: 100, sortable: false, hidden: true, align: 'right', editable: true, label: 'TB',
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
                    }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        afterSaveCell: function (rowid) {
            calculaTotalImputaciones();
        },
        gridComplete: function () {
            calculaTotalImputaciones();
        },
        pager: $('#ListaPager3'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleConciliacionNoContable',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '300px', // 'auto',
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
        caption: '<b>MOVIMIENTOS PENDIENTES EN CONTABILIDAD</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaNoContable").jqGrid('navGrid', '#ListaPager3', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaNoContable").jqGrid('navButtonAdd', '#ListaPager3',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaNoContable"));
                                     },
                                 });
    jQuery("#ListaNoContable").jqGrid('navButtonAdd', '#ListaPager3',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaNoContable"));
                                     },
                                 });
    jQuery("#ListaNoContable").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $("#ListaDrag").jqGrid({
        url: ROOT + 'Valor/ConciliacionBanco',
        postData: { 'IdCuentaBancaria': function () { return $("#IdCuentaBancaria").val(); }, 'FechaInicial': function () { return "01/01/2000"; }, 'FechaFinal': function () { return "31/12/2100"; }, 'ConfirmacionBanco': function () { return "NO"; } },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdValor', 'Tipo', 'Numero valor', 'Ingresos', 'Egresos', 'Saldo', 'Conv.$', 'Ingresos $', 'Egresos $', 'Saldo $', 'Fecha comp.', 'Conc.', 'Mov. conf. bco.', 'Fecha conf. bco.',
                   'Cuenta banco', 'Numero conciliacion', 'Fecha conciliacion', 'Numero interno', 'Fecha valor', 'Fecha deposito', 'Numero deposito', 'Iva', 'Mon.', 'Banco', 'Tipo comp.',
                   'Numero Comprobante', 'Fecha origen', 'Cliente', 'Proveedor', 'Cuenta contable', 'Detalle', 'Numero asi. ch. dif.', 'Observaciones'],
        colModel: [
                    { name: 'ver', index: 'ver', hidden: true, width: 50 },
                    { name: 'IdValor', index: 'IdValor', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'Tipo', index: 'Tipo', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'NumeroValor', index: 'NumeroValor', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'Ingresos', index: 'Ingresos', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Egresos', index: 'Egresos', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Saldo', index: 'Saldo', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'CotizacionMoneda', index: 'CotizacionMoneda', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'IngresosPesos', index: 'IngresosPesos', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'EgresosPesos', index: 'EgresosPesos', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'SaldoPesos', index: 'SaldoPesos', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Conciliado', index: 'Conciliado', align: 'center', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'MovimientoConfirmadoBanco', index: 'MovimientoConfirmadoBanco', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'FechaConfirmacionBanco', index: 'FechaConfirmacionBanco', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Cuenta', index: 'Cuenta', align: 'left', width: 150, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'NumeroConciliacion', index: 'NumeroConciliacion', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'FechaIngresoConciliacion', index: 'FechaIngresoConciliacion', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'NumeroInterno', index: 'NumeroInterno', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'FechaValor', index: 'FechaValor', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'FechaDeposito', index: 'FechaDeposito', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'NumeroDeposito', index: 'NumeroDeposito', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'Iva', index: 'Iva', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Moneda', index: 'Moneda', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'Banco', index: 'Banco', align: 'left', width: 150, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'TipoComprobante', index: 'TipoComprobante', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'NumeroComprobante', index: 'NumeroComprobante', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'FechaOrigen', index: 'FechaOrigen', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Cliente', index: 'Cliente', align: 'left', width: 300, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'Proveedor', index: 'Proveedor', align: 'left', width: 300, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'CuentaContable', index: 'CuentaContable', align: 'left', width: 300, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'Detalle', index: 'Detalle', align: 'left', width: 300, sortable: false, editable: false, search: false, hidden: false },
                    { name: 'NumeroAsientoChequesDiferidos', index: 'NumeroAsientoChequesDiferidos', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 300, sortable: false, editable: false, search: false, hidden: false }
        ],
        ondblClickRow: function (id) {
            Copiar1(id, "Dbl");
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroInterno', // 'FechaRecibo,NumeroRecibo',
        sortorder: 'desc',
        multiselect: true,
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
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager',
     { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
     { width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false }
    );
    jQuery("#ListaDrag").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/
    jQuery("#ListaDrag").jqGrid('navButtonAdd', '#ListaDragPager',
                                 {
                                     caption: "", buttonicon: "ui-icon-arrowreturnthick-1-s", title: "Agregar a EN EXTRACTO",
                                     onClickButton: function () {
                                         AgregarAGrilla(jQuery("#ListaDrag"), "EnExtracto");
                                     },
                                 });
    jQuery("#ListaDrag").jqGrid('navButtonAdd', '#ListaDragPager',
                                 {
                                     caption: "", buttonicon: "ui-icon-arrowreturnthick-1-n", title: "Agregar a FUERA DE EXTRACTO",
                                     onClickButton: function () {
                                         AgregarAGrilla(jQuery("#ListaDrag"), "FueraDeExtracto");
                                     },
                                 });

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Valores no confirmados');
    //$('a#a_panel_este_tab5').remove();  //    

    ConectarGrillas1();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });

    function ConectarGrillas1() {
        $("#ListaDrag").jqGrid('gridDnD', {
            connectWith: '#ListaFueraDeExtracto',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                Copiar1($(ui.draggable).attr("id"), "DnD");
                //var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                //var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
            }
        });
    }

    function Copiar1(idsource, Origen) {
        var acceptId = idsource, IdValor = 0, mPrimerItem = true, Ingreso = 0, Egreso = 0;
        var $gridOrigen = $("#ListaDrag"), $gridDestino = $("#ListaFueraDeExtracto");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        dataIds = $gridDestino.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            data2 = $gridDestino.jqGrid('getRowData', dataIds[i]);
            if (data2.IdValor == idsource) {
                if (Origen == "DnD") $gridDestino.jqGrid('delRowData', dataIds[0]);
                alert("Ya existe el registro");
                return;
            }
        };

        try {
            IdValor = getdata['IdValor'];
            Ingreso = getdata['Ingresos'];
            Egreso = getdata['Egresos'];

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Valor/TraerUno/',
                data: { IdValor: IdValor },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;

                        tmpdata['IdDetalleConciliacion'] = Id2;
                        tmpdata['IdValor'] = data[i].IdValor;
                        tmpdata['TipoValor'] = data[i].Tipo;
                        tmpdata['NumeroValor'] = data[i].NumeroValor;
                        tmpdata['NumeroInterno'] = data[i].NumeroInterno;
                        tmpdata['FechaValor'] = data[i].FechaValor;
                        tmpdata['FechaDeposito'] = data[i].FechaDeposito;
                        tmpdata['NumeroDeposito'] = data[i].NumeroDeposito;
                        tmpdata['Iva'] = data[i].Iva;
                        tmpdata['BancoOrigen'] = data[i].Banco;
                        tmpdata['Tipo'] = data[i].TipoComprobante;
                        tmpdata['NumeroComprobante'] = data[i].NumeroComprobante;
                        tmpdata['FechaComprobante'] = data[i].FechaComprobante;
                        tmpdata['Cliente'] = data[i].Cliente;
                        tmpdata['Proveedor'] = data[i].Proveedor;
                        tmpdata['Controlado'] = data[i].Controlado;
                        tmpdata['ControladoNoConciliado'] = data[i].ControladoNoConciliado;
                        tmpdata['Cuenta'] = "";

                        tmpdata['Ingresos'] = Ingreso;
                        tmpdata['Egresos'] = Egreso;
                        tmpdata['TotalIngresos'] = Ingreso;
                        tmpdata['TotalEgresos'] = Egreso;
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
                            calculaTotalImputaciones();
                        } else {
                            Id = Id2
                            $gridDestino.jqGrid('addRowData', Id, getdata, "first");
                        };
                        ActualizarDatos();
                    }
                }
            });
        } catch (e) { }

        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    function AgregarAGrilla(grid,destino) {
        var selectedIds = grid.jqGrid('getGridParam', 'selarrrow');
        var getdata, getdata2, $gridDestino, $gridDestino2, i, j, k, IdValor = 0, Ingreso = 0, Egreso = 0, tmpdata = {}, dataIds, data2, Id, Id2, esta = false, esta2 = false;

        if (destino == "EnExtracto") { $gridDestino = $('#ListaEnExtracto'); } else { $gridDestino2 = $('#ListaEnExtracto'); }
        if (destino == "FueraDeExtracto") { $gridDestino = $('#ListaFueraDeExtracto'); } else { $gridDestino2 = $('#ListaFueraDeExtracto'); }

        for (i = selectedIds.length - 1; i >= 0; i--) {
            getdata = grid.jqGrid('getRowData', selectedIds[i]);

            IdValor = getdata['IdValor'];
            Ingreso = getdata['Ingresos'];
            Egreso = getdata['Egresos'];

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Valor/TraerUno/',
                data: { IdValor: IdValor },
                async: false,
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (j = 0; j < data.length; j++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;

                        dataIds = $gridDestino.jqGrid('getDataIDs');
                        esta = false
                        for (k = 0; k < dataIds.length; k++) {
                            data2 = $gridDestino.jqGrid('getRowData', dataIds[k]);
                            if (data2.IdValor == IdValor) { esta = true; }
                        };

                        dataIds = $gridDestino2.jqGrid('getDataIDs');
                        esta2 = false
                        for (k = 0; k < dataIds.length; k++) {
                            data2 = $gridDestino2.jqGrid('getRowData', dataIds[k]);
                            if (data2.IdValor == IdValor) { esta2 = true; }
                        };

                        if (!esta && !esta2) {
                            tmpdata['IdDetalleConciliacion'] = Id2;
                            tmpdata['IdValor'] = data[j].IdValor;
                            tmpdata['TipoValor'] = data[j].Tipo;
                            tmpdata['NumeroValor'] = data[j].NumeroValor;
                            tmpdata['NumeroInterno'] = data[j].NumeroInterno;
                            tmpdata['FechaValor'] = data[j].FechaValor;
                            tmpdata['FechaDeposito'] = data[j].FechaDeposito;
                            tmpdata['NumeroDeposito'] = data[j].NumeroDeposito;
                            tmpdata['Iva'] = data[j].Iva;
                            tmpdata['BancoOrigen'] = data[j].Banco;
                            tmpdata['Tipo'] = data[j].TipoComprobante;
                            tmpdata['NumeroComprobante'] = data[j].NumeroComprobante;
                            tmpdata['FechaComprobante'] = data[j].FechaComprobante;
                            tmpdata['Cliente'] = data[j].Cliente;
                            tmpdata['Proveedor'] = data[j].Proveedor;
                            tmpdata['Controlado'] = data[j].Controlado;
                            tmpdata['ControladoNoConciliado'] = data[j].ControladoNoConciliado;
                            tmpdata['Cuenta'] = "";

                            tmpdata['Ingresos'] = Ingreso;
                            tmpdata['Egresos'] = Egreso;
                            tmpdata['TotalIngresos'] = Ingreso;
                            tmpdata['TotalEgresos'] = Egreso;
                            getdata = tmpdata;

                            Id = Id2
                            $gridDestino.jqGrid('addRowData', Id, getdata, "first");
                        }
                    }
                }
            });
        }
        ActualizarDatos();
    };

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

    $("#ImporteAjuste").change(function () {
        CalcularTotales()
    });
    $("#SaldoInicialResumen").change(function () {
        CalcularTotales()
    });
    $("#SaldoFinalResumen").change(function () {
        CalcularTotales()
    });
    $("#FechaFinal").change(function () {
        CalcularTotales()
    });
    
    $("#IdCuentaBancaria").change(function () {
        $("#ListaDrag").trigger("reloadGrid");
    });


    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();

        //cabecera.NumeroDeposito = $("#NumeroDeposito").val();
        //cabecera.Cliente = "";
        //cabecera.Provincia = "";

        cabecera.DetalleConciliacionesContables = [];
        $grid = $('#ListaEnExtracto');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleConciliacion'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleConciliacion":"' + iddeta + '",';
                data1 = data1 + '"IdConciliacion":"' + $("#IdConciliacion").val() + '",';
                data1 = data1 + '"Conciliado":"SI",';
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
                cabecera.DetalleConciliacionesContables.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        $grid = $('#ListaFueraDeExtracto');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleConciliacion'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleConciliacion":"' + iddeta + '",';
                data1 = data1 + '"IdConciliacion":"' + $("#IdConciliacion").val() + '",';
                data1 = data1 + '"Conciliado":"NO",';
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
                cabecera.DetalleConciliacionesContables.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleConciliacionesNoContables = [];
        $grid = $('#ListaNoContable');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleConciliacionNoContable'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleConciliacionNoContable":"' + iddeta + '",';
                data1 = data1 + '"IdConciliacion":"' + $("#IdConciliacion").val() + '",';
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
                cabecera.DetalleConciliacionesNoContables.push(data2);
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

        var IdAprobo = parseInt($("#IdAprobo").val() || 0) || 0;
        if (IdAprobo > 0 && Diferencia2 != 0) {
            alert("La diferencia debe ser cero para grabar el resumen");
            return;
        }

        var cabecera = SerializaForm();

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'ResumenConciliacion/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Conciliacion: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "ResumenConciliacion/Edit/" + result.IdConciliacion);
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

function ActualizarDatos() {
    var IdCodigoIva = 0, Letra = "B", id = 0;

    //id = $("#IdCliente").val();
    //if (id.length > 0) {
    //    MostrarDatosCliente(id);
    //}

    //id = $("#OrdenCompra").val() || 0;
    //if (id <= 0) {
    //}

    //calculaTotalImputaciones();
}

calculaTotalImputaciones = function () {
    var Ingresos = 0, Egresos = 0, imp1 = 0, imp2 = 0, imp3 = 0, FechaIngreso, FechaCaducidad, FechaFinal, parts1, parts2, date1, date2, Procesar = true;

    FechaFinal = $("#FechaFinal").val();
    parts1 = FechaFinal.split('/');
    date1 = new Date(parseInt(parts1[2], 10), parseInt(parts1[1], 10) - 1, parseInt(parts1[0], 10));

    var dataIds = $('#ListaEnExtracto').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaEnExtracto').jqGrid('getRowData', dataIds[i]);
        Ingresos = parseFloat(data['Ingresos'].replace(",", ".") || 0) || 0;
        Egresos = parseFloat(data['Egresos'].replace(",", ".") || 0) || 0;
        imp1 = imp1 + Ingresos;
        imp2 = imp2 + Egresos;
        imp3 = imp3 + (Ingresos - Egresos);
    }
    imp3 = Math.round((imp3) * 10000) / 10000;
    SumatoriaMovimientosEnExtracto = imp3;
    $("#SumatoriaMovimientosEnExtracto").val(imp3.toFixed(2));
    $("#ListaEnExtracto").jqGrid('footerData', 'set', { NumeroDeposito: 'TOTALES (*)', Ingresos: imp1.toFixed(2), Egresos: imp2.toFixed(2) });

    imp1 = 0, imp2 = 0, imp3 = 0;
    var dataIds = $('#ListaFueraDeExtracto').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaFueraDeExtracto').jqGrid('getRowData', dataIds[i]);
        Ingresos = parseFloat(data['Ingresos'].replace(",", ".") || 0) || 0;
        Egresos = parseFloat(data['Egresos'].replace(",", ".") || 0) || 0;
        imp1 = imp1 + Ingresos;
        imp2 = imp2 + Egresos;
        imp3 = imp3 + (Ingresos - Egresos);
    }
    imp3 = Math.round((imp3) * 10000) / 10000;
    SumatoriaMovimientosFueraExtracto = imp3;
    $("#SumatoriaMovimientosFueraExtracto").val(imp3.toFixed(2));
    $("#ListaFueraDeExtracto").jqGrid('footerData', 'set', { NumeroDeposito: 'TOTALES (**)', Ingresos: imp1.toFixed(2), Egresos: imp2.toFixed(2) });

    imp1 = 0, imp2 = 0, imp3 = 0, SaldoFueraDeContabilidad1 = 0, SaldoFueraDeContabilidad2 = 0;
    var dataIds = $('#ListaNoContable').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaNoContable').jqGrid('getRowData', dataIds[i]);
        Ingresos = parseFloat(data['Ingresos'].replace(",", ".") || 0) || 0;
        Egresos = parseFloat(data['Egresos'].replace(",", ".") || 0) || 0;
        imp1 = imp1 + Ingresos;
        imp2 = imp2 + Egresos;
        imp3 = imp3 + (Ingresos - Egresos);

        FechaIngreso = data['FechaIngreso']
        FechaCaducidad = data['FechaCaducidad']

        Procesar = true;
        if (isValidDate(FechaCaducidad)) {
            parts2 = FechaCaducidad.split('/');
            date2 = new Date(parseInt(parts2[2], 10), parseInt(parts2[1], 10) - 1, parseInt(parts2[0], 10));
            if (date2 <= date1) {
                Procesar = false;
            }
        }
        if (Procesar) { SaldoFueraDeContabilidad1 = SaldoFueraDeContabilidad1 + (Ingresos - Egresos); }

        Procesar = false;
        if (isValidDate(FechaIngreso)) {
            parts2 = FechaIngreso.split('/');
            if (parseInt(parts1[2], 10) == parseInt(parts2[2], 10) && parseInt(parts1[1], 10) == parseInt(parts2[1], 10)) {
                Procesar = true;
            }
        }
        if (Procesar) { SaldoFueraDeContabilidad2 = SaldoFueraDeContabilidad2 + (Ingresos - Egresos); }
    }
    imp3 = Math.round((imp3) * 10000) / 10000;
    SaldoFueraDeContabilidad = imp3;
    $("#SaldoFueraDeContabilidad").val(SaldoFueraDeContabilidad1.toFixed(2));
    $("#ListaNoContable").jqGrid('footerData', 'set', { Detalle: 'TOTALES (***)', Ingresos: imp1.toFixed(2), Egresos: imp2.toFixed(2) });

    CalcularTotales()
};

function CalcularTotales() {
    var SaldoInicialResumen = 0, SaldoFinalResumen = 0, SaldoContable = 0, Diferencia1 = 0, Diferencia3 = 0, OPAnuladas = 0, SaldoFinalCalculado = 0, ImporteAjuste = 0;

    SaldoInicialResumen = parseFloat($("#SaldoInicialResumen").val().replace(",", ".") || 0) || 0;
    SaldoFinalResumen = parseFloat($("#SaldoFinalResumen").val().replace(",", ".") || 0) || 0;
    SaldoContable = parseFloat($("#SaldoContable").val().replace(",", ".") || 0) || 0;
    OPAnuladas = parseFloat($("#OPAnuladas").val().replace(",", ".") || 0) || 0;
    ImporteAjuste = parseFloat($("#ImporteAjuste").val().replace(",", ".") || 0) || 0;

    $("#SaldoInicialResumen").val(SaldoInicialResumen.toFixed(2));
    $("#SaldoFinalResumen").val(SaldoFinalResumen.toFixed(2));

    TraerSaldoContable()

    Diferencia1 = SaldoContable - OPAnuladas - SumatoriaMovimientosFueraExtracto;
    SaldoFinalCalculado = Diferencia1 + ImporteAjuste + SaldoFueraDeContabilidad1;
    Diferencia2 = SaldoFinalCalculado - SaldoFinalResumen;
    Diferencia3 = SaldoInicialResumen + SumatoriaMovimientosEnExtracto + SaldoFueraDeContabilidad2 + ImporteAjuste - SaldoFinalResumen;

    $("#Diferencia1").val(Diferencia1.toFixed(2));
    $("#SaldoFinalCalculado").val(SaldoFinalCalculado.toFixed(2));
    $("#Diferencia2").val(Diferencia2.toFixed(2));
    $("#Diferencia3").val(Diferencia3.toFixed(2));
};

function pickdates(id) {
    jQuery("#" + id + "_sdate", "#ListaEnExtracto").datepicker({ dateFormat: "yy-mm-dd" });
}

function unformatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(",", ".");
}

function formatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(".", ",");
}

var isValidDate = function (value, userFormat) {
    var userFormat = userFormat || 'dd/mm/yyyy', // default format

    delimiter = /[^mdy]/.exec(userFormat)[0],
    theFormat = userFormat.split(delimiter),
    theDate = value.split(delimiter),

    isDate = function (date, format) {
        var m, d, y
        for (var i = 0, len = format.length; i < len; i++) {
            if (/m/.test(format[i])) m = date[i]
            if (/d/.test(format[i])) d = date[i]
            if (/y/.test(format[i])) y = date[i]
        }
        return (
          m > 0 && m < 13 &&
          y && y.length === 4 &&
          d > 0 && d <= (new Date(y, m, 0)).getDate()
        )
    }
    return isDate(theDate, theFormat)
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

function TraerSaldoContable() {
    var IdCuentaBancaria = $("#IdCuentaBancaria").val();
    var FechaFinal = $("#FechaFinal").val();
    if (IdCuentaBancaria.length == 0) { IdCuentaBancaria = 0 };

    if (IdCuentaBancaria > 0) {
        $.ajax({
            type: "GET",
            async: false,
            url: ROOT + 'Cuenta/SaldoContablePorIdCuentaBancaria/',
            data: { IdCuentaBancaria: IdCuentaBancaria, Fecha: FechaFinal },
            contentType: "application/json",
            dataType: "json",
            success: function (result) {
                if (result.records > 0) {
                    //var Saldo = result.rows[0].cell[1];
                    //var OPAnuladas = result.rows[0].cell[2];
                    var Saldo = parseFloat(result.rows[0].cell[1].replace(",", ".") || 0) || 0;
                    var OPAnuladas = parseFloat(result.rows[0].cell[2].replace(",", ".") || 0) || 0;
                    $("#SaldoContable").val(Saldo.toFixed(2));
                    $("#OPAnuladas").val(OPAnuladas.toFixed(2));
                }
            }
        });

    }
}
