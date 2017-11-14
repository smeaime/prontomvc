$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight;
    var idaux = 0, detalle = "", mTotalImputaciones, mImporteIva1, mPercepcionIIBB1, mPercepcionIIBB2, mPercepcionIIBB3, mPercepcionIVA, mImporteTotal, mIVANoDiscriminado, mPorcentajePercepcionIIBB1;
    var mPorcentajePercepcionIIBB2, mPorcentajePercepcionIIBB3;

    if ($("#Cumplido").val() == "AN") {
        $("#grabar2").prop("disabled", true);
        $("#anular").prop("disabled", true);
    }

    idaux = $("#IdValeSalida").val();
    if (idaux <= 0) {
    } else {
        pageLayout.close('east');
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
        grid.jqGrid('setCell', Id, 'Cantidad', 0);
    };

    var CalcularItem = function (value, colname) {
        if (colname === "Cantidad") {
            var rowid = $('#Lista').getGridParam('selrow');
            value = Number(value);
            var Cantidad = value;
            //$('#Lista').jqGrid('setCell', rowid, 'Cantidad', Cantidad[0]);
        } 
        return [true];
    };

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
                            data['Codigo'] = ui.codigo;
                            data['Articulo'] = ui.title;
                            data['IdUnidad'] = ui.IdUnidad;
                            data['Unidad'] = ui.Unidad;
                            data['IdDetalleValeSalida'] = data['IdDetalleValeSalida'] || 0;

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
                            data['Codigo'] = "";
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
                                data['Codigo'] = "";
                                data['Cantidad'] = 0;

                                $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
                                return;
                            }

                            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

                            data['IdArticulo'] = ui.id;
                            data['Codigo'] = ui.codigo;
                            data['Articulo'] = ui.value;
                            data['IdUnidad'] = ui.IdUnidad;
                            data['Unidad'] = ui.Unidad;
                            data['IdDetalleValeSalida'] = data['IdDetalleValeSalida'] || 0;

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
                                data['Codigo'] = "";
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
        AgregarRenglonesEnBlanco({ "IdDetalleValeSalida": "0", "IdArticulo": "0", "PrecioUnitario": "0", "Articulo": "" }, "#Lista");
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'ValeSalida/DetValesSalida/',
        postData: { 'IdValeSalida': function () { return $("#IdValeSalida").val(); } },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdDetalleValeSalida', 'IdArticulo', 'IdUnidad', 'Codigo', 'Artículo', 'Cantidad', 'Un.', 'Cump.', 'Est.', 'Nro.RM', 'Item RM', 'Tipo RM'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleValeSalida', index: 'IdDetalleValeSalida', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUnidad', index: 'IdUnidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'Codigo', index: 'Codigo', width: 200, align: 'center', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
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
                                        $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', ui.item.IdUnidad);
                                        $('#Lista').jqGrid('setCell', rowid, 'Unidad', ui.item.Unidad);
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
                        name: 'Articulo', index: 'Articulo', align: 'left', width: 500, hidden: false, editable: true, edittype: 'text', editrules: { required: true },
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
                        name: 'Unidad', index: 'Unidad', align: 'left', width: 45, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Unidad/GetUnidades2',
                            dataInit: function (elem) { $(elem).width(40); },
                            dataEvents: [
                                { type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
                                {
                                    type: 'change', fn: function (e) {
                                        var rowid = $('#Lista').getGridParam('selrow');
                                        $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', this.value);
                                    }
                                }]
                        },
                    },
                    { name: 'Cumplido', index: 'Cumplido', width: 50, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
                    { name: 'Estado', index: 'Estado', width: 50, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', width: 100, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
                    { name: 'ItemRM', index: 'ItemRM', width: 50, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
                    { name: 'TipoRequerimiento', index: 'TipoRequerimiento', width: 50, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
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
            AgregarRenglonesEnBlanco({ "IdDetalleValeSalida": "0", "IdArticulo": "0", "Articulo": "" },"#Lista");
        },
        pager: $('#ListaPager'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleValeSalida',
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
        // caption: '<b>DETALLE DE ARTICULOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    //$('#Lista').jqGrid("inlineNav", "#ListaPager", { addParams: { position: "last" } });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
                                    {
                                        caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                        onClickButton: function () {
                                            AgregarItemVacio(jQuery("#Lista"));
                                        },
                                    });
    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager',
                                    {
                                        caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                        onClickButton: function () {
                                            EliminarSeleccionados(jQuery("#Lista"));
                                        },
                                    });
    jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // LISTAS DRAG



    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP




    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    //$("#IdPuntoVenta").change(function () {
    //    TraerNumeroComprobante()
    //});


    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;

        var cabecera = $("#formid").serializeObject();

        cabecera.NumeroValeSalida = $("#NumeroValeSalida").val();
        cabecera.NumeroValePreimpreso = $("#NumeroValePreimpreso").val();
        cabecera.FechaValeSalida = $("#FechaValeSalida").val();
        cabecera.IdObra = $("#IdObra").val();
        cabecera.Aprobo = $("#Aprobo").val();
        cabecera.FechaAnulacion = $("#FechaAnulacion").val();
        cabecera.Anulo = $("#Anulo").val();
        cabecera.MotivoAnulacion = $("#MotivoAnulacion").val();

        cabecera.DetalleValesSalidas = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleValeSalida'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleValeSalida":"' + iddeta + '",';
                data1 = data1 + '"IdValeSalida":"' + $("#IdValeSalida").val() + '",';
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
                if (data2["IdArticulo"] != "0") {
                    cabecera.DetalleValesSalidas.push(data2);
                }
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante." + ex);
                return;
            }
        };

        return cabecera;
    }

    $('#grabar2').click(function () {
        try {
            jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);
        } catch (e) { }

        var cabecera = SerializaForm();

        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'ValeSalida/BatchUpdate',   // '@Url.Action("BatchUpdate", "Requerimiento")',
            dataType: 'json',
            data: JSON.stringify(cabecera),
            success: function (result) {
                if (result) {
                    $('#Lista').trigger('reloadGrid');
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "ValeSalida/Edit/" + result.IdValeSalida);
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

});

calculaTotalImputaciones = function () {
    var Cantidad = 0, TotalCantidad = 0;

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

        Cantidad = parseFloat(data['Cantidad'].replace(",", ".") || 0) || 0;
        TotalCantidad = TotalCantidad + Math.round((Cantidad) * 10000) / 10000;

        //data['ImporteIva'] = ivaitem.toFixed(4);
        //$('#Lista').jqGrid('setRowData', dataIds[i], data);
    }
    $("#Lista").jqGrid('footerData', 'set', { Codigo: 'TOTALES', Cantidad: TotalCantidad.toFixed(2) });
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
        $("#FechaValeSalida").prop("disabled", true);
        $("#IdObra").prop("disabled", true);
        $("#Aprobo").prop("disabled", true);
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




//"use strict";

//var lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;

//function EliminarSeleccionados(grid) {
//    var selectedIds = grid.jqGrid('getGridParam', 'selarrrow');
//    var i;
//    for (i = selectedIds.length - 1; i >= 0; i--) {
//        grid.jqGrid('delRowData', selectedIds[i]);
//    }
//};

//function AgregarItemVacio(grid) {
//    var colModel = grid.jqGrid('getGridParam', 'colModel');
//    var dataIds = grid.jqGrid('getDataIDs');
//    var Id = (grid.jqGrid('getGridParam', 'records') + 1) * -1;
//    var data, j, cm;

//    data = '{';
//    for (j = 1; j < colModel.length; j++) {
//        cm = colModel[j];
//        data = data + '"' + cm.index + '":' + '"",';
//    }
//    data = data.substring(0, data.length - 1) + '}';
//    data = data.replace(/(\r\n|\n|\r)/gm, "");
//    grid.jqGrid('addRowData', Id, data);
//    grid.jqGrid('setCell', Id, 'Cantidad', 0);
//};

//function RefrescarRestoDelRenglon(rowid, name, val, iRow, iCol) {
//    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//    var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
//    var cm = jQuery("#Lista").jqGrid("getGridParam", "colModel");
//    var colName = cm[iCol]['index'];

//    if (colName == "Codigo") {
//        $.post(ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',  // ?term=' + val
//                { term: val }, // JSON.stringify(val)},
//                function (data) {
//                    if (data.length > 0) {
//                        var ui = data[0];

//                        sacarDeEditMode3(lastSelectediRow,lastSelectediCol);

//                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

//                        data['IdArticulo'] = ui.id;
//                        data['Codigo'] = ui.codigo;
//                        data['Articulo'] = ui.title;
//                        data['IdUnidad'] = ui.IdUnidad;
//                        data['Unidad'] = ui.Unidad;
//                        data['IdDetalleValeSalida'] = data['IdDetalleValeSalida'] || 0;

//                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

//                        FinRefresco();
//                    }
//                    else {
//                        alert("No existe el código"); 
//                        var ui = data[0];
//                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos

//                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
//                        data['Articulo'] = "";
//                        data['IdArticulo'] = 0;
//                        data['Codigo'] = "";
//                        data['Cantidad'] = 0;

//                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
//                    }
//                }
//        );
//    }

//    else if (colName == "Articulo") {
//        $.post(ROOT + 'Articulo/GetArticulosAutocomplete2',  
//                { term: val }, // JSON.stringify(val)},
//                function (data) {
//                    if (val != "No se encontraron resultados" && (data.length == 1 || data.length > 1)) { // qué pasa si encuentra más de uno?????
//                        var ui = data[0];

//                        sacarDeEditMode3(lastSelectediRow, lastSelectediCol);

//                        if (ui.value == "No se encontraron resultados") {
//                            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//                            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

//                            data['Articulo'] = "";
//                            data['IdArticulo'] = 0;
//                            data['Codigo'] = "";
//                            data['Cantidad'] = 0;

//                            $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
//                            return;
//                        }

//                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

//                        data['IdArticulo'] = ui.id;
//                        data['Codigo'] = ui.codigo;
//                        data['Articulo'] = ui.value; 
//                        data['IdUnidad'] = ui.IdUnidad;
//                        data['Unidad'] = ui.Unidad;
//                        data['IdDetalleValeSalida'] = data['IdDetalleValeSalida'] || 0;

//                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

//                        FinRefresco();
//                    }
//                    else {
//                        alert("No existe el artículo " + val); // se está bancando que no sea identica la descripcion
//                        var ui = data[0];
//                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//                        if (true) {

//                            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
//                            data['Articulo'] = "";
//                            data['IdArticulo'] = 0;
//                            data['Codigo'] = "";
//                            data['Cantidad'] = 0;

//                            $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
//                        } else {
//                            $('#Lista').jqGrid('restoreRow', dataIds[iRow - 1]);
//                        }
//                        // hay que cancelar la grabacion
//                    }
//                }
//        );

//    }
//    else if (colName == "Cantidad") { }

//    else {
//        FinRefresco()
//    }
//}

//function FinRefresco() {
//    calculaTotalImputaciones();
//    //RefrescarOrigenDescripcion();
//    AgregarRenglonesEnBlanco({ "IdDetalleValeSalida": "0", "IdArticulo": "0", "Articulo": "" }, "#Lista");
//}

//var CalcularItem = function (value, colname) {
//    return [true];
//};

//var dobleclic
//    var headerRow, rowHight, resizeSpanHeight;
//    var grid = $("#Lista")

//    //pageLayout.show('east', true);
//    //pageLayout.open('east');

//    //pageLayout.options.center.onresize = function () { RefrescaAnchoGrillaDetalle(); };

//    //Esto es para analizar los parametros de entrada via querystring
//    var querystring = location.search.replace('?', '').split('&');
//    var queryObj = {};
//    for (var i = 0; i < querystring.length; i++) {
//        var name = querystring[i].split('=')[0];
//        var value = querystring[i].split('=')[1];
//        queryObj[name] = value;
//    }
//    if (queryObj["code"] === "1") {
//        $(":input").attr("disabled", "disabled");
//        $(".boton").hide();
//    }

//    $("#FechaRequerimiento").datepicker({
//        changeMonth: true,
//        changeYear: true,
//        dateFormat: 'dd/mm/yy'
//        //numberOfMonths: 2,
//    });

//    //Para que haga wrap en las celdas
//    //  $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');
//    //$.jgrid.formatter.integer.thousandsSeparator=',';

//    function radioFormatter(cellvalue, options, rowObject) {
//        var radioName = "radio" + rowObject.id;
//        if (cellvalue == null) {
//            cellvalue = false;
//        }
//        return "<input type='radio' name='" + radioName + "' value='" + cellvalue + "'/>";
//    };

//    function unformatRadio(cellvalue, options) {
//        var value = $(cellvalue).val();
//        if (value == undefined) {
//            value = false;
//        }
//        return value;
//    }

//    ///////////////////////////////////////////////////////////////////////////
//    //////////////////////////DEFINICION DE GRILLAS   /////////////////////////
//    ///////////////////////////////////////////////////////////////////////////

//    $('#Lista').jqGrid({
//        url: ROOT + 'ValeSalida/DetValesSalida/',
//        postData: { 'IdValeSalida': function () { return $("#IdValeSalida").val(); } },
//        datatype: 'json',
//        mtype: 'POST',
//        colNames: ['', 'IdDetalleValeSalida', 'IdArticulo', 'IdUnidad', 'Codigo', 'Artículo', 'Unidad', 'Cumplido', 'Estado', 'NumeroRequerimiento', 'ItemRM', 'TipoRequerimiento'],
//        colModel: [
//                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
//                    { name: 'IdDetalleValeSalida', index: 'IdDetalleValeSalida', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
//                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
//                    { name: 'IdUnidad', index: 'IdUnidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
//                    {
//                        name: 'Codigo', index: 'Codigo', width: 120, align: 'center', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
//                        editoptions: {
//                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }],
//                            dataInit: function (elem) {
//                                var NoResultsLabel = "No se encontraron resultados";
//                                $(elem).autocomplete({
//                                    source: ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',
//                                    minLength: 0,
//                                    select: function (event, ui) {
//                                        if (ui.item.label === NoResultsLabel) {
//                                            event.preventDefault();
//                                            return;
//                                        }
//                                        event.preventDefault();
//                                        $(elem).val(ui.item.label);
//                                        var rowid = $('#Lista').getGridParam('selrow');
//                                        $('#Lista').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
//                                        $('#Lista').jqGrid('setCell', rowid, 'Articulo', ui.item.title);
//                                        $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', ui.item.IdUnidad);
//                                        $('#Lista').jqGrid('setCell', rowid, 'Unidad', ui.item.Unidad);
//                                        CalcularItem(1, "Cantidad");
//                                    },
//                                    focus: function (event, ui) {
//                                        if (ui.item.label === NoResultsLabel) {
//                                            event.preventDefault();
//                                        }
//                                    }
//                                })
//                                .data("ui-autocomplete")._renderItem = function (ul, item) {
//                                    return $("<li></li>")
//                                        .data("ui-autocomplete-item", item)
//                                        .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + "</b></span></a>")
//                                        .appendTo(ul);
//                                };
//                            },
//                        }
//                    },
//                    {
//                        name: 'Articulo', index: 'Articulo', align: 'left', width: 350, hidden: false, editable: true, edittype: 'text', editrules: { required: true },
//                        editoptions: {
//                            dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }],
//                            dataInit: function (elem) {
//                                var NoResultsLabel = "No se encontraron resultados";
//                                $(elem).autocomplete({
//                                    source: ROOT + 'Articulo/GetArticulosAutocomplete2',
//                                    minLength: 0,
//                                    select: function (event, ui) {
//                                        if (ui.item.label === NoResultsLabel) {
//                                            event.preventDefault();
//                                            return;
//                                        }
//                                        event.preventDefault();
//                                        $(elem).val(ui.item.label);
//                                        var rowid = $('#Lista').getGridParam('selrow');
//                                        $('#Lista').jqGrid('setCell', rowid, 'IdArticulo', ui.item.id);
//                                        $('#Lista').jqGrid('setCell', rowid, 'Codigo', ui.item.codigo);
//                                        $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', ui.item.IdUnidad);
//                                        $('#Lista').jqGrid('setCell', rowid, 'Unidad', ui.item.Unidad);
//                                    },
//                                    focus: function (event, ui) {
//                                        if (ui.item.label === NoResultsLabel) {
//                                            event.preventDefault();
//                                        }
//                                    }
//                                })
//                                .data("ui-autocomplete")._renderItem = function (ul, item) {
//                                    return $("<li></li>")
//                                        .data("ui-autocomplete-item", item)
//                                        .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + "</b></span></a>")
//                                        //.append("<a>" + item.value + "<br>" + item.title + "</a>")
//                                        .appendTo(ul);
//                                };
//                            },
//                        }
//                    },
//                    {
//                        name: 'Cantidad', index: 'Cantidad', width: 70, align: 'right', editable: true, editrules: { custom: true, custom_func: CalcularItem, required: false, number: true }, edittype: 'text', label: 'TB',
//                        editoptions: {
//                            maxlength: 20, defaultValue: '0.00',
//                            dataEvents: [
//                                { type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
//                                {
//                                    type: 'keypress',
//                                    fn: function (e) {
//                                        var key = e.charCode || e.keyCode;
//                                        if (key == 13) { setTimeout("jQuery('#Lista').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
//                                        if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
//                                    }
//                                }]
//                        }
//                    },
//                    {
//                        name: 'Unidad', index: 'Unidad', align: 'left', width: 45, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
//                        editoptions: {
//                            dataUrl: ROOT + 'Unidad/GetUnidades2',
//                            dataInit: function (elem) { $(elem).width(40); },
//                            dataEvents: [
//                                { type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
//                                {
//                                    type: 'change', fn: function (e) {
//                                        var rowid = $('#Lista').getGridParam('selrow');
//                                        $('#Lista').jqGrid('setCell', rowid, 'IdUnidad', this.value);
//                                    }
//                                }]
//                        },
//                    },
//                    { name: 'Cumplido', index: 'Cumplido', width: 80, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
//                    { name: 'Estado', index: 'Estado', width: 80, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
//                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', width: 100, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
//                    { name: 'ItemRM', index: 'ItemRM', width: 50, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } },
//                    { name: 'TipoRequerimiento', index: 'TipoRequerimiento', width: 100, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled' } }
//        ],
//        onCellSelect: function (rowid, iCol, cellcontent, e) {
//            var $this = $(this);
//            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
//            lastSelectedId = rowid;
//            lastSelectediCol = iCol;
//            lastSelectediRow = iRow;
//        },
//        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
//            lastSelectediRow = iRow;
//            lastSelectediCol = iCol;
//        },
//        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
//            //if (cellName == 'FechaVigencia') {
//            //    jQuery("#" + iRow + "_FechaVigencia", "#ListaPolizas").datepicker({ dateFormat: "dd/mm/yy" });
//            //}
//        },
//        afterSaveCell: function (rowid, cellname, value, iRow, iCol) {
//            RefrescarRestoDelRenglon(rowid, cellname, value, iRow, iCol);
//            calculaTotalImputaciones();
//        },
//        gridComplete: function () {
//            calculaTotalImputaciones();
//        },

//        loadComplete: function () { 
//            //AgregarItemVacio(jQuery("#Lista"));
//            AgregarRenglonesEnBlanco({ "IdDetalleValeSalida": "0", "IdArticulo": "0", "Articulo": "" },"#Lista");
//        },
//        pager: $('#ListaPager1'),
//        rowNum: 100,
//        rowList: [10, 20, 50, 100],
//        sortname: 'IdDetalleValeSalida',
//        sortorder: 'asc',
//        viewrecords: true,
//        width: 'auto', // 'auto',
//        autowidth: true,
//        shrinkToFit: false,
//        height: '150px', // 'auto',
//        rownumbers: true,
//        multiselect: true,
//        altRows: false,
//        footerrow: true,
//        userDataOnFooter: true,
//        pgbuttons: false,
//        viewrecords: false,
//        pgtext: "",
//        pginput: false,
//        rowList: "",
//        // caption: '<b>DETALLE DE ARTICULOS</b>',
//        cellEdit: true,
//        cellsubmit: 'clientArray'
//    });
//    //$('#Lista').jqGrid("inlineNav", "#ListaPager", { addParams: { position: "last" } });
//    jQuery("#Lista").jqGrid('navGrid', '#ListaPager1', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
//    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
//                                 {
//                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
//                                     onClickButton: function () {
//                                         AgregarItemVacio(jQuery("#Lista"));
//                                     },
//                                 });
//    jQuery("#Lista").jqGrid('navButtonAdd', '#ListaPager1',
//                                 {
//                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
//                                     onClickButton: function () {
//                                         EliminarSeleccionados(jQuery("#Lista"));
//                                     },
//                                 });
//    jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });


//    $("#ListaDrag").jqGrid({
//        url: ROOT + 'Articulo/Articulos_DynamicGridData',
//        datatype: 'json',
//        mtype: 'POST',
//        postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'IdObra': function () { return $("#IdObra").val(); } },
//        colNames: ['', '', 'Codigo', 'Numero inventario', 'Descripcion', 'Rubro', 'Subrubro', '', '', '', '', '', '', '', '', 'Unidad'],
//        colModel: [
//                    { name: 'Edit', index: 'Edit', width: 50, align: 'left', sortable: false, search: false, hidden: true },
//                    { name: 'Delete', index: 'Delete', width: 1, align: 'left', sortable: false, search: false, hidden: true },
//                    { name: 'Codigo', index: 'Codigo', width: 130, align: 'left', stype: 'text', search: true, searchoptions: { clearSearch: true, searchOperators: true, sopt: ['cn'] } },
//                    { name: 'NumeroInventario', index: 'NumeroInventario', width: 130, align: 'left', stype: 'text', search: true, searchoptions: { clearSearch: true, searchOperators: true, sopt: ['cn'] }, hidden: true },
//                    {
//                        name: 'Descripcion', index: 'Descripcion', width: 480, align: 'left', stype: 'text', editable: false, edittype: 'text', editoptions: { maxlength: 250 }, editrules: { required: true },
//                        search: true, searchoptions: { clearSearch: true, searchOperators: true, sopt: ['cn'] }
//                    },
//                    { name: 'Rubro.Descripcion', index: 'Rubro.Descripcion', width: 250, align: 'left', editable: true, edittype: 'select', editoptions: { dataUrl: '@Url.Action("Unidades")' }, editrules: { required: true }, search: true, searchoptions: {} },
//                    { name: 'Subrubro.Descripcion', index: '', width: 200, align: 'left', search: true, stype: 'text', hidden: true },
//                    { name: 'AlicuotaIVA', index: 'AlicuotaIVA', width: 50, align: 'left', search: true, stype: 'text', hidden: true },
//                    { name: 'CostoPPP', index: 'CostoPPP', align: 'left', width: 100, editable: false, hidden: true },
//                    { name: 'CostoPPPDolar', index: 'CostoPPPDolar', align: 'left', width: 100, editable: false, hidden: true },
//                    { name: 'CostoReposicion', index: 'CostoReposicion', align: 'left', width: 100, editable: false, hidden: true },
//                    { name: 'CostoReposicionDolar', index: 'CostoReposicionDolar', align: 'left', width: 100, editable: false, hidden: true },
//                    { name: 'StockMinimo', index: 'StockMinimo', align: 'left', width: 100, editable: false, hidden: true },
//                    { name: 'StockReposicion', index: 'StockReposicion', align: 'left', width: 100, editable: false, hidden: true },
//                    { name: 'CantidadUnidades', index: 'CantidadUnidades', align: 'left', width: 100, editable: false, hidden: true },
//                    { name: 'Unidad', index: 'Unidad', width: 100, align: 'left', search: true, stype: 'text' },
//        ],
//        ondblClickRow: function (id) {
//            copiarArticulo(id);
//        },
//        loadComplete: function () {
//            grid = $("ListaDrag");
//        },
//        pager: '#ListaDragPager', // $(),
//        rowNum: 50,
//        rowList: [10, 20, 50, 100],
//        sortname: 'IdArticulo',
//        sortorder: "desc",
//        viewrecords: true,
//        //toppager: true,
//        emptyrecords: 'No hay registros para mostrar',
//        width: 'auto', // 'auto',
//        autowidth: true,
//        shrinkToFit: false,
//        height: $(window).height() - ALTOLISTADO, // '100%'
//        altRows: false,
//        footerrow: false, //true,
//        userDataOnFooter: true,
//        gridview: true,
//        multiboxonly: true,
//        multipleSearch: true
//    })
//    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
//         { width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false }
//    );
//    jQuery("#ListaDrag").jqGrid('navButtonAdd', '#ListaDragPager', {
//        caption: "", buttonicon: "ui-icon-calculator", title: "Choose columns",
//        onClickButton: function () {
//            $(this).jqGrid('columnChooser',
//                { width: 550, msel_opts: { dividerLocation: 0.5 }, modal: true });
//            $("#colchooser_" + $.jgrid.jqID(this.id) + ' div.available>div.actions')
//                .prepend('<label style="float:left;position:relative;margin-left:0.6em;top:0.6em">Search:</label>');
//        }
//    });
//    jQuery("#ListaDrag").filterToolbar({ stringResult: true, searchOnEnter: true, defaultSearch: 'cn', enableClear: false });
//    jQuery("#ListaDrag").jqGrid('navButtonAdd', '#ListaDragPager', { caption: "Filter", title: "Toggle Searching Toolbar", buttonicon: 'ui-icon-pin-s', onClickButton: function () { myGrid[0].toggleToolbar(); } });


//    $('#ListaDrag2').jqGrid({
//        url: ROOT + 'Requerimiento/Requerimientos_DynamicGridData',
//        postData: {
//            'FechaInicial': function () { return $("#FechaInicial").val(); },
//            'FechaFinal': function () { return $("#FechaFinal").val(); },
//            'IdObra': function () { return $("#IdObra").val(); },
//            'bAConfirmar': function () {
//                return $('#bAConfirmar').is(":checked");
//            },
//            'bALiberar': function () {
//                return $('#bALiberar').is(":checked");
//            }
//        },
//        datatype: 'json',
//        mtype: 'POST',
//        colNames: ['', '', 'IdRequerimiento', 'Numero', 'Fecha', 'Cump.', 'Recep.', 'Entreg.', 'Impresa', 'Detalle', 'Obra', 'Presupuestos', 'Comparativas', 'Pedidos', 'Recepciones', 'Salidas',
//                   'Libero', 'Solicito', 'Sector', 'Usuario anulo', 'Fecha anulacion', 'Motivo anulacion', 'Fechas liberacion', 'Observaciones', 'Lugar de entrega', '', '', 'Web'],
//        colModel: [
//                    { name: 'act', index: 'act', align: 'center', width: 50, sortable: false, editable: false, search: false, frozen: true, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
//                    { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, frozen: true, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
//                    { name: 'IdRequerimiento', index: 'IdRequerimiento', align: 'left', width: 0, editable: false, hidden: true, frozen: true },
//                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 80, editable: false, frozen: true, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
//                    { name: 'FechaRequerimiento', index: 'FechaRequerimiento', width: 100, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false, frozen: false },
//                    { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Recepcionado', index: 'Recepcionado', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Entregado', index: 'Entregado', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Impresa', index: 'Impresa', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Detalle', index: 'Detalle', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Obra.NumeroObra', index: 'Obra.NumeroObra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Presupuestos', index: 'Presupuestos', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Comparativas', index: 'Comparativas', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Pedidos', index: 'Pedidos', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Recepciones', index: 'Recepciones', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Salidas', index: 'Salidas', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Libero', index: 'Libero', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: [''] } },
//                    { name: 'Solicito', index: 'Solicito', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Sector', index: 'Sector', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Usuario_anulo', index: 'Usuario_anulo', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Fecha_anulacion', index: 'Fecha_anulacion', align: 'center', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Motivo_anulacion', index: 'Motivo_anulacion', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Fechas_liberacion', index: 'Fechas_liberacion', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'LugarEntrega', index: 'LugarEntrega', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Web', index: 'Web', align: 'left', width: 0, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Web', index: 'Web', align: 'left', width: 0, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn'] } },
//                    { name: 'Web', index: 'Web', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } }

//        ],
//        ondblClickRow: function (id) {
//            copiarRM(id);
//        },
//        loadComplete: function () {
//            grid = $("ListaDrag2");
//        },
//        pager: $('#ListaDragPager2'),
//        rowNum: 15,
//        rowList: [10, 20, 50],
//        sortname: 'NumeroRequerimiento', // 'FechaRecibo,NumeroRecibo',
//        sortorder: 'desc',
//        viewrecords: true,
//        emptyrecords: 'No hay registros para mostrar', //,
//        width: 'auto', // 'auto',
//        autowidth: true,
//        shrinkToFit: false,
//        height: $(window).height() - ALTOLISTADO, // '100%'
//        altRows: false,
//        footerrow: false, //true,
//        userDataOnFooter: true,
//        gridview: true,
//        multiboxonly: true,
//        multipleSearch: true
//    });
//    jQuery("#ListaDrag2").jqGrid('bindKeys');
//    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2',
//        { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false }
//    );
//    jQuery("#ListaDrag2").filterToolbar({
//        stringResult: true, searchOnEnter: true,
//        defaultSearch: 'cn',
//        enableClear: false
//    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/

//    function ConectarGrillas1() {
//        // connect grid1 with grid2
//        $("#ListaDrag").jqGrid('gridDnD', {
//            connectWith: '#Lista', //drag_opts:{stop:null},
//            onstart: function (ev, ui) {
//                sacarDeEditMode();

//                ui.helper.removeClass("ui-state-highlight myAltRowClass")
//                        .addClass("ui-state-error ui-widget")
//                        .css({ border: "5px ridge tomato" });
//                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
//            },
//            beforedrop: function (ev, ui, getdata, $source, $target) {
//                //                var names = $target.jqGrid('getCol', 'name2');
//                //                if ($.inArray(getdata.name2, names) >= 0) {
//                //                    // prevent data for dropping
//                //                    ui.helper.dropped = false;
//                //                    alert("The row is already in the destination grid");
//                //                }
//            },
//            ondrop: function (ev, ui, getdata) {
//                var acceptId = $(ui.draggable).attr("id");
//                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
//                var j = 0, tmpdata = {}, dropname;
//                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
//                //var prox = ProximoNumeroItem();

//                var IdArticulo = getdata['IdArticulo'];
//                copiarArticulo(IdArticulo);
//                $("#gbox_grid2").css("border", "1px solid #aaaaaa");

//                return;

//                try {
//                    //					for (var key in getdata) {
//                    //						if(getdata.hasOwnProperty(key) && dropmodel[j]) {
//                    //							dropname = dropmodel[j].name;
//                    //							tmpdata[dropname] = getdata[key];
//                    //						}
//                    //						j++;
//                    //					}
//                    tmpdata['IdArticulo'] = getdata['IdArticulo'];
//                    tmpdata['Codigo'] = getdata['Codigo'];
//                    tmpdata['Descripcion'] = getdata['Descripcion'];
//                    tmpdata['OrigenDescripcion'] = 1;
//                    var now = new Date();
//                    var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
//                    tmpdata['FechaEntrega'] = currentDate;
//                    tmpdata['IdUnidad'] = getdata['IdUnidad'];
//                    tmpdata['Unidad'] = getdata['Unidad'];
//                    tmpdata['IdDetalleRequerimiento'] = 0;
//                    tmpdata['Cantidad'] = 0;
//                    tmpdata['NumeroItem'] = prox++;
//                    getdata = tmpdata;
//                } catch (e) { }
//                var grid;
//                grid = Math.ceil(Math.random() * 1000000);
//                // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
//                $("#" + this.id).jqGrid('addRowData', grid, getdata);
//                //resetAltRows.call(this);
//                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
//                RefrescarOrigenDescripcion();
//            }
//        });
//    }

//    function ConectarGrillas2() {
//        var grid = $("#ListaDrag2");

//        $("#ListaDrag2").jqGrid('gridDnD', {
//            connectWith: '#Lista',
//            onstart: function (ev, ui) {
//                sacarDeEditMode();
//                ui.helper.removeClass("ui-state-highlight myAltRowClass")
//                        .addClass("ui-state-error ui-widget")
//                        .css({ border: "5px ridge tomato" });
//                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
//            },
//            ondrop: function (ev, ui, getdata) {
//                var acceptId = $(ui.draggable).attr("id");
//                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
//                var j = 0, tmpdata = {}, dropname, IdRequerimiento;
//                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
//                IdRequerimiento = getdata['IdRequerimiento'];
//                copiarRM(IdRequerimiento);
//                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
//                return;

//                var grid;
//                try {
//                    $("#Observaciones").val(getdata['Observaciones']);
//                    $("#LugarEntrega").val(getdata['LugarEntrega']);
//                    $("#IdObra").val(getdata['IdObra']);
//                    $("#IdSector").val(getdata['IdSector']);

//                    IdRequerimiento = getdata['IdRequerimiento'];
//                    $.ajax({
//                        type: "GET",
//                        contentType: "application/json; charset=utf-8",
//                        url: ROOT + 'Requerimiento/DetRequerimientosSinFormato/',
//                        data: { IdRequerimiento: IdRequerimiento },
//                        dataType: "Json",
//                        success: function (data) {
//                            var prox = ProximoNumeroItem();
//                            var longitud = data.length;
//                            for (var i = 0; i < data.length; i++) {
//                                tmpdata['IdArticulo'] = data[i].IdArticulo;
//                                tmpdata['Codigo'] = data[i].Codigo;
//                                tmpdata['Descripcion'] = data[i].Descripcion;
//                                tmpdata['IdUnidad'] = data[i].IdUnidad;
//                                tmpdata['Unidad'] = data[i].Unidad;
//                                tmpdata['IdDetalleRequerimiento'] = 0;

//                                tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
//                                tmpdata['Cantidad'] = data[i].Cantidad;
//                                tmpdata['Observaciones'] = data[i].Observaciones;
//                                tmpdata['NumeroItem'] = prox;

//                                var now = new Date();
//                                var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
//                                tmpdata['FechaEntrega'] = currentDate;

//                                prox++;
//                                getdata = tmpdata;
//                                grid = Math.ceil(Math.random() * 1000000);
//                                $("#Lista").jqGrid('addRowData', grid, getdata);
//                            }
//                            RefrescarOrigenDescripcion();
//                        }
//                    });
//                } catch (e) { }
//                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
//            }
//        });
//    }

//    function copiarArticulo(id) {
//        try {
//            jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);
//        } catch (e) {
//            LogJavaScript("Error en Script copiarArticulo   ", e);
//        }

//        sacarDeEditMode();

//        GrabarGrillaLocal()

//        var acceptId = id;
//        var getdata = $("#ListaDrag").jqGrid('getRowData', acceptId);
//        var j = 0, tmpdata = {}, dropname;
//        var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');
//        var prox = ProximoNumeroItem();
//        try {
//            //					for (var key in getdata) {
//            //						if(getdata.hasOwnProperty(key) && dropmodel[j]) {
//            //							dropname = dropmodel[j].name;
//            //							tmpdata[dropname] = getdata[key];
//            //						}
//            //						j++;
//            //					}
//            tmpdata['IdArticulo'] = getdata['IdArticulo'];
//            tmpdata['Codigo'] = getdata['Codigo'];
//            tmpdata['Descripcion'] = getdata['Descripcion'];
//            tmpdata['OrigenDescripcion'] = 1;
//            var now = new Date();
//            var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
//            tmpdata['FechaEntrega'] = currentDate;
//            tmpdata['IdUnidad'] = getdata['IdUnidad'];
//            tmpdata['Unidad'] = getdata['Unidad'];
//            tmpdata['IdDetalleRequerimiento'] = 0;
//            tmpdata['Cantidad'] = 0;
//            tmpdata['NumeroItem'] = prox++;
//            getdata = tmpdata;
//        } catch (e) { }

//        var idazar = Math.ceil(Math.random() * 1000000);
//        // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
//        ///////////////
//        // paso 1: borrar el renglon vacío de yapa que agrega el D&D (pero no el dblClick) -pero cómo sabés que estás en modo D&D?
//        ///////////////
//        var segundorenglon = $($("#Lista")[0].rows[1]).attr("id")
//        // var segundorenglon = $($("#Lista")[0].rows[pos+2]).attr("id") // el segundo renglon
//        //alert(segundorenglon);
//        if (segundorenglon.indexOf("dnd") != -1) {
//            // tiró el renglon en modo dragdrop, no hizo dobleclic
//            $("#Lista").jqGrid('delRowData', segundorenglon);
//        }
//        //var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//        //var data = $('#Lista').jqGrid('getRowData', dataIds[1]);
//        ///////////////
//        // paso 2: agregar en el ultimo lugar antes de los renglones vacios
//        ///////////////
//        //acá hay un problemilla... si el tipo está usando el DnD, se crea un renglon libre arriba de todo...

//        var pos = TraerPosicionLibre();
//        if (pos == null) {
//            $("#Lista").jqGrid('addRowData', idazar, getdata, "first")
//        }
//        else {
//            $("#Lista").jqGrid('addRowData', idazar, getdata, "after", pos); // como hago para escribir en el primer renglon usando 'after'? paso null?
//        }
//        //$("#Lista").jqGrid('addRowData', idazar, getdata, "last");
//        // http: //stackoverflow.com/questions/8517988/how-to-add-new-row-in-jqgrid-in-middle-of-grid
//        // $("#Lista").jqGrid('addRowData', grid, getdata, 'first');  // usar por ahora 'first'   'after' : 'before'; 'last' : 'first';
//        //resetAltRows.call(this);
//        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
//        RefrescarOrigenDescripcion();

//        AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });
//    }

//    function copiarRM(id) {
//        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

//        sacarDeEditMode();

//        GrabarGrillaLocal()

//        var acceptId = id;
//        var getdata = $("#ListaDrag2").jqGrid('getRowData', acceptId);
//        var j = 0, tmpdata = {}, dropname, IdRequerimiento;
//        var dropmodel = $("#ListaDrag2").jqGrid('getGridParam', 'colModel');
//        var grid;
//        try {
//            $("#Observaciones").val(getdata['Observaciones']);
//            $("#LugarEntrega").val(getdata['LugarEntrega']);
//            $("#IdObra").val(getdata['IdObra']);
//            $("#IdSector").val(getdata['IdSector']);

//            IdRequerimiento = getdata['IdRequerimiento'];
//            $.ajax({
//                type: "GET",
//                contentType: "application/json; charset=utf-8",
//                url: ROOT + 'Requerimiento/DetRequerimientosSinFormato/',
//                data: { IdRequerimiento: IdRequerimiento },
//                dataType: "Json",
//                success: function (data) {
//                    var prox = ProximoNumeroItem();
//                    var longitud = data.length;
//                    for (var i = 0; i < data.length; i++) {
//                        tmpdata['IdArticulo'] = data[i].IdArticulo;
//                        tmpdata['Codigo'] = data[i].Codigo;
//                        tmpdata['Descripcion'] = data[i].Descripcion;
//                        tmpdata['IdUnidad'] = data[i].IdUnidad;
//                        tmpdata['Unidad'] = data[i].Unidad;
//                        tmpdata['IdDetalleRequerimiento'] = 0;

//                        tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
//                        tmpdata['Cantidad'] = data[i].Cantidad;
//                        tmpdata['Observaciones'] = data[i].Observaciones;
//                        tmpdata['NumeroItem'] = prox;

//                        var now = new Date();
//                        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
//                        tmpdata['FechaEntrega'] = currentDate;

//                        prox++;
//                        getdata = tmpdata;
//                        var idazar = Math.ceil(Math.random() * 1000000);

//                        ///////////////
//                        // paso 1: borrar el renglon vacío de yapa que agrega el D&D (pero no el dblClick) -pero cómo sabés que estás en modo D&D?
//                        ///////////////
//                        var segundorenglon = $($("#Lista")[0].rows[1]).attr("id")
//                        // var segundorenglon = $($("#Lista")[0].rows[pos+2]).attr("id") // el segundo renglon
//                        //alert(segundorenglon);
//                        if (segundorenglon.indexOf("dnd") != -1) {
//                            // tiró el renglon en modo dragdrop, no hizo dobleclic
//                            $("#Lista").jqGrid('delRowData', segundorenglon);
//                        }
//                        //var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//                        //var data = $('#Lista').jqGrid('getRowData', dataIds[1]);

//                        ///////////////
//                        // paso 2: agregar en el ultimo lugar antes de los renglones vacios
//                        ///////////////

//                        //acá hay un problemilla... si el tipo está usando el DnD, se crea un renglon libre arriba de todo...

//                        var pos = TraerPosicionLibre();
//                        if (pos == null) {
//                            $("#Lista").jqGrid('addRowData', idazar, getdata, "first")
//                        }
//                        else {
//                            $("#Lista").jqGrid('addRowData', idazar, getdata, "after", pos); // como hago para escribir en el primer renglon usando 'after'? paso null?
//                        }
//                        //$("#Lista").jqGrid('addRowData', idazar, getdata, "last");
//                        // http: //stackoverflow.com/questions/8517988/how-to-add-new-row-in-jqgrid-in-middle-of-grid
//                        // $("#Lista").jqGrid('addRowData', grid, getdata, 'first');  // usar por ahora 'first'   'after' : 'before'; 'last' : 'first';
//                    }
//                    RefrescarOrigenDescripcion();

//                    AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });
//                }
//            });
//        } catch (e) { }
//    }

//    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
//    $('a#a_panel_este_tab1').text('Artículos');
//    $('a#a_panel_este_tab2').text('Requerimientos');
//    $('a#a_panel_este_tab3').hide();

//    ConectarGrillas1();

//    $('#a_panel_este_tab1').click(function () {
//        ConectarGrillas1();
//    });

//    $('#a_panel_este_tab2').click(function () {
//        ConectarGrillas2();
//    });

//    $(window).bind('resize', function () {
//        $("#Lista").setGridWidth($(window).width());
//    }).trigger('resize');

//    function myelem(value, options) {
//        var el = document.createElement("input");
//        el.type = "text";
//        el.value = value;
//        return el;
//    }

//    function myvalue(elem, operation, value) {
//        if (operation === 'get') {
//            return $(elem).val();
//        } else if (operation === 'set') {
//            $('input', elem).val(value);
//        }
//    }

//    function numUnformat(cellvalue, options, rowObject) {
//        return cellvalue.replace(",", ".");
//    }

//    function numFormat(cellvalue, options, rowObject) {
//        return cellvalue.replace(".", ",");
//    }

//    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

//    //$("#IdPuntoVenta").change(function () {
//    //    TraerNumeroComprobante()
//    //});

//    //$("#ClienteCodigo").change(function () {
//    //    TraerDatosClientePorCodigo()
//    //})

//    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

//    function SerializaForm() {
//        saveEditedCell("");

//        //calculaTotalImputaciones();

//        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo, BienesOServicios="";

//        var cabecera = $("#formid").serializeObject();

//        cabecera.NumeroValeSalida = $("#NumeroValeSalida").val();
//        cabecera.NumeroValePreimpreso = $("#NumeroValePreimpreso").val();
//        cabecera.FechaValeSalida = $("#FechaValeSalida").val();
//        cabecera.IdObra = $("#IdObra").val();
//        cabecera.Aprobo = $("#Aprobo").val();
//        cabecera.FechaAnulacion = $("#FechaAnulacion").val();
//        cabecera.Anulo = $("#Anulo").val();
//        cabecera.MotivoAnulacion = $("#MotivoAnulacion").val();

//        cabecera.DetalleValesSalidas = [];
//        $grid = $('#Lista');
//        nuevo = -1;
//        colModel = $grid.jqGrid('getGridParam', 'colModel');
//        dataIds = $grid.jqGrid('getDataIDs');
//        for (i = 0; i < dataIds.length; i++) {
//            try {
//                data = $grid.jqGrid('getRowData', dataIds[i]);
//                iddeta = data['IdDetalleValeSalida'];
//                if (!iddeta) {
//                    iddeta = nuevo;
//                    nuevo--;
//                }

//                data1 = '{"IdDetalleValeSalida":"' + iddeta + '",';
//                data1 = data1 + '"IdValeSalida":"' + $("#IdValeSalida").val() + '",';
//                for (j = 0; j < colModel.length; j++) {
//                    cm = colModel[j]
//                    if (cm.label === 'TB') {
//                        valor = data[cm.name];
//                        data1 = data1 + '"' + cm.index + '":"' + valor + '",';
//                    }
//                }
//                data1 = data1.substring(0, data1.length - 1) + '}';
//                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
//                data2 = JSON.parse(data1);
//                cabecera.DetalleFacturas.push(data2);
//            }
//            catch (ex) {
//                alert("SerializaForm(): No se pudo serializar el comprobante." + ex);
//                return;
//            }
//        };

//        return cabecera;
//    }


//    $('#grabar2').click(function () {
//        try {
//            jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);
//        } catch (e) { }

//        var cabecera = SerializaForm();

//        $.ajax({
//            type: 'POST',
//            contentType: 'application/json; charset=utf-8',
//            url: ROOT + 'ValeSalida/BatchUpdate',   // '@Url.Action("BatchUpdate", "Requerimiento")',
//            dataType: 'json',
//            data: JSON.stringify(cabecera),
//            success: function (result) {
//                if (result) {
//                    $('#Lista').trigger('reloadGrid');
//                    $('html, body').css('cursor', 'auto');
//                    //  window.location = (ROOT + "Requerimiento/index");
//                    window.location = (ROOT + "Requerimiento/Edit/" + result.IdRequerimiento);
//                } else {
//                    alert('No se pudo grabar el comprobante.');
//                    $('.loading').html('');

//                    $('html, body').css('cursor', 'auto');
//                    $('#grabar2').attr("disabled", false).val("Aceptar");
//                }
//            },
//            beforeSend: function () {
//                //$('.loading').html('some predefined loading img html');
//                $("#loading").show();
//                $('#grabar2').attr("disabled", true).val("Espere...");
//            },
//            complete: function () {
//                $("#loading").hide();
//            },
//            error: function (xhr, textStatus, exceptionThrown) {
//                try {
//                    var errorData = $.parseJSON(xhr.responseText);
//                    var errorMessages = [];
//                    //this ugly loop is because List<> is serialized to an object instead of an array
//                    for (var key in errorData) {
//                        errorMessages.push(errorData[key]);
//                    }

//                    $('html, body').css('cursor', 'auto');
//                    $('#grabar2').attr("disabled", false).val("Aceptar");
//                    //alert(errorMessages.join("<br />"));
//                    // $("#textoMensajeAlerta").html(errorMessages.join("<br />"));
//                    //$('#result').html(errorMessages.join("<br />"));
//                    //$("#textoMensajeAlerta").html(xhr.responseText);
//                    $("#textoMensajeAlerta").html(errorData.Errors.join("<br />"));
//                    $("#mensajeAlerta").show();
//                } catch (e) {
//                    $('html, body').css('cursor', 'auto');
//                    $('#grabar2').attr("disabled", false).val("Aceptar");
//                    //alert(xhr.responseText);
//                    $("#textoMensajeAlerta").html(xhr.responseText);
//                    $("#mensajeAlerta").show();
//                }
//            }
//        });
//    });

//    // get the header row which contains
//    headerRow = grid.closest("div.ui-jqgrid-view").find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

//    // increase the height of the resizing span
//    resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
//    headerRow.find("span.ui-jqgrid-resize").each(function () {
//        this.style.cssText = resizeSpanHeight;
//    });

//    // set position of the dive with the column header text to the middle
//    rowHight = headerRow.height();
//    headerRow.find("div.ui-jqgrid-sortable").each(function () {
//        var ts = $(this);
//        ts.css('top', (rowHight - ts.outerHeight()) / 2 + 'px');
//    });

//    $("#Aprobo").change(function () {
//        var IdAprobo = $("#Aprobo > option:selected").attr("value");
//        var Aprobo = $("#Aprobo > option:selected").html();
//        $("#Aux1").val(IdAprobo);
//        $("#Aux2").val(Aprobo);
//        $("#Aux3").val("");
//        $("#Aux10").val("");
//        $('#dialog-password').data('Combo', 'Aprobo');
//        $('#dialog-password').dialog('open');
//        $('#mySelect').focus(); // esto es clave, para que no me cierre el cuadro de dialogo al recibir un posible enter apretado en el change
//    });

//    $("#anular").click(function () {
//        $("#Aux1").val("");
//        $("#Aux2").val("");
//        $("#Aux3").val("");
//        $("#Aux10").val("anularRM");
//        $('#dialog-password').dialog('open');
//        $('#mySelect').focus(); // esto es clave, para que no me cierre el cuadro de dialogo al recibir un posible enter apretado en el change
//    });

//    RefrescaAnchoGrillaDetalle();

//    // vuelvo a llenar el mySelect (se hace por primera vez en el Layout) porque no sé qué pasa que algo me lo vacía
//    $.post(ROOT + 'Empleado/EmpleadosParaCombo/',
//            function (data) {
//                var select = $('#mySelect').empty();
//                for (var i = 0; i < data.length; i++) {
//                    select.append('<option value="' + data[i].IdEmpleado + '">' + data[i].Nombre + '</option>');
//                }
//            }, "json");

//    function pickdates(id) {
//        jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
//    }

//    function getColumnIndexByName(grid, columnName) {
//        var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
//        for (i = 0; i < l; i++) {
//            if (cm[i].name === columnName) {
//                return i; // return the index
//            }
//        }
//        return -1;
//    }


//    //$("#addData").click(function () {
//    //    dobleclic = true;

//    //    sacarDeEditMode();

//    //    jQuery("#Lista").jqGrid('editGridRow', "new",
//    //            {
//    //                addCaption: "", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,

//    //                closeOnEscape: true,
//    //                closeAfterAdd: true,
//    //                recreateForm: true,
//    //                beforeShowForm: function (form) {

//    //                    GrabarGrillaLocal();
//    //                    PopupCentrar();

//    //                    $('#tr_IdDetalleRequerimiento', form).hide();
//    //                    $('#tr_IdArticulo', form).hide();
//    //                    $('#tr_IdUnidad', form).hide();
//    //                },
//    //                beforeInitData: function () {
//    //                    inEdit = false;
//    //                },
//    //                onInitializeForm: function (form) {
//    //                    $('#IdDetalleRequerimiento', form).val(0);
//    //                    $('#NumeroItem', form).val(ProximoNumeroItem());
//    //                    $('#NumeroItem').attr('readonly', 'readonly');

//    //                    var now = new Date();
//    //                    var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();

//    //                    $('#FechaEntrega', form).val(currentDate);
//    //                    $('#Cantidad', form).val(1);
//    //                    $('#Unidad', form).val(1);
//    //                    //                      mvarAux = BuscarClaveINI("Dias default para fecha necesidad en RM")
//    //                    //                      If Len(mvarAux) > 0 Then
//    //                    //                         DTFields(0).Value = DateAdd("d", Val(mvarAux), Me.FechaRequerimiento)
//    //                    //                      Else
//    //                    //                         DTFields(0).Value = Date
//    //                    //                      End If
//    //                },

//    //                onClose: function (data) {
//    //                    GrabarGrillaLocal()
//    //                    RefrescarOrigenDescripcion();
//    //                    PonerRenglonesInline();

//    //                    AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });
//    //                }
//    //            });
//    //});

//    //$("#edtData").click(function () {
//    //    sacarDeEditMode();
//    //    var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
//    //    EditarItem(gr)
//    //});

//    //$("#delData").click(function () {
//    //    //var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
//    //    var gr = jQuery("#Lista").jqGrid('getGridParam', 'selarrrow');

//    //    if (gr != null) {
//    //        //jQuery("#Lista").jqGrid('setRowData',gr,{Eliminado:"true"});
//    //        //$("#"+gr).hide();  
//    //        if (false) {
//    //            jQuery("#Lista").jqGrid('delGridRow', gr, {
//    //                caption: "Borrar", msg: "Elimina el registro seleccionado?",
//    //                bSubmit: "Borrar", bCancel: "Cancelar", width: 300, closeOnEscape: true, reloadAfterSubmit: false
//    //            });
//    //        }
//    //        else {

//    //            var $grid = $("#Lista");
//    //            var righe = $grid.jqGrid("getGridParam", "selarrrow");

//    //            if ((righe == null) || (righe.length == 0)) {
//    //                return false;
//    //            }

//    //            for (var i = righe.length - 1; i >= 0; i--) {
//    //                $grid.delRowData(righe[i]);
//    //            }
//    //        }
//    //    }
//    //    else alert("Debe seleccionar un item!");
//    //});


//function calculateTotal() {
//    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
//    var totalCantidad = 0;

//    for (var i = 0; i < dataIds.length; i++) {
//        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
//        var cant = parseFloat(data['Cantidad'].replace(",", ".")) || 0;
//        totalCantidad += cant;
//    }

//    $('#Lista').jqGrid('footerData', 'set', { NumeroItem: 'TOTAL', Cantidad: totalCantidad });
//};

////function EditarItem(rowid) {
////    var gr = rowid; // jQuery("#Lista").jqGrid('getGridParam',  'selrow');
////    var row = jQuery("#Lista").jqGrid('getRowData', rowid);

////    if (row.Cumplido == "SI") {
////        alert("El item ya está cumplido")
////        return;
////    }

////    if (gr != null) jQuery("#Lista").jqGrid('editGridRow', gr,
////        {
////            editCaption: "", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800
////            , reloadAfterSubmit: false, closeOnEscape: true,
////            closeAfterEdit: true, recreateForm: true, Top: 0,
////            beforeShowForm: function (form) {
////                GrabarGrillaLocal();

////                PopupCentrar();

////                $('#NumeroItem').attr('readonly', 'readonly');

////                $('#tr_IdDetalleRequerimiento', form).hide();
////                $('#tr_IdArticulo', form).hide();
////                $('#tr_IdUnidad', form).hide();
////            },
////            beforeInitData: function () {
////                inEdit = true;
////            }
////            ,
////            onClose: function (data) {

////                RefrescarOrigenDescripcion();
////                AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

////                //var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
////                //data['Unidad'] = $("#Unidad").text(); ;
////                //$('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

////                //PonerRenglonesInline();
////                // jQuery('#Lista').editRow(gr, true);
////            }
////            ,
////            beforeSubmit: function (postdata, formid) {
////                //alert(postdata.Unidad + " " + $("#Unidad").children("option").filter(":selected").text());
////                //postdata.Unidad es un numero?????
////                postdata.Unidad = $("#Unidad").children("option").filter(":selected").text()
////                postdata.ControlCalidad = $("#ControlCalidad").children("option").filter(":selected").text()

////                return [true, 'no se puede'];
////            }
////        });
////    else alert("Debe seleccionar un item!");
////}
