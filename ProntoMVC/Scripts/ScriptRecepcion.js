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
        grid.jqGrid('setCell', Id, 'Cantidad', 1);
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'Recepcion/DetRecepcion/',
        postData: { 'IdRecepcion': function () { return $("#IdRecepcion").val(); } },
        editurl: ROOT + 'Recepcion/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleRecepcion', 'IdArticulo', 'IdUnidad', 'IdColor', 'IdUbicacion', 'IdObra', 'IdControlCalidad', 'IdDetalleRequerimiento', 'IdDetallePedido',
                   'Numero RM', 'Item RM', 'Numero Pedido', 'Item PE', 'Codigo', 'Articulo', 'Cantidad', 'Unidad', 'Ubicacion', 'Obra', 'Partida', 'Recepcionado', 'Control de calidad',
                   'Observaciones'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleRecepcion', index: 'IdDetalleRecepcion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUnidad', index: 'IdUnidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdColor', index: 'IdColor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUbicacion', index: 'IdUbicacion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdObra', index: 'IdObra', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdControlCalidad', index: 'IdControlCalidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDetalleRequerimiento', index: 'IdDetalleRequerimiento', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDetallePedido', index: 'IdDetallePedido', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', width: 80, align: 'right', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    { name: 'ItemRM', index: 'ItemRM', width: 50, align: 'center', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    { name: 'NumeroPedido', index: 'NumeroPedido', width: 80, align: 'right', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    { name: 'ItemPE', index: 'ItemPE', width: 50, align: 'center', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
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
                                        var rowid = $('#Lista').getGridParam('selrow');
                                        $('#Lista').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
                                        $('#Lista').jqGrid('setCell', rowid, 'Articulo', ui.item.title);
                                        $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', ui.item.IdUnidad);
                                        $('#Lista').jqGrid('setCell', rowid, 'Unidad', ui.item.Unidad);
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
                                        var rowid = $('#Lista').getGridParam('selrow');
                                        $('#Lista').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
                                        $('#Lista').jqGrid('setCell', rowid, 'Codigo', ui.item.codigo);
                                        $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', ui.item.IdUnidad);
                                        $('#Lista').jqGrid('setCell', rowid, 'Unidad', ui.item.Unidad);
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
                                    if (key == 13) { setTimeout("jQuery('#Lista').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'Unidad', index: 'Unidad', align: 'left', width: 50, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, 
                        editoptions: {
                            dataUrl: ROOT + 'Unidad/GetUnidades2',
                            dataInit: function (elem) {
                                $(elem).width(45);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#Lista').getGridParam('selrow');
                                    $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Ubicacion', index: 'Ubicacion', align: 'left', width: 120, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, 
                        editoptions: {
                            dataUrl: ROOT + 'Ubicacion/GetUbicaciones',
                            dataInit: function (elem) {
                                $(elem).width(115);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#Lista').getGridParam('selrow');
                                    $('#Lista').jqGrid('setCell', rowid, 'IdUbicacion', this.value);
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
                                    var rowid = $('#Lista').getGridParam('selrow');
                                    $('#Lista').jqGrid('setCell', rowid, 'IdObra', this.value);
                                }
                            }]
                        },
                    },
                    { name: 'Partida', index: 'Partida', width: 80, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'Recepcionado', index: 'Recepcionado', width: 100, align: 'right', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
                    { name: 'ControlCalidad', index: 'ControlCalidad', width: 100, align: 'left', editable: false, editoptions: { disabled: 'disabled', defaultValue: 0 } },
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
            //calculaTotalImputaciones();
        },
        gridComplete: function () {
            //calculaTotalImputaciones();
        },
        loadComplete: function () {
            //AgregarItemVacio(jQuery("#Lista"));
            AgregarRenglonesEnBlanco({ "IdDetalleRecepcion": "0", "IdArticulo": "0", "Cantidad": "0", "Articulo": "" });
        },
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleRecepcion',
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
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#Lista"));
                                     },
                                 });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#Lista"));
                                     },
                                 });
    jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $("#ListaDrag").jqGrid({
        url: ROOT + 'Pedido/Pedidos_Pendientes2_DynamicGridData',
        postData: { 'Destino': "Recepcion" },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdPedido', 'IdProveedor', 'IdCondicionCompra', 'Numero', 'Sub', 'Fecha', 'Salida', 'Cumplido', 'RMs', 'Obras', 'Cod. prov.', 'Proveedor', 'Subtotal', 'Bonif.',
                   'IVA', 'Otros', 'Imp. Int.', 'Total pedido', 'Mon.', 'Comprador', 'Aprobo', 'Items', 'Comparativa', 'Tipo compra', 'Observaciones', 'Cond. compra', 'Detalle cond. compra',
                   'Exterior', 'Nro. licitacion', 'Impresa', 'Anuló', 'Fecha anulacion', 'Motivo anulacion', 'Equipos destino', 'Circ. firma completo', 'Condicion iva', 'Fecha envio',
                   'Detalles generales'
        ],
        colModel: [
                    { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, frozen: true, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                    { name: 'IdPedido', index: 'IdPedido', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'IdProveedor', index: 'IdProveedor', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'IdCondicionCompra', index: 'IdCondicionCompra', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'NumeroPedido', index: 'NumeroPedido', align: 'right', width: 70, frozen: true, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'SubNumero', index: 'SubNumero', align: 'right', width: 30, frozen: true, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    {
                        name: 'FechaPedido', index: 'FechaPedido', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    {
                        name: 'FechaSalida', index: 'FechaSalida', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'Cumplido', index: 'Cumplido', align: 'left', width: 40, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Requerimientos', index: 'Requerimientos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Obras', index: 'Obras', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'ProveedoresCodigo', index: 'ProveedoresCodigo', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'ProveedoresNombre', index: 'ProveedoresNombre', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'TotalGravado', index: 'TotalGravado', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'ImporteBonificacion', index: 'ImporteBonificacion', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'ImporteIva1', index: 'ImporteIva1', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'OtrosConceptos', index: 'OtrosConceptos', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'ImpuestosInternos', index: 'ImpuestosInternos', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'Moneda', index: 'Moneda', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Comprador', index: 'Comprador', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'LiberadoPor', index: 'LiberadoPor', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'CantidadItems', index: 'CantidadItems', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'NumeroComparativa', index: 'NumeroComparativa', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'TiposCompra', index: 'TiposCompra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'CondicionCompra', index: 'CondicionCompra', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'DetalleCondicionCompra', index: 'DetalleCondicionCompra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'PedidoExterior', index: 'PedidoExterior', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'NumeroLicitacion', index: 'NumeroLicitacion', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'Impresa', index: 'Impresa', align: 'left', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'UsuarioAnulo', index: 'UsuarioAnulo', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    {
                        name: 'FechaAnulacion', index: 'FechaAnulacion', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'MotivoAnulacion', index: 'MotivoAnulacion', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'EquipoDestino', index: 'EquipoDestino', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'CircuitoFirmasCompleto', index: 'CircuitoFirmasCompleto', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'DescripcionIva', index: 'DescripcionIva', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    {
                        name: 'FechaEnvioProveedor', index: 'FechaEnvioProveedor', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'Detalle', index: 'Detalle', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } }
        ],
        ondblClickRow: function (id) {
            CopiarPE(id);
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager'),
    rowNum: 15,
    rowList: [10, 20, 50],
    sortname: 'NumeroPedido', // 'FechaRecibo,NumeroRecibo',
    sortorder: 'desc',
    viewrecords: true,
    emptyrecords: 'No hay registros para mostrar', 
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
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
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
    }); 

    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Pedido/Pedidos_Pendientes_DynamicGridData',
        //postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'PendienteRecepcion': "SI" },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdDetallePedido', 'IdPedido', 'IdProveedor', 'IdObra', 'IdArticulo', 'IdUnidad', 'Numero Pedido', 'Sub', 'Item PE', 'Fecha pedido', 'Proveedor', 'Obra', 'Comprador',
                   'Solicito RM', 'Fecha entrega', 'Codigo', 'Descripcion', 'Observaciones RM', 'Observaciones PE', 'Cantidad', 'Un.', 'Entregado', 'Pendiente', 'Numero RM', 'Item RM', 'Cump',
                   'Tipo compra', 'Circ. Compl. Firmas', 'Control de calidad'],
        colModel: [
                    { name: 'ver', index: 'ver', hidden: true, width: 50 },
                    { name: 'IdDetallePedido', index: 'IdDetallePedido', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdPedido', index: 'IdPedido', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdProveedor', index: 'IdProveedor', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdObra', index: 'IdObra', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdArticulo', index: 'IdArticulo', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdUnidad', index: 'IdUnidad', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'NumeroPedido', index: 'NumeroPedido', align: 'right', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'SubNumero', index: 'SubNumero', align: 'center', width: 30, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ItemPE', index: 'ItemPE', align: 'center', width: 30, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'FechaPedido', index: 'FechaPedido', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Proveedor', index: 'Proveedor', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Obra', index: 'Obra', align: 'left', width: 70, editable: false, hidden: false },
                    { name: 'Comprador', index: 'Comprador', align: 'left', width: 130, editable: false, hidden: false },
                    { name: 'SolicitoRM', index: 'SolicitoRM', align: 'left', width: 130, editable: false, hidden: false },
                    { name: 'FechaEntrega', index: 'FechaEntrega', width: 70, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'ArticuloCodigo', index: 'ArticuloCodigo', align: 'center', width: 100, editable: false, hidden: false },
                    { name: 'ArticuloDescripcion', index: 'ArticuloDescripcion', align: 'left', width: 300, editable: false, hidden: false },
                    { name: 'ObservacionesRM', index: 'ObservacionesRM', align: 'left', width: 300, editable: false, hidden: false },
                    { name: 'ObservacionesPE', index: 'ObservacionesPE', align: 'left', width: 300, editable: false, hidden: false },
                    { name: 'Cantidad', index: 'Cantidad', align: 'right', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Unidad', index: 'Unidad', align: 'center', width: 40, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Entregado', index: 'Entregado', align: 'right', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Pendiente', index: 'Pendiente', align: 'right', width: 80, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ItemRM', index: 'ItemRM', align: 'center', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'TipoCompra', index: 'TipoCompra', align: 'left', width: 150, editable: false, hidden: false },
                    { name: 'CircuitoFirmasCompleto', index: 'CircuitoFirmasCompleto', align: 'center', width: 60, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ControlCalidad', index: 'ControlCalidad', align: 'left', width: 150, editable: false, hidden: false }
        ],
        ondblClickRow: function (id) {
            CopiarPEdetalle(id);
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag2 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroPedido', // 'FechaRecibo,NumeroRecibo',
        sortorder: 'desc',
        viewrecords: true,
        emptyrecords: 'No hay registros para mostrar',
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
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
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
    });


    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Ped. Res.');
    $('a#a_panel_este_tab1').attr('title', 'Pedidos Resumidos');
    $('a#a_panel_este_tab2').text('Ped. Det.');
    $('a#a_panel_este_tab2').attr('title', 'Pedidos detallados');

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });

    $('#a_panel_este_tab2').click(function () {
        ConectarGrillas2();
    });

    ///////////////////////////////////////// CONEXION DE GRILLAS //////////////////////////////////////////////

    function ConectarGrillas1() {
        $("#ListaDrag").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            //ondrop: function (ev, ui, getdata) {
            //    Copiar1($(ui.draggable).attr("id"), "DnD");
            //}
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");
                BorraElPrimeroAgregado();
                CopiarPE(acceptId, ui, "DnD");
            }
        });
    }

    function ConectarGrillas2() {
        $("#ListaDrag2").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                //sacarDeEditMode();
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");
                BorraElPrimeroAgregado();
                CopiarPEdetalle(acceptId, ui, "DnD"); //, ui);
                return;
            }
        });
    }

    function CopiarPE(acceptId, ui, Origen) {
        jQuery('#Lista').jqGrid('saveCell', lastSelectediRow, lastSelectediCol);
        GrabarGrillaLocal()
        var getdata = jQuery("#ListaDrag").jqGrid('getRowData', acceptId);
        try {
            //me traigo los datos de detalle
            var Id = getdata['IdPedido']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Pedido/DetPedidosSinFormato/',
                data: { IdPedido: Id },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        CopiarItemPE(data, i, Origen, "ListaDrag");
                    }
                    AgregarRenglonesEnBlanco({ "IdDetalleRecepcion": "0", "IdArticulo": "0", "Cantidad": "0", "Articulo": "" });
                    ActualizarDatos();
                }
            });
        } catch (e) {
            alert(e.message);
        }
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    function CopiarPEdetalle(acceptId, ui, Origen) {
        jQuery('#Lista').jqGrid('saveCell', lastSelectediRow, lastSelectediCol);
        GrabarGrillaLocal()
        var getdata = jQuery("#ListaDrag2").jqGrid('getRowData', acceptId);
        var j = 0, dropname, grid;
        var Id = getdata['IdDetallePedido']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas

        try {
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Pedido/DetPedidosSinFormato/',
                data: { IdDetallePedido: Id },
                dataType: "Json",
                success: function (data) {
                    CopiarItemPE(data, 0, Origen, "ListaDrag2");
                    AgregarRenglonesEnBlanco({ "IdDetalleRecepcion": "0", "IdArticulo": "0", "Cantidad": "0", "Articulo": "" });
                    ActualizarDatos();
                }
            })
        } catch (e) {
            alert(e.message);
        }
    }

    function CopiarItemPE(data, i, Origen, source) {
        jQuery('#Lista').jqGrid('saveCell', lastSelectediRow, lastSelectediCol);

        GrabarGrillaLocal()

        var tmpdata = {};
        var longitud = data.length;
        var mPrimerItem = true, $gridOrigen = $("#" + source), $gridDestino = $("#Lista");
        var dataIds, Id;
        var Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;

        if (data[i].Pendiente > 0) {
            tmpdata['IdDetalleRecepcion'] = Id2;
            tmpdata['IdArticulo'] = 
            tmpdata['IdUnidad'] = data[i].IdUnidad;
            tmpdata['IdColor'] = data[i].IdColor;
            tmpdata['IdObra'] = data[i].IdObra;
            tmpdata['Obra'] = data[i].Obra;
            tmpdata['IdControlCalidad'] = data[i].IdControlCalidad;
            tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
            tmpdata['IdDetallePedido'] = data[i].IdDetallePedido;
            tmpdata['Codigo'] = data[i].ArticuloCodigo;
            tmpdata['Articulo'] = data[i].ArticuloDescripcion;
            tmpdata['Cantidad'] = data[i].Pendiente;
            tmpdata['Unidad'] = data[i].Unidad;
            tmpdata['Observaciones'] = data[i].ObservacionesPE;
            tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
            tmpdata['ItemRM'] = data[i].ItemRM;
            tmpdata['NumeroPedido'] = data[i].NumeroPedido;
            tmpdata['ItemPE'] = data[i].ItemPE;
            tmpdata['Recepcionado'] = data[i].Entregado;
            tmpdata['ControlCalidad'] = data[i].ControlCalidad;

            getdata = tmpdata;

            // estos son datos de cabecera que ya tengo en la grilla auxiliar
            $("#IdProveedor").val(data[i].IdProveedor);
            $("#Proveedor").val(data[i].Proveedor);
            $("#IdObra").val(getdata['IdObra']);

            //if (Origen == "DnD") {
            //    if (mPrimerItem) {
            //        dataIds = $gridDestino.jqGrid('getDataIDs');
            //        Id = dataIds[0];
            //        $gridDestino.jqGrid('setRowData', Id, getdata);
            //        mPrimerItem = false;
            //    } else {
            //        Id = Id2
            //        $gridDestino.jqGrid('addRowData', Id, getdata, "first");
            //    }
            //} else {
            //    Id = Id2
            //    $gridDestino.jqGrid('addRowData', Id, getdata, "first");
            //};
        }

        var getdata = tmpdata;
        var idazar = Math.ceil(Math.random() * 1000000);

        ///////////////
        // paso 1: borrar el renglon vacío de yapa que agrega el D&D (pero no el dblClick) -pero cómo sabés que estás en modo D&D?
        ///////////////
        var segundorenglon = $($("#Lista")[0].rows[1]).attr("id")
        // var segundorenglon = $($("#Lista")[0].rows[pos+2]).attr("id") // el segundo renglon
        //alert(segundorenglon);
        if (segundorenglon.indexOf("dnd") != -1) {
            // tiró el renglon en modo dragdrop, no hizo dobleclic
            $("#Lista").jqGrid('delRowData', segundorenglon);
        }
        //var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
        //var data = $('#Lista').jqGrid('getRowData', dataIds[1]);

        ///////////////
        // paso 2: agregar en el ultimo lugar antes de los renglones vacios
        ///////////////
        //acá hay un problemilla... si el tipo está usando el DnD, se crea un renglon libre arriba de todo...
        var pos = TraerPosicionLibre();
        if (pos == null) {
            $("#Lista").jqGrid('addRowData', idazar, getdata, "first")
        }
        else {
            $("#Lista").jqGrid('addRowData', idazar, getdata, "after", pos); // como hago para escribir en el primer renglon usando 'after'? paso null?
        }
        //$("#Lista").jqGrid('addRowData', idazar, getdata, "last");
        // http: //stackoverflow.com/questions/8517988/how-to-add-new-row-in-jqgrid-in-middle-of-grid
        // $("#Lista").jqGrid('addRowData', grid, getdata, 'first');  // usar por ahora 'first'   'after' : 'before'; 'last' : 'first';
        //    rows = $("#Lista").getGridParam("reccount");
        //    if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);
        AgregarRenglonesEnBlanco({ "IdDetalleRecepcion": "0", "IdArticulo": "0", "Cantidad": "0", "Articulo": "" });
    }

    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    $("input[name=TipoRecepcion]:radio").change(function () {
        valor = $("input[name='TipoRecepcion']:checked").val();
        if (valor == "1") {
            //$("#Proveedor").css("display", "block");
            $('#Proveedor:input').removeAttr('disabled');
            $('#IdProveedor').val("");
        } else {
            //$("#Proveedor").css("display", "none");
            $('#Proveedor').val("");
            $('#Proveedor:input').attr('disabled', 'disabled');
            $('#IdProveedor').val("");
        }
        $("#Cuit").val("");
        $("#Direccion").val("");
        $("#Localidad").val("");
        $("#Provincia").val("");
        $("#CodigoPostal").val("");
        $("#Email").val("");
        $("#Telefono").val("");

    })

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();

        cabecera.NumeroRecepcionAlmacen = $("#NumeroRecepcionAlmacen").val();
        cabecera.Obra = "";

        cabecera.DetalleRecepciones = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleRecepcion'];
                if (data['Articulo'].length == 0) continue;
                //if (!iddeta) {
                //    iddeta = nuevo;
                //    nuevo--;
                //}

                data1 = '{"IdDetalleRecepcion":"' + iddeta + '",';
                data1 = data1 + '"IdRecepcion":"' + $("#IdRecepcion").val() + '",';
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
                cabecera.DetalleRecepciones.push(data2);
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
            url: ROOT + 'Recepcion/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Recepcion: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "Recepcion/Edit/" + result.IdRecepcion);
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
    var id = 0;

    id = $("#IdProveedor").val();
    if (id.length > 0) { MostrarDatosProveedor(id); }
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
    var Id = $("#IdRecepcion").val();

    if (Id <= 0) {
        $.ajax({
            type: "GET",
            async: false,
            url: ROOT + 'Parametro/Parametros/',
            contentType: "application/json",
            dataType: "json",
            success: function (result) {
                if (result.length > 0) {
                    var ProximoNumero = result[0]["ProximoNumeroInternoRecepcion"];
                    $("#NumeroRecepcionAlmacen").val(ProximoNumero);
                }
            }
        });
    } else {
        $("#grabar2").prop("disabled", true);
    }
}

function GrabarGrillaLocal() {
    var $this = $('#Lista')
    var ids = $this.jqGrid('getDataIDs'), i, l = ids.length;

    for (i = 0; i < l; i++) {
        try {
            var rowdata = $('#Lista').jqGrid('saveRow', ids[i]);
        } catch (e) {
            $('#Lista').jqGrid('restoreRow', ids[i]);
            continue;
        }
    }
}

function BorraElPrimeroAgregado() {
    var grid = $("#Lista"),
        ids = grid.jqGrid("getDataIDs");
    if (ids && ids.length > 0)
        grid.jqGrid("delRowData", ids[0]);
}

function TraerPosicionLibre() {
    var grid = jQuery("#Lista")
    var rows = $("#Lista").getGridParam("reccount");
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        var desc = data['Articulo'];
        if (desc == "") break;
    }

    if (i == 0) return null;
    if (i == dataIds.length) i = dataIds.length - 1;

    return $($("#Lista")[0].rows[i]).attr("id");
}
