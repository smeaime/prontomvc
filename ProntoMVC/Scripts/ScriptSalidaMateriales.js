
// FALTA INICIALIZAR EQUIPOS DESTINO Y ORDENES DE TRABAJO AL CARGAR UNA SALIDA YA GRABADA (HAY QUE BUSCAR EL DATO EN MANTENIMIENTO)

$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "";

    pageLayout.show('east');

    if ($("#Anulada").val() == "SI") {
        $("#grabar2").prop("disabled", true);
        $("#anular").prop("disabled", true);
    }

    ActualizarDatos()

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
        var data, j, cm, IdObra, Obra;

        IdObra = $('select#IdObraOrigen').val() || 0;
        Obra = $("#IdObraOrigen option:selected").text() || "";

        data = '{';
        for (j = 1; j < colModel.length; j++) {
            cm = colModel[j];
            data = data + '"' + cm.index + '":' + '"",';
        }
        data = data.substring(0, data.length - 1) + '}';
        data = data.replace(/(\r\n|\n|\r)/gm, "");
        grid.jqGrid('addRowData', Id, data);
        grid.jqGrid('setCell', Id, 'Cantidad', 1);
        if (IdObra > 0) {
            grid.jqGrid('setCell', Id, 'IdObra', IdObra);
            grid.jqGrid('setCell', Id, 'Obra', Obra);
        }
            
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaArticulos').jqGrid({
        url: ROOT + 'SalidaMateriales/DetSalidaMateriales/',
        postData: { 'IdSalidaMateriales': function () { return $("#IdSalidaMateriales").val(); } },
        editurl: ROOT + 'SalidaMateriales/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleSalidaMateriales', 'IdArticulo', 'IdUnidad', 'IdColor', 'IdUbicacion', 'IdUbicacionDestino', 'IdObra', 'IdDetalleRecepcion', 'IdDetalleValeSalida', 'IdOrdenTrabajo',
                   'IdDetalleRequerimiento', 'IdMoneda', 'IdEquipoDestino', 'IdPresupuestoObrasNodo', 
                   'Numero recepcion', 'Numero vale', 'Numero RM', 'Item RM', 'Codigo', 'Articulo', 'Cantidad', 'Un.', 'Ubicacion', 'Ubicacion destino', 'Obra', 'Partida', 'Costo Un.', 'Mon.',
                   'Fecha imputacion', 'Equipo destino', 'Orden de trabajo', 'Etapa de presupuesto obra', 'Observaciones'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleSalidaMateriales', index: 'IdDetalleSalidaMateriales', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUnidad', index: 'IdUnidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdColor', index: 'IdColor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUbicacion', index: 'IdUbicacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUbicacionDestino', index: 'IdUbicacionDestino', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdObra', index: 'IdObra', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDetalleRecepcion', index: 'IdDetalleRecepcion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDetalleValeSalida', index: 'IdDetalleValeSalida', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdOrdenTrabajo', index: 'IdOrdenTrabajo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDetalleRequerimiento', index: 'IdDetalleRequerimiento', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdMoneda', index: 'IdMoneda', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdEquipoDestino', index: 'IdEquipoDestino', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdPresupuestoObrasNodo', index: 'IdPresupuestoObrasNodo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },

                    { name: 'NumeroRecepcionAlmacen', index: 'NumeroRecepcionAlmacen', width: 60, align: 'right', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    { name: 'NumeroValeSalida', index: 'NumeroValeSalida', width: 50, align: 'right', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', width: 50, align: 'right', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    { name: 'ItemRM', index: 'ItemRM', width: 30, align: 'center', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    {
                        name: 'Codigo', index: 'Codigo', width: 120, align: 'center', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
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
                                        //.append("<a>" + item.value + "<br>" + item.title + "</a>")
                                        .appendTo(ul);
                                };
                            },
                        }
                    },
                    {
                        name: 'Cantidad', index: 'Cantidad', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 12, defaultValue: '',
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
                        name: 'Unidad', index: 'Unidad', align: 'left', width: 30, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, 
                        editoptions: {
                            dataUrl: ROOT + 'Unidad/GetUnidades2',
                            dataInit: function (elem) {
                                $(elem).width(25);
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
                        name: 'Ubicacion', index: 'Ubicacion', align: 'left', width: 120, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            //dataUrl: ROOT + 'Ubicacion/GetUbicaciones',
                            dataInit: function (elem) {
                                $(elem).width(115);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdUbicacion', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'UbicacionDestino', index: 'UbicacionDestino', align: 'left', width: 120, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            //dataUrl: ROOT + 'Ubicacion/GetUbicaciones',
                            dataInit: function (elem) {
                                $(elem).width(115);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdUbicacionDestino', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Obra', index: 'Obra', align: 'left', width: 120, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, 
                        editoptions: {
                            dataUrl: ROOT + 'Obra/GetObrasCodigo',
                            dataInit: function (elem) {
                                $(elem).width(115);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdObra', this.value);
                                }
                            }]
                        },
                    },
                    { name: 'Partida', index: 'Partida', width: 80, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    {
                        name: 'CostoUnitario', index: 'CostoUnitario', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 12, defaultValue: '',
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
                        name: 'Moneda', index: 'Moneda', align: 'left', width: 30, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Moneda/GetMonedas2',
                            dataInit: function (elem) {
                                $(elem).width(25);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdMoneda', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'FechaImputacion', index: 'FechaImputacion', width: 130, sortable: false, align: 'right', editable: true, label: 'TB',
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
                        name: 'EquipoDestino', index: 'EquipoDestino', align: 'left', width: 250, editable: true, hidden: false, 
            edittype: 'select', editrules: { required: false },
                        editoptions: {
                            //dataUrl: ROOT + 'Ubicacion/GetUbicaciones',
                            dataInit: function (elem) {
                                $(elem).width(240);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdEquipoDestino', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'OrdenTrabajo', index: 'OrdenTrabajo', align: 'left', width: 120, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            //dataUrl: ROOT + 'Ubicacion/GetUbicaciones',
                            dataInit: function (elem) {
                                $(elem).width(115);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdOrdenTrabajo', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'PresupuestoObrasEtapa', index: 'PresupuestoObrasEtapa', align: 'left', width: 250, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            //dataUrl: ROOT + 'Ubicacion/GetUbicaciones',
                            dataInit: function (elem) {
                                $(elem).width(240);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaArticulos').getGridParam('selrow');
                                    $('#ListaArticulos').jqGrid('setCell', rowid, 'IdPresupuestoObrasNodo', this.value);
                                }
                            }]
                        },
                    },
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
            var listdata = "";
            if (cellname == 'Ubicacion') {
                listdata = GetUbicaciones(rowid, cellname);
                //if (listdata == null) listdata = "1:1";
                jQuery("#ListaArticulos").setColProp(cellname, { editoptions: { value: listdata.toString() } })
            }
            if (cellname == 'UbicacionDestino') {
                listdata = GetUbicaciones(rowid, cellname);
                jQuery("#ListaArticulos").setColProp(cellname, { editoptions: { value: listdata.toString() } })
            }
            if (cellname == 'EquipoDestino') {
                listdata = GetEquiposDestino();
                jQuery("#ListaArticulos").setColProp(cellname, { editoptions: { value: listdata.toString() } })
            }
            if (cellname == 'OrdenTrabajo') {
                listdata = GetOrdenesTrabajo(rowid);
                jQuery("#ListaArticulos").setColProp(cellname, { editoptions: { value: listdata.toString() } })
            }
            if (cellname == 'PresupuestoObrasEtapa') {
                listdata = GetPresupuestoObraEtapas(rowid);
                jQuery("#ListaArticulos").setColProp(cellname, { editoptions: { value: listdata.toString() } })
            }
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        afterSaveCell: function (rowid) {
            //calculaTotalImputaciones();
        },
        gridComplete: function () {
            //calculaTotalImputaciones();
        },
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleSalidaMateriales',
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
        caption: '<b>DETALLE DE ARTICULOS</b>',
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
        url: ROOT + 'Recepcion/RecepcionesPendientesDeSalidaMateriales',
        //postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'PendienteSalidaMateriales': "SI" },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdDetalleRecepcion', 'IdArticulo', 'IdUnidad', 'IdColor', 'IdUbicacion', 'IdObra', 'IdControlCalidad', 'IdDetalleRequerimiento', 'IdDetallePedido', 'IdProveedor',
                   'Nro. recepcion', 'Nro. remito', 'Fecha recepcion', 'Numero RM', 'Item RM', 'Numero pedido', 'Item PE', 'Codigo', 'Descripcion', 'Cantidad', 
                   'Un.', 'Ubicacion', 'Obra', 'Proveedor', 'Partida', 'Control de calidad', 'Observaciones'],
        colModel: [
                    { name: 'ver', index: 'ver', hidden: true, width: 50 },
                    { name: 'IdDetalleRecepcion', index: 'IdDetalleRecepcion', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdArticulo', index: 'IdArticulo', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdUnidad', index: 'IdUnidad', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdColor', index: 'IdColor', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdUbicacion', index: 'IdUbicacion', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdObra', index: 'IdObra', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdControlCalidad', index: 'IdControlCalidad', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdDetalleRequerimiento', index: 'IdDetalleRequerimiento', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdDetallePedido', index: 'IdDetallePedido', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdProveedor', index: 'IdProveedor', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'NumeroRecepcionAlmacen', index: 'NumeroRecepcionAlmacen', align: 'right', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'NumeroRecepcion', index: 'NumeroRecepcion', align: 'right', width: 100, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'FechaRecepcion', index: 'FechaRecepcion', width: 70, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'ItemRM', index: 'ItemRM', align: 'center', width: 30, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'NumeroPedido', index: 'NumeroPedido', align: 'right', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'ItemPE', index: 'ItemPE', align: 'center', width: 30, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'ArticuloCodigo', index: 'ArticuloCodigo', align: 'center', width: 100, editable: false, hidden: false },
                    { name: 'ArticuloDescripcion', index: 'ArticuloDescripcion', align: 'left', width: 300, editable: false, hidden: false },
                    { name: 'Cantidad', index: 'Cantidad', align: 'right', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Unidad', index: 'Unidad', align: 'center', width: 40, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Ubicacion', index: 'Ubicacion', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'Obra', index: 'Obra', align: 'left', width: 100, editable: false, hidden: false },
                    { name: 'Proveedor', index: 'Proveedor', align: 'left', width: 200, editable: false, hidden: false },
                    { name: 'Partida', index: 'Partida', align: 'left', width: 70, editable: false, hidden: false },
                    { name: 'ControlCalidad', index: 'ControlCalidad', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 300, editable: false, hidden: false }
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
        sortname: 'NumeroRecepcionAlmacen',
        sortorder: "desc",
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
    })
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });

    $("#ListaDrag2").jqGrid({
        url: ROOT + 'ValeSalida/ValesSalidaPendientesDeSalidaMateriales',
        //postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'PendienteSalidaMateriales': "SI" },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdDetalleValeSalida', 'IdValeSalida', 'IdArticulo', 'Numero Vale', 'Fecha Vale', 'Codigo', 'Descripcion', 'Cantidad',
                   'Un.', 'Entregado', 'Pendiente', 'Obra', 'Aprobo', 'Ubicacion', 'Observaciones', 'Observaciones RM', 'Equipo destino'],
        colModel: [
                    { name: 'ver', index: 'ver', hidden: true, width: 50 },
                    { name: 'IdDetalleValeSalida', index: 'IdDetalleValeSalida', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdValeSalida', index: 'IdValeSalida', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdArticulo', index: 'IdArticulo', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'NumeroValeSalida', index: 'NumeroValeSalida', align: 'right', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'FechaValeSalida', index: 'FechaValeSalida', width: 70, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'ArticuloCodigo', index: 'ArticuloCodigo', align: 'center', width: 100, editable: false, hidden: false },
                    { name: 'ArticuloDescripcion', index: 'ArticuloDescripcion', align: 'left', width: 300, editable: false, hidden: false },
                    { name: 'Cantidad', index: 'Cantidad', align: 'right', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Unidad', index: 'Unidad', align: 'center', width: 40, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Entregado', index: 'Entregado', align: 'right', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Pendiente', index: 'Pendiente', align: 'right', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn','eq']  } },
                    { name: 'Obra', index: 'Obra', align: 'left', width: 100, editable: false, hidden: false },
                    { name: 'Aprobo', index: 'Aprobo', align: 'left', width: 100, editable: false, hidden: false },
                    { name: 'Ubicacion', index: 'Ubicacion', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 300, editable: false, hidden: false },
                    { name: 'ObservacionesRM', index: 'ObservacionesRM', align: 'left', width: 300, editable: false, hidden: false },
                    { name: 'EquipoDestino', index: 'EquipoDestino', align: 'left', width: 300, editable: false, hidden: false }
        ],
        ondblClickRow: function (id) {
            Copiar2(id, "Dbl");
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag2 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager2'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroValeSalida',
        sortorder: "desc",
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
    })
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });

    ActualizarGrillas();

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Recepciones pendientes');
    $('a#a_panel_este_tab2').text('Vales pendientes');

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

    function ConectarGrillas2() {
        $("#ListaDrag2").jqGrid('gridDnD', {
            connectWith: '#ListaArticulos',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                Copiar2($(ui.draggable).attr("id"), "DnD");
                //var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                //var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
            }
        });
    }

    function Copiar1(idsource, Origen) {
        var acceptId = idsource, IdEntidad = 0, mPrimerItem = true, IdObra = 0;
        var $gridOrigen = $("#ListaDrag"), $gridDestino = $("#ListaArticulos");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        try {
            IdEntidad = getdata['IdDetalleRecepcion'];
            IdObra = getdata['IdObra'];

            $("#IdProveedor").val(getdata['IdProveedor']);
            $("#Proveedor").val(getdata['Proveedor']);
            $("#IdObra").val(getdata['IdObra']);

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Recepcion/DetRecepcionesSinFormato/',
                data: { IdDetalleRecepcion: IdEntidad },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;
                        tmpdata['IdDetalleSalidaMateriales'] = Id2;
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        tmpdata['IdColor'] = data[i].IdColor;
                        tmpdata['IdUbicacion'] = data[i].IdUbicacion;
                        tmpdata['IdObra'] = data[i].IdObra;
                        tmpdata['IdDetalleRecepcion'] = data[i].IdDetalleRecepcion;
                        tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                        tmpdata['NumeroRecepcionAlmacen'] = data[i].NumeroRecepcionAlmacen;
                        tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                        tmpdata['ItemRM'] = data[i].ItemRM;
                        tmpdata['Codigo'] = data[i].ArticuloCodigo;
                        tmpdata['Articulo'] = data[i].ArticuloDescripcion;
                        tmpdata['Cantidad'] = data[i].Cantidad;
                        tmpdata['Unidad'] = data[i].Unidad;
                        tmpdata['Obra'] = data[i].Obra;
                        tmpdata['Partida'] = data[i].Partida;
                        tmpdata['Observaciones'] = data[i].Observaciones;

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
                    }
                    ActualizarDatos();
                }
            });
        } catch (e) { }

        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    function Copiar2(idsource, Origen) {
        var acceptId = idsource, IdEntidad = 0, mPrimerItem = true, IdObra = 0;
        var $gridOrigen = $("#ListaDrag2"), $gridDestino = $("#ListaArticulos");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        try {
            IdEntidad = getdata['IdDetalleValeSalida'];

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'ValeSalida/DetValesSalidaSinFormato/',
                data: { IdDetalleValeSalida: IdEntidad },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;
                        tmpdata['IdDetalleSalidaMateriales'] = Id2;
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        tmpdata['IdObra'] = data[i].IdObra;
                        tmpdata['IdDetalleValeSalida'] = data[i].IdDetalleValeSalida;
                        tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                        tmpdata['NumeroValeSalida'] = data[i].NumeroValeSalida;
                        tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                        tmpdata['ItemRM'] = data[i].ItemRM;
                        tmpdata['Codigo'] = data[i].ArticuloCodigo;
                        tmpdata['Articulo'] = data[i].ArticuloDescripcion;
                        tmpdata['Cantidad'] = data[i].Pendiente;
                        tmpdata['Unidad'] = data[i].Unidad;
                        tmpdata['Obra'] = data[i].Obra;
                        tmpdata['Partida'] = data[i].Partida;

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
                    }
                    ActualizarDatos();
                }
            });
        } catch (e) { }

        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    $("#TipoSalida").change(function () {
        TraerNumeroComprobante()
        var TipoSalida = $(this).val();
        //IdCuentaGasto = $('select#IdCuentaGasto').val() || 0;
        if (TipoSalida == 4) {
            $('#IdObra:input').removeAttr('disabled');
        } else {
            $("#IdObra").val("");
            $('#IdObra:input').attr('disabled', 'disabled');
        }
    });

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();
        cabecera.Obra = "";

        cabecera.DetalleSalidasMateriales = [];
        $grid = $('#ListaArticulos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleSalidaMateriales'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleSalidaMateriales":"' + iddeta + '",';
                data1 = data1 + '"IdSalidaMateriales":"' + $("#IdSalidaMateriales").val() + '",';
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
                cabecera.DetalleSalidasMateriales.push(data2);
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
            url: ROOT + 'SalidaMateriales/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ SalidaMateriales: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "SalidaMateriales/Edit/" + result.IdSalidaMateriales);
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
    var id = 0, ProntoIni = "";

    id = $("#IdProveedor").val();
    if (id.length > 0) { MostrarDatosProveedor(id); }
}

function ActualizarGrillas() {
    var ProntoIni = "";

    ProntoIni = $("#ProntoIni_OcultarCosto").val();
    if (ProntoIni == "SI") {
        $("#ListaArticulos").hideCol("CostoUnitario")
        $("#ListaArticulos").hideCol("Moneda")
    }
    ProntoIni = $("#ProntoIni_OcultarEquipoDestino_OT").val();
    if (ProntoIni == "SI") {
        $("#ListaArticulos").hideCol("EquipoDestino")
        $("#ListaArticulos").hideCol("OrdenTrabajo")
    }
    ProntoIni = $("#ProntoIni_ActivarFechaImputacion").val();
    if (ProntoIni == "SI") {
        jQuery("#ListaArticulos").jqGrid('showCol', ["FechaImputacion"]);
    } else {
        jQuery("#ListaArticulos").jqGrid('hideCol', ["FechaImputacion"]);
    }

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

function MostrarDatosProveedor(Id) {
    var Entidad = "";
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Proveedor/GetProveedorPorId/',
        data: { Id: Id },
        success: function (result) {
            if (result.length > 0) {
                Entidad = result[0].value;
                $("#Proveedor").val(Entidad);
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

function TraerNumeroComprobante() {
    var Id = $("#IdSalidaMateriales").val() || -1;
    var TipoSalida = $('select#TipoSalida').val() || -1;

    if (Id <= 0) {
        $.ajax({
            type: "GET",
            async: false,
            url: ROOT + 'Parametro/Parametros2/',
            data: { TipoSalida: TipoSalida },
            contentType: "application/json",
            dataType: "json",
            success: function (result) {
                $("#NumeroSalidaMateriales2").val(result.mAuxI1);
                $("#NumeroSalidaMateriales").val(result.mAuxI2);
            }
        });
    } else {
        $("#grabar2").prop("disabled", true);
    }
}

function GetUbicaciones(rowid, columna) {
    var Opciones = "0:;", IdObra = 0;

    if (columna == "Ubicacion") {
        IdObra = $("#ListaArticulos").getCell(rowid, "IdObra") || -1;
    } else {
        IdObra = $("#IdObra").val() || -1;
    }
    var IdArticulo = $("#ListaArticulos").getCell(rowid, "IdArticulo") || -1;

    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Ubicacion/GetUbicacionesPorObra2',
        data: { IdObra: IdObra, IdDeposito: -1, IdArticulo: IdArticulo, IdUsuario: -1 },
        success: function (result) {
            if (result.length > 0) {
                for (var i = 0; i < result.length; i++) {
                    var data1 = result[i]
                    Opciones = Opciones + '' + data1.id + ':' + data1.value + ';';
                }
            }
        }
    });
    Opciones = Opciones.substring(0, Opciones.length - 1);
    Opciones = Opciones.replace(/(\r\n|\n|\r)/gm, "");
    return Opciones;
}

function GetEquiposDestino() {
    var Opciones = "0:;";
    var IdObra = $("#IdObraOrigen").val() || -1;

    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'Articulo/GetEquiposPorObra',
        data: { IdObra: IdObra },
        success: function (result) {
            if (result.length > 0) {
                for (var i = 0; i < result.length; i++) {
                    var data1 = result[i]
                    Opciones = Opciones + '' + data1.id + ':' + data1.value + ';';
                }
            }
        }
    });
    Opciones = Opciones.substring(0, Opciones.length - 1);
    Opciones = Opciones.replace(/(\r\n|\n|\r)/gm, "");
    return Opciones;
}

function GetOrdenesTrabajo(rowid) {
    var Opciones = "0:;";
    var IdEquipoDestino = $("#ListaArticulos").getCell(rowid, "IdEquipoDestino") || -1;

    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'OrdenTrabajo/GetOrdenesTrabajo',
        data: { IdEquipoDestino: IdEquipoDestino },
        success: function (result) {
            if (result.length > 0) {
                for (var i = 0; i < result.length; i++) {
                    var data1 = result[i]
                    Opciones = Opciones + '' + data1.id + ':' + data1.value + ';';
                }
            }
        }
    });
    Opciones = Opciones.substring(0, Opciones.length - 1);
    Opciones = Opciones.replace(/(\r\n|\n|\r)/gm, "");
    return Opciones;
}

function GetPresupuestoObraEtapas(rowid) {
    var Opciones = "0:;";
    var IdObra = $("#IdObraOrigen").val() || 0;

    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'PresupuestoObra/GetPresupuestoObraEtapas',
        data: { IdObra: IdObra },
        success: function (result) {
            if (result.length > 0) {
                for (var i = 0; i < result.length; i++) {
                    var data1 = result[i]
                    Opciones = Opciones + '' + data1.id + ':' + data1.value + ';';
                }
            }
        }
    });
    Opciones = Opciones.substring(0, Opciones.length - 1);
    Opciones = Opciones.replace(/(\r\n|\n|\r)/gm, "");
    return Opciones;
}

function ActualizarDatosPresupuestoObra(rowid) {
    var IdPresupuestoObrasNodo = $("#ListaArticulos").getCell(rowid, "IdPresupuestoObrasNodo") || -1;

    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'PresupuestoObra/GetPresupuestoObraPorId',
        data: { Id: IdPresupuestoObrasNodo },
        success: function (result) {
            if (result.length > 0) {
                $('#ListaArticulos').jqGrid('setCell', rowid, 'PresupuestoObrasEtapa', result[0].value);
            }
        }
    });
}
