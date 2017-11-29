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
        colNames: ['Acciones', 'IdDetalleComprobanteProveedor', 'IdCuenta', 'IdObra', 'IdCuentaGasto', 'IdCuentaBancaria', 'IdRubroContable', 'IdEquipoDestino', 'IdArticulo',
                   'CodigoCuenta', 'CuentaContable', 'CodigoArticulo', 'Articulo', 'Cantidad', 'Importe', 'PorcentajeIva', 'ImporteIva', 'TomarEnCalculoDeImpuestos', 'IdProvinciaDestino1',
                   'PorcentajeProvinciaDestino1', 'IdProvinciaDestino2', 'PorcentajeProvinciaDestino2'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleComprobanteProveedor', index: 'IdDetalleComprobanteProveedor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdCuenta', index: 'IdCuenta', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
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
        colNames: ['IdPedido', 'IdProveedor', 'Numero', 'Sub', 'Fecha', 'Salida', 'Cumplido', 'RMs', 'Obras', 'Cod. prov.', 'Proveedor', 'Subtotal', 'Bonif.', 'IVA', 'Otros',
                   'Imp. Int.', 'Total pedido', 'Mon.', 'Comprador', 'Aprobo', 'Items', 'Comparativa', 'Tipo compra', 'Observaciones', 'Cond. compra', 'Detalle cond. compra', 'Exterior',
                   'Nro. licitacion', 'Impresa', 'Anuló', 'Fecha anulacion', 'Motivo anulacion', 'Equipos destino', 'Circ. firma completo', 'Condicion iva', 'Fecha envio', 'Detalles generales'
        ],
        colModel: [
                    { name: 'IdPedido', index: 'IdPedido', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'IdProveedor', index: 'IdProveedor', align: 'left', width: 100, editable: false, hidden: true },
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
        url: ROOT + 'Remito/TT_DynamicGridData',
        postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'PendienteFactura': "SI" },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['', '', 'IdRemito', 'IdCliente', 'IdProveedor', 'IdObra', 'IdTransportista', 'IdCondicionVenta', 'IdListaPrecios', 'Destino', 'Punto venta', 'Numero', 'Fecha', 'Anulado',
                   'Codigo cliente', 'Cliente', 'CUIT cliente', 'Condicion iva cliente', 'Codigo proveedor', 'Proveedor', 'CUIT proveedor', 'Obras', 'OCompras', 'Facturas', 'Materiales', 'Tipo de remito',
                   'Condicion de venta', 'Transportista', 'Lista de precio', 'Obra', 'Total bultos', 'Valor declarado', 'Items', 'Chofer', 'Hora salida', 'Observaciones'],
        colModel: [
                    { name: 'ver', index: 'ver', hidden: true, width: 50 },
                    { name: 'Emitir', index: 'Emitir', hidden: true, width: 50 },
                    { name: 'IdRemito', index: 'IdRemito', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdCliente', index: 'IdCliente', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdProveedor', index: 'IdProveedor', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdObra', index: 'IdObra', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdTransportista', index: 'IdTransportista', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdCondicionVenta', index: 'IdCondicionVenta', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'IdListaPrecios', index: 'IdListaPrecios', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'Destino', index: 'Destino', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'PuntoVenta', index: 'PuntoVenta', align: 'center', width: 40, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    {
                        name: 'NumeroRemito', index: 'NumeroRemito', align: 'right',
                        width: 80, editable: false, hidden: false
                        , search: true, searchoptions: { sopt: ['cn', 'eq'] }
                    },
                    {
                        name: 'FechaRemito', index: 'FechaRemito', width: 80, align: 'center',
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
                    { name: 'Anulado', index: 'Anulado', align: 'center', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Cliente.Codigo', index: 'Cliente.Codigo', align: 'center', width: 60, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Cliente.RazonSocial', index: 'Cliente.RazonSocial', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Cliente.Cuit', index: 'Cliente.Cuit', align: 'center', width: 120, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'DescripcionIva', index: 'DescripcionIva.Descripcion', align: 'left', width: 170, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ProveedorCodigo', index: 'Proveedore.CodigoEmpresa', align: 'center', width: 70, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ProveedorNombre', index: 'Proveedore.RazonSocial', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ProveedorCuit', index: 'Proveedore.Cuit', align: 'center', width: 120, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Obras', index: 'Obras', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'OCompras', index: 'OCompras', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Facturas', index: 'Facturas', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Materiales', index: 'Materiales', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'TipoRemito', index: 'TipoRemito', align: 'center', width: 100, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Condiciones_Compra.Descripcion', index: 'Condiciones_Compra.Descripcion', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Transportista.RazonSocial', index: 'Transportista', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'ListasPrecio.Descripcion', index: 'ListasPrecio.Descripcion', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Obra.Descripcion', index: 'Obra.NumeroObra', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'TotalBultos', index: 'TotalBultos', align: 'right', width: 80, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'ValorDeclarado', index: 'ValorDeclarado', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'CantidadItems', index: 'CantidadItems', align: 'right', width: 40, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Chofer', index: 'Chofer', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'HoraSalida', index: 'HoraSalida', align: 'center', width: 50, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 500, editable: false, hidden: false }
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
        sortname: 'NumeroRemito',//,NumeroOrdenCompra',
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
        multipleSearch: true
    })

    // jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2',
         { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false });
    jQuery("#ListaDrag2").jqGrid('navButtonAdd', '#ListaDragPager2', {
        caption: "",
        buttonicon: "ui-icon-calculator",
        title: "Choose columns",
        onClickButton: function () {
            $(this).jqGrid('columnChooser',
                { width: 550, msel_opts: { dividerLocation: 0.5 }, modal: true });
            $("#colchooser_" + $.jgrid.jqID(this.id) + ' div.available>div.actions')
                .prepend('<label style="float:left;position:relative;margin-left:0.6em;top:0.6em">Search:</label>');
        }
    });
    jQuery("#ListaDrag2").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/
    jQuery("#ListaDrag2").jqGrid('navButtonAdd', '#ListaDragPager2', { caption: "Filter", title: "Toggle Searching Toolbar", buttonicon: 'ui-icon-pin-s', onClickButton: function () { myGrid[0].toggleToolbar(); } });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $("#ListaDrag3").jqGrid({
        //url: ROOT + 'Articulo/ArticulosGridDataResumido', // '@Url.Action("ArticulosGridData", "Articulo")',
        url: ROOT + 'Articulo/Articulos_DynamicGridData',
        datatype: 'json',
        mtype: 'POST',
        postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'IdObra': function () { return $("#IdObra").val(); } },
        postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'IdObra': function () { return $("#IdObra").val(); } },
        colNames: ['', '', 'Codigo', 'Numero inventario', 'Descripcion', 'Rubro', 'Subrubro', '', '', '', '', '', '', '', '', 'Unidad'],
        colModel: [
                    { name: 'Edit', index: 'Edit', width: 50, align: 'left', sortable: false, search: false, hidden: true },
                    { name: 'Delete', index: 'Delete', width: 1, align: 'left', sortable: false, search: false, hidden: true },
                    { name: 'Codigo', index: 'Codigo', width: 130, align: 'left', stype: 'text', search: true, searchoptions: { clearSearch: true, searchOperators: true, sopt: ['cn'] } },
                    { name: 'NumeroInventario', index: 'NumeroInventario', width: 130, align: 'left', stype: 'text', search: true, searchoptions: { clearSearch: true, searchOperators: true, sopt: ['cn'] }, hidden: true },
                    {
                        name: 'Descripcion', index: 'Descripcion', width: 480, align: 'left', stype: 'text', editable: false, edittype: 'text', editoptions: { maxlength: 250 }, editrules: { required: true },
                        search: true, searchoptions: { clearSearch: true, searchOperators: true, sopt: ['cn'] }
                    },
                    { name: 'Rubro.Descripcion', index: 'Rubro.Descripcion', width: 250, align: 'left', editable: true, edittype: 'select', editoptions: { dataUrl: '@Url.Action("Unidades")' }, editrules: { required: true }, search: true, searchoptions: {} },
                    { name: 'Subrubro.Descripcion', index: '', width: 200, align: 'left', search: true, stype: 'text', hidden: true },
                    { name: 'AlicuotaIVA', index: 'AlicuotaIVA', width: 50, align: 'left', search: true, stype: 'text', hidden: true },
                    { name: 'CostoPPP', index: 'CostoPPP', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'CostoPPPDolar', index: 'CostoPPPDolar', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'CostoReposicion', index: 'CostoReposicion', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'CostoReposicionDolar', index: 'CostoReposicionDolar', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'StockMinimo', index: 'StockMinimo', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'StockReposicion', index: 'StockReposicion', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'CantidadUnidades', index: 'CantidadUnidades', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'Unidad', index: 'Unidad', width: 100, align: 'left', search: true, stype: 'text' },
        ],
        ondblClickRow: function (id) {
            Copiar3(id, "Dbl");
        },
        loadComplete: function () {
            grid = $("ListaDrag3");
        },
        pager: '#ListaDragPager3', // $(),
        rowNum: 50,
        rowList: [10, 20, 50, 100],
        sortname: 'IdArticulo',
        sortorder: "desc",
        viewrecords: true,
        //toppager: true,
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
    jQuery("#ListaDrag3").jqGrid('navGrid', '#ListaDragPager3',
     { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
     {
         width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
     }
    );
    jQuery("#ListaDrag3").jqGrid('navButtonAdd', '#ListaDragPager3', {
        caption: "",
        buttonicon: "ui-icon-calculator",
        title: "Choose columns",
        onClickButton: function () {
            $(this).jqGrid('columnChooser',
                { width: 550, msel_opts: { dividerLocation: 0.5 }, modal: true });
            $("#colchooser_" + $.jgrid.jqID(this.id) + ' div.available>div.actions')
                .prepend('<label style="float:left;position:relative;margin-left:0.6em;top:0.6em">Search:</label>');
        }
    });
    jQuery("#ListaDrag3").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    });
    jQuery("#ListaDrag3").jqGrid('navButtonAdd', '#ListaDragPager3',
        {
            caption: "Filter", title: "Toggle Searching Toolbar",
            buttonicon: 'ui-icon-pin-s',
            onClickButton: function () { myGrid[0].toggleToolbar(); }
        });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Pedidos');
    $('a#a_panel_este_tab2').text('Vacante 1');
    $('a#a_panel_este_tab3').text('Vacante 2');

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
            $("#Proveedor").val(getdata['ProveedoresNombre']);

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
        var acceptId = idsource, IdRemito = 0, mPrimerItem = true, IdObra = 0, Letra = "", Precio = 0, PorcentajeBonificacion = 0, Cantidad = 0, PendienteFacturar = 0, PorcentajeIva = 0;
        var PrecioUnitario = 0, IdCodigoIva = 0, mAux, $gridOrigen = $("#ListaDrag2"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        try {
            IdRemito = getdata['IdRemito'];
            IdObra = getdata['IdObra'];

            $("#IdCliente").val(getdata['IdCliente']);
            $("#IdObra").val(getdata['IdObra']);
            $("#IdCondicionVenta").val(getdata['IdCondicionVenta']);
            $("#IdListaPrecios").val(getdata['IdListaPrecios']);
            //$("#IdMoneda").val(getdata['IdMoneda']);
            $("#Observaciones").val(getdata['Observaciones']);
            $("#PorcentajeBonificacion").val(getdata['PorcentajeBonificacion']);

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Remito/DetRemitosSinFormato/',
                data: { IdRemito: IdRemito },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;
                        if (data[i].PendienteFacturar > 0) {
                            IdCodigoIva = data[i].IdCodigoIva;
                            Letra = "B";
                            if (IdCodigoIva == 1) { Letra = "A" }
                            if (IdCodigoIva == 3) { Letra = "E" }
                            if (IdCodigoIva == 9) { Letra = "A" }
                            Precio = data[i].Precio;
                            PorcentajeBonificacion = data[i].PorcentajeBonificacion;
                            Cantidad = data[i].Cantidad;
                            PendienteFacturar = data[i].PendienteFacturar;
                            PorcentajeIva = data[i].PorcentajeIva;

                            tmpdata['IdDetalleFactura'] = Id2;
                            tmpdata['IdArticulo'] = data[i].IdArticulo;
                            tmpdata['IdUnidad'] = data[i].IdUnidad;
                            tmpdata['IdColor'] = data[i].IdColor;
                            tmpdata['IdObra'] = data[i].IdObra;
                            tmpdata['Obra'] = data[i].Obra;
                            tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
                            tmpdata['TipoCancelacion'] = data[i].TipoCancelacion;
                            tmpdata['IdDetalleOrdenCompra'] = data[i].IdDetalleOrdenCompra;
                            tmpdata['IdDetalleRemito'] = data[i].IdDetalleRemito;
                            tmpdata['Codigo'] = data[i].Codigo;
                            tmpdata['Articulo'] = data[i].Articulo;
                            if (data[i].TipoCancelacion == 1) {
                                tmpdata['Cantidad'] = PendienteFacturar;
                                tmpdata['PorcentajeCertificacion'] = "";
                            } else {
                                tmpdata['Cantidad'] = Cantidad;
                                tmpdata['PorcentajeCertificacion'] = PendienteFacturar;
                            }
                            tmpdata['Unidad'] = data[i].Unidad;
                            tmpdata['TiposDeDescripcion'] = data[i].TiposDeDescripcion;
                            tmpdata['Observaciones'] = data[i].Observaciones;
                            tmpdata['OrdenCompra'] = data[i].OrdenCompraNumero;
                            tmpdata['Remito'] = data[i].RemitoNumero;
                            tmpdata['Bonificacion'] = PorcentajeBonificacion;
                            if (Letra == "B" && IdCodigoIva != 8) {
                                PrecioUnitario = Precio + (Precio * PorcentajeIva / 100);
                            } else {
                                PrecioUnitario = Precio;
                            }
                            tmpdata['PrecioUnitario'] = PrecioUnitario;

                            var Importe = CalcularImporteItem(tmpdata['Cantidad'], PrecioUnitario, PorcentajeBonificacion) || 0;
                            tmpdata['Importe'] = Importe[0];

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
        var acceptId = idsource, mPrimerItem = true, IdArticulo = 0, Letra = "", Precio = 0, PorcentajeBonificacion = 0, Cantidad = 0, PendienteFacturar = 0, PorcentajeIva = 0;
        var PrecioUnitario = 0, IdCodigoIva = 0, mAux, $gridOrigen = $("#ListaDrag3"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        try {
            IdArticulo = getdata['IdArticulo'];

            tmpdata['IdArticulo'] = getdata['IdArticulo'];
            tmpdata['Codigo'] = getdata['Codigo'];
            tmpdata['Articulo'] = getdata['Descripcion'];
            tmpdata['OrigenDescripcion'] = 1;
            var now = new Date();
            var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
            tmpdata['IdUnidad'] = getdata['IdUnidad'];
            tmpdata['Unidad'] = getdata['Unidad'];
            tmpdata['PorcentajeCertificacion'] = "";
            tmpdata['Cantidad'] = 0;
            tmpdata['PrecioUnitario'] = 0;
            tmpdata['Importe'] = 0;

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
        cabecera.IdMoneda = $("#IdMoneda").val();
        cabecera.BienesOServicios = BienesOServicios;
        cabecera.NumeroCAI = $("#NumeroCAI").val();
        cabecera.NumeroCAE = $("#NumeroCAE").val();
        cabecera.FechaVencimientoCAI = $("#FechaVencimientoCAI").val();
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

    //$.ajax({
    //    type: "GET",
    //    async: false,
    //    url: ROOT + 'Parametro/Parametros/',
    //    contentType: "application/json",
    //    dataType: "json",
    //    success: function (result) {
    //        if ((result[0]["PercepcionIIBB"] || "") == "NO") {
    //            $('#LabelRetencionIBrutos1').hide();
    //            $('#PorcentajeIBrutos1').hide();
    //            $('#RetencionIBrutos1').hide();
    //            $('#LabelRetencionIBrutos2').hide();
    //            $('#PorcentajeIBrutos2').hide();
    //            $('#RetencionIBrutos2').hide();
    //            $('#LabelRetencionIBrutos3').hide();
    //            $('#PorcentajeIBrutos3').hide();
    //            $('#RetencionIBrutos3').hide();
    //        }
    //    }
    //});

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
