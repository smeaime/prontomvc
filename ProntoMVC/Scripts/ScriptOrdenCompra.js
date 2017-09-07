//AGREGAR ADJUNTOS A LA CABECERA

$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", mTotalImputaciones, mImporteTotal;

    pageLayout.show('east');

    if ($("#Anulada").val() == "SI") {
        $("#grabar2").prop("disabled", true);
        $("#anular").prop("disabled", true);
    }

    if ($("#IdOrdenCompra").val() > 0) {
        $("#grabar2").prop("disabled", true);
    }

    idaux = $("#IdCliente").val();
    if (idaux.length > 0) {
        MostrarDatosCliente(idaux);
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

        if (jQuery("#ListaArticulos").find(target).length) {
            $grid = $('#ListaArticulos');
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
        grid.jqGrid('setCell', Id, 'OrigenDescripcion', 1);
        grid.jqGrid('setCell', Id, 'TiposDeDescripcion', "Solo material");
        grid.jqGrid('setCell', Id, 'Cantidad', 1);
        grid.jqGrid('setCell', Id, 'NumeroItem', ProximoItem(grid));
        grid.jqGrid('setCell', Id, 'TipoCancelacion', 1);
        grid.jqGrid('setCell', Id, 'TiposCancelacion', "Por cantidad");
        grid.jqGrid('setCell', Id, 'FechaNecesidad', $("#FechaOrdenCompra").val().substring(0, 10));
        grid.jqGrid('setCell', Id, 'FacturacionAutomatica', "NO");
        grid.jqGrid('setCell', Id, 'FacturacionCompletaMensual', "NO");
    };

    var CalcularItem = function (value, colname) {
        if (colname === "Cantidad") {
            var rowid = $('#ListaArticulos').getGridParam('selrow');
            value = Number(value);
            var Cantidad = value;
            var Bonificacion = parseFloat($("#ListaArticulos").getCell(rowid, "PorcentajeBonificacion").replace(",", ".")) || 0;
            var PrecioUnitario = parseFloat($("#ListaArticulos").getCell(rowid, "Precio").replace(",", ".")) || 0;
            var Importe = CalcularImporteItem(Cantidad, PrecioUnitario, Bonificacion) || 0;
            $('#ListaArticulos').jqGrid('setCell', rowid, 'Importe', Importe[0]);
        } else {
            if (colname === "Precio") {
                var rowid = $('#ListaArticulos').getGridParam('selrow');
                value = Number(value);
                var PrecioUnitario = value;
                var Bonificacion = parseFloat($("#ListaArticulos").getCell(rowid, "PorcentajeBonificacion").replace(",", ".")) || 0;
                var Cantidad = parseFloat($("#ListaArticulos").getCell(rowid, "Cantidad").replace(",", ".")) || 0;
                var Importe = CalcularImporteItem(Cantidad, PrecioUnitario, Bonificacion) || 0;
                $('#ListaArticulos').jqGrid('setCell', rowid, 'Importe', Importe[0]);
            } else {
                if (colname === "% Bonif.") {
                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                    value = Number(value);
                    var Bonificacion = value;
                    var PrecioUnitario = parseFloat($("#ListaArticulos").getCell(rowid, "Precio").replace(",", ".")) || 0;
                    var Cantidad = parseFloat($("#ListaArticulos").getCell(rowid, "Cantidad").replace(",", ".")) || 0;
                    var Importe = CalcularImporteItem(Cantidad, PrecioUnitario, Bonificacion) || 0;
                    $('#ListaArticulos').jqGrid('setCell', rowid, 'Importe', Importe[0]);
                }
            }
        }
        return [true];
    };

    var CalcularImporteItem = function (Cantidad, PrecioUnitario, PorcentajeBonificacion) {
        var Importe1 = Math.round(PrecioUnitario * Cantidad * 10000) / 10000;
        var Bonificacion = Math.round(Importe1 * PorcentajeBonificacion / 100 * 10000) / 10000;
        var Importe = Math.round((Importe1 - Bonificacion) * 100) / 100 || 0;
        Importe = Importe.toFixed(2);

        return [Importe];
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaArticulos').jqGrid({
        url: ROOT + 'OrdenCompra/DetOrdenesCompra/',
        postData: { 'IdOrdenCompra': function () { return $("#IdOrdenCompra").val(); } },
        editurl: ROOT + 'OrdenCompra/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenCompra', 'IdArticulo', 'IdUnidad', 'IdColor', 'OrigenDescripcion', 'TipoCancelacion', 'Item', 'Codigo', 'Articulo', 'Cantidad', 'Unidad', 'Precio',
                   '% Bonif.', 'Importe', 'Tipos de descripcion', 'Tipos de cancelacion', 'Fecha de necesidad', 'Fecha de entrega', 'Facturacion automatica?', 'Fecha comienzo facturacion',
                   'Cant. meses a facturar', 'Fact. completa mensual?', 'Observaciones'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenCompra', index: 'IdDetalleOrdenCompra', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUnidad', index: 'IdUnidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdColor', index: 'IdColor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'OrigenDescripcion', index: 'OrigenDescripcion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'TipoCancelacion', index: 'TipoCancelacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'NumeroItem', index: 'NumeroItem', width: 40, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 3, defaultValue: '',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaArticulos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'Codigo', index: 'Codigo', width: 120, align: 'right', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
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
                                        event.preventDefault();
                                        $(elem).val(ui.item.label);
                                        var rowid = $('#ListaArticulos').getGridParam('selrow');
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'Articulo', ui.item.title);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'IdUnidad', ui.item.IdUnidad);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'Unidad', ui.item.Unidad);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'Precio', ui.item.CostoReposicion);
                                        CalcularItem(1, "Cantidad");
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
                                        .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + "</b></span></a>")
                                        .appendTo(ul);
                                };
                            },
                        }
                    },
                    {
                        name: 'Articulo', index: 'Articulo', align: 'left', width: 350, hidden: false, editable: true, edittype: 'text', editrules: { required: true },
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
                                        event.preventDefault();
                                        $(elem).val(ui.item.label);
                                        var rowid = $('#ListaArticulos').getGridParam('selrow');
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'Codigo', ui.item.codigo);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'IdUnidad', ui.item.IdUnidad);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'Unidad', ui.item.Unidad);
                                        $('#ListaArticulos').jqGrid('setCell', rowid, 'Precio', ui.item.CostoReposicion);
                                        CalcularItem(1, "Cantidad");
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
                                        .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + "</b></span></a>")
                                        .appendTo(ul);
                                };
                            },
                        }
                    },
                    {
                        name: 'Cantidad', index: 'Cantidad', width: 80, align: 'right', editable: true, editrules: { custom: true, custom_func: CalcularItem, required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaArticulos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'Unidad', index: 'Unidad', align: 'left', width: 50, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Unidad/GetUnidades2',
                            dataInit: function (elem) {
                                $(elem).width(45);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdUnidad', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Precio', index: 'Precio', width: 80, align: 'right', editable: true, editrules: { custom: true, custom_func: CalcularItem, required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaArticulos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'PorcentajeBonificacion', index: 'PorcentajeBonificacion', width: 80, align: 'right', editable: true, editrules: { custom: true, custom_func: CalcularItem, required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaArticulos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    { name: 'Importe', index: 'Importe', width: 100, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled', defaultValue: 0 }, label: 'TB' },
                    {
                        name: 'TiposDeDescripcion', index: 'TiposDeDescripcion', align: 'left', width: 150, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Articulo/GetTiposDeDescripcion',
                            dataInit: function (elem) {
                                $(elem).width(145);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'OrigenDescripcion', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'TiposCancelacion', index: 'TiposCancelacion', align: 'left', width: 150, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'OrdenCompra/GetTiposCancelacion',
                            dataInit: function (elem) {
                                $(elem).width(145);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'TipoCancelacion', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'FechaNecesidad', index: 'FechaNecesidad', width: 120, sortable: false, align: 'right', editable: true, label: 'TB',
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
                        name: 'FechaEntrega', index: 'FechaEntrega', width: 120, sortable: false, align: 'right', editable: true, label: 'TB',
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
                    { name: 'FacturacionAutomatica', index: 'FacturacionAutomatica', width: 100, align: 'left', editable: true, editrules: { required: false }, editoptions: { value: "SI:NO" }, edittype: 'checkbox', label: 'TB' },
                    {
                        name: 'FechaComienzoFacturacion', index: 'FechaComienzoFacturacion', width: 120, sortable: false, align: 'right', editable: true, label: 'TB',
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
                        name: 'CantidadMesesAFacturar', index: 'CantidadMesesAFacturar', width: 100, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 3, defaultValue: '',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaArticulos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    { name: 'FacturacionCompletaMensual', index: 'FacturacionCompletaMensual', width: 100, align: 'left', editable: true, editrules: { required: false }, editoptions: { value: "SI:NO" }, edittype: 'checkbox', label: 'TB' },
                    { name: 'Observaciones', index: 'Observaciones', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'textarea', label: 'TB' }
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
        loadComplete: function (data) {
            AgregarRenglonesEnBlanco({ "IdDetalleOrdenCompra": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" } , "#ListaArticulos");
        },


        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'NumeroItem',
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
        //caption: '<b>DETALLE DE ARTICULOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaArticulos").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaArticulos").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaArticulos"));
                                     },
                                 });
    jQuery("#ListaArticulos").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaArticulos"));
                                     },
                                 });
    jQuery("#ListaArticulos").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $("#ListaDrag").jqGrid({
        url: ROOT + 'OrdenCompra/TT_DynamicGridData',
        postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); } },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', '', 'IdOrdenCompra', 'IdCliente', 'IdObra', 'IdCondicionVenta', 'IdListaPrecios', 'IdMoneda', 'Nro. OC cliente', 'Numero OC', 'Fecha', 'Producido', 'Cumplido', 'Anulada',
                   'Selecc.', 'Obra', 'Codigo cliente', 'Cliente', 'CUIT', 'Aprobo', 'Remitos', 'Facturas', 'Condicion de venta', 'Items', 'Facturar a', 'Fecha anulacion', 'Usuario anulo', 'Fecha ingreso',
                   'Usuario ingreso', 'Fecha modificacion', 'Usuario modifico', 'Grupo fact.', 'Tipo OC', 'Mayor fecha entrega', 'Lista de precio', '% Bonif.', 'Importe total', 'Mon.', 'Observaciones'],
        colModel: [
                    { name: 'ver', index: 'ver', hidden: true, width: 50 },
                    { name: 'Emitir', index: 'Emitir', hidden: true, width: 50 },
                    { name: 'IdOrdenCompra', index: 'IdOrdenCompra', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdCliente', index: 'IdCliente', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdObra', index: 'IdObra', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdCondicionVenta', index: 'IdCondicionVenta', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdListaPrecios', index: 'IdListaPrecios', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdMoneda', index: 'IdMoneda', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'NumeroOrdenCompraCliente', index: 'NumeroOrdenCompraCliente', align: 'center', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'NumeroOrdenCompra', index: 'NumeroOrdenCompra', align: 'center', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'FechaOrdenCompra', index: 'FechaOrdenCompra', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Producido', index: 'Producido', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Anulada', index: 'Anulada', align: 'center', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'SeleccionadaParaFacturacion', index: 'SeleccionadaParaFacturacion', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Obra', index: 'Obra', align: 'center', width: 120, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'ClienteCodigo', index: 'ClienteCodigo', align: 'center', width: 60, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'ClienteNombre', index: 'ClienteNombre', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'ClienteCuit', index: 'ClienteCuit', align: 'center', width: 120, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Aprobo', index: 'Aprobo', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'Remitos', index: 'Remitos', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Facturas', index: 'Facturas', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'CondicionVenta', index: 'CondicionVenta', align: 'left', width: 170, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Items', index: 'Items', align: 'center', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'FacturarA', index: 'FacturarA', align: 'left', width: 170, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'FechaAnulacion', index: 'FechaAnulacion', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'UsuarioAnulo', index: 'UsuarioAnulo', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'FechaIngreso', index: 'FechaIngreso', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'UsuarioIngreso', index: 'UsuarioIngreso', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'FechaModifico', index: 'FechaModifico', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'UsuarioModifico', index: 'UsuarioModifico', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'GrupoFacturacion', index: 'GrupoFacturacion', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'TipoOC', index: 'TipoOC', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'MayorFechaEntrega', index: 'MayorFechaEntrega', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'ListaDePrecio', index: 'ListaDePrecio', align: 'left', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'PorcentajeBonificacion', index: 'PorcentajeBonificacion', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Moneda', index: 'Moneda', align: 'center', width: 40, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 500, editable: false, hidden: false }
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
    sortname: 'NumeroOrdenCompra', // 'FechaRecibo,NumeroRecibo',
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
    userDataOnFooter: true
    // ,caption: '<b>ORDENES DE COMPRA</b>'

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




    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Ordenes de compra');
    //$('a#a_panel_este_tab5').remove();  //    

    ConectarGrillas1();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });

    function ConectarGrillas1() {
        $("#ListaDrag").jqGrid('gridDnD', {
            connectWith: '#ListaArticulos',
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
        var acceptId = idsource, IdOrdenCompra = 0, mPrimerItem = true;
        var $gridOrigen = $("#ListaDrag"), $gridDestino = $("#ListaArticulos");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        try {
            IdOrdenCompra = getdata['IdOrdenCompra'];
            $("#IdCliente").val(getdata['IdCliente']);
            $("#IdObra").val(getdata['IdObra']);
            $("#IdCondicionVenta").val(getdata['IdCondicionVenta']);
            $("#IdListaPrecios").val(getdata['IdListaPrecios']);
            $("#IdMoneda").val(getdata['IdMoneda']);
            $("#Cliente").val(getdata['ClienteNombre']);
            $("#Observaciones").val(getdata['Observaciones']);
            $("#PorcentajeBonificacion").val(getdata['PorcentajeBonificacion']);

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'OrdenCompra/DetOrdenesCompraSinFormato/',
                data: { IdOrdenCompra: IdOrdenCompra },
                dataType: "Json",
                success: function (data) {
                    var prox = ProximoItem($("#ListaArticulos"));
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;

                        tmpdata['IdDetalleOrdenCompra'] = Id2;
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        tmpdata['IdColor'] = data[i].IdColor;
                        tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
                        tmpdata['TipoCancelacion'] = data[i].TipoCancelacion;
                        tmpdata['NumeroItem'] = prox;
                        tmpdata['Codigo'] = data[i].Codigo;
                        tmpdata['Articulo'] = data[i].Articulo;
                        tmpdata['Cantidad'] = data[i].Cantidad;
                        tmpdata['Unidad'] = data[i].Unidad;
                        tmpdata['Precio'] = data[i].Precio;
                        tmpdata['PorcentajeBonificacion'] = data[i].PorcentajeBonificacion;
                        tmpdata['Importe'] = data[i].Importe;
                        tmpdata['TiposDeDescripcion'] = data[i].TiposDeDescripcion;
                        tmpdata['TiposCancelacion'] = data[i].TiposCancelacion;
                        var now = new Date();
                        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                        tmpdata['FechaNecesidad'] = currentDate;
                        tmpdata['FacturacionAutomatica'] = data[i].FacturacionAutomatica;
                        tmpdata['FechaComienzoFacturacion'] = data[i].FechaComienzoFacturacion;
                        tmpdata['Observaciones'] = data[i].Observaciones;
                        //date = new Date(parseInt(data[i].Fecha.substr(6)));
                        //displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        //data2.Fecha = displayDate;

                        prox++;
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
                        ActualizarDatos();
                    }
                }
            });
        } catch (e) { }

        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    $("#IdCondicionVenta").change(function () {
        //var fechaFinal = CalcularFechaVencimiento($("#FechaFactura").val());
        //$("#FechaVencimiento").val(fechaFinal);
    })

    $("#PorcentajeBonificacion").change(function () {
        CalcularTotales()
    })

    $("#Aprobo").change(function () {
        var IdAprobo = $("#Aprobo > option:selected").attr("value");
        var Aprobo = $("#Aprobo > option:selected").html();
        $("#Aux1").val(IdAprobo);
        $("#Aux2").val(Aprobo);
        $("#Aux3").val("");
        $("#Aux10").val("");
        $('#dialog-password').data('Combo', 'Aprobo');
        $('#dialog-password').dialog('open');
        $('#mySelect').focus(); // esto es clave, para que no me cierre el cuadro de dialogo al recibir un posible enter apretado en el change
    });

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();

        cabecera.NumeroOrdenCompra = $("#NumeroOrdenCompra").val();
        cabecera.Cliente = "";
        cabecera.Provincia = "";

        cabecera.DetalleOrdenesCompras = [];
        $grid = $('#ListaArticulos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleOrdenCompra'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleOrdenCompra":"' + iddeta + '",';
                data1 = data1 + '"IdOrdenCompra":"' + $("#IdOrdenCompra").val() + '",';
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
                cabecera.DetalleOrdenesCompras.push(data2);
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
            url: ROOT + 'OrdenCompra/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ OrdenCompra: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "OrdenCompra/Edit/" + result.IdOrdenCompra);
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

    //$("#Upload").click(function () {
    //    var formData = new FormData();
    //    var totalFiles = document.getElementById("FileUpload").files.length;
    //    for (var i = 0; i < totalFiles; i++) {
    //        var file = document.getElementById("FileUpload").files[i];
    //        formData.append("FileUpload", file);
    //    }
    //    $.ajax({
    //        type: "POST",
    //        url: ROOT + 'OrdenCompra/Upload',
    //        data: formData,
    //        dataType: 'json',
    //        contentType: false,
    //        processData: false,
    //        success: function (response) {
    //            alert('succes!!');
    //        },
    //        error: function (error) {
    //            alert("errror");
    //        }
    //    });
    //});

    $('#fileupload').fileupload({
        dataType: 'json',
        url: ROOT + 'Home/UploadFiles',
        autoUpload: true,
        done: function (e, data) {
            var i = ProximoAdjuntoLibre();
            if (i==0){
                alert("No hay mas adjuntos disponibles");
                return
            }
            $("#ArchivoAdjunto"+i).val(data.result.name)
            //$('.file_name').html(data.result.name);
            //$('.file_type').html(data.result.type);
            //$('.file_size').html(data.result.size);
        }
    }).on('fileuploadprogressall', function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('.progress .progress-bar').css('width', progress + '%');
    });

});

function ActualizarDatos() {
    var IdCodigoIva = 0, Letra = "B", id = 0;

    id = $("#IdCliente").val();
    if (id.length > 0) {
        MostrarDatosCliente(id);
    }

    id = $("#OrdenCompra").val() || 0;
    if (id <= 0) {
    }

    calculaTotalImputaciones();
}

calculaTotalImputaciones = function () {
    var imp = 0, imp2 = 0, grav = "", letra = "";

    var dataIds = $('#ListaArticulos').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaArticulos').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalImputaciones = imp2;
    $("#ListaArticulos").jqGrid('footerData', 'set', { Precio: 'TOTALES', Importe: imp2.toFixed(2) });

    CalcularTotales()
};

function CalcularTotales() {
    var mSubtotal = 0, mIdOrdenCompra = 0, mIdCliente = 0, mIdMoneda = 0, mPorcentajeBonificacion = 0, mImporteBonificacion = 0, mFecha, datos1;

    mIdOrdenCompra = $("#IdOrdenCompra").val();

    if (typeof mTotalImputaciones == "undefined") { mTotalImputaciones = 0; }
    mSubtotal = mTotalImputaciones;

    mPorcentajeBonificacion = parseFloat($("#PorcentajeBonificacion").val().replace(",", ".") || 0) || 0;
    mImporteBonificacion = Math.round((mSubtotal * mPorcentajeBonificacion / 100) * 10000) / 10000;

    mIdCliente = $("#IdCliente").val();
    mIdMoneda = $("#IdMoneda").val();
    mFecha = $("#FechaOrdenCompra").val();

    mImporteTotal = mSubtotal - mImporteBonificacion;

    $("#Subtotal").val(mSubtotal.toFixed(2));
    $("#Bonificacion").val(mImporteBonificacion.toFixed(2));
    $("#ImporteTotal").val(mImporteTotal.toFixed(2));
};

function ProximoAdjuntoLibre() {
    for (i = 1; i <= 6; i++) {
        var adj = $("#ArchivoAdjunto" + i).val();
        if (adj.length == 0) { return i;}
    }
    return 0;
}

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

function ProximoItem(grid) {
    var totalCantidad = grid.jqGrid('getCol', 'NumeroItem', false, 'max')
    return (totalCantidad || 0) + 1;
}
