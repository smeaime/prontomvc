function SerializaForm() {
    var cm, data1, data2, valor;
    var colModel = jQuery("#Lista").jqGrid('getGridParam', 'colModel');
    var ImporteBonificacion = $("#TotalBonificacionGlobal").val();
    var cabecera = $("#formid").serializeObject(); // .serializeArray(); // serializeArray 
    cabecera.DetallePedidos = [];
    cabecera.IdProveedor = $("#IdProveedor").val();
    cabecera.NumeroPedido = $("#NumeroPedido").val();
    cabecera.FechaPedido = $.datepicker.formatDate("yy/mm/dd", $.datepicker.parseDate("dd/mm/yy", $("#FechaPedido").val()));
    cabecera.DetalleCondicionCompra = $("#DetalleCondicionCompra").val();
    cabecera.Bonificacion = $("#TotalBonificacionGlobal").val().replace(".", ",");
    cabecera.TotalIva1 = $("#TotalIva").val().replace(".", ",");
    cabecera.TotalPedido = $("#Total").val().replace(".", ",");

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

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic
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
        if (jQuery("#ListaImpuestos").find(target).length) {
            $grid = $('#ListaImpuestos');
            grillaenfoco = true;
        }
        if (jQuery("#ListaRubrosContables").find(target).length) {
            $grid = $('#ListaRubrosContables');
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

    var ControlImportes = function (value, colname) {
        
        if (colname === "A pagar") {
            var rowid = $('#Lista').getGridParam('selrow');
            var SinImpuestos = $("#Lista").getCell(rowid, "SinImpuestos");
            SinImpuestos = Number(SinImpuestos.replace(",", "."));
            value = Number(value);
            if (value < SinImpuestos) {
                return [false, "El monto a pagar no puede ser inferior al importe sin impuestos"];
            }
        }
        if (colname === "Imp.s/Impuestos") {
            var rowid = $('#Lista').getGridParam('selrow');
            var Importe = $("#Lista").getCell(rowid, "Importe")
            Importe = Number(Importe.replace(",", "."));
            value = Number(value);
            if (value > Importe) {
                return [false, "El importe sin impuestos no puede ser superior al monto a pagar"];
            }
        }
        return [true];
    };
        
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPago/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPago', 'IdImputacion', 'IdTipoRetencionGanancia', 'IdIBCondicion', 'BaseCalculoIIBB', 'CotizacionMoneda', 'IdTipoComp', 'IdComprobante',
                   'Tipo', 'Numero ', 'Fecha', 'Imp. Original', 'Saldo', 'A pagar', 'Imp.s/Impuestos', 'Iva total', 'Total comp.', 'B/S', 'Imp.Ret.Iva', 'Nro.OP Ret.Iva', 'Imp.Gravado',
                   '% Iva Mono', 'Certif.Poliza', 'Nro.Endoso Poliza', 'Fecha Vto.', 'Fecha Comp.', 'Categoria IIBB', 'Categoria ganancias'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPago', index: 'IdDetalleOrdenPago', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdImputacion', index: 'IdImputacion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdTipoRetencionGanancia', index: 'IdTipoRetencionGanancia', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdIBCondicion', index: 'IdIBCondicion', editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'BaseCalculoIIBB', index: 'BaseCalculoIIBB', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'CotizacionMoneda', index: 'CotizacionMoneda', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdTipoComp', index: 'IdTipoComp', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'IdComprobante', index: 'IdComprobante', editable: false, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true } },
                    { name: 'Tipo', index: 'Tipo', width: 50, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Numero', index: 'Numero', width: 120, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Fecha', index: 'Fecha', width: 85, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteOriginal', index: 'ImporteOriginal', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'Saldo', index: 'Saldo', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    {
                        name: 'Importe', index: 'Importe', width: 85, align: 'right', editable: true, editrules: { custom: true, custom_func: ControlImportes, required: false, number: true }, edittype: 'text',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {   type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) {setTimeout("jQuery('#Lista').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100);}
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'SinImpuestos', index: 'SinImpuestos', width: 85, align: 'right', editable: true, editrules: { custom: true, custom_func: ControlImportes, required: false, number: true }, edittype: 'text',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
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
                    { name: 'IvaTotal', index: 'IvaTotal', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'TotalComprobante', index: 'TotalComprobante', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'BienesYServicios', index: 'BienesYServicios', width: 30, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'ImporteRetencionIVA', index: 'ImporteRetencionIVA', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroOrdenPagoRetencionIVA', index: 'NumeroOrdenPagoRetencionIVA', width: 100, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'GravadoIVA', index: 'GravadoIVA', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'PorcentajeIVAParaMonotributistas', index: 'PorcentajeIVAParaMonotributistas', width: 85, align: 'right', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'CertificadoPoliza', index: 'CertificadoPoliza', width: 120, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'NumeroEndosoPoliza', index: 'NumeroEndosoPoliza', width: 120, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'FechaVencimiento', index: 'FechaVencimiento', width: 85, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 85, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false } },
                    {
                        name: 'CategoriaIIBB', index: 'CategoriaIIBB', align: 'left', width: 150, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'IBCondicion/GetCategoriasIIBB',
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    //if ($this.hasClass("FormElement")) {
                                    //    // form editing
                                    //    $('#IdIBCondicion').val(this.value);
                                    //} else {
                                    //    $td = $this.closest("td");
                                    //    if ($td.hasClass("edit-cell")) {
                                    //        // cell editing
                                    //        var rowid = $('#Lista').getGridParam('selrow');
                                    //        $('#Lista').jqGrid('setCell', rowid, 'IdIBCondicion', this.value);
                                    //    } else {
                                    //        // inline editing
                                    //    }
                                    //}
                                }
                            }]
                        },
                    },
                    {
                        name: 'CategoriaGanancias', index: 'CategoriaGanancias', align: 'left', width: 150, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'TipoRetencionGanancia/GetCategoriasGanancia',
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    //if ($this.hasClass("FormElement")) {
                                    //    // form editing
                                    //    $('#IdTipoRetencionGanancia').val(this.value);
                                    //} else {
                                    //    $td = $this.closest("td");
                                    //    if ($td.hasClass("edit-cell")) {
                                    //        // cell editing
                                    //        var rowid = $('#Lista').getGridParam('selrow');
                                    //        $('#Lista').jqGrid('setCell', rowid, 'IdTipoRetencionGanancia', this.value);
                                    //    } else {
                                    //        // inline editing
                                    //    }
                                    //}
                                }
                            }]
                        },
                    }
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
            if (jQuery("#Lista").jqGrid('getCell', rowid, 'Tipo') != 'PA') {
                jQuery("#Lista").jqGrid('setCell', rowid, 'CategoriaIIBB', '', 'not-editable-cell');
                jQuery("#Lista").jqGrid('setCell', rowid, 'CategoriaGanancias', '', 'not-editable-cell');
            }
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
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar anticipo",
                                     onClickButton: function () {
                                         AgregarAnticipo(jQuery("#Lista"));
                                     },
                                 });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#Lista"));
                                     },
                                 });
    

    $('#ListaValores').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoValores/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleOrdenPagoValores', 'IdTipoValor', 'IdBanco', 'IdValor ', 'IdCuentaBancaria', 'IdBancoChequera', 'IdCaja', 'IdTarjetaCredito',
                    'Tipo', 'Nro.Int.', 'Nro.Valor', 'Fecha Vto.', 'Banco / Caja', 'Importe', 'Anulado', 'Cheque a la orden de', 'No a la orden'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleOrdenPagoValores', index: 'IdDetalleOrdenPagoValores', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdTipoValor', index: 'IdTipoValor', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdBanco', index: 'IdBanco', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false } },
                    { name: 'IdValor', index: 'IdValor', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false } },
                    { name: 'IdCuentaBancaria', index: 'IdCuentaBancaria', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false } },
                    { name: 'IdBancoChequera', index: 'IdBancoChequera', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false } },
                    { name: 'IdCaja', index: 'IdCaja', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false } },
                    { name: 'IdTarjetaCredito', index: 'IdTarjetaCredito', formoptions: { rowpos: 1, colpos: 1 }, editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false } },
                    {
                        name: 'Tipo', index: 'Tipo', formoptions: { rowpos: 3, colpos: 1 }, align: 'left', width: 50, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Valor/GetTiposValores',
                            dataInit: function(elem) {
                                $(elem).width(40);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var $this = $(e.target), $td;
                                    if ($this.hasClass("FormElement")) {
                                        // form editing
                                        $('#IdTipoValor').val(this.value);
                                    } else {
                                        $td = $this.closest("td");
                                        if ($td.hasClass("edit-cell")) {
                                            // cell editing
                                            var rowid = $('#ListaValores').getGridParam('selrow');
                                            $('#ListaValores').jqGrid('setCell', rowid, 'IdTipoValor', this.value);
                                        } else {
                                            // inline editing
                                        }
                                    }
                                }
                            }]
                        },
                    },
                    {
                        name: 'NumeroInterno', index: 'NumeroInterno', formoptions: { rowpos: 2, colpos: 1 }, width: 70, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text',
                        editoptions: {
                            maxlength: 20, defaultValue: '0',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaValores').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'NumeroValor', index: 'NumeroValor', formoptions: { rowpos: 2, colpos: 2 }, width: 100, align: 'center', editable: true, editrules: { required: false, number: true }, edittype: 'text', 
                        editoptions: {
                            maxlength: 20, defaultValue: '0',
                            dataEvents: [
                            {   type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaValores').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'FechaValor', index: 'FechaValor', formoptions: { rowpos: 3, colpos: 2 }, width: 120, sortable: false, align: 'right', editable: true,
                        editoptions: {
                            size: 10,
                            maxlengh: 10,
                            dataInit: function (elem) {
                                $(elem).width(110);
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
                        name: 'Entidad', index: 'Entidad', formoptions: { rowpos: 4, colpos: 1 }, align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'Banco/GetBancosPropios',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaValores').getGridParam('selrow');
                                    var idcaja = $("#ListaValores").getRowData(rowid)['IdCaja'];
                                    if (idcaja == "") {
                                        $('#ListaValores').jqGrid('setCell', rowid, 'IdCuentaBancaria', this.value);
                                    } else {
                                        $('#ListaValores').jqGrid('setCell', rowid, 'IdCaja', this.value);
                                    };
                                }
                            }]
                        },
                    },
                    {
                        name: 'Importe', index: 'Importe', formoptions: { rowpos: 4, colpos: 2 }, width: 90, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaValores').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'Anulado', index: 'Anulado', width: 50, align: 'center', editable: false, hidden: false, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false }
                    },
                    { name: 'ChequesALaOrdenDe', index: 'ChequesALaOrdenDe', formoptions: { rowpos: 5, colpos: 1 }, width: 200, align: 'left', editable: true, editrules: { required: false, number: true }, edittype: 'text'},
                    { name: 'NoALaOrden', index: 'NoALaOrden', formoptions: { rowpos: 5, colpos: 2 }, width: 40, align: 'left', editable: true, editrules: { required: false, number: true }, edittype: 'text' }
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
            if (jQuery("#ListaValores").jqGrid('getCell', rowid, 'Tipo') == 'CE') {
                jQuery("#ListaValores").jqGrid('setCell', rowid, 'Tipo', '', 'not-editable-cell');
            }
            var cm = jQuery("#ListaValores").jqGrid("getGridParam", "colModel");
            if (cm[iCol].name == "Entidad") {
                var TipoEntidad, TipoEntidad1;
                TipoEntidad = $("#ListaValores").getRowData(rowid)['IdCaja'];
                TipoEntidad1 = 1
                if (TipoEntidad != "") { TipoEntidad1 = 2 }
                $("#ListaValores").setColProp('Entidad', { editoptions: { dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=' + TipoEntidad1 } });
            }
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
    //$("#ListaValores").setFrozenColumns();
    jQuery("#ListaValores").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-home", title: "Agregar valor",
                                        onClickButton: function () {
                                            AgregarValor(jQuery("#ListaValores"));
                                        },
                                    });
    jQuery("#ListaValores").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-clipboard", title: "Agregar caja",
                                        onClickButton: function () {
                                            AgregarCaja(jQuery("#ListaValores"));
                                        },
                                    });
    jQuery("#ListaValores").jqGrid('navButtonAdd', '#ListaPager3',
                                    {
                                        caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                        onClickButton: function () {
                                            EliminarSeleccionados(jQuery("#ListaValores"));
                                        },
                                    });


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
            CopiarCtaCte(id, "Dbl");
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
            CopiarValorTercero(id, "Dbl");
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
                CopiarCtaCte($(ui.draggable).attr("id"), "DnD");
                //var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                //var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
                CopiarValorTercero($(ui.draggable).attr("id"), "DnD");
            }
        });
    }

    function CopiarCtaCte(IdCtaCte, Origen) {
        var acceptId = IdCtaCte;
        var $gridOrigen = $("#ListaDrag"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;
        //var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');

        dataIds = $gridDestino.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            data2 = $gridDestino.jqGrid('getRowData', dataIds[i]);
            if (data2.IdImputacion == IdCtaCte) {
                if (Origen == "DnD") $gridDestino.jqGrid('delRowData', dataIds[0]);
                alert("Ya existe el registro");
                return;
            }
        };
        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;
        try {
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'CuentaCorriente/TraerUno/',
                data: { IdCtaCte: IdCtaCte },
                dataType: "Json",
                success: function (data) {
                    for (i = 0; i < data.length; i++) {
                        data2 = data[i]
                        data2.IdDetalleOrdenPago = Id2;

                        date = new Date(parseInt(data[i].Fecha.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        data2.Fecha = displayDate;
                        date = new Date(parseInt(data[i].FechaVencimiento.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        data2.FechaVencimiento = displayDate;
                        date = new Date(parseInt(data[i].FechaComprobante.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        data2.FechaComprobante = displayDate;

                        if (Origen == "DnD") {
                            Id = dataIds[0];
                            $gridDestino.jqGrid('setRowData', Id, data2);
                        } else {
                            Id = Id2
                            $gridDestino.jqGrid('addRowData', Id, data2, "first");
                        };

                        //ar new_id = 39; //for example
                        //aftersavefunc: function( old_id ) {

                        //    //get data param
                        //    var row = grid.jqGrid('getLocalRow', old_id);
                        //    console.log(row); //use for firefox test
                        //    row._id_ = new_id;

                        //    grid.jqGrid('setRowData',old_id,{my_id:new_id});
                        //    $("#"+response).attr("id", new_id); //change TR element in DOM

                        //    //very important to change the _index, some functions using the                  
                        //    var _index = grid.jqGrid('getGridParam', '_index');
                        //    var valueTemp = _index[old_id];
                        //    delete _index[old_id];
                        //    _index[new_id] = valueTemp;
                        //}
                    }
                }
            });
        } catch (e) { }
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }

    function CopiarValorTercero(IdValor, Origen) {
        var acceptId = IdValor;
        var $gridOrigen = $("#ListaDrag2"), $gridDestino = $("#ListaValores");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;
        //var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');

        dataIds = $gridDestino.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            data2 = $gridDestino.jqGrid('getRowData', dataIds[i]);
            if (data2.IdValor == IdValor) {
                if (Origen == "DnD") $gridDestino.jqGrid('delRowData', dataIds[0]);
                alert("Ya existe el registro");
                return;
            }
        };
        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;
        try {
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Valor/TraerUno/',
                data: { IdValor: IdValor },
                dataType: "Json",
                success: function (data) {
                    for (i = 0; i < data.length; i++) {
                        data2 = data[i]
                        data2.IdDetalleOrdenPagoValores = Id2;

                        date = new Date(parseInt(data[i].FechaValor.substr(6)));
                        displayDate = $.datepicker.formatDate("dd/mm/yy", date);
                        data2.FechaValor = displayDate;

                        if (Origen == "DnD") {
                            Id = dataIds[0];
                            $gridDestino.jqGrid('setRowData', Id, data2);
                        } else {
                            Id = Id2
                            $gridDestino.jqGrid('addRowData', Id, data2, "first");
                        };
                    }
                }
            });
        } catch (e) { }
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
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

function AgregarAnticipo(grid) {
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Datos anticipo", bSubmit: "Aceptar", bCancel: "Cancelar", width: 400, reloadAfterSubmit: false,
                closeOnEscape: true,
                closeAfterAdd: true,
                closeAfterEdit: true,
                recreateForm: true,
                beforeShowForm: function (form) {
                    PopupCentrar(grid);
                    $('#tr_IdDetalleOrdenPago', form).hide();
                    $('#tr_IdImputacion', form).hide();
                    $('#tr_IdTipoRetencionGanancia', form).hide();
                    $('#tr_IdIBCondicion', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleOrdenPago', form).val(0);
                    $('#Importe', form).val(0);
                    $('#SinImpuestos', form).val(0);
                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    postdata.CategoriaIIBB = $("#CategoriaIIBB").children("option").filter(":selected").text()
                    postdata.CategoriaGanancias = $("#CategoriaGanancias").children("option").filter(":selected").text()
                    postdata.Tipo = "PA"
                    postdata.IdImputacion = -1
                    return [true, ''];
                }
            });
};

function AgregarValor(grid) {
    $("#ListaValores").setColProp('Entidad', { editoptions: { dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=1' }, formoptions: { label: 'Banco - Cuenta' } });
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Ingreso de valores", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,
                closeOnEscape: true,
                closeAfterAdd: true,
                recreateForm: true,
                beforeShowForm: function (form) {
                    PopupCentrar(grid);
                    $('#tr_IdDetalleOrdenPagoValores', form).hide();
                    $('#tr_IdTipoValor', form).hide();
                    $('#tr_IdBanco', form).hide();
                    $('#tr_IdValor', form).hide();
                    $('#tr_IdCuentaBancaria', form).hide();
                    $('#tr_IdBancoChequera', form).hide();
                    $('#tr_IdCaja', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleOrdenPagoValores', form).val(0);
                    $('#NumeroValor', form).val(0);
                    $('#Importe', form).val(0);
                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    postdata.Tipo = $("#Tipo").children("option").filter(":selected").text();
                    postdata.Entidad = $("#Entidad").children("option").filter(":selected").text();
                    return [true, ''];
                }
            });
};

function AgregarCaja(grid) {
    $("#ListaValores").setColProp('Entidad', { editoptions: { dataUrl: ROOT + 'Banco/GetBancosPropios?TipoEntidad=2' }, formoptions: { label: 'Caja' } });
    grid.jqGrid('editGridRow', "new",
            {
                addCaption: "Pago con caja", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,
                closeOnEscape: true,
                closeAfterAdd: true,
                recreateForm: true,
                beforeShowForm: function (form) {
                    PopupCentrar(grid);
                    $('#tr_IdDetalleOrdenPagoValores', form).hide();
                    $('#tr_IdTipoValor', form).hide();
                    $('#tr_IdBanco', form).hide();
                    $('#tr_IdValor', form).hide();
                    $('#tr_IdCuentaBancaria', form).hide();
                    $('#tr_IdBancoChequera', form).hide();
                    $('#tr_IdCaja', form).hide();
                    $('#tr_IdTarjetaCredito', form).hide();

                    $('#tr_Tipo', form).hide();
                    $('#tr_NumeroInterno', form).hide();
                    $('#tr_NumeroValor', form).hide();
                    $('#tr_FechaValor', form).hide();
                    $('#tr_ChequesALaOrdenDe', form).hide();
                    $('#tr_NoALaOrden', form).hide();
                },
                beforeInitData: function () {
                    inEdit = false;
                },
                onInitializeForm: function (form) {
                    $('#IdDetalleOrdenPagoValores', form).val(0);
                    $('#Importe', form).val(0);

                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: ROOT + 'Parametro/Parametros/',
                        dataType: "Json",
                        success: function (data) {
                            var data2 = data[0]
                            $('#IdTipoValor', form).val(data2.IdTipoComprobanteCajaEgresos);
                        }
                    });

                },
                onClose: function (data) {
                },
                beforeSubmit: function (postdata, formid) {
                    postdata.Tipo = "CE";
                    postdata.Entidad = $("#Entidad").children("option").filter(":selected").text();
                    postdata.NumeroInterno = "";
                    postdata.NumeroValor = "";
                    return [true, ''];
                }
            });
};

function PopupCentrar(grid) {
    var dlgDiv = $("#editmod" + grid[0].id);

    $("#editmod" + grid[0].id).find('.ui-datepicker-trigger').attr("class", "btn btn-primary");
    $("#editmod" + grid[0].id).find('#FechaPosible').width(160);
    $("#editmod" + grid[0].id).find('.ui-datepicker-trigger').attr("class", "btn btn-primary");
    $("#sData").attr("class", "btn btn-primary");
    $("#sData").css("color", "white");
    $("#sData").css("margin-right", "20px");
    $("#cData").attr("class", "btn");
    $("#editmod" + grid[0].id).find('.ui-icon-disk').remove();
    $("#editmod" + grid[0].id).find('.ui-icon-close').remove();
    var parentDiv = dlgDiv.parent();
    var dlgWidth = dlgDiv.width();
    var parentWidth = parentDiv.width();
    var dlgHeight = dlgDiv.height();
    var parentHeight = parentDiv.height();
    var left = (screen.width / 2) - (dlgWidth / 2) + "px";
    var top = (screen.height / 2) - (dlgHeight / 2) + "px";
    dlgDiv[0].style.top = top; // 500; // Math.round((parentHeight - dlgHeight) / 2) + "px";
    dlgDiv[0].style.left = left; //Math.round((parentWidth - dlgWidth) / 2) + "px";
};
