$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "";

    idaux = $("#IdLocalidad").val();
    if (idaux.length > 0) {
        detalle = TraerLocalidad(idaux);
        $("#Localidad").val(detalle);
    }
    idaux = $("#IdArticuloAsociado").val();
    if (idaux.length > 0) {
        detalle = TraerArticulo(idaux);
        $("#ArticuloAsociado").val(detalle);
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

        if (jQuery("#ListaPolizas").find(target).length) {
            $grid = $('#ListaPolizas');
            grillaenfoco = true;
        }
        if (jQuery("#ListaEquipos").find(target).length) {
            $grid = $('#ListaEquipos');
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

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaPolizas').jqGrid({
        url: ROOT + 'Obra/DetObrasPolizas/',
        postData: { 'IdObra': function () { return $("#IdObra").val(); } },
        editurl: ROOT + 'Obra/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleObraPoliza', 'IdProveedor', 'IdTipoPoliza', 'Tipo de poliza', 'Proveedor', 'Numero de poliza', 'Fecha de vigencia', 'Fecha vto. cuota', 'Importe',
                   'Fecha estimada recupero', 'Fecha recupero', 'Fecha fin cobertura', 'Condicion de recupero', 'Motivo de contratacion', 'Observaciones'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleObraPoliza', index: 'IdDetalleObraPoliza', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdProveedor', index: 'IdProveedor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdTipoPoliza', index: 'IdTipoPoliza', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'TipoPoliza', index: 'TipoPoliza', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'TiposPoliza/GetTiposPolizas',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaPolizas').getGridParam('selrow');
                                    $('#ListaPolizas').jqGrid('setCell', rowid, 'IdTipoPoliza', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Proveedor', index: 'Proveedor', align: 'left', width: 300, editable: true, hidden: false, edittype: 'text', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataInit: function (elem) {
                                var NoResultsLabel = "No se encontraron resultados";
                                $(elem).autocomplete({
                                    source: ROOT + 'Proveedor/GetProveedoresAutocomplete2',
                                    minLength: 0,
                                    select: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                            return;
                                        }
                                        var rowid = $('#ListaPolizas').getGridParam('selrow');
                                        $('#ListaPolizas').jqGrid('setCell', rowid, 'IdProveedor', ui.item.id);
                                    },
                                    focus: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                        }
                                    }
                                })
                                .data("ui-autocomplete")._renderItem = function (ul, item) {
                                    return $("<li></li>")
                                        .data("ui-autocomplete-item", item)
                                        .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + " [" + item.codigo + "]</b></span></a>")
                                        .appendTo(ul);
                                };
                            }
                        }
                    },
                    {
                        name: 'NumeroPoliza', index: 'NumeroPoliza', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaPolizas').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'FechaVigencia', index: 'FechaVigencia', width: 130, sortable: false, align: 'right', editable: true, label: 'TB',
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
                    },
                    {
                        name: 'FechaVencimientoCuota', index: 'FechaVencimientoCuota', width: 130, sortable: false, align: 'right', editable: true, label: 'TB',
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
                                    if (key == 13) { setTimeout("jQuery('#ListaPolizas').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'FechaEstimadaRecupero', index: 'FechaEstimadaRecupero', width: 130, sortable: false, align: 'right', editable: true, label: 'TB',
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
                    },
                    {
                        name: 'FechaRecupero', index: 'FechaRecupero', width: 130, sortable: false, align: 'right', editable: true, label: 'TB',
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
                    },
                    {
                        name: 'FechaFinalizacionCobertura', index: 'FechaFinalizacionCobertura', width: 130, sortable: false, align: 'right', editable: true, label: 'TB',
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
                    },
                    { name: 'CondicionRecupero', index: 'CondicionRecupero', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'MotivoDeContratacionSeguro', index: 'MotivoDeContratacionSeguro', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'Observaciones', index: 'Observaciones', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            if (cellName == 'FechaVigencia') {
                jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            }
            if (cellName == 'FechaVencimientoCuota') {
                jQuery("#" + iRow + "_FechaVencimientoCuota", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            }
            if (cellName == 'FechaEstimadaRecupero') {
                jQuery("#" + iRow + "_FechaEstimadaRecupero", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            }
            if (cellName == 'FechaRecupero') {
                jQuery("#" + iRow + "_FechaRecupero", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            }
            if (cellName == 'FechaFinalizacionCobertura') {
                jQuery("#" + iRow + "_FechaFinalizacionCobertura", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            }
        },
        pager: $('#PagerPolizas'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleObraPoliza',
        sortorder: 'asc',
        viewrecords: true,
        width: '1200px', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '400px', // 'auto',
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
        caption: '<b>DETALLE POLIZAS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaPolizas").jqGrid('navGrid', '#PagerPolizas', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaPolizas").jqGrid('navButtonAdd', '#PagerPolizas',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar poliza",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaPolizas"));
                                     },
                                 });
    jQuery("#ListaPolizas").jqGrid('navButtonAdd', '#PagerPolizas',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaPolizas"));
                                     },
                                 });
    jQuery("#ListaPolizas").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });
    $("#ListaPolizas").jqGrid('setGridWidth', 500);


    $('#ListaEquipos').jqGrid({
        url: ROOT + 'Obra/DetObrasEquiposInstalados/',
        postData: { 'IdObra': function () { return $("#IdObra").val(); } },
        editurl: ROOT + 'Obra/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleObraEquipoInstalado', 'IdArticulo', 'Codigo equipo', 'Descripcion equipo', 'Cantidad', 'Fecha instalacion', 'Fecha desinstalacion', 'Observaciones'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleObraEquipoInstalado', index: 'IdDetalleObraEquipoInstalado', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    {
                        name: 'ArticuloCodigo', index: 'ArticuloCodigo', align: 'left', width: 120, editable: true, hidden: false, edittype: 'text', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataInit: function (elem) {
                                var NoResultsLabel = "No se encontraron resultados";
                                $(elem).autocomplete({
                                    source: ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',
                                    minLength: 0,
                                    select: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                            return;
                                        }
                                        var rowid = $('#ListaEquipos').getGridParam('selrow');
                                        $('#ListaEquipos').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
                                        $('#ListaEquipos').jqGrid('setCell', rowid, 'ArticuloDescripcion', ui.item.title);
                                    },
                                    focus: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                        }
                                    }
                                })
                                .data("ui-autocomplete")._renderItem = function (ul, item) {
                                    return $("<li></li>")
                                        .data("ui-autocomplete-item", item)
                                        .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.title + " [" + item.codigo + "]</b></span></a>")
                                        .appendTo(ul);
                                };
                            }
                        }
                    },
                    {
                        name: 'ArticuloDescripcion', index: 'ArticuloDescripcion', align: 'left', width: 300, editable: true, hidden: false, edittype: 'text', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataInit: function (elem) {
                                var NoResultsLabel = "No se encontraron resultados";
                                $(elem).autocomplete({
                                    source: ROOT + 'Articulo/GetArticulosAutocomplete2',
                                    minLength: 0,
                                    select: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                            return;
                                        }
                                        var rowid = $('#ListaEquipos').getGridParam('selrow');
                                        $('#ListaEquipos').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
                                        $('#ListaEquipos').jqGrid('setCell', rowid, 'ArticuloCodigo', ui.item.codigo);
                                    },
                                    focus: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                        }
                                    }
                                })
                                .data("ui-autocomplete")._renderItem = function (ul, item) {
                                    return $("<li></li>")
                                        .data("ui-autocomplete-item", item)
                                        .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + " [" + item.codigo + "]</b></span></a>")
                                        .appendTo(ul);
                                };
                            }
                        }
                    },
                    {
                        name: 'Cantidad', index: 'Cantidad', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaEquipos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'FechaInstalacion', index: 'FechaInstalacion', width: 120, sortable: false, align: 'right', editable: true, label: 'TB',
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
                    },
                    {
                        name: 'FechaDesinstalacion', index: 'FechaDesinstalacion', width: 120, sortable: false, align: 'right', editable: true, label: 'TB',
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
                    },
                    { name: 'Observaciones', index: 'Observaciones', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            if (cellName == 'FechaInstalacion') {
                jQuery("#" + iRow + "_FechaInstalacion", "#ListaEquipos").datepicker({ dateFormat: "dd/mm/yy" });
            }
            if (cellName == 'FechaDesinstalacion') {
                jQuery("#" + iRow + "_FechaDesinstalacion", "#ListaEquipos").datepicker({ dateFormat: "dd/mm/yy" });
            }
        },
        pager: $('#PagerEquipos'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleObraEquipoInstalado',
        sortorder: 'asc',
        viewrecords: true,
        width: '1200px', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '400px', // 'auto',
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
        caption: '<b>DETALLE EQUIPOS INSTALADOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaEquipos").jqGrid('navGrid', '#PagerEquipos', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaEquipos").jqGrid('navButtonAdd', '#PagerEquipos',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar equipo",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaEquipos"));
                                     },
                                 });
    jQuery("#ListaEquipos").jqGrid('navButtonAdd', '#PagerEquipos',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaEquipos"));
                                     },
                                 });
    jQuery("#ListaEquipos").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;
        var cabecera = $("#formid").serializeObject();
        //cabecera.IdProveedor = $("#IdProveedor").val();

        var chk = $('#Activa').is(':checked');
        if (chk) {
            cabecera.Activa = "SI";
        } else {
            cabecera.Activa = "NO";
        };
        var chk = $('#ActivarPresupuestoObra').is(':checked');
        if (chk) {
            cabecera.ActivarPresupuestoObra = "SI";
        } else {
            cabecera.ActivarPresupuestoObra = "NO";
        };

        cabecera.DetalleObrasPolizas = [];
        $grid = $('#ListaPolizas');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleObraPoliza'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleObraPoliza":"' + iddeta + '",';
                data1 = data1 + '"IdObra":"' + $("#IdObra").val() + '",';
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
                cabecera.DetalleObrasPolizas.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleObrasEquiposInstalados = [];
        $grid = $('#ListaEquipos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleObraEquipoInstalado'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleObraEquipoInstalado":"' + iddeta + '",';
                data1 = data1 + '"IdObra":"' + $("#IdObra").val() + '",';
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
                cabecera.DetalleObrasEquiposInstalados.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        return cabecera;
    }

    $('#grabar2').click(function () {
        var cabecera = SerializaForm();

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Obra/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Obra: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "Obra/Edit/" + result.IdObra);
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

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if (e.target.hash == "#polizas") {
            jQuery("#ListaPolizas").setGridWidth(1200);
        }
        if (e.target.hash == "#equipos") {
            jQuery("#ListaEquipos").setGridWidth(1200);
        }
    })

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

function TraerLocalidad(IdLocalidad) {
    var Localidad = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Localidad/GetLocalidadPorId/',
        data: { IdLocalidad: IdLocalidad },
        success: function (result) {
            if (result.length > 0) {
                Localidad = result[0].value;
            }
        }
    });
    return Localidad;
}

function TraerArticulo(IdArticulo) {
    var Articulo = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Articulo/GetArticuloPorId/',
        data: { IdArticulo: IdArticulo },
        success: function (result) {
            if (result.length > 0) {
                Articulo = result[0].value;
            }
        }
    });
    return Articulo;
}
