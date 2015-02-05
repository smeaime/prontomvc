$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", mTotalImputaciones, mImporteIva1, mPercepcionIIBB1, mPercepcionIIBB2, mPercepcionIIBB3, mPercepcionIVA, mImporteTotal;
    var mIVANoDiscriminado, mPorcentajePercepcionIIBB1, mPorcentajePercepcionIIBB2, mPorcentajePercepcionIIBB3;

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

    var CalcularItem = function (value, colname) {
        if (colname === "Cantidad") {
            var rowid = $('#ListaArticulos').getGridParam('selrow');
            value = Number(value);
            var Cantidad = value;
            var Bonificacion = parseFloat($("#ListaArticulos").getCell(rowid, "Bonificacion")) || 0;
            var PrecioUnitario = parseFloat($("#ListaArticulos").getCell(rowid, "PrecioUnitario")) || 0;

            var Importe1 = Math.round(PrecioUnitario * Cantidad * 10000) / 10000;
            var Bonificacion = Math.round(Importe1 * Bonificacion / 100 * 10000) / 10000;
            var Importe = (Importe1 - Bonificacion) || 0;

            $('#ListaArticulos').jqGrid('setCell', rowid, 'Importe', Importe);
        } else {
            if (colname === "Precio") {
                var rowid = $('#ListaArticulos').getGridParam('selrow');
                value = Number(value);
                var PrecioUnitario = value;
                var Bonificacion = parseFloat($("#ListaArticulos").getCell(rowid, "Bonificacion")) || 0;
                var Cantidad = parseFloat($("#ListaArticulos").getCell(rowid, "Cantidad")) || 0;

                var Importe1 = Math.round(PrecioUnitario * Cantidad * 10000) / 10000;
                var Bonificacion = Math.round(Importe1 * Bonificacion / 100 * 10000) / 10000;
                var Importe = (Importe1 - Bonificacion) || 0;

                $('#ListaArticulos').jqGrid('setCell', rowid, 'Importe', Importe);
            }
        }
        return [true];
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaArticulos').jqGrid({
        url: ROOT + 'Factura/DetFactura/',
        postData: { 'IdFactura': function () { return $("#IdFactura").val(); } },
        editurl: ROOT + 'Factura/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleFactura', 'IdArticulo', 'IdUnidad', 'IdColor', 'Codigo', 'Articulo', 'Cantidad', 'Unidad', 'Costo', 'Precio', '% Bonif.', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleFactura', index: 'IdDetalleFactura', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUnidad', index: 'IdUnidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdColor', index: 'IdColor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'Codigo', index: 'Codigo', width: 120, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                            dataUrl: ROOT + 'Unidad/GetCuentasBancariasPorIdCuenta2?IdCuenta=0',
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
                    { name: 'Costo', index: 'Costo', width: 80, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled', defaultValue: 0 }, label: 'TB' },
                    {
                        name: 'PrecioUnitario', index: 'PrecioUnitario', width: 80, align: 'right', editable: true, editrules: { custom: true, custom_func: CalcularItem, required: false, number: true }, edittype: 'text', label: 'TB',
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
                        name: 'Bonificacion', index: 'Bonificacion', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                    { name: 'Importe', index: 'Importe', width: 100, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled', defaultValue: 0 }, label: 'TB' }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
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
        sortname: 'IdDetalleFactura',
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

    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    $("#IdPuntoVenta").change(function () {
        TraerNumeroComprobante()
    });

    $("#IdIBCondicion").change(function () {
        CalcularTotales()
    });

    $("#IdIBCondicion2").change(function () {
        CalcularTotales()
    });

    $("#IdIBCondicion3").change(function () {
        CalcularTotales()
    });

    $("input[name=CtaCte]:radio").change(function () {
        TraerNumeroComprobante();
        CalcularTotales();
    })

    $("#IdMoneda").change(function () {
        TraerCotizacion()
    })

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();

        cabecera.NumeroFactura = $("#NumeroFactura").val();
        cabecera.CAE = $("#CAE").val();
        cabecera.FechaVencimientoORechazoCAE = $("#FechaVencimientoORechazoCAE").val();
        cabecera.IdPuntoVenta = $("#IdPuntoVenta").val();
        cabecera.PuntoVenta = $("#IdPuntoVenta").find('option:selected').text();
        cabecera.Cliente = "";
        cabecera.Provincia = "";

        cabecera.DetalleFacturas = [];
        $grid = $('#ListaArticulos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleFactura'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleFactura":"' + iddeta + '",';
                data1 = data1 + '"IdFactura":"' + $("#IdFactura").val() + '",';
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
                cabecera.DetalleFacturas.push(data2);
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
            url: ROOT + 'Factura/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Factura: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "Factura/Edit/" + result.IdFactura);
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


    $('#probar').click(function () {
        CalcularTotales()

        var cabecera = SerializaForm();

        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Factura/Probar',
            dataType: 'json',
            data: JSON.stringify({ Factura: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                } else {
                }
            },
        });
    });

});

function ActualizarDatos() {
    var IdCodigoIva = 0, Letra = "B", id = 0;

    id = $("#IdCliente").val();
    if (id.length > 0) {
        MostrarDatosCliente(id);
    }

    IdCodigoIva = $("#IdCodigoIva").val();

    if (IdCodigoIva == 1) { Letra = "A" }
    if (IdCodigoIva == 2) { Letra = "B" }
    if (IdCodigoIva == 3) { Letra = "E" }
    if (IdCodigoIva == 8) { Letra = "B" }
    if (IdCodigoIva == 9) { Letra = "A" }
    $("#TipoABC").val(Letra)

    calculaTotalImputaciones();

    $.ajax({
        type: "GET",
        async: false,
        url: ROOT + 'PuntoVenta/GetPuntosVenta2/',
        data: { IdTipoComprobante: 1, Letra: Letra },
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

calculaTotalImputaciones = function () {
    var imp = 0, imp2 = 0, grav = "", letra = "", porciva = 0, ivaitem = 0;

    letra = $("#TipoABC").val();
    porciva = parseFloat($("#PorcentajeIva1").val().replace(",", ".") || 0) || 0;
    mIVANoDiscriminado = 0;
    mImporteIva1 = 0;

    var dataIds = $('#ListaArticulos').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaArticulos').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        if (letra == "B") {
            ivaitem = imp - (imp / (1 + (porciva / 100)));
            mIVANoDiscriminado = mIVANoDiscriminado + ivaitem;
        } else {
            mImporteIva1 = mImporteIva1 + (imp * (porciva / 100));
        }
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalImputaciones = imp2;
    $("#ListaArticulos").jqGrid('footerData', 'set', { Gravado: 'TOTALES', Importe: imp2.toFixed(2) });
    $("#ImporteIva1").val(mImporteIva1.toFixed(2));
    $("#IVANoDiscriminado").val(mIVANoDiscriminado.toFixed(2));

    CalcularTotales()
};

function CalcularTotales() {
    var mSubtotal = 0, mIdFactura = 0, mIdCliente = 0, mIdMoneda = 0, mIdIBCondicion1 = 0, mIdIBCondicion2 = 0, mIdIBCondicion3 = 0, mFecha, datos1, CtaCte = "";

    mIdFactura = $("#IdFactura").val();

    if (typeof mTotalImputaciones == "undefined") { mTotalImputaciones = 0; }
    mSubtotal = mTotalImputaciones;

    mImporteIva1 = parseFloat($("#ImporteIva1").val().replace(",", ".") || 0) || 0;

    mIdCliente = $("#IdCliente").val();
    mIdMoneda = $("#IdMoneda").val();
    mIdIBCondicion1 = parseInt($("#IdIBCondicion").val() || 0) || 0;
    mIdIBCondicion2 = parseInt($("#IdIBCondicion2").val() || 0) || 0;
    mIdIBCondicion3 = parseInt($("#IdIBCondicion3").val() || 0) || 0;
    mFecha = $("#FechaNotaDebito").val();
    CtaCte = $("input[name='CtaCte']:checked").val();

    mPorcentajePercepcionIIBB1 = 0;
    mPorcentajePercepcionIIBB2 = 0;
    mPorcentajePercepcionIIBB3 = 0;

    if (CtaCte != "SI") {
        $("#RetencionIBrutos1").val(0);
        $("#RetencionIBrutos2").val(0);
        $("#RetencionIBrutos3").val(0);
        $("#PercepcionIVA").val(0);
    }

    if (mIdFactura <= 0 && mIdCliente > 0 && CtaCte == "SI") {
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Cliente/CalcularPercepciones',
            dataType: 'json',
            async: false,
            data: JSON.stringify({ IdCliente: mIdCliente, TotalGravado: mSubtotal, IdMoneda: mIdMoneda, IdIBCondicion1: mIdIBCondicion1, IdIBCondicion2: mIdIBCondicion2, IdIBCondicion3: mIdIBCondicion3, Fecha: mFecha }),
            //data: { IdCliente: mIdCliente, TotalGravado: mSubtotal, IdMoneda: mIdMoneda, IdIBCondicion1: mIdIBCondicion1, IdIBCondicion2: mIdIBCondicion2, IdIBCondicion3: mIdIBCondicion3, Fecha: mFecha },
            success: function (result) {
                if (result) {
                    datos = JSON.parse(result);
                    datos1 = datos.campo1;
                    mPercepcionIIBB1 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo2;
                    mPercepcionIIBB2 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo3;
                    mPercepcionIIBB3 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo4;
                    mPorcentajePercepcionIIBB1 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo5;
                    mPorcentajePercepcionIIBB2 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo6;
                    mPorcentajePercepcionIIBB3 = parseFloat(datos1.replace(",", ".") || 0) || 0;
                    datos1 = datos.campo7;
                    mPercepcionIVA = parseFloat(datos1.replace(",", ".") || 0) || 0;
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
    } else {
        mPercepcionIIBB1 = parseFloat($("#RetencionIBrutos1").val().replace(",", ".") || 0) || 0;
        mPercepcionIIBB2 = parseFloat($("#RetencionIBrutos2").val().replace(",", ".") || 0) || 0;
        mPercepcionIIBB3 = parseFloat($("#RetencionIBrutos3").val().replace(",", ".") || 0) || 0;
        mPorcentajePercepcionIIBB1 = parseFloat($("#PorcentajeIBrutos1").val().replace(",", ".") || 0) || 0;
        mPorcentajePercepcionIIBB2 = parseFloat($("#PorcentajeIBrutos2").val().replace(",", ".") || 0) || 0;
        mPorcentajePercepcionIIBB3 = parseFloat($("#PorcentajeIBrutos3").val().replace(",", ".") || 0) || 0;
        mPercepcionIVA = parseFloat($("#PercepcionIVA").val().replace(",", ".") || 0) || 0;
    }

    mImporteTotal = mSubtotal + mImporteIva1 + mPercepcionIIBB1 + mPercepcionIIBB2 + mPercepcionIIBB3 + mPercepcionIVA

    $("#Subtotal").val(mSubtotal.toFixed(2));
    $("#RetencionIBrutos1").val(mPercepcionIIBB1.toFixed(2));
    $("#RetencionIBrutos2").val(mPercepcionIIBB2.toFixed(2));
    $("#RetencionIBrutos3").val(mPercepcionIIBB3.toFixed(2));
    $("#PorcentajeIBrutos1").val(mPorcentajePercepcionIIBB1.toFixed(2));
    $("#PorcentajeIBrutos2").val(mPorcentajePercepcionIIBB2.toFixed(2));
    $("#PorcentajeIBrutos3").val(mPorcentajePercepcionIIBB3.toFixed(2));
    $("#PercepcionIVA").val(mPercepcionIVA.toFixed(2));
    $("#ImporteTotal").val(mImporteTotal.toFixed(2));
};

function TraerCotizacion() {
    var fecha, IdMoneda, datos1, mIdMonedaPrincipal = 1, mIdMonedaDolar = 2, mCotizacionDolar = 0;
    fecha = $("#FechaNotaDebito").val();
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
        if (mCotizacionDolar != 0) { $("#CotizacionDolar").val(mCotizacionDolar.toFixed(2)); }
    }
    else {
        if (IdMoneda == mIdMonedaDolar) {
            $("#CotizacionMoneda").val(mCotizacionDolar.toFixed(2));
            $("#CotizacionDolar").val(mCotizacionDolar.toFixed(2));
        }
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
                $("#PorcentajePercepcionIVA").val(result[0].PorcentajePercepcionIVA);
                $("#BaseMinimaParaPercepcionIVA").val(result[0].BaseMinimaParaPercepcionIVA);
                $("#EsAgenteRetencionIVA").val(result[0].EsAgenteRetencionIVA);
                $("#IdIBCondicion").val(result[0].IdIBCondicionPorDefecto);
                $("#IdIBCondicion2").val(result[0].IdIBCondicionPorDefecto2);
                $("#IdIBCondicion3").val(result[0].IdIBCondicionPorDefecto3);

            }
        }
    });
    return Entidad;
}

function TraerNumeroComprobante() {
    var IdFactura = $("#IdFactura").val();
    var IdPuntoVenta = $("#IdPuntoVenta").val();
    var CtaCte = $("input[name='CtaCte']:checked").val();

    if (IdFactura <= 0) {
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
                    var CAEManual = result[0]["CAEManual"];
                    $("#NumeroFactura").val(ProximoNumero);
                    if (CAEManual == "SI") {
                        $("#CAE").prop("disabled", false);
                        $("#FechaVencimientoORechazoCAE").prop("disabled", false);
                    } else {
                        $("#CAE").val("");
                        $("#FechaVencimientoORechazoCAE").val("");
                        $("#CAE").prop("disabled", true);
                        $("#FechaVencimientoORechazoCAE").prop("disabled", true);
                    }
                }
            }
        });
    } else {
        $("#IdPuntoVenta").prop("disabled", true);
        $("#CAE").prop("disabled", true);
        $("#FechaVencimientoORechazoCAE").prop("disabled", true);
    }
}
