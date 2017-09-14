$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", mTotalImputaciones, mImporteIva1, mPercepcionIIBB1, mPercepcionIIBB2, mPercepcionIIBB3, mPercepcionIVA, mImporteTotal;
    var mIVANoDiscriminado, mPorcentajePercepcionIIBB1, mPorcentajePercepcionIIBB2, mPorcentajePercepcionIIBB3;

    pageLayout.hide('east');

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

    $('#ListaConceptos').jqGrid({
        url: ROOT + 'NotaDebito/DetNotaDebito/',
        postData: { 'IdNotaDebito': function () { return $("#IdNotaDebito").val(); } },
        editurl: ROOT + 'NotaDebito/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleNotaDebito', 'IdConcepto', 'IdCuentaBancaria', 'IdCaja', 'IdDiferenciaCambio', 'Concepto', 'Cuenta bancaria', 'Caja', 'Iva?', '% Iva', 'Imp.Iva', 'IvaNoDiscriminado', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleNotaDebito', index: 'IdDetalleNotaDebito', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdConcepto', index: 'IdConcepto', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdCaja', index: 'IdCaja', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdDiferenciaCambio', index: 'IdDiferenciaCambio', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'Concepto', index: 'Concepto', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Concepto/GetConceptos',
                            dataInit: function (elem) { $(elem).width(190); },
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#ListaConceptos').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
                                         { type: 'change', fn: function (e) {
                                            var rowid = $('#ListaConceptos').getGridParam('selrow');
                                            $('#ListaConceptos').jqGrid('setCell', rowid, 'IdConcepto', this.value);
                                            }
                                         }]
                        },
                    },
                    {
                        name: 'CuentaBancaria', index: 'CuentaBancaria', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetCuentasBancariasPorIdCuenta2?IdCuenta=0',
                            dataInit: function (elem) { $(elem).width(190); },
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#ListaConceptos').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
                                         { type: 'change', fn: function (e) {
                                             var rowid = $('#ListaConceptos').getGridParam('selrow');
                                             $('#ListaConceptos').jqGrid('setCell', rowid, 'IdCuentaBancaria', this.value);
                                            }
                                         }]
                        },
                    },
                    {
                        name: 'Caja', index: 'Caja', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Caja/GetCajasPorIdCuenta2?IdCuenta=0',
                            dataInit: function (elem) { $(elem).width(190); },
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#ListaConceptos').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
                                         { type: 'change', fn: function (e) {
                                             var rowid = $('#ListaConceptos').getGridParam('selrow');
                                             $('#ListaConceptos').jqGrid('setCell', rowid, 'IdCaja', this.value);
                                         }}]
                                },
                    },
                    { name: 'Gravado', index: 'Gravado', width: 40, align: 'left', editable: true, hidden: true, editrules: { required: false }, editoptions: { value: "SI:NO" }, edittype: 'checkbox', label: 'TB' },
                    { name: 'PorcentajeIva', index: 'PorcentajeIva', width: 70, align: 'right', editable: true, hidden: false, formatter: 'dynamicText', edittype: 'custom', editoptions: { custom_element: radioelem, custom_value: radiovalue }, label: 'TB' },
                    { name: 'ImporteIva', index: 'ImporteIva', width: 80, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled', defaultValue: 0 }, label: 'TB' },
                    { name: 'IvaNoDiscriminado', index: 'IvaNoDiscriminado', width: 80, align: 'right', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, label: 'TB' },
                    {
                        name: 'Importe', index: 'Importe', width: 120, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#ListaConceptos').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
                                         { type: 'keypress',
                                            fn: function (e) {
                                                var key = e.charCode || e.keyCode;
                                                if (key == 13) { setTimeout("jQuery('#ListaConceptos').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                                if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                        }}]
                                }
                    }
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
        sortname: 'IdDetalleNotaDebito',
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
        //caption: '<b>DETALLE DE CONCEPTOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaConceptos").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaConceptos").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaConceptos"));
                                     },
                                 });
    jQuery("#ListaConceptos").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaConceptos"));
                                     },
                                 });
    jQuery("#ListaConceptos").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });

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

    $("#ClienteCodigo").change(function () {
        TraerDatosClientePorCodigo()
    })

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo, CtaCte = "";

        CtaCte = $("input[name='CtaCte']:checked").val();

        var cabecera = $("#formid").serializeObject();

        cabecera.NumeroNotaDebito = $("#NumeroNotaDebito").val();
        cabecera.CAE = $("#CAE").val();
        cabecera.FechaVencimientoORechazoCAE = $("#FechaVencimientoORechazoCAE").val();
        cabecera.IdPuntoVenta = $("#IdPuntoVenta").val();
        cabecera.PuntoVenta = $("#IdPuntoVenta").find('option:selected').text();
        cabecera.CotizacionMoneda = $("#CotizacionMoneda").val();
        cabecera.CotizacionDolar = $("#CotizacionDolar").val();
        cabecera.FechaNotaDebito = $("#FechaNotaDebito").val();
        cabecera.IdMoneda = $("#IdMoneda").val();
        cabecera.CtaCte = CtaCte;
        cabecera.Cliente = "";
        cabecera.Provincia = "";

        if (CtaCte == "SI") {
            cabecera.IdPuntoVenta = $("#IdPuntoVenta").val();
            cabecera.PuntoVenta = $("#IdPuntoVenta").find('option:selected').text();
        } else {
            cabecera.IdPuntoVenta = 0;
            cabecera.PuntoVenta = 0;
        }

        var chk = $('#AplicarEnCtaCte').is(':checked');
        if (chk) {
            cabecera.AplicarEnCtaCte = "SI";
        } else {
            cabecera.AplicarEnCtaCte = "NO";
        };

        cabecera.DetalleNotasDebitoes = [];
        $grid = $('#ListaConceptos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleNotaDebito'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleNotaDebito":"' + iddeta + '",';
                data1 = data1 + '"IdNotaDebito":"' + $("#IdNotaDebito").val() + '",';
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
                cabecera.DetalleNotasDebitoes.push(data2);
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
            url: ROOT + 'NotaDebito/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ NotaDebito: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "NotaDebito/Edit/" + result.IdNotaDebito);
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

    idaux = $("#IdNotaDebito").val();
    if (idaux <= 0) {
        ActivarControles(true);
    } else {
        ActivarControles(false);
    }
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
        data: { IdTipoComprobante: 3, Letra: Letra },
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
    var imp = 0, imp2 = 0, grav = "", letra = "", porciva = 0, ivaitem = 0, mIdCodigoIva = 0;

    letra = $("#TipoABC").val();
    mIdCodigoIva = $("#IdCodigoIva").val();

    porciva = 0; //parseFloat($("#PorcentajeIva1").val().replace(",", ".") || 0) || 0;
    mIVANoDiscriminado = 0;
    mImporteIva1 = 0;

    var dataIds = $('#ListaConceptos').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaConceptos').jqGrid('getRowData', dataIds[i]);

        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
        porciva = parseFloat(data['PorcentajeIva'].replace(",", ".") || 0) || 0;
        if (mIdCodigoIva == 3 || mIdCodigoIva == 8 || mIdCodigoIva == 9) { porciva = 0 }
        if (porciva != 0) {
            data['Gravado'] = "SI";
        } else {
            data['Gravado'] = "NO";
        }

        if (letra == "B") {
            ivaitem = imp - (imp / (1 + (porciva / 100)));
            mIVANoDiscriminado = mIVANoDiscriminado + ivaitem;
            data['IvaNoDiscriminado'] = ivaitem.toFixed(2);
        } else {
            ivaitem = imp * porciva / 100;
            mImporteIva1 = mImporteIva1 + ivaitem;
            data['IvaNoDiscriminado'] = 0;
        }
        data['ImporteIva'] = ivaitem.toFixed(4);
        data['IvaNoDiscriminado'] = ivaitem.toFixed(2);

        $('#ListaConceptos').jqGrid('setRowData', dataIds[i], data);
        //grav = data['Gravado'];
        //if (grav == "SI") {
        //    if (letra == "B") {
        //        ivaitem = imp - (imp / (1 + (porciva / 100)));
        //        mIVANoDiscriminado = mIVANoDiscriminado + ivaitem;
        //    } else {
        //        mImporteIva1 = mImporteIva1 + (imp * (porciva / 100));
        //    }
        //}
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalImputaciones = imp2;
    $("#ListaConceptos").jqGrid('footerData', 'set', { Caja: 'TOTALES', Importe: imp2.toFixed(2) });
    $("#ImporteIva1").val(mImporteIva1.toFixed(2));
    $("#IVANoDiscriminado").val(mIVANoDiscriminado.toFixed(2));

    CalcularTotales()
};

function CalcularTotales() {
    var mSubtotal = 0, mIdNotaDebito = 0, mIdCliente = 0, mIdMoneda = 0, mIdIBCondicion1 = 0, mIdIBCondicion2 = 0, mIdIBCondicion3 = 0, mFecha, datos1, CtaCte = "";

    mIdNotaDebito = $("#IdNotaDebito").val();

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

    if (mIdNotaDebito <= 0 && mIdCliente > 0 && CtaCte == "SI") {
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
                $("#IdCodigoIva").val(result[0].IdCodigoIva);
                $("#ClienteCodigo").val(result[0].Codigo);
            }
        }
    });
    return Entidad;
}

function TraerNumeroComprobante() {
    var IdNotaDebito = $("#IdNotaDebito").val();
    var IdPuntoVenta = $("#IdPuntoVenta").val();
    var CtaCte = $("input[name='CtaCte']:checked").val();

    if (IdNotaDebito <= 0) {
        if (CtaCte == "SI") {
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
                        $("#NumeroNotaDebito").val(ProximoNumero);
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
            $("#IdPuntoVenta").val("");
            $("#IdPuntoVenta").prop("disabled", true);
            $("#CAE").val("");
            $("#FechaVencimientoORechazoCAE").val("");
            $("#CAE").prop("disabled", true);
            $("#FechaVencimientoORechazoCAE").prop("disabled", true);
            $.ajax({
                type: "GET",
                async: false,
                url: ROOT + 'Parametro/Parametros/',
                contentType: "application/json",
                dataType: "json",
                success: function (result) {
                    if (result.length > 0) {
                        var ProximoNumero = result[0]["ProximaNotaDebitoInterna"];
                        $("#NumeroNotaDebito").val(ProximoNumero);
                    }
                }
            });
        }
    } else {
        $("#IdPuntoVenta").prop("disabled", true);
        $("#CAE").prop("disabled", true);
        $("#FechaVencimientoORechazoCAE").prop("disabled", true);
    }
}

function ActivarControles(Activar) {
    var $td;
    if (Activar) {
        //pageLayout.show('east');
        //pageLayout.close('east');
        $("#ListaConceptos").unblock({ message: "", theme: true, });
        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Agregar item"]');        $td.show();        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Eliminar"]');        $td.show();
    } else {
        //pageLayout.hide('east');
        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Agregar item"]');        $td.hide();        $td = $($("#ListaConceptos")[0].p.pager + '_left ' + 'td[title="Eliminar"]');        $td.hide();
        $("#ListaConceptos").block({ message: "", theme: true, });

        $("#Cliente").prop("disabled", true);
        $("#FechaNotaDebito").prop("disabled", true);
        $("#IdMoneda").prop("disabled", true);
        $("#CotizacionMoneda").prop("disabled", true);
        $("#CotizacionDolar").prop("disabled", true);
        $("#AplicarEnCtaCte").prop("disabled", true);
        $("#ClienteCodigo").prop("disabled", true);
        jQuery("input[name='CtaCte']").each(function (i) {
            jQuery(this).prop("disabled", true); })
    }
}

$.extend($.fn.fmatter, {
    dynamicText: function (cellvalue, options, rowObject) {
        if (cellvalue) { return cellvalue } else { return '' }
    }
});
$.extend($.fn.fmatter.dynamicText, {
    unformat: function (cellValue, options, elem) {
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
        url: ROOT + 'DescripcionIva/GetPorcentajes/',
        //data: { IdComparativa: IdComparativa },
        dataType: "Json",
        async: false,
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].value) {
                    a.push(data[i].value);
                }
            }
        }
    })
    return (a);
}

function TraerDatosClientePorCodigo() {
    var ClienteCodigo = $("#ClienteCodigo").val();
    if (ClienteCodigo.length > 0) {
        $.ajax({
            type: "GET",
            async: false,
            url: ROOT + 'Cliente/GetCodigosClienteAutocomplete/',
            data: { term: ClienteCodigo },
            contentType: "application/json",
            dataType: "json",
            success: function (result) {
                if (result.length > 0) {
                    $("#IdCliente").val(result[0]["id"]);
                    $("#Cliente").val(result[0]["value"]);
                    $("#IdCodigoIva").val(result[0]["IdCodigoIva"]);
                    $("#IdCondicionVenta").val(result[0]["IdCondicionVenta"]);
                    $("#ClienteCodigo").val(result[0]["codigo"]);
                    event.preventDefault();
                    ActualizarDatos();
                } else {
                    $("#ClienteCodigo").val("");
                }
            }
        });
    } else {
        $("#ClienteCodigo").val("");
    }
}
