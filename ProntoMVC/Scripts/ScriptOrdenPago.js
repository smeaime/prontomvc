function SerializaForm() {
    var cm, data1, data2, valor;
    var colModel = jQuery("#Lista").jqGrid('getGridParam', 'colModel');
    //            var cabecera = { "IdPedido": "", "Numero": "", "SubNumero": "", "FechaIngreso": "", "IdProveedor": "", "Validez": "", "Bonificacion": "", "PorcentajeIva1": "", "IdMoneda": "",
    //                "ImporteBonificacion": "", "ImporteIva1": "", "ImporteTotal": "", "IdPlazoEntrega": "", "IdCondicionCompra": "", "Garantia": "", "LugarEntrega": "",
    //                "IdComprador": "", "Aprobo": "", "Referencia": "", "Detalle": "", "Contacto": "", "Observaciones": "", "DetallePedidos": []
    //            };

    var ImporteBonificacion = $("#TotalBonificacionGlobal").val();
    //            ImporteBonificacion = ImporteBonificacion.replace(".", ",");

    //////////////////////////////////////////////////////////////////////////////////////////////
    var cabecera = $("#formid").serializeObject(); // .serializeArray(); // serializeArray 
    cabecera.DetallePedidos = [];
    cabecera.IdProveedor = $("#IdProveedor").val();
    // como no le encontre la vuelta a automatizar la serializacion de inputs disableados, los pongo manualmente
    // como no le encontre la vuelta a automatizar la serializacion de inputs disableados, los pongo manualmente
    //cabecera.NumeroFactura = $("#NumeroFactura").val();

    //            cabecera.IdPedido = $("#IdPedido").val();
    cabecera.NumeroPedido = $("#NumeroPedido").val();
    // cabecera.FechaPedido = $("#FechaPedido").datepicker("getDate");
    cabecera.FechaPedido = $.datepicker.formatDate("yy/mm/dd", $.datepicker.parseDate("dd/mm/yy", $("#FechaPedido").val()));
    //            cabecera.SubNumero = $("#SubNumero").val();
    //            cabecera.FechaIngreso = $("#FechaIngreso").val();
    //            cabecera.IdProveedor = $("#IdProveedor").val();
    //            cabecera.Validez = $("#Validez").val();
    cabecera.DetalleCondicionCompra = $("#DetalleCondicionCompra").val();
    cabecera.Bonificacion = $("#TotalBonificacionGlobal").val().replace(".", ",");
    ////            cabecera.PorcentajeIva1 = 21;
    //            cabecera.IdMoneda = $("#IdMoneda").val();
    //            cabecera.ImporteBonificacion = ImporteBonificacion;
    cabecera.TotalIva1 = $("#TotalIva").val().replace(".", ",");
    cabecera.TotalPedido = $("#Total").val().replace(".", ",");
    //            cabecera.IdPlazoEntrega = $("#IdPlazoEntrega").val();
    //            cabecera.IdCondicionCompra = $("#IdCondicionCompra").val();
    //            cabecera.Garantia = $("#Garantia").val();
    //            cabecera.LugarEntrega = $("#LugarEntrega").val();
    //            cabecera.IdComprador = $("#IdComprador").val();
    //            cabecera.Aprobo = $("#Aprobo").val();
    //            cabecera.Referencia = $("#Referencia").val();
    //            cabecera.Detalle = $("#Detalle").val();
    //            cabecera.Contacto = $("#Contacto").val();
    //            cabecera.Observaciones = $("#Observaciones").val();

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        try {
            saveparameters = {
                "successfunc": null,
                "url": 'clientArray',
                "extraparam": {},
                //                "aftersavefunc": function (response) {
                //                    alert('saved');
                //                },
                "errorfunc": null,
                "afterrestorefunc": null,
                "restoreAfterError": true,
                "mtype": "POST"
            }

            $('#Lista').jqGrid('saveRow', dataIds[i], saveparameters, 'clientArray'); //si esta en inline mode, quizas salta un error!

            var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

            data1 = '{"IdPedido":"' + $("#IdPedido").val() + '",'
            for (var j = 0; j < colModel.length; j++) {
                cm = colModel[j]
                if (cm.label === 'TB') {
                    valor = data[cm.name];
                    if (cm.name === 'Cantidad') valor = valor.replace(".", ",")
                    if (cm.name === 'Precio') valor = valor.replace(".", ",")
                    if (cm.name === 'PorcentajeBonificacion') valor = valor.replace(".", ",")  // parseFloat(valor) || 0;
                    if (cm.name === 'ImporteBonificacion') valor = valor.replace(".", ",")
                    if (cm.name === 'PorcentajeIva') valor = valor.replace(".", ",")
                    if (cm.name === 'ImporteIva') valor = valor.replace(".", ",")
                    if (cm.name === 'ImporteTotalItem') valor = valor.replace(".", ",")
                    if (cm.name === 'IdDetalleRequerimiento') valor = valor.replace(".", ",")
                    //if (cm.name === 'Observaciones') {
                    valor = valor.replace('"', '\\"');
                    //}
                    if (cm.name === 'Adj. 1') {
                        valor = '';
                    }

                    if (cm.name.indexOf("Fecha") !== -1) valor = $.datepicker.formatDate("yy/mm/dd", $.datepicker.parseDate("dd/mm/yy", valor));

                    if (cm.name === 'Cumplido' && cabecera.Cumplido === 'AN') valor = 'AN'

                    if (cm.name === 'OrigenDescripcion') {
                        if (valor == 'Solo el material') {
                            valor = 1;
                        }
                        else if (valor == 'Solo las observaciones') {
                            valor = 2;
                        }
                        else if (valor == 'Material mas observaciones') {
                            valor = 3;
                        }
                        else {
                            //valor = 0;
                        }
                    }
                    data1 = data1 + '"' + cm.name + '":"' + valor + '",';
                }
            }
            data1 = data1.substring(0, data1.length - 1) + '}';
            data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
            data2 = JSON.parse(data1);
            cabecera.DetallePedidos.push(data2);
        }
        catch (ex) {
            $('#Lista').jqGrid('restoreRow', dataIds[i]);
            alert("No se pudo grabar el comprobante. " + ex);
            return;
        }
    }
    return cabecera;
}

function DeSerializaForm() {
    var cm, data1, data2, valor;
}

function Validar() {
    var cabecera = SerializaForm();

    $.ajax({
        type: "POST", //deber�a ser "GET", pero me queda muy larga la url http://stackoverflow.com/questions/6269683/ajax-post-request-will-not-send-json-data
        contentType: 'application/json; charset=utf-8',
        url: ROOT + 'Pedido/ValidarJson',

        dataType: 'json',
        data: JSON.stringify(cabecera), // $.toJSON(cabecera),

        beforeSend: function () {
            $("#loading").show();
        },
        complete: function () {
            $("#loading").hide();
        },
        error: function (xhr, textStatus, exceptionThrown) {

            // ac� se podr�a restaurar el estado de la grilla como antes de haber hecho el envio

            try {
                var errorData = $.parseJSON(xhr.responseText);
                //el xhr.responseText es el JsonResult que mande, y adentro tiene el Status, Messages y Errors.
                //  Podría mostrar directamente el Messages?

                var errorMessages = [];

                //this ugly loop is because List<> is serialized to an object instead of an array
                for (var key in errorData.Errors) {
                    errorMessages.push(errorData[key]);
                }
                //      $('#result').html(errorMessages.join("<br />"));

                //       $('html, body').css('cursor', 'auto');
                //       $('#grabar2').attr("disabled", false).val("Aceptar");

                $("#textoMensajeAlerta").html(errorData.Message);
                //$("#textoMensajeAlerta").html(errorMessages.join());
                $("#mensajeAlerta").show();
                QuitarRenglones(errorData.Errors);

                // alert(errorMessages.join("<br />"));

            } catch (e) {
                // http://stackoverflow.com/questions/15532667/asp-netazure-400-bad-request-doesnt-return-json-data
                // si tira error de Bad Request en el II7, agregar el asombroso   <httpErrors existingResponse="PassThrough"/>

                $('html, body').css('cursor', 'auto');
                $('#grabar2').attr("disabled", false).val("Aceptar");

                $("#textoMensajeAlerta").html(xhr.responseText);
                $("#mensajeAlerta").show(); //http://stackoverflow.com/questions/8965018/dynamically-creating-bootstrap-css-alert-messages?rq=1
                //$(".alert").alert();
                //   alert(xhr.responseText);
            }
        },
        success: function (data) {
            // me paseo por el objeto devuelto, y verifico que esten todos los renglones de la grilla
            // si falta uno, lo borro.

            var arraydemensajes = xhr.responseText;
            QuitarRenglones(arraydemensajes);
        }
    });
}

$(function () {
    $('#grabar2').click(function () {

        var cabecera = SerializaForm();

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Pedido/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify(cabecera), // $.toJSON(cabecera),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    if (true) {
                        //window.location = (ROOT + "Pedido/index");
                        window.location = (ROOT + "Pedido/Edit/" + result.IdPedido);

                    } else {

                        var dt = new Date();
                        var currentTime = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();

                        $("#textoMensajeAlerta").html("Grabado " + currentTime);
                        $("#mensajeAlerta").show();
                        $('html, body').css('cursor', 'auto');
                        $('#grabar2').attr("disabled", false).val("Aceptar");
                    }
                } else {
                    alert('No se pudo grabar el comprobante.');
                    $('.loading').html('');
                    $('html, body').css('cursor', 'auto');
                    $('#grabar2').attr("disabled", false).val("Aceptar");
                }
            },

            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $('#grabar2').attr("disabled", true).val("Espere...");
            },
            error: function (xhr, textStatus, exceptionThrown) {
                try {
                    var errorData = $.parseJSON(xhr.responseText);
                    var errorMessages = [];
                    //this ugly loop is because List<> is serialized to an object instead of an array
                    for (var key in errorData) {
                        errorMessages.push(errorData[key]);
                    }
                    $('html, body').css('cursor', 'auto');
                    $('#grabar2').attr("disabled", false).val("Aceptar");
                    $("#textoMensajeAlerta").html(errorData.Errors.join("<br />"));
                    $("#mensajeAlerta").show();
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

$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "";
    var lastSelectedId;
    var lastSelectediCol;
    var lastSelectediRow;
    var lastSelectediCol2;
    var lastSelectediRow2;
    var inEdit;
    var selICol;
    var selIRow;
    var gridCellWasClicked = false;
    var grillaenfoco = false;
    var dobleclic
    var headerRow, rowHight, resizeSpanHeight;
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

    $.extend($.jgrid.inlineEdit, {
        keys: true
    });

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
        if (jQuery("#ListaContable").find(target).length) {
            $grid = $('#ListaContable');
            grillaenfoco = true;
        }
        if (jQuery("#ListaValores").find(target).length) {
            $grid = $('#ListaValores');
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

    //Esto es para analizar los parametros de entrada via querystring
    var querystring = location.search.replace('?', '').split('&');
    var queryObj = {};
    for (var i = 0; i < querystring.length; i++) {
        var name = querystring[i].split('=')[0];
        var value = querystring[i].split('=')[1];
        queryObj[name] = value;
    }
    if (queryObj["code"] === "1") {
        $(":input").attr("disabled", "disabled");
        $(".boton").hide();
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////DEFINICION DE GRILLAS   ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPago/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPago', 'IdImputacion', 'IdTipoRetencionGanancia', 'IdIBCondicion', 'BaseCalculoIIBB', 'CotizacionMoneda', 'IdTipoComp', 'IdComprobante',
                   'Tipo', 'Numero ', 'Fecha', 'Imp. Original', 'Saldo', 'Importe', 'Imp.s/Impuestos', 'Iva total', 'Total comp.', 'B/S', 'Imp.Ret.Iva', 'Nro.OP Ret.Iva', 'Imp.Gravado',
                   '% Iva Mono', 'Certif.Poliza', 'Nro.Endoso Poliza', 'Fecha Vto.', 'Fecha Comp.'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPago', index: 'IdDetalleOrdenPago', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdImputacion', index: 'IdImputacion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdTipoRetencionGanancia', index: 'IdTipoRetencionGanancia', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdIBCondicion', index: 'IdIBCondicion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'BaseCalculoIIBB', index: 'BaseCalculoIIBB', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'CotizacionMoneda', index: 'CotizacionMoneda', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdTipoComp', index: 'IdTipoComp', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdComprobante', index: 'IdComprobante', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'Tipo', index: 'Tipo', width: 50, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Numero', index: 'Numero', width: 120, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Fecha', index: 'Fecha', width: 85, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteOriginal', index: 'ImporteOriginal', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Saldo', index: 'Saldo', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Importe', index: 'Importe', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'SinImpuestos', index: 'SinImpuestos', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'IvaTotal', index: 'IvaTotal', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'TotalComprobante', index: 'TotalComprobante', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'BienesYServicios', index: 'BienesYServicios', width: 30, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteRetencionIVA', index: 'ImporteRetencionIVA', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroOrdenPagoRetencionIVA', index: 'NumeroOrdenPagoRetencionIVA', width: 100, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'GravadoIVA', index: 'GravadoIVA', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'PorcentajeIVAParaMonotributistas', index: 'PorcentajeIVAParaMonotributistas', width: 85, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'CertificadoPoliza', index: 'CertificadoPoliza', width: 120, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroEndosoPoliza', index: 'NumeroEndosoPoliza', width: 120, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'FechaVencimiento', index: 'FechaVencimiento', width: 85, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 85, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } }
        ],
        gridComplete: function () {
            calculaTotalImputaciones();
            CalcularTotales()
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdImputacion',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
        rownumbers: true,
        multiselect: true,
        altRows: false,
        footerrow: true,
        userDataOnFooter: true,
        caption: '<b>DETALLE IMPUTACIONES</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });


    $(function () {
        $('#ListaValores').jqGrid({
            url: ROOT + 'OrdenPago/DetOrdenesPagoValores/',
            postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
            editurl: ROOT + 'OrdenPago/EditGridData/',
            datatype: 'json',
            mtype: 'POST',
            colNames: ['Acciones', 'IdDetalleOrdenPagoValores', 'IdTipoValor', 'IdBanco', 'IdValor ', 'IdCuentaBancaria', 'IdBancoChequera', 'IdCaja', 'IdTarjetaCredito',
                       'Tipo', 'Nro.Int.', 'Nro.Valor', 'Fecha Vto.', 'Banco / Caja', 'Importe', 'Anulado'],
            colModel: [
                        { name: 'act', formoptions: { rowpos: 1, colpos: 1 }, index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                        {
                            name: 'IdDetalleOrdenPagoValores', formoptions: { rowpos: 2, colpos: 1 }, index: 'IdDetalleOrdenPagoValores', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }
                        },
                        {
                            name: 'IdTipoValor', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdTipoValor', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }
                        },
                        {
                            name: 'IdBanco', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdBanco', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }
                        },
                        {
                            name: 'IdValor', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdValor', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }
                        },
                        {
                            name: 'IdCuentaBancaria', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdCuentaBancaria', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }
                        },
                        {
                            name: 'IdBancoChequera', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdBancoChequera', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }
                        },
                        {
                            name: 'IdCaja', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdCaja', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }
                        },
                        {
                            name: 'IdTarjetaCredito', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdTarjetaCredito', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true }
                        },
                        {
                            name: 'Tipo', formoptions: { rowpos: 4, colpos: 1 }, index: 'Tipo', width: 50, align: 'center', editable: true,
                            hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                        },
                        {
                            name: 'NumeroInterno', formoptions: { rowpos: 5, colpos: 1 }, index: 'NumeroInterno', width: 60, align: 'center', editable: true,
                            hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                        },
                        {
                            name: 'NumeroValor', formoptions: { rowpos: 5, colpos: 1 }, index: 'NumeroValor', width: 100, align: 'center', editable: true,
                            hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                        },
                        {
                            name: 'FechaVencimiento', formoptions: { rowpos: 6, colpos: 1 }, index: 'FechaVencimiento', width: 85, align: 'center', editable: true,
                            hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                        },
                        {
                            name: 'Entidad', formoptions: { rowpos: 4, colpos: 1 }, index: 'Entidad', width: 250, align: 'left', editable: true,
                            hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                        },
                        {
                            name: 'Importe', formoptions: { rowpos: 9, colpos: 1 }, index: 'Importe', width: 85, align: 'right', editable: true,
                            hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                        },
                        {
                            name: 'Anulado', formoptions: { rowpos: 4, colpos: 1 }, index: 'Anulado', width: 50, align: 'center', editable: true,
                            hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                        }
            ],
            gridComplete: function () {
                calculaTotalValores();
            },
            onCellSelect: function (rowid, iCol, cellcontent, e) {
                var $this = $(this);
                var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
                lastSelectedId = rowid;
                lastSelectediCol = iCol;
                lastSelectediRow = iRow;
            },
            pager: $('#ListaPager3'),
            rowNum: 100,
            rowList: [10, 20, 50, 100],
            sortname: 'IdDetalleOrdenPagoValores',
            sortorder: 'asc',
            viewrecords: true,
            width: 'auto', 
            autowidth: true,
            shrinkToFit: false,
            height: '200px',
            rownumbers: true,
            multiselect: true,
            altRows: false,
            footerrow: true,
            userDataOnFooter: true,
            caption: '<b>DETALLE VALORES</b>',
            cellEdit: true,
            cellsubmit: 'clientArray'
        });
        jQuery("#ListaValores").jqGrid('navGrid', '#ListaPager3', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
        $("#ListaValores").setFrozenColumns();
    })


    $('#ListaContable').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoCuentas/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoCuentas', 'IdCuenta', 'Codigo', 'Cuenta', 'Debe', 'Haber'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoCuentas', index: 'IdDetalleOrdenPagoCuentas', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdCuenta', index: 'IdCuenta', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'Codigo', index: 'Codigo', width: 70, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Cuenta', index: 'Cuenta', width: 200, align: 'left', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Debe', index: 'Debe', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Haber', index: 'Haber', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } }
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
        pager: $('#ListaPager2'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleOrdenPagoCuentas',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
        rownumbers: true,
        multiselect: true,
        altRows: false,
        footerrow: true,
        userDataOnFooter: true,
        caption: '<b>REGISTRO CONTABLE</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaContable").jqGrid('navGrid', '#ListaPager2', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });


    $('#ListaImpuestos').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoImpuestos/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoImpuestos', 'IdTipoImpuesto', 'Tipo', 'Categoria', 'Imp.Pag.S/Imp.', 'Imp.Retenido', 'Pagos mes', 'Retenc.Mes',
                   'Minimo IIBB', 'Alic.IIBB', 'Alic.Conv.IIBB', '% Adic.', 'Impuesto ad.', 'Cert.Ret.Gan.', 'Cert.Ret.IIBB', 'Fact.M a Ret.'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoImpuestos', index: 'IdDetalleOrdenPagoImpuestos', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdTipoImpuesto', index: 'IdTipoImpuesto', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'Tipo', index: 'Tipo', width: 70, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Categoria', index: 'Categoria', width: 200, align: 'left', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImportePagadoSinImpuestos', index: 'ImportePagadoSinImpuestos', width: 100, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImpuestoRetenido', index: 'ImpuestoRetenido', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'PagosMes', index: 'PagosMes', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'RetencionesMes', index: 'RetencionesMes', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'MinimoIIBB', index: 'MinimoIIBB', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'AlicuotaIIBB', index: 'AlicuotaIIBB', width: 60, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'AlicuotaConvenioIIBB', index: 'AlicuotaConvenioIIBB', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'PorcentajeAdicional', index: 'PorcentajeAdicional', width: 50, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImpuestoAdicional', index: 'ImpuestoAdicional', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroCertificadoRetencionGanancias', index: 'NumeroCertificadoRetencionGanancias', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroCertificadoRetencionIIBB', index: 'NumeroCertificadoRetencionIIBB', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteTotalFacturasMPagadasSujetasARetencion', index: 'ImporteTotalFacturasMPagadasSujetasARetencion', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } }
        ],
        gridComplete: function () {
            //calculaTotalContable();
        },
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        pager: $('#ListaPager4'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'Tipo,Categoria',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
        rownumbers: true,
        multiselect: true,
        altRows: false,
        footerrow: true,
        userDataOnFooter: true,
        caption: '<b>DETALLE IMPUESTOS CALCULADOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaImpuestos").jqGrid('navGrid', '#ListaPager4', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });


    $('#ListaRubrosContables').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoRubrosContables/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoRubrosContables', 'IdRubroContable', 'Rubro contable', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoRubrosContables', index: 'IdDetalleOrdenPagoRubrosContables', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRubroContable', index: 'IdRubroContable', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'RubroContable', index: 'RubroContable', width: 120, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Importe', index: 'Importe', width: 90, align: 'right', editable: true, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } }
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
        pager: $('#ListaPager5'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleOrdenPagoRubrosContables',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
        rownumbers: true,
        multiselect: true,
        altRows: false,
        footerrow: true,
        userDataOnFooter: true,
        caption: '<b>DETALLE RUBROS CONTABLES</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaRubrosContables").jqGrid('navGrid', '#ListaPager5', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });


    $("#ListaDrag").jqGrid({
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
                        { name: 'Numero', index: 'Numero', align: 'right', width: 120, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                        { name: 'Fecha', index: 'Fecha', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'FechaVencimiento', index: 'FechaVencimiento', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Moneda', index: 'Moneda', align: 'left', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                        { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Saldo', index: 'Saldo', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'SaldoTrs', index: 'SaldoTrs', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } }
                    ],
        ondblClickRow: function (id) {
            CopiarCtaCte(id);
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'IdImputacion,Cabeza,Fecha,Numero',
        sortorder: "asc",
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
        //caption: '<b>REQUERIMIENTOS RESUMIDO</b>'
    })
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });


    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Valor/ValoresEnCartera',
        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'IdValor', 'Tipo', 'Nro.Int.', 'Nro.Valor', 'Fecha valor', 'Banco', 'Importe', 'T.Cmp.', 'Nro.Comprob.', 'Fecha Cmp.', 'Cliente'],
        colModel: [
                        { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: true },
                        { name: 'IdValor', index: 'IdValor', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Tipo', index: 'Tipo', align: 'center', width: 40, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'NumeroInterno', index: 'NumeroInterno', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                        { name: 'NumeroValor', index: 'NumeroValor', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                        { name: 'FechaValor', index: 'FechaValor', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Banco', index: 'Banco', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                        { name: 'Importe', index: 'Importe', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'TipoComprobante', index: 'TipoComprobante', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'NumeroComprobante', index: 'NumeroComprobante', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq'] } },
                        { name: 'FechaComprobante', index: 'FechaComprobante', width: 90, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Cliente', index: 'Cliente', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } }
        ],
        ondblClickRow: function (id) {
            CopiarValorTercero(id);
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag2 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager2'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'FechaValor',
        sortorder: "desc",
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
        //caption: '<b>REQUERIMIENTOS RESUMIDO</b>'
    })
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Cuenta corriente');
    $('a#a_panel_este_tab2').text('Cartera de valores');
    //$('a#a_panel_este_tab5').remove();  //    

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
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");
                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                var j = 0, tmpdata = {}, dropname, IdValor;
                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                var grid;
                try {
                    IdValor = getdata['IdValor'];
                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: ROOT + 'Valor/TraerUnValor/',
                        data: { IdValor: IdValor },
                        dataType: "Json",
                        success: function (data) {
                            var longitud = data.length;
                            for (var i = 0; i < data.length; i++) {
                                var date = new Date(parseInt(data[i].FechaEntrega.substr(6)));
                                var displayDate = $.datepicker.formatDate("mm/dd/yy", date);
                                tmpdata['IdArticulo'] = data[i].IdArticulo;
                                tmpdata['Codigo'] = data[i].Codigo;
                                tmpdata['Descripcion'] = data[i].Descripcion;
                                tmpdata['IdUnidad'] = data[i].IdUnidad;
                                tmpdata['Unidad'] = data[i].Unidad;
                                tmpdata['IdDetallePedido'] = 0;
                                tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                                tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                                tmpdata['NumeroItemRM'] = data[i].NumeroItemRM;
                                tmpdata['Cantidad'] = data[i].Cantidad;
                                tmpdata['Observaciones'] = data[i].Observaciones;
                                tmpdata['NumeroObra'] = data[i].NumeroObra;
                                tmpdata['FechaEntrega'] = displayDate;
                                tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                                getdata = tmpdata;
                                grid = Math.ceil(Math.random() * 1000000);
                                $("#Lista").jqGrid('addRowData', grid, getdata);
                            }
                        }
                    });
                } catch (e) { }
                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
            }
        });
    }

    function ConectarGrillas2() {
        $("#ListaDrag2").jqGrid('gridDnD', {
            connectWith: '#ListaValores',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                            .addClass("ui-state-error ui-widget")
                            .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");
                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                var j = 0, tmpdata = {}, dropname, IdValor;
                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                var grid;
                try {
                    IdValor = getdata['IdValor'];
                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: ROOT + 'Valor/TraerUnValor/',
                        data: { IdValor: IdValor },
                        dataType: "Json",
                        success: function (data) {
                            var longitud = data.length;
                            for (var i = 0; i < data.length; i++) {
                                var date = new Date(parseInt(data[i].FechaEntrega.substr(6)));
                                var displayDate = $.datepicker.formatDate("mm/dd/yy", date);
                                tmpdata['IdArticulo'] = data[i].IdArticulo;
                                tmpdata['Codigo'] = data[i].Codigo;
                                tmpdata['Descripcion'] = data[i].Descripcion;
                                tmpdata['IdUnidad'] = data[i].IdUnidad;
                                tmpdata['Unidad'] = data[i].Unidad;
                                tmpdata['IdDetallePedido'] = 0;
                                tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                                tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                                tmpdata['NumeroItemRM'] = data[i].NumeroItemRM;
                                tmpdata['Cantidad'] = data[i].Cantidad;
                                tmpdata['Observaciones'] = data[i].Observaciones;
                                tmpdata['NumeroObra'] = data[i].NumeroObra;
                                tmpdata['FechaEntrega'] = displayDate;
                                tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                                getdata = tmpdata;
                                grid = Math.ceil(Math.random() * 1000000);
                                $("#Lista").jqGrid('addRowData', grid, getdata);
                            }
                        }
                    });
                } catch (e) { }
                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
            }
        });
    }

    $("#BuscadorPanelDerecho").change(function () {
        var grid = jQuery("#ListaDrag");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                searchField: 'NumeroValor', // Codigo
                searchOper: 'eq',
                searchString: $("#BuscadorPanelDerecho").val()
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);
    });
});

function pickdates(id) {
    jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
}

getColumnIndexByName = function (grid, columnName) {
    var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
    for (i = 0; i < l; i++) {
        if (cm[i].name === columnName) {
            return i; // return the index
        }
    }
    return -1;
},

function unformatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(",", ".");
}

function formatNumber(cellvalue, options, rowObject) {
    return cellvalue.replace(".", ",");
}

calculaTotalImputaciones = function () {
    var totalCantidad = $('#Lista').jqGrid('getCol', 'Importe', false, 'sum')

    var imp = 0, imp2 = 0;
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    $("#Lista").jqGrid('footerData', 'set', {
        Fecha: 'TOTALES',
        Importe: imp2.toFixed(2)
    });
};

calculaTotalValores = function () {
    var total = $('#ListaValores').jqGrid('getCol', 'Importe', false, 'sum')
    $("#ListaValores").jqGrid('footerData', 'set', {
        Entidad: 'TOTALES',
        Importe: total.toFixed(2)
    });
};

calculaTotalContable = function () {
    var debe = $('#ListaContable').jqGrid('getCol', 'Debe', false, 'sum')
    var haber = $('#ListaContable').jqGrid('getCol', 'Haber', false, 'sum')
    $("#ListaContable").jqGrid('footerData', 'set', {
        Cuenta: 'TOTALES',
        Debe: debe.toFixed(2),
        Haber: haber.toFixed(2)
    });
};

calculaTotalRubroContable = function () {
    var total = $('#ListaRubrosContables').jqGrid('getCol', 'Importe', false, 'sum')
    $("#ListaRubrosContables").jqGrid('footerData', 'set', {
        RubroContable: 'TOTAL',
        Importe: total.toFixed(2)
    });
};

function CalcularTotales() {
    var DECIMALES = 2;
    var subtotal = $('#Lista').jqGrid('getCol', 'Importe', false, 'sum')

    $("#Subtotal").val(subtotal.toFixed(DECIMALES));
};

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

function BuscarOrden(Numero) {
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'Pedido/BuscarOrden/',
        data: { Numero: Numero },
        dataType: "text",
        success: function (data) {
            var sn;
            if (data.length > 0) {
                sn = parseInt(data) + 1;
                $("#SubNumero").val(sn);
            }
            else { $("#SubNumero").val("1"); }
        }
    });
}

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
