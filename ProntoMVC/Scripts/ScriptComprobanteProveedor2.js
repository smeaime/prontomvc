$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight;
    var idaux = 0, detalle = "", mTotalImputaciones, mImporteIva1, mAjusteIVA, mImporteTotal, mTotalIVANoDiscriminado;

    //if ($("#Anulada").val() == "SI") {
    //    $("#grabar2").prop("disabled", true);
    //    $("#anular").prop("disabled", true);
    //}

    idaux = $("#IdComprobanteProveedor").val();
    if (idaux <= 0) {
        $("#FechaPrestacionServicio").prop("disabled", true);
        //$("#FechaFinServicio").prop("disabled", true);
    } else {
        pageLayout.close('east');
    }

    idaux = $("#IdProveedor").val();
    if (idaux.length > 0) {
        MostrarDatosProveedor(idaux);
    }
    TraerCotizacion()
    TraerNumeroComprobante()
    ActualizarPuntosDeVenta()
    TipoComprobante()
    MostrarComprobanteImputado()

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
        target.focus();
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
        //grid.jqGrid('setCell', Id, 'OrigenDescripcion', 1);
        //grid.jqGrid('setCell', Id, 'TiposDeDescripcion', "Solo material");
        grid.jqGrid('setCell', Id, 'Cantidad', 0);
    };

    var CalcularItem = function (value, colname) {
        if (colname === "Cantidad") {
            var rowid = $('#Lista').getGridParam('selrow');
            value = Number(value);
            var Cantidad = value;
            //var Bonificacion = parseFloat($("#Lista").getCell(rowid, "Bonificacion").replace(",", ".")) || 0;
            //var PrecioUnitario = parseFloat($("#Lista").getCell(rowid, "PrecioUnitario").replace(",", ".")) || 0;
            //var Importe = CalcularImporteItem(Cantidad, PrecioUnitario, Bonificacion) || 0;
            //$('#Lista').jqGrid('setCell', rowid, 'Importe', Importe[0]);
        } else {
            if (colname === "Precio") {
                var rowid = $('#Lista').getGridParam('selrow');
                value = Number(value);
                var PrecioUnitario = value;
                //var Bonificacion = parseFloat($("#Lista").getCell(rowid, "Bonificacion").replace(",", ".")) || 0;
                //var Cantidad = parseFloat($("#Lista").getCell(rowid, "Cantidad").replace(",", ".")) || 0;
                //var Importe = CalcularImporteItem(Cantidad, PrecioUnitario, Bonificacion) || 0;
                //$('#Lista').jqGrid('setCell', rowid, 'Importe', Importe[0]);
            } else {
                if (colname === "% Bonif.") {
                    var rowid = $('#Lista').getGridParam('selrow');
                    value = Number(value);
                    //var Bonificacion = value;
                    //var PrecioUnitario = parseFloat($("#Lista").getCell(rowid, "PrecioUnitario").replace(",", ".")) || 0;
                    //var Cantidad = parseFloat($("#Lista").getCell(rowid, "Cantidad").replace(",", ".")) || 0;
                    //var Importe = CalcularImporteItem(Cantidad, PrecioUnitario, Bonificacion) || 0;
                    //$('#Lista').jqGrid('setCell', rowid, 'Importe', Importe[0]);
                }
            }
        }
        return [true];
    };

    //var CalcularImporteItem = function (Cantidad, PrecioUnitario, PorcentajeBonificacion) {
    //    var Importe1 = Math.round(PrecioUnitario * Cantidad * 10000) / 10000;
    //    var Bonificacion = Math.round(Importe1 * PorcentajeBonificacion / 100 * 10000) / 10000;
    //    var Importe = Math.round((Importe1 - Bonificacion) * 100) / 100 || 0;
    //    Importe = Importe.toFixed(2);

    //    return [Importe];
    //};

    function RefrescarRestoDelRenglon(rowid, name, val, iRow, iCol) {
        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
        var cm = jQuery("#Lista").jqGrid("getGridParam", "colModel");
        var colName = cm[iCol]['index'];

        if (colName == "Codigo") {
            $.post(ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',  // ?term=' + val
                    { term: val }, // JSON.stringify(val)},
                    function (data) {
                        if (data.length > 0) {
                            var ui = data[0];

                            sacarDeEditMode3(lastSelectediRow, lastSelectediCol);

                            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

                            data['IdArticulo'] = ui.id;
                            data['CodigoArticulo'] = ui.codigo;
                            data['Articulo'] = ui.title;
                            data['PorcentajeIva'] = ui.iva;
                            data['IdDetalleComprobanteProveedor'] = data['IdDetalleComprobanteProveedor'] || 0;

                            $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

                            FinRefresco();
                        }
                        else {
                            alert("No existe el código");
                            var ui = data[0];
                            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos

                            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
                            data['Articulo'] = "";
                            data['IdArticulo'] = 0;
                            data['CodigoArticulo'] = "";
                            data['Cantidad'] = 0;

                            $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
                        }
                    }
            );
        }

        else if (colName == "Articulo") {
            $.post(ROOT + 'Articulo/GetArticulosAutocomplete2',
                    { term: val }, // JSON.stringify(val)},
                    function (data) {
                        if (val != "No se encontraron resultados" && (data.length == 1 || data.length > 1)) { // qué pasa si encuentra más de uno?????
                            var ui = data[0];

                            sacarDeEditMode3(lastSelectediRow, lastSelectediCol);

                            if (ui.value == "No se encontraron resultados") {
                                var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                                var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

                                data['Articulo'] = "";
                                data['IdArticulo'] = 0;
                                data['CodigoArticulo'] = "";
                                data['Cantidad'] = 0;

                                $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
                                return;
                            }

                            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

                            data['IdArticulo'] = ui.id;
                            data['CodigoArticulo'] = ui.codigo;
                            data['Articulo'] = ui.value;
                            data['PorcentajeIva'] = ui.iva;
                            data['IdDetalleComprobanteProveedor'] = data['IdDetalleComprobanteProveedor'] || 0;

                            $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

                            FinRefresco();
                        }
                        else {
                            alert("No existe el artículo " + val); // se está bancando que no sea identica la descripcion
                            var ui = data[0];
                            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                            if (true) {

                                var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
                                data['Articulo'] = "";
                                data['IdArticulo'] = 0;
                                data['CodigoArticulo'] = "";
                                data['Cantidad'] = 0;

                                $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
                            } else {
                                $('#Lista').jqGrid('restoreRow', dataIds[iRow - 1]);
                            }
                            // hay que cancelar la grabacion
                        }
                    }
            );

        }
        else if (colName == "Cantidad") { }

        else {
            FinRefresco()
        }
    }

    function FinRefresco() {
        calculaTotalImputaciones();
        //RefrescarOrigenDescripcion();
        AgregarRenglonesEnBlanco({ "IdDetalleComprobanteProveedor": "0", "IdArticulo": "0", "Importe": "0", "Articulo": "" }, "#Lista");
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'ComprobanteProveedor/DetComprobantesProveedor/',
        postData: { 'IdComprobanteProveedor': function () { return $("#IdComprobanteProveedor").val(); } },
        editurl: ROOT + 'Factura/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleComprobanteProveedor', 'IdCuenta', 'IdDetallePedido', 'IdDetalleRecepcion', 'IdObra', 'IdCuentaGasto', 'IdCuentaBancaria', 'IdRubroContable',
                   'IdEquipoDestino', 'IdArticulo', 'CodigoCuenta', 'CuentaContable', 'CodigoArticulo', 'Articulo', 'Cantidad', 'Importe', 'PorcentajeIva', 'ImporteIva',
                   'TomarEnCalculoDeImpuestos', 'IdProvinciaDestino1', 'PorcentajeProvinciaDestino1', 'IdProvinciaDestino2', 'PorcentajeProvinciaDestino2'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleComprobanteProveedor', index: 'IdDetalleComprobanteProveedor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdCuenta', index: 'IdCuenta', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDetallePedido', index: 'IdDetallePedido', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDetalleRecepcion', index: 'IdDetalleRecepcion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdObra', index: 'IdObra', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdCuentaGasto', index: 'IdCuentaGasto', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdRubroContable', index: 'IdRubroContable', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdEquipoDestino', index: 'IdEquipoDestino', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'CodigoCuenta', index: 'CodigoCuenta', width: 120, align: 'center', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: {
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }],
                            dataInit: function (elem) {
                                var NoResultsLabel = "No se encontraron resultados";
                                $(elem).autocomplete({
                                    source: ROOT + 'Cuenta/GetCodigosCuentasAutocomplete2',
                                    minLength: 0,
                                    select: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                            return;
                                        }
                                        event.preventDefault();
                                        $(elem).val(ui.item.label);
                                        var rowid = $('#Lista').getGridParam('selrow');
                                        $('#Lista').jqGrid('setCell', rowid, 'IdCuenta', ui.item.id);
                                        $('#Lista').jqGrid('setCell', rowid, 'CuentaContable', ui.item.title);
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
                        name: 'CuentaContable', index: 'CuentaContable', align: 'left', width: 350, hidden: false, editable: true, edittype: 'text', editrules: { required: true },
                        editoptions: {
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }],
                            dataInit: function (elem) {
                                var NoResultsLabel = "No se encontraron resultados";
                                $(elem).autocomplete({
                                    source: ROOT + 'Cuenta/GetCuentasAutocomplete',
                                    minLength: 0,
                                    select: function (event, ui) {
                                        if (ui.item.label === NoResultsLabel) {
                                            event.preventDefault();
                                            return;
                                        }
                                        event.preventDefault();
                                        $(elem).val(ui.item.label);
                                        var rowid = $('#Lista').getGridParam('selrow');
                                        $('#Lista').jqGrid('setCell', rowid, 'IdCuenta', ui.item.id);
                                        $('#Lista').jqGrid('setCell', rowid, 'CodigoCuenta', ui.item.codigo);
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
                        name: 'CodigoArticulo', index: 'CodigoArticulo', width: 120, align: 'center', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: {
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }],
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
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }],
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
                                        $('#Lista').jqGrid('setCell', rowid, 'CodigoArticulo', ui.item.codigo);
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
                        name: 'Cantidad', index: 'Cantidad', width: 70, align: 'right', editable: true, editrules: { custom: true, custom_func: CalcularItem, required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                                { type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
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
                        name: 'Importe', index: 'Importe', width: 80, align: 'right', editable: true, editrules: { custom: true, custom_func: CalcularItem, required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '',
                            dataInit: function (elem) {
                                var a = $(elem).val();
                                if (a == 0) { $(elem).val("") }
                            },
                            dataEvents: [
                                { type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
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
                        name: 'PorcentajeIva', index: 'PorcentajeIva', width: 70, align: 'right', editable: true, hidden: false, label: 'TB', formatter: 'dynamicText', edittype: 'custom',
                        editoptions: {
                            dataEvents: [{
                                type: 'focusout', fn: function (e) {
                                    $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol);
                                }
                            }
                            ],
                            custom_element: radioelem, custom_value: radiovalue,
                        }
                    },
                    { name: 'ImporteIva', index: 'ImporteIva', width: 80, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled', defaultValue: 0 }, label: 'TB' },
                    { name: 'TomarEnCalculoDeImpuestos', index: 'TomarEnCalculoDeImpuestos', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdProvinciaDestino1', index: 'IdProvinciaDestino1', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'PorcentajeProvinciaDestino1', index: 'PorcentajeProvinciaDestino1', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdProvinciaDestino2', index: 'IdProvinciaDestino2', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'PorcentajeProvinciaDestino2', index: 'PorcentajeProvinciaDestino2', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
            //if (jQuery("#Lista").jqGrid('getCell', rowid, 'TipoCancelacion') == '1') {
            //    jQuery("#Lista").jqGrid('setCell', rowid, 'PorcentajeCertificacion', '', 'not-editable-cell');
            //}
        },
        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
            lastSelectediRow = iRow;
            lastSelectediCol = iCol;
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
            RefrescarRestoDelRenglon(rowid, cellname, value, iRow, iCol);
            calculaTotalImputaciones();
        },
        gridComplete: function () {
            calculaTotalImputaciones();
        },

        loadComplete: function () {
            //AgregarItemVacio(jQuery("#Lista"));
            AgregarRenglonesEnBlanco({ "IdDetalleComprobanteProveedor": "0", "IdArticulo": "0", "Importe": "0", "Articulo": "" }, "#Lista");
        },
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleComprobanteProveedor',
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

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $("#ListaDrag").jqGrid({
        url: ROOT + 'Pedido/Pedidos_Pendientes',
        postData: { 'IdProveedor': function () { return $("#IdProveedor").val(); } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['IdPedido', 'IdProveedor', 'IdCondicionCompra', 'Numero', 'Sub', 'Fecha', 'Salida', 'Cumplido', 'RMs', 'Obras', 'Cod. prov.', 'Proveedor', 'Subtotal', 'Bonif.', 'IVA', 'Otros',
                   'Imp. Int.', 'Total pedido', 'Mon.', 'Comprador', 'Aprobo', 'Items', 'Comparativa', 'Tipo compra', 'Observaciones', 'Cond. compra', 'Detalle cond. compra', 'Exterior',
                   'Nro. licitacion', 'Impresa', 'Anuló', 'Fecha anulacion', 'Motivo anulacion', 'Equipos destino', 'Circ. firma completo', 'Condicion iva', 'Fecha envio', 'Detalles generales'
        ],
        colModel: [
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
            Copiar1(id, "Dbl");
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },

        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroPedido', 
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
        multipleSearch: true,
        multiselect: true,
    })
    //jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager',
    //        { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false });
    //jQuery("#ListaDrag").jqGrid('navButtonAdd', '#ListaPager', {
    //    caption: "",
    //    buttonicon: "ui-icon-calculator",
    //    title: "Choose columns",
    //    onClickButton: function () {
    //        $(this).jqGrid('columnChooser',
    //            { width: 550, msel_opts: { dividerLocation: 0.5 }, modal: true });
    //        $("#colchooser_" + $.jgrid.jqID(this.id) + ' div.available>div.actions')
    //            .prepend('<label style="float:left;position:relative;margin-left:0.6em;top:0.6em">Search:</label>');
    //    }
    //});
    jQuery("#ListaDrag").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); 
    //jQuery("#ListaDrag").jqGrid('navButtonAdd', '#ListaPager',
    //    {
    //        caption: "Filter", title: "Toggle Searching Toolbar",
    //        buttonicon: 'ui-icon-pin-s',
    //        onClickButton: function () { myGrid[0].toggleToolbar(); }
    //    });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Recepcion/Recepciones_Pendientes',
        postData: { 'IdProveedor': function () { return $("#IdProveedor").val(); } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['IdRecepcion', 'IdProveedor', 'IdCondicionCompra', 'Numero interno', 'Pto. Vta.', 'Numero', 'Sub', 'Codigo proveedor', 'Proveedor', 'Cuit proveedor', 'Fecha',
                   'Anulada', 'Obras', 'Requerimientos', 'Solicitantes RMs', 'Pedidos', 'L.Acopio', 'Observaciones', 'Confecciono', 'Fecha ingreso', 'Modifico', 'Fecha modificacion',
                   'Anulo', 'Fecha anulacion', 'Motivo anulacion', 'Nro. pesada', 'Progresiva 1', 'Progresiva 2', 'Fecha pesada', 'Observaciones pesada', 'Circ. Firmas Compl.',
                   'Transportista', 'Chofer', 'Nro. Doc. chofer', 'Patente', 'Peso bruto', 'Peso neto', 'Tara', 'Nro. orden carga', 'Pto. Vta. Rem. Transp.', 'Nro. Rem. Transp.', 'Items'
        ],
        colModel: [
                    { name: 'IdRecepcion', index: 'IdRecepcion', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdProveedor', index: 'IdProveedor', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'IdCondicionCompra', index: 'IdCondicionCompra', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'NumeroRecepcionAlmacen', index: 'NumeroRecepcionAlmacen', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'NumeroRecepcion1', index: 'NumeroRecepcion1', align: 'center', width: 60, editable: false, hidden: false, searchoptions: { sopt: ['cn'] } },
                    { name: 'NumeroRecepcion2', index: 'NumeroRecepcion2', align: 'center', width: 100, editable: false, hidden: false, searchoptions: { sopt: ['cn'] } },
                    { name: 'SubNumero', index: 'SubNumero', align: 'center', width: 50, editable: false, hidden: false, searchoptions: { sopt: ['cn'] } },
                    { name: 'ProveedorCodigo', index: 'ProveedorCodigo', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ProveedorNombre', index: 'ProveedorNombre', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ProveedorCuit', index: 'ProveedorCuit', align: 'center', width: 120, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    {
                        name: 'FechaRecepcion', index: 'FechaRecepcion', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'Anulada', index: 'Anulada', align: 'center', width: 60, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Obras', index: 'Obras', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Requerimientos', index: 'Requerimientos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'SolicitantesRequerimientos', index: 'SolicitantesRequerimientos', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Pedidos', index: 'Pedidos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ListaAcopio', index: 'ListaAcopio', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Confecciono', index: 'Confecciono', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    {
                        name: 'FechaIngreso', index: 'FechaIngreso', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'Modifico', index: 'Modifico', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    {
                        name: 'FechaUltimaModificacion', index: 'FechaUltimaModificacion', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'Anulo', index: 'Anulo', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    {
                        name: 'FechaAnulacion', index: 'FechaAnulacion', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'MotivoAnulacion', index: 'MotivoAnulacion', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'NumeroPesada', index: 'NumeroPesada', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'Progresiva1', index: 'Progresiva1', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'Progresiva2', index: 'Progresiva2', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    {
                        name: 'FechaPesada', index: 'FechaPesada', width: 100, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                        search: true, searchrules: { date: true }, searchoptions: { sopt: ['ge', 'le', 'eq'] }
                    },
                    { name: 'ObservacionesPesada', index: 'ObservacionesPesada', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'CircuitoFirmasCompleto', index: 'CircuitoFirmasCompleto', align: 'center', width: 60, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn'] } },
                    { name: 'Transportista', index: 'Transportista', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Chofer', index: 'Chofer', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'NumeroDocumentoChofer', index: 'NumeroDocumentoChofer', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Patente', index: 'Patente', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'PesoBruto', index: 'PesoBruto', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'PesoNeto', index: 'PesoNeto', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'Tara', index: 'Tara', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'NumeroOrdenCarga', index: 'NumeroOrdenCarga', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'NumeroRemitoTransporte1', index: 'NumeroRemitoTransporte1', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'NumeroRemitoTransporte2', index: 'NumeroRemitoTransporte2', align: 'right', width: 80, editable: false, hidden: false, searchoptions: { sopt: ['eq'] } },
                    { name: 'Items', index: 'Items', align: 'center', width: 100, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } }
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
        sortname: 'NumeroRecepcionAlmacen',
        sortorder: "desc",
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
        multipleSearch: true,
        multiselect: true,
    })
    jQuery("#ListaDrag2").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $("#ListaDrag3").jqGrid({
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
                        { name: 'Numero', index: 'Numero', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                        { name: 'Fecha', index: 'Fecha', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'FechaVencimiento', index: 'FechaVencimiento', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Moneda', index: 'Moneda', align: 'left', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                        { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Saldo', index: 'Saldo', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'SaldoTrs', index: 'SaldoTrs', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } }
        ],
        ondblClickRow: function (id) {
            Copiar3(id, "Dbl");
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag3 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager3'),
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
        multipleSearch: true,
        multiselect: true
    })
    jQuery("#ListaDrag3").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Pedidos');
    $('a#a_panel_este_tab2').text('Recepciones');
    $('a#a_panel_este_tab3').text('Cuenta corriente');

    ConectarGrillas1();
    ConectarGrillas2();
    ConectarGrillas3();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });
    $('#a_panel_este_tab2').click(function () {
        ConectarGrillas2();
    });
    $('#a_panel_este_tab3').click(function () {
        ConectarGrillas3();
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
                Copiar1($(ui.draggable).attr("id"), "DnD");
            }
        });
    }

    function ConectarGrillas2() {
        $("#ListaDrag2").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                Copiar2($(ui.draggable).attr("id"), "DnD");
            }
        });
    }

    function ConectarGrillas3() {
        $("#ListaDrag3").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                Copiar3($(ui.draggable).attr("id"), "DnD");
            }
        });
    }

    function Copiar1(idsource, Origen) {
        var acceptId = idsource, IdPedido = 0, IdProveedor = 0;
        var mPrimerItem = true, $gridOrigen = $("#ListaDrag"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        try {
            IdPedido = getdata['IdPedido'];

            $("#IdProveedor").val(getdata['IdProveedor']);
            $("#ProveedorCodigo").val(getdata['ProveedoresCodigo']);
            $("#IdCondicionCompra").val(getdata['IdCondicionCompra']);

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Pedido/DetPedidosParaComprobanteProveedor/',
                data: { IdPedido: IdPedido },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;

                        if (data[i].Importe != 0) {
                            tmpdata['IdDetalleComprobanteProveedor'] = Id2;
                            tmpdata['IdDetallePedido'] = data[i].IdDetallePedido;
                            tmpdata['IdArticulo'] = data[i].IdArticulo;
                            tmpdata['IdCuenta'] = data[i].IdCuentaContable;
                            tmpdata['IdRubroFinanciero'] = data[i].IdRubroFinanciero;
                            tmpdata['CodigoCuenta'] = data[i].CuentaCodigo;
                            tmpdata['CuentaContable'] = data[i].CuentaDescripcion;
                            tmpdata['CodigoArticulo'] = data[i].ArticuloCodigo;
                            tmpdata['Articulo'] = data[i].ArticuloDescripcion;
                            tmpdata['Cantidad'] = data[i].Cantidad;
                            tmpdata['Importe'] = data[i].Importe;
                            tmpdata['PorcentajeIva'] = data[i].AlicuotaIVA;
                            
                            $("#IdObra").val(data[i].IdObra);

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
                    }
                    ActualizarDatos();
                }
            });
        } catch (e) { }

        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    function Copiar2(idsource, Origen) {
        var acceptId = idsource, IdRecepcion = 0, IdProveedor = 0;
        var mPrimerItem = true, $gridOrigen = $("#ListaDrag2"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        try {
            IdRecepcion = getdata['IdRecepcion'];

            $("#IdProveedor").val(getdata['IdProveedor']);
            $("#ProveedorCodigo").val(getdata['ProveedoresCodigo']);
            $("#IdCondicionCompra").val(getdata['IdCondicionCompra']);

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Recepcion/DetRecepcionesParaComprobanteProveedor/',
                data: { IdRecepcion: IdRecepcion },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;

                        if (data[i].Importe != 0) {
                            tmpdata['IdDetalleComprobanteProveedor'] = Id2;
                            tmpdata['IdDetalleRecepcion'] = data[i].IdDetalleRecepcion;
                            tmpdata['IdDetallePedido'] = data[i].IdDetallePedido;
                            tmpdata['IdArticulo'] = data[i].IdArticulo;
                            tmpdata['IdCuenta'] = data[i].IdCuentaContable;
                            tmpdata['IdRubroFinanciero'] = data[i].IdRubroFinanciero;
                            tmpdata['CodigoCuenta'] = data[i].CuentaCodigo;
                            tmpdata['CuentaContable'] = data[i].CuentaDescripcion;
                            tmpdata['CodigoArticulo'] = data[i].ArticuloCodigo;
                            tmpdata['Articulo'] = data[i].ArticuloDescripcion;
                            tmpdata['Cantidad'] = data[i].Cantidad;
                            tmpdata['Importe'] = data[i].Importe;
                            tmpdata['PorcentajeIva'] = data[i].AlicuotaIVA;

                            $("#IdObra").val(data[i].IdObra);

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
                    }
                    ActualizarDatos();
                }
            });
        } catch (e) { }

        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    function Copiar3(idsource, Origen) {
        var acceptId = idsource, IdCtaCte = 0, IdProveedor = 0, Coeficiente = 0, date, displayDate;
        var mPrimerItem = true, $gridOrigen = $("#ListaDrag3"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, data2, data3;

        Coeficiente = $("#CoeficienteComprobante").val();
        if (Coeficiente < 0) {
            IdCtaCte = getdata['IdCtaCte'];
            $("#IdComprobanteImputado").val(IdCtaCte);
            MostrarComprobanteImputado;
        } else {
            alert('Solo puede imputar comprobantes credito.');
        }
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    $("#IdPuntoVenta").change(function () {
        TraerNumeroComprobante()
    });

    $("#IdIBCondicion").change(function () {
        CalcularTotales()
    });
    
    $("#AjusteIVA").change(function () {
        CalcularTotales()
    });

    $("#IdMoneda").change(function () {
        TraerCotizacion()
    })

    $("#IdCondicionCompra").change(function () {
        var fechaFinal = CalcularFechaVencimiento($("#FechaComprobante").val());
        $("#FechaVencimiento").val(fechaFinal);
    })

    $("input[name=BienesOServicios]:radio").change(function () {
        ActivarFechasServicio();
    })

    $("#Observaciones").change(function () {
        var Observaciones = $("#Observaciones").val();
        //Observaciones = cleanString(Observaciones);
        $("#Observaciones").val(Observaciones)
    })

    $("#ProveedorCodigo").change(function () {
        TraerDatosProveedorPorCodigo()
    })

    $("#IdTipoComprobante").change(function () {
        TipoComprobante()
    })


    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        calculaTotalImputaciones();

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo, BienesOServicios = "", index;

        var cabecera = $("#formid").serializeObject();

        BienesOServicios = $("input[name='BienesOServicios']:checked").val();

        cabecera.NumeroReferencia = $("#NumeroReferencia").val();
        cabecera.FechaComprobante = $("#FechaComprobante").val();
        cabecera.FechaRecepcion = $("#FechaRecepcion").val();
        cabecera.FechaVencimiento = $("#FechaVencimiento").val();
        cabecera.Letra = $("#Letra").val();
        cabecera.NumeroComprobante1 = $("#NumeroComprobante1").val();
        cabecera.NumeroComprobante2 = $("#NumeroComprobante2").val();
        cabecera.IdTipoComprobante = $("#IdTipoComprobante").val();
        cabecera.IdProveedor = $("#IdProveedor").val();
        cabecera.IdPuntoVenta = $("#IdPuntoVenta").val();
        cabecera.PuntoVenta = $("#IdPuntoVenta").find('option:selected').text();
        cabecera.IdCondicionCompra = $("#IdCondicionCompra").val();
        cabecera.CotizacionMoneda = $("#CotizacionMoneda").val();
        cabecera.CotizacionDolar = $("#CotizacionDolar").val();
        cabecera.CotizacionEuro = $("#CotizacionEuro").val();
        cabecera.IdMoneda = $("#IdMoneda").val();
        cabecera.BienesOServicios = BienesOServicios;
        cabecera.NumeroCAI = $("#NumeroCAI").val();
        cabecera.NumeroCAE = $("#NumeroCAE").val();
        cabecera.FechaVencimientoCAI = $("#FechaVencimientoCAI").val();
        cabecera.Dolarizada = "NO";
        cabecera.Proveedor = "";

        if (BienesOServicios == "B") {
        } else {
            cabecera.FechaPrestacionServicio = $("#FechaPrestacionServicio").val();
            //cabecera.FechaFinServicio = $("#FechaFinServicio").val();
        }

        cabecera.DetalleComprobantesProveedores = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleComprobanteProveedor'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleComprobanteProveedor":"' + iddeta + '",';
                data1 = data1 + '"IdComprobanteProveedor":"' + $("#IdComprobanteProveedor").val() + '",';
                for (j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') {
                        index = cm.index;
                        if (index == "ImporteIva") { index = "ImporteIVA1"; }
                        if (index == "PorcentajeIva") { index = "IVAComprasPorcentaje1"; }
                        valor = data[cm.name];
                        data1 = data1 + '"' + index + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetalleComprobantesProveedores.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante." + ex);
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
            url: ROOT + 'ComprobanteProveedor/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ ComprobanteProveedor: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "ComprobanteProveedor/Edit/" + result.IdComprobanteProveedor);
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
                    pageLayout.show('east', true);
                    pageLayout.open('east');

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

    //idaux = $("#IdFactura").val();
    //if (idaux <= 0) {
    //    ActivarControles(true);
    //} else {
    //    ActivarControles(false);
    //}

});

function ActualizarDatos() {
    var IdCodigoIva = 0, Letra = "B", id = 0, IdComprobanteProveedor = 0;

    id = $("#IdProveedor").val();
    if (id.length > 0) {
        MostrarDatosProveedor(id);
    }

    IdComprobanteProveedor = $("#IdComprobanteProveedor").val() || 0;
    if (IdComprobanteProveedor <= 0) {
        var fechaFinal = CalcularFechaVencimiento($("#FechaComprobante").val());
        $("#FechaVencimiento").val(fechaFinal);
    }

    IdCodigoIva = $("#IdCodigoIva").val();

    Letra = "B";
    if (IdCodigoIva == 1) { Letra = "A" }
    if (IdCodigoIva == 3) { Letra = "E" }
    if (IdCodigoIva == 9) { Letra = "A" }
    $("#Letra").val(Letra)

    calculaTotalImputaciones();
}

function ActualizarPuntosDeVenta() {
    var IdCodigoIva = 0, Letra = "", id = 0, IdComprobanteProveedor = 0;

    IdComprobanteProveedor = $("#IdComprobanteProveedor").val() || 0;
    IdCodigoIva = $("#IdCodigoIva").val();
    //Letra = $("#Letra").val();

    if (IdComprobanteProveedor <= 0) {
        $.ajax({
            type: "GET",
            async: false,
            url: ROOT + 'PuntoVenta/GetPuntosVenta2/',
            data: { IdTipoComprobante: 11, Letra: Letra },
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
}

calculaTotalImputaciones = function () {
    var imp = 0, imp2 = 0, grav = "", letra = "", porciva = 0, ivaitem = 0, mIdCodigoIva = 0;

    letra = $("#Letra").val();
    mIdCodigoIva = $("#IdCodigoIva").val();

    porciva = 0; //parseFloat($("#PorcentajeIva1").val().replace(",", ".") || 0) || 0;
    mTotalIVANoDiscriminado = 0;
    mImporteIva1 = 0;

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
        porciva = parseFloat(data['PorcentajeIva'].replace(",", ".") || 0) || 0;

        if (mIdCodigoIva == 3 || mIdCodigoIva == 8 || mIdCodigoIva == 9) { porciva = 0 }

        if (letra == "B") {
            ivaitem = imp - (imp / (1 + (porciva / 100)));
            mTotalIVANoDiscriminado = mTotalIVANoDiscriminado + ivaitem;
        } else {
            //mImporteIva1 = mImporteIva1 + (imp * (porciva / 100));
            ivaitem = imp * porciva / 100;
            mImporteIva1 = mImporteIva1 + ivaitem;
        }
        data['ImporteIva'] = ivaitem.toFixed(4);

        $('#Lista').jqGrid('setRowData', dataIds[i], data);
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalImputaciones = imp2;
    $("#Lista").jqGrid('footerData', 'set', { Gravado: 'TOTALES', Importe: imp2.toFixed(2) });
    $("#TotalIva1").val(mImporteIva1.toFixed(2));
    $("#TotalIVANoDiscriminado").val(mTotalIVANoDiscriminado.toFixed(2));

    CalcularTotales()
};

function CalcularTotales() {
    var mSubtotal = 0, mIdComprobanteProveedor = 0;

    mIdComprobanteProveedor = $("#IdComprobanteProveedor").val();

    if (typeof mTotalImputaciones == "undefined") { mTotalImputaciones = 0; }
    mSubtotal = mTotalImputaciones;
    mImporteIva1 = parseFloat($("#TotalIva1").val().replace(",", ".") || 0) || 0;
    mAjusteIVA = parseFloat($("#AjusteIVA").val().replace(",", ".") || 0) || 0;
    mImporteTotal = mSubtotal + mImporteIva1 + mAjusteIVA

    $("#Subtotal").val((mSubtotal.toFixed(2)));
    $("#TotalComprobante").val((mImporteTotal.toFixed(2)));
};

function TraerCotizacion() {
    var fecha, IdMoneda, datos1, mIdMonedaPrincipal = 1, mIdMonedaDolar = 2, mCotizacionDolar = 0;
    fecha = $("#FechaComprobante").val();
    if (fecha != "") {
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
                    if (mCotizacionDolar == 0) {
                        alert('Cuidado, no hay cotizacion dolar.');
                    }
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
        }
        else {
            if (IdMoneda == mIdMonedaDolar) {
                $("#CotizacionMoneda").val(mCotizacionDolar.toFixed(2));
                $("#CotizacionDolar").val(mCotizacionDolar.toFixed(2));
            }
        }
    }
    else {
        $("#CotizacionMoneda").val("1");
        $("#CotizacionDolar").val("0");
    }
};

function TipoComprobante() {
    var datos1, IdTipoComprobante = 0, Coeficiente = 0;
    IdTipoComprobante = $("#IdTipoComprobante").val();
    $.ajax({
        type: "Post",
        async: false,
        url: ROOT + 'TiposComprobante/TipoComprobantePorId/',
        data: { IdTipoComprobante: IdTipoComprobante },
        success: function (result) {
            if (result.length > 0) {
                Coeficiente = result[0].Coeficiente;
                $("#CoeficienteComprobante").val(Coeficiente);
                if (Coeficiente >= 0) {
                    $("#DivComprobanteImputado").css("display", "none");
                } else {
                    $("#DivComprobanteImputado").css("display", "block");
                }
            }
        },
        error: function (xhr, textStatus, exceptionThrown) {
            alert('No se encontro el registro');
            $('#CoeficienteComprobante').val("");
        }
    });
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
                $("#CondicionIva").val(result[0].DescripcionIva);
                $("#Cuit").val(result[0].Cuit);
                $("#Direccion").val(result[0].Direccion);
                $("#Localidad").val(result[0].Localidad);
                $("#Provincia").val(result[0].Provincia);
                $("#CodigoPostal").val(result[0].CodigoPostal);
                $("#Email").val(result[0].Email);
                $("#Telefono").val(result[0].Telefono);
                $("#IdIBCondicion").val(result[0].IdIBCondicionPorDefecto);
                $("#IdCodigoIva").val(result[0].IdCodigoIva);
            }
        }
    });
    return Entidad;
}

function TraerNumeroComprobante() {
    var IdComprobanteProveedor = $("#IdComprobanteProveedor").val();
    var IdPuntoVenta = $("#IdPuntoVenta").val();
    //var CtaCte = $("input[name='CtaCte']:checked").val();

    if (IdComprobanteProveedor <= 0) {
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
                    //var CAEManual = result[0]["CAEManual"];
                    $("#NumeroReferencia").val(ProximoNumero);
                    //if (CAEManual == "SI") {
                    //    $("#CAE").prop("disabled", false);
                    //    $("#FechaVencimientoORechazoCAE").prop("disabled", false);
                    //} else {
                    //    $("#CAE").val("");
                    //    $("#FechaVencimientoORechazoCAE").val("");
                    //    $("#CAE").prop("disabled", true);
                    //    $("#FechaVencimientoORechazoCAE").prop("disabled", true);
                    //}
                }
            }
        });
    } else {
        $("#IdPuntoVenta").prop("disabled", true);
        //$("#CAE").prop("disabled", true);
        //$("#FechaVencimientoORechazoCAE").prop("disabled", true);
    }
}

function CalcularFechaVencimiento(fecha) {
    var mCantidadDias1, id;

    id = $("#IdCondicionCompra").val() || 0;
    $.ajax({
        type: "GET",
        async: false,
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'CondicionVenta/GetCondicionVenta',
        data: { IdCondicionCompra: id },
        dataType: "json",
        success: function (result) {
            if (result) {
                mCantidadDias1 = parseInt(result[0]["CantidadDias1"] || 0) || 0;
            } else { alert('No se pudo completar la operacion.'); }
        }
    });

    var arrayFecha = fecha.split('/');
    var dia = arrayFecha[0];
    var mes = arrayFecha[1];
    var año = arrayFecha[2].substring(0, 4);
    var fecha2 = mes + '/' + dia + '/' + año;
    var date = new Date(fecha2);
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var fechaFinal = new Date(y, m, d + mCantidadDias1);
    dia = fechaFinal.getDate();
    mes = fechaFinal.getMonth() + 1;
    año = fechaFinal.getFullYear();
    mes = (mes < 10) ? ("0" + mes) : mes;
    dia = (dia < 10) ? ("0" + dia) : dia;
    fechaFinal = dia + '/' + mes + '/' + año;

    return (fechaFinal);
}

function ActivarControles(Activar) {
    var $td;
    if (Activar) {
        pageLayout.show('east');
        pageLayout.close('east');
        $("#Lista").unblock({ message: "", theme: true, });
        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Agregar item"]');
        $td.show();
        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.show();
    } else {
        pageLayout.hide('east');
        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Agregar item"]');
        $td.hide();
        $td = $($("#Lista")[0].p.pager + '_left ' + 'td[title="Eliminar"]');
        $td.hide();
        $("#Lista").block({ message: "", theme: true, });
        $("#Proveedor").prop("disabled", true);
        $("#FechaComprobante").prop("disabled", true);
        $("#FechaRecepcion").prop("disabled", true);
        $("#FechaVencimiento").prop("disabled", true);
        $("#IdCondicionCompra").prop("disabled", true);
        $("#IdMoneda").prop("disabled", true);
        $("#CotizacionMoneda").prop("disabled", true);
        $("#CotizacionDolar").prop("disabled", true);
        $("#FechaPrestacionServicio").prop("disabled", true);
        //$("#FechaFinServicio").prop("disabled", true);
        jQuery("input[name='BienesOServicios']").each(function (i) {
            jQuery(this).prop("disabled", true);
        })
    }

}

$.extend($.fn.fmatter, {
    dynamicText: function (cellvalue, options, rowObject) {
        //if (cellvalue == '0') {
        //    return '0 %';
        //} else if (cellvalue == '10.5') {
        //    return '10.5 %';
        //} else if (cellvalue == '21') {
        //    return '21 %';
        //} else {
        //    return '';
        //}
        if (cellvalue) { return cellvalue } else { return '' }
    }
});
$.extend($.fn.fmatter.dynamicText, {
    unformat: function (cellValue, options, elem) {
        //debugger;
        var text = $(elem).text();
        return text === '&nbsp;' ? '' : text;
    }
});

function radioelem(value, options) {
    var radiohtml = '';
    var a = [];
    a = TraerPorcentajesIva();
    for (var i = 0; i < a.length; i++) {
        radiohtml = radiohtml + '<input type="radio" name="PorcentajeIva" value="' + a[i] + '"';
        if (value == a[i]) { radiohtml = radiohtml + ' checked="checked"' }
        radiohtml = radiohtml + '/>' + a[i] + '<br>';
    }
    return "<span>" + radiohtml + "</span>";
}

function radiovalue(elem, operation, value) {
    if (operation === 'get') {
        return elem.find("input[name=PorcentajeIva]:checked").val();
    } else if (operation === 'set') {
        if ($(elem).is(':checked') === false) {
            $(elem).filter('[value=' + value + ']').attr('checked', true);
        }
    }
}

function TraerPorcentajesIva() {
    var a = [];
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'DescripcionIva/GetPorcentajesIvaCompras/',
        //data: { IdComparativa: IdComparativa },
        dataType: "Json",
        async: false,
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].Value) {
                    a.push(data[i].Value);
                }
            }
        }
    })
    return (a);
}

function ActivarFechasServicio() {
    var BienesOServicios = $("input[name='BienesOServicios']:checked").val();
    if (BienesOServicios == "B") {
        $("#FechaPrestacionServicio").prop("disabled", true);
        //$("#FechaFinServicio").prop("disabled", true);
    } else {
        $("#FechaPrestacionServicio").prop("disabled", false);
        //$("#FechaFinServicio").prop("disabled", false);
    }
}

function cleanString(st) {
    var ltr = ['[àáâãä]', '[èéêë]', '[ìíîï]', '[òóôõö]', '[ùúûü]', 'ñ', 'ç', '[ýÿ]', '\\s|\\W|_'];
    var rpl = ['a', 'e', 'i', 'o', 'u', 'n', 'c', 'y', ' '];
    var str = String(st);

    for (var i = 0, c = ltr.length; i < c; i++) {
        var rgx = new RegExp(ltr[i], 'g');
        str = str.replace(rgx, rpl[i]);
    };

    return str;
}

function TraerDatosProveedorPorCodigo() {
    var ProveedorCodigo = $("#ProveedorCodigo").val();
    if (ProveedorCodigo.length > 0) {
        $.ajax({
            type: "GET",
            async: false,
            url: ROOT + 'Proveedor/GetCodigosProveedorAutocomplete/',
            data: { term: ProveedorCodigo },
            contentType: "application/json",
            dataType: "json",
            success: function (result) {
                if (result.length > 0) {
                    $("#IdProveedor").val(result[0]["id"]);
                    $("#Proveedor").val(result[0]["value"]);
                    $("#IdCodigoIva").val(result[0]["IdCodigoIva"]);
                    $("#IdCondicionCompra").val(result[0]["IdCondicionCompra"]);
                    $("#ProveedorCodigo").val(result[0]["codigo"]);
                    event.preventDefault();
                    ActualizarDatos();
                    //ActualizarPuntosDeVenta()
                } else {
                    $("#ProveedorCodigo").val("");
                }
            }
        });
    } else {
        $("#ProveedorCodigo").val("");
    }
}

function MostrarComprobanteImputado() {
    var IdComprobanteImputado, data2, data3, displayDate;

    IdComprobanteImputado = $("#IdComprobanteImputado").val();
    if (IdComprobanteImputado.length > 0) {
        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: ROOT + 'CuentaCorriente/TraerUno/',
            data: { IdCtaCte: IdComprobanteImputado },
            dataType: "Json",
            success: function (data) {
                data2 = data[0]
                date = new Date(parseInt(data2.Fecha.substr(6)));
                displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                data2.Fecha = displayDate;
                data3 = data2.Tipo + " " + data2.Numero + " del " + data2.Fecha;
                $("#ComprobanteImputado").val(data3);
            }
        });
    }
}

