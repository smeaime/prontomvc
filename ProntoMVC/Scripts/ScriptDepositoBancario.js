$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight, idaux = 0, detalle = "", mTotalImputaciones, mImporteTotal;

    pageLayout.show('east');

    if ($("#Anulado").val() == "SI") {
        $("#grabar2").prop("disabled", true);
        $("#anular").prop("disabled", true);
    }

    if ($("#IdDepositoBancario").val() > 0) {
        $("#grabar2").prop("disabled", true);
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
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'DepositoBancario/DetDepositoBancario/',
        postData: { 'IdDepositoBancario': function () { return $("#IdDepositoBancario").val(); } },
        editurl: ROOT + 'DepositoBancario/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleDepositoBancario', 'IdValor', 'Numero interno', 'Numero valor', 'Fecha vto.', 'Cliente', 'Banco', 'Importe', 'Mon.'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleDepositoBancario', index: 'IdDetalleDepositoBancario', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdValor', index: 'IdValor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'NumeroInterno', index: 'NumeroInterno', align: 'left', width: 70, editable: false, hidden: false },
                    { name: 'NumeroValor', index: 'NumeroValor', align: 'left', width: 80, editable: false, hidden: false },
                    { name: 'FechaValor', index: 'FechaValor', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Cliente', index: 'Cliente', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'Banco', index: 'Banco', align: 'left', width: 250, editable: false, hidden: false },
                    { name: 'Importe', index: 'Importe', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Moneda', index: 'Moneda', align: 'left', width: 40, editable: false, hidden: false }
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
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdValor',
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
        caption: '<b>DETALLE DEL DEPOSITO</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
    //                             {
    //                                 caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
    //                                 onClickButton: function () {
    //                                     AgregarItemVacio(jQuery("#Lista"));
    //                                 },
    //                             });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#Lista"));
                                     },
                                 });
    jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


    $("#ListaDrag").jqGrid({
        url: ROOT + 'Valor/ValoresEnCartera',
        //postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); } },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdValor', 'Tipo', 'Numero interno', 'Numero valor', 'Fecha vto.', 'Banco', 'Importe', 'Comp.', 'Numero comp.', 'Fecha comp.', 'Cliente'],
        colModel: [
                    { name: 'ver', index: 'ver', hidden: true, width: 50 },
                    { name: 'IdValor', index: 'IdValor', width: 80, sortable: false, editable: false, search: false, hidden: true },
                    { name: 'Tipo', index: 'Tipo', align: 'center', width: 40, editable: false, search: true, hidden: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'NumeroInterno', index: 'NumeroInterno', align: 'left', width: 100, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'NumeroValor', index: 'NumeroValor', align: 'left', width: 100, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'FechaValor', index: 'FechaValor', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Entidad', index: 'Entidad', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'Importe', index: 'Importe', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'TipoComprobante', index: 'TipoComprobante', align: 'center', width: 40, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'NumeroComprobante', index: 'NumeroComprobante', align: 'left', width: 100, editable: false, search: true, hidden: false, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'FechaComprobante', index: 'FechaComprobante', width: 80, align: 'center', sorttype: 'date', hidden: false, editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Cliente', index: 'Cliente', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } }
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
    sortname: 'NumeroInterno', // 'FechaRecibo,NumeroRecibo',
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
    userDataOnFooter: true,
    gridview: true,
    multiboxonly: true,
    multipleSearch: true
    })
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager',
     { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
     { width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false }
    );
    jQuery("#ListaDrag").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Cheques en cartera');
    //$('a#a_panel_este_tab5').remove();  //    

    ConectarGrillas1();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
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
                //var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                //var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
            }
        });
    }

    function Copiar1(idsource, Origen) {
        var acceptId = idsource, IdValor = 0, mPrimerItem = true;
        var $gridOrigen = $("#ListaDrag"), $gridDestino = $("#Lista");

        var getdata = $gridOrigen.jqGrid('getRowData', acceptId);
        var tmpdata = {}, dataIds, data2, Id, Id2, i, date, displayDate;

        dataIds = $gridDestino.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            data2 = $gridDestino.jqGrid('getRowData', dataIds[i]);
            if (data2.IdValor == idsource) {
                if (Origen == "DnD") $gridDestino.jqGrid('delRowData', dataIds[0]);
                alert("Ya existe el registro");
                return;
            }
        };

        try {
            IdValor = getdata['IdValor'];

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Valor/TraerUno/',
                data: { IdValor: IdValor },
                dataType: "Json",
                success: function (data) {
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        Id2 = ($gridDestino.jqGrid('getGridParam', 'records') + 1) * -1;

                        tmpdata['IdDetalleDepositoBancario'] = Id2;
                        tmpdata['IdValor'] = data[i].IdValor;
                        tmpdata['NumeroInterno'] = data[i].NumeroInterno;
                        tmpdata['NumeroValor'] = data[i].NumeroValor;
                        tmpdata['FechaValor'] = data[i].FechaValor;
                        tmpdata['Cliente'] = data[i].Cliente;
                        tmpdata['Banco'] = data[i].Entidad;
                        tmpdata['Importe'] = data[i].Importe;
                        tmpdata['Moneda'] = data[i].Moneda;
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
                            calculaTotalImputaciones();
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

    //$("#Aprobo").change(function () {
    //    var IdAprobo = $("#Aprobo > option:selected").attr("value");
    //    var Aprobo = $("#Aprobo > option:selected").html();
    //    $("#Aux1").val(IdAprobo);
    //    $("#Aux2").val(Aprobo);
    //    $("#Aux3").val("");
    //    $("#Aux10").val("");
    //    $('#dialog-password').data('Combo', 'Aprobo');
    //    $('#dialog-password').dialog('open');
    //    $('#mySelect').focus(); 
    //});

    $("#Efectivo").change(function () {
        CalcularTotales()
    });


    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();

        cabecera.NumeroDeposito = $("#NumeroDeposito").val();
        //cabecera.Cliente = "";
        //cabecera.Provincia = "";

        cabecera.DetalleDepositosBancarios = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleDepositoBancario'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleDepositoBancario":"' + iddeta + '",';
                data1 = data1 + '"IdDepositoBancario":"' + $("#IdDepositoBancario").val() + '",';
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
                cabecera.DetalleDepositosBancarios.push(data2);
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
            url: ROOT + 'DepositoBancario/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ DepositoBancario: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "DepositoBancario/Edit/" + result.IdDepositoBancario);
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

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        imp = parseFloat(data['Importe'].replace(",", ".") || 0) || 0;
        imp2 = imp2 + imp;
    }
    imp2 = Math.round((imp2) * 10000) / 10000;
    mTotalImputaciones = imp2;
    $("#Lista").jqGrid('footerData', 'set', { Banco: 'TOTAL CHEQUES', Importe: imp2.toFixed(2) });

    CalcularTotales()
};

function CalcularTotales() {
    var mSubtotal = 0, mIdDepositoBancario = 0, mEfectivo = 0;

    mIdDepositoBancario = $("#IdDepositoBancario").val();

    if (typeof mTotalImputaciones == "undefined") { mTotalImputaciones = 0; }
    mSubtotal = mTotalImputaciones;

    mEfectivo = parseFloat($("#Efectivo").val().replace(",", ".") || 0) || 0;

    mImporteTotal = mSubtotal + mEfectivo;

    $("#TotalCheques").val(mTotalImputaciones.toFixed(2));
    $("#TotalDeposito").val(mImporteTotal.toFixed(2));
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

//function MostrarDatosCliente(Id) {
//    var Entidad = "";
//    $.ajax({
//        type: "Post",
//        async: false,
//        url: ROOT + 'Cliente/GetClientePorId/',
//        data: { Id: Id },
//        success: function (result) {
//            if (result.length > 0) {
//                Entidad = result[0].value;
//                $("#Cliente").val(Entidad);
//                $("#CondicionIva").val(result[0].DescripcionIva);
//                $("#Cuit").val(result[0].Cuit);
//                $("#Direccion").val(result[0].Direccion);
//                $("#Localidad").val(result[0].Localidad);
//                $("#Provincia").val(result[0].Provincia);
//                $("#CodigoPostal").val(result[0].CodigoPostal);
//                $("#Email").val(result[0].Email);
//                $("#Telefono").val(result[0].Telefono);
//            }
//        }
//    });
//    return Entidad;
//}
