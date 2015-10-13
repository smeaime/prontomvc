$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", mTotalImputaciones, mImporteTotal;

    //pageLayout.show('east');

    if ($("#IdPlazoFijo").val() > 0) {
        //$("#grabar2").prop("disabled", true);
        if ($("#IdCajaOrigen").val() > 0) {
            $("input[name=OrigenFondosTipo][value=Caja]").attr('checked', 'checked');
        }
        if ($("#IdCuentaBancariaOrigen").val() > 0) {
            $("input[name=OrigenFondosTipo][value=Banco]").attr('checked', 'checked');
        }
        if ($("#IdCajaDestino").val() > 0) {
            $("input[name=DestinoFondosTipo][value=Caja]").attr('checked', 'checked');
        }
        if ($("#IdCuentaBancariaDestino").val() > 0) {
            $("input[name=DestinoFondosTipo][value=Banco]").attr('checked', 'checked');
        }
    }

    ConfigurarControles();

    if ($("#Anulado").val() == "SI") {
        $("#grabar2").prop("disabled", true);
        $("#anular").prop("disabled", true);
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

        if (jQuery("#ListaRubrosContablesEgreso").find(target).length) {
            $grid = $('#ListaRubrosContablesEgreso');
            grillaenfoco = true;
        }
        
        if (jQuery("#ListaRubrosContablesIngreso").find(target).length) {
            $grid = $('#ListaRubrosContablesIngreso');
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
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaRubrosContablesEgreso').jqGrid({
        url: ROOT + 'PlazoFijo/DetPlazosFijosRubrosContables/',
        postData: { 'IdPlazoFijo': function () { return $("#IdPlazoFijo").val(); }, 'Tipo': function () { return 'Egreso'; } },
        editurl: ROOT + 'PlazoFijo/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetallePlazoFijoRubrosContables', 'IdRubroContable', 'Rubro contable', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetallePlazoFijoRubrosContables', index: 'IdDetallePlazoFijoRubrosContables', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRubroContable', index: 'IdRubroContable', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'RubroContable', index: 'RubroContable', align: 'left', width: 280, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'RubroContable/GetRubrosContables',
                            dataInit: function (elem) {
                                $(elem).width(270);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaRubrosContablesEgreso').getGridParam('selrow');
                                    $('#ListaRubrosContablesEgreso').jqGrid('setCell', rowid, 'IdRubroContable', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Importe', index: 'Importe', width: 100, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaRubrosContablesEgreso').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
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
        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaRubrosContablesEgresoPolizas").datepicker({ dateFormat: "dd/mm/yy" });
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
        sortname: 'IdDetallePlazoFijoRubrosContables',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '70px', // 'auto',
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
        caption: '<b>RUBROS CONTABLES EGRESOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaRubrosContablesEgreso").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaRubrosContablesEgreso").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaRubrosContablesEgreso"));
                                     },
                                 });
    jQuery("#ListaRubrosContablesEgreso").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaRubrosContablesEgreso"));
                                     },
                                 });
    jQuery("#ListaRubrosContablesEgreso").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $('#ListaRubrosContablesIngreso').jqGrid({
        url: ROOT + 'PlazoFijo/DetPlazosFijosRubrosContables/',
        postData: { 'IdPlazoFijo': function () { return $("#IdPlazoFijo").val(); }, 'Tipo': function () { return 'Ingreso'; } },
        editurl: ROOT + 'PlazoFijo/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetallePlazoFijoRubrosContables', 'IdRubroContable', 'Rubro contable', 'Importe'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetallePlazoFijoRubrosContables', index: 'IdDetallePlazoFijoRubrosContables', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRubroContable', index: 'IdRubroContable', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'RubroContable', index: 'RubroContable', align: 'left', width: 280, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'RubroContable/GetRubrosContables',
                            dataInit: function (elem) {
                                $(elem).width(270);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaRubrosContablesIngreso').getGridParam('selrow');
                                    $('#ListaRubrosContablesIngreso').jqGrid('setCell', rowid, 'IdRubroContable', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Importe', index: 'Importe', width: 100, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaRubrosContablesIngreso').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
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
        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
        },
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVigencia') {
            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaRubrosContablesEgresoPolizas").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        afterSaveCell: function (rowid) {
            calculaTotalImputaciones();
        },
        gridComplete: function () {
            calculaTotalImputaciones();
        },
        pager: $('#ListaPager2'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetallePlazoFijoRubrosContables',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '70px', // 'auto',
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
        caption: '<b>RUBROS CONTABLES INGRESOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaRubrosContablesIngreso").jqGrid('navGrid', '#ListaPager2', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaRubrosContablesIngreso").jqGrid('navButtonAdd', '#ListaPager2',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaRubrosContablesIngreso"));
                                     },
                                 });
    jQuery("#ListaRubrosContablesIngreso").jqGrid('navButtonAdd', '#ListaPager2',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaRubrosContablesIngreso"));
                                     },
                                 });
    jQuery("#ListaRubrosContablesIngreso").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });



    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    $("#Importe").change(function () {
        CalcularTotales()
    });
    $("#ImporteIntereses").change(function () {
        CalcularTotales()
    });
    $("#RetencionGanancia").change(function () {
        CalcularTotales()
    });

    $("input[name=OrigenFondosTipo]:radio").change(function () {
        ConfigurarControles();
    })

    $('#Finalizado').change(function () {
        ConfigurarControles();
    });

    $("input[name=DestinoFondosTipo]:radio").change(function () {
        ConfigurarControles();
    })


    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo, chk;

        var cabecera = $("#formid").serializeObject();

        chk = $('#Finalizado').is(':checked');
        if (chk) { cabecera.Finalizado = "SI"; } else { cabecera.Finalizado = "NO"; };

        chk = $('#NoExigirRubroContable').is(':checked');
        if (chk) { cabecera.NoExigirRubroContable = "SI"; } else { cabecera.NoExigirRubroContable = "NO"; };

        chk = $('#AcreditarInteresesAlFinalizar').is(':checked');
        if (chk) { cabecera.AcreditarInteresesAlFinalizar = "SI"; } else { cabecera.AcreditarInteresesAlFinalizar = "NO"; };

        cabecera.DetallePlazosFijosRubrosContables = [];
        $grid = $('#ListaRubrosContablesEgreso');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetallePlazoFijoRubrosContables'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetallePlazoFijoRubrosContables":"' + iddeta + '",';
                data1 = data1 + '"IdPlazoFijo":"' + $("#IdPlazoFijo").val() + '",';
                for (j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') {
                        valor = data[cm.name];
                        data1 = data1 + '"' + cm.index + '":"' + valor + '",';
                    }
                }
                data1 = data1 + '"Tipo":"E",';
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetallePlazosFijosRubrosContables.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        $grid = $('#ListaRubrosContablesIngreso');
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetallePlazoFijoRubrosContables'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetallePlazoFijoRubrosContables":"' + iddeta + '",';
                data1 = data1 + '"IdPlazoFijo":"' + $("#IdPlazoFijo").val() + '",';
                for (j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') {
                        valor = data[cm.name];
                        data1 = data1 + '"' + cm.index + '":"' + valor + '",';
                    }
                }
                data1 = data1 + '"Tipo":"I",';
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetallePlazosFijosRubrosContables.push(data2);
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
            url: ROOT + 'PlazoFijo/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ PlazoFijo: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "PlazoFijo/Edit/" + result.IdPlazoFijo);
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

    //id = $("#IdCliente").val();
    //if (id.length > 0) {
    //    MostrarDatosCliente(id);
    //}

    //id = $("#OrdenCompra").val() || 0;
    //if (id <= 0) {
    //}

    calculaTotalImputaciones();
}

calculaTotalImputaciones = function () {
    var imp = 0, imp2 = 0;

    var dataIds = $('#ListaRubrosContablesEgreso').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#ListaRubrosContablesEgreso').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    $("#ListaRubrosContablesEgreso").jqGrid('footerData', 'set', { RubroContable: 'TOTAL ', Importe: imp2.toFixed(2) });

    imp2 = 0;
    dataIds = $('#ListaRubrosContablesIngreso').jqGrid('getDataIDs');
    for (i = 0; i < dataIds.length; i++) {
        data = $('#ListaRubrosContablesIngreso').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    $("#ListaRubrosContablesIngreso").jqGrid('footerData', 'set', { RubroContable: 'TOTAL ', Importe: imp2.toFixed(2) });

    CalcularTotales()
};

function CalcularTotales() {
    var mImporte = 0, mIntereses = 0, mRetenciones = 0;

    mImporte = parseFloat($("#Importe").val().replace(",", ".") || 0) || 0;
    mIntereses = parseFloat($("#ImporteIntereses").val().replace(",", ".") || 0) || 0;
    mRetenciones = parseFloat($("#RetencionGanancia").val().replace(",", ".") || 0) || 0;

    mImporteTotal = mImporte - mRetenciones + mIntereses;

    $("#TotalPlazoFijo").val(mImporteTotal.toFixed(2));
};

function ConfigurarControles() {
    var valor = "";

    var valor = $('#Finalizado').is(':checked');
    if (valor) {
        $('input[name = DestinoFondosTipo]').removeAttr('disabled');
    } else {
        $('#IdCajaDestino').val(0);
        $('#IdCuentaBancariaDestino').val(0);
        
        $('input[name = DestinoFondosTipo]').attr('disabled', 'disabled');
        $('#IdCajaDestino:input').attr('disabled', 'disabled');
        $('#IdCuentaBancariaDestino:input').attr('disabled', 'disabled');
    };

    valor = $("input[name='OrigenFondosTipo']:checked").val();
    if (valor == "Caja") {
        $('#IdCuentaBancariaOrigen').val("");

        $('#IdCajaOrigen:input').removeAttr('disabled');
        $('#IdCuentaBancariaOrigen:input').attr('disabled', 'disabled');
    } else {
        if (valor == "Banco") {
            $('#IdCajaOrigen').val("");

            $('#IdCuentaBancariaOrigen:input').removeAttr('disabled');
            $('#IdCajaOrigen:input').attr('disabled', 'disabled');
        } else {
            $('#IdCajaOrigen:input').attr('disabled', 'disabled');
            $('#IdCuentaBancariaOrigen:input').attr('disabled', 'disabled');
        }
    }

    valor = $("input[name='DestinoFondosTipo']:checked").val();
    if (valor == "Caja") {
        $('#IdCuentaBancariaDestino').val("");

        $('#IdCajaDestino:input').removeAttr('disabled');
        $('#IdCuentaBancariaDestino:input').attr('disabled', 'disabled');
    } else {
        if (valor == "Banco") {
            $('#IdCajaDestino').val("");

            $('#IdCuentaBancariaDestino:input').removeAttr('disabled');
            $('#IdCajaDestino:input').attr('disabled', 'disabled');
        } else {
            $('#IdCajaDestino:input').attr('disabled', 'disabled');
            $('#IdCuentaBancariaDestino:input').attr('disabled', 'disabled');
        }
    }
}

function pickdates(id) {
    jQuery("#" + id + "_sdate", "#ListaRubrosContablesEgreso").datepicker({ dateFormat: "yy-mm-dd" });
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
