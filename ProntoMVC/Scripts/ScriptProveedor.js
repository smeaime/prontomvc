$(function () {
    $("#loading").hide();

    'use strict';

    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic
    var headerRow, rowHight, resizeSpanHeight;

    ConfigurarControles();

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

        if (jQuery("#ListaContactos").find(target).length) {
            $grid = $('#ListaContactos');
            grillaenfoco = true;
        }
        if (jQuery("#ListaRubros").find(target).length) {
            $grid = $('#ListaRubros');
            grillaenfoco = true;
        }
        if (jQuery("#ListaIIBB").find(target).length) {
            $grid = $('#ListaIIBB');
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

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaContactos').jqGrid({
        url: ROOT + 'Proveedor/DetProveedores/',
        postData: { 'IdProveedor': function () { return $("#IdProveedor").val(); } },
        editurl: ROOT + 'Proveedor/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleProveedor', 'Contacto', 'Puesto', 'Telefono', 'Email'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleProveedor', index: 'IdDetalleProveedor', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'Contacto', index: 'Contacto', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'Puesto', index: 'Puesto', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'Telefono', index: 'Telefono', width: 150, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'Email', index: 'Email', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        pager: $('#PagerContactos'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleProveedor',
        sortorder: 'asc',
        viewrecords: true,
        width: '500px', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
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
        caption: '<b>DETALLE CONTACTOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaContactos").jqGrid('navGrid', '#PagerContactos', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaContactos").jqGrid('navButtonAdd', '#PagerContactos',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar contacto",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaContactos"));
                                     },
                                 });
    jQuery("#ListaContactos").jqGrid('navButtonAdd', '#PagerContactos',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaContactos"));
                                     },
                                 });
    jQuery("#ListaContactos").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });
    // solo está reaccionando a los min y max una vez que cambias el tamaño a mano o llamas por ejemplo a setGridWidth
    $("#ListaContactos").jqGrid('setGridWidth', 500);
    


    $('#ListaRubros').jqGrid({
        url: ROOT + 'Proveedor/DetProveedoresRubros/',
        postData: { 'IdProveedor': function () { return $("#IdProveedor").val(); } },
        editurl: ROOT + 'Proveedor/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleProveedorRubros', 'IdRubro', 'IdSubrubro', 'Rubro', 'Subrubro'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleProveedorRubros', index: 'IdDetalleProveedorRubros', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRubro', index: 'IdRubro', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdSubrubro', index: 'IdSubrubro', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    {
                        name: 'Rubro', index: 'Rubro', align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Rubro/GetRubros',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaRubros').getGridParam('selrow');
                                    $('#ListaRubros').jqGrid('setCell', rowid, 'IdRubro', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Subrubro', index: 'Subrubro', align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Subrubro/GetSubrubros',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaRubros').getGridParam('selrow');
                                    $('#ListaRubros').jqGrid('setCell', rowid, 'IdSubrubro', this.value);
                                }
                            }]
                        },
                    }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        pager: $('#PagerRubros'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleProveedorRubros',
        sortorder: 'asc',
        viewrecords: true,
        width: '500px', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '200px', // 'auto',
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
        caption: '<b>DETALLE RUBROS PROVISTOS</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaRubros").jqGrid('navGrid', '#PagerRubros', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaRubros").jqGrid('navButtonAdd', '#PagerRubros',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar rubro",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaRubros"));
                                     },
                                 });
    jQuery("#ListaRubros").jqGrid('navButtonAdd', '#PagerRubros',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaRubros"));
                                     },
                                 });
    jQuery("#ListaRubros").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });

    $('#ListaIIBB').jqGrid({
        url: ROOT + 'Proveedor/DetProveedoresIIBB/',
        postData: { 'IdProveedor': function () { return $("#IdProveedor").val(); } },
        editurl: ROOT + 'Proveedor/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleProveedorIB', 'IdIBCondicion', 'Jurisdiccion', 'Alicuota', 'Fecha vto.'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleProveedorIB', index: 'IdDetalleProveedorIB', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdIBCondicion', index: 'IdIBCondicion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    {
                        name: 'Jurisdiccion', index: 'Jurisdiccion', align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'IBCondicion/GetCategoriasIIBB',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaIIBB').getGridParam('selrow');
                                    $('#ListaIIBB').jqGrid('setCell', rowid, 'IdIBCondicion', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'AlicuotaAAplicar', index: 'AlicuotaAAplicar', width: 80, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 20, defaultValue: '0.00',
                            dataEvents: [
                            {
                                type: 'keypress',
                                fn: function (e) {
                                    var key = e.charCode || e.keyCode;
                                    if (key == 13) { setTimeout("jQuery('#ListaIIBB').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100); }
                                    if ((key < 48 || key > 57) && key !== 46 && key !== 44 && key !== 8 && key !== 37 && key !== 39) { return false; }
                                }
                            }]
                        }
                    },
                    {
                        name: 'FechaVencimiento', index: 'FechaVencimiento', width: 130, sortable: false, align: 'right', editable: true, label: 'TB',
                        editoptions: {
                            size: 10,
                            maxlengh: 10,
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
            if (cellName == 'FechaVencimiento') {
                jQuery("#" + iRow + "_FechaVencimiento", "#ListaIIBB").datepicker({ dateFormat: "dd/mm/yy" });
            }
        },
        pager: $('#PagerIIBB'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleProveedorIB',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '80px', // 'auto',
        rownumbers: true,
        multiselect: true,
        altRows: false,
        footerrow: false,
        userDataOnFooter: false,
        pgbuttons: false,
        viewrecords: false,
        pgtext: "",
        pginput: false,
        rowList: "",
        caption: '<b>DETALLE DE RETENCION PARA CONVENIO MULTILATERAL</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaIIBB").jqGrid('navGrid', '#PagerIIBB', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaIIBB").jqGrid('navButtonAdd', '#PagerIIBB',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar item",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaIIBB"));
                                     },
                                 });
    jQuery("#ListaIIBB").jqGrid('navButtonAdd', '#PagerIIBB',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaIIBB"));
                                     },
                                 });
    jQuery("#ListaIIBB").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 50, maxHeight: 100 });

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo;
        var cabecera = $("#formid").serializeObject();
        //cabecera.IdProveedor = $("#IdProveedor").val();

        var chk = $('#Exterior').is(':checked');
        if (chk) {
            cabecera.Exterior = "SI";
        } else {
            cabecera.Exterior = "NO";
        };
        var chk = $('#RegistrarMovimientosEnCuentaCorriente').is(':checked');
        if (chk) {
            cabecera.RegistrarMovimientosEnCuentaCorriente = "NO";
        } else {
            cabecera.RegistrarMovimientosEnCuentaCorriente = "SI";
        };
        var chk = $('#IvaExencionRetencion').is(':checked');
        if (chk) {
            cabecera.IvaExencionRetencion = "SI";
        } else {
            cabecera.IvaExencionRetencion = "NO";
        };
        var chk = $('#CancelacionInmediataDeDeuda').is(':checked');
        if (chk) {
            cabecera.CancelacionInmediataDeDeuda = "SI";
        } else {
            cabecera.CancelacionInmediataDeDeuda = "NO";
        };
        var chk = $('#DebitoAutomaticoPorDefecto').is(':checked');
        if (chk) {
            cabecera.DebitoAutomaticoPorDefecto = "SI";
        } else {
            cabecera.DebitoAutomaticoPorDefecto = "NO";
        };
        var chk = $('#FechaVencimientoParaEgresosProyectados').is(':checked');
        if (chk) {
            cabecera.FechaVencimientoParaEgresosProyectados = "SI";
        } else {
            cabecera.FechaVencimientoParaEgresosProyectados = "NO";
        };
        var chk = $('#OperacionesMercadoInternoEntidadVinculada').is(':checked');
        if (chk) {
            cabecera.OperacionesMercadoInternoEntidadVinculada = "SI";
        } else {
            cabecera.OperacionesMercadoInternoEntidadVinculada = "NO";
        };
        var chk = $('#ResolucionAfip3668').is(':checked');
        if (chk) {
            cabecera.ResolucionAfip3668 = "SI";
        } else {
            cabecera.ResolucionAfip3668 = "NO";
        };

        cabecera.DetalleProveedoresContactos = [];
        $grid = $('#ListaContactos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleProveedor'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleProveedor":"' + iddeta + '",';
                data1 = data1 + '"IdProveedor":"' + $("#IdProveedor").val() + '",';
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
                cabecera.DetalleProveedoresContactos.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleProveedoresRubros = [];
        $grid = $('#ListaRubros');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleProveedorRubros'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleProveedorRubros":"' + iddeta + '",';
                data1 = data1 + '"IdProveedor":"' + $("#IdProveedor").val() + '",';
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
                cabecera.DetalleProveedoresRubros.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleProveedoresIBs = [];
        $grid = $('#ListaIIBB');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleProveedorIB'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleProveedorIB":"' + iddeta + '",';
                data1 = data1 + '"IdProveedor":"' + $("#IdProveedor").val() + '",';
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
                cabecera.DetalleProveedoresIBs.push(data2);
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
            url: ROOT + 'Proveedor/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Proveedor: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    if ($('#Eventual').val() == "SI") {
                        window.location = (ROOT + "Proveedor/EditEventual/" + result.IdProveedor);
                    } else {
                        window.location = (ROOT + "Proveedor/Edit/" + result.IdProveedor);
                    }
                } else {
                    alert('No se pudo grabar el proveedor.');
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

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        if (e.target.hash == "#rubros") {
            jQuery("#ListaRubros").setGridWidth(900);
        }
        if (e.target.hash == "#contactos") {
            jQuery("#ListaContactos").setGridWidth(900);
        }
        if (e.target.hash == "#retenciones") {
            jQuery("#ListaIIBB").setGridWidth(500);
        }
    })

    $("input[name=IGCondicion]:radio").change(function () {
        ConfigurarControles();
    })

    $("input[name=RetenerSUSS]:radio").change(function () {
        ConfigurarControles();
    })

    $("input[name=IBCondicion]:radio").change(function () {
        ConfigurarControles();
    })

    $('#IvaExencionRetencion').change(function () {
        ConfigurarControles();
    });

    
});

function ConfigurarControles() {
    var valor = "";
    
    valor = $("input[name='IGCondicion']:checked").val();
    if (valor == "1") {
        $('#IdTipoRetencionGanancia').val("");
        $('#IdTipoRetencionGanancia:input').attr('disabled', 'disabled');
        $('#FechaLimiteExentoGanancias:input').removeAttr('disabled');
    } else {
        $('#FechaLimiteExentoGanancias').val("");
        $('#IdTipoRetencionGanancia:input').removeAttr('disabled');
        $('#FechaLimiteExentoGanancias:input').attr('disabled', 'disabled');
    }

    valor = $("input[name='RetenerSUSS']:checked").val();
    if (valor == "SI") {
        $('#SUSSFechaCaducidadExencion').val("");
        $('#IdImpuestoDirectoSUSS:input').removeAttr('disabled');
        $('#SUSSFechaCaducidadExencion:input').attr('disabled', 'disabled');
    } else {
        if (valor == "EX") {
            $('#IdImpuestoDirectoSUSS').val("");
            $('#IdImpuestoDirectoSUSS:input').attr('disabled', 'disabled');
            $('#SUSSFechaCaducidadExencion:input').removeAttr('disabled');
        } else {
            $('#IdImpuestoDirectoSUSS').val("");
            $('#SUSSFechaCaducidadExencion').val("");
            $('#IdImpuestoDirectoSUSS:input').attr('disabled', 'disabled');
            $('#SUSSFechaCaducidadExencion:input').attr('disabled', 'disabled');
        }
    }

    valor = $("input[name='IBCondicion']:checked").val();
    if (valor == "1") {
        $('#IdIBCondicionPorDefecto').val("");
        $('#CoeficienteIIBBUnificado').val("");
        $('#PorcentajeIBDirecto').val("");
        $('#GrupoIIBB').val("");
        $('#FechaInicioVigenciaIBDirecto').val("");
        $('#FechaFinVigenciaIBDirecto').val("");
        $('#PorcentajeIBDirectoCapital').val("");
        $('#GrupoIIBBCapital').val("");
        $('#FechaInicioVigenciaIBDirectoCapital').val("");
        $('#FechaFinVigenciaIBDirectoCapital').val("");
        
        $('#IdIBCondicionPorDefecto:input').attr('disabled', 'disabled');
        $('#FechaLimiteExentoIIBB:input').removeAttr('disabled');
        $('#CoeficienteIIBBUnificado:input').attr('disabled', 'disabled');
        $('#PorcentajeIBDirecto:input').attr('disabled', 'disabled');
        $('#GrupoIIBB:input').attr('disabled', 'disabled');
        $('#FechaInicioVigenciaIBDirecto:input').attr('disabled', 'disabled');
        $('#FechaFinVigenciaIBDirecto:input').attr('disabled', 'disabled');
        $('#PorcentajeIBDirectoCapital:input').attr('disabled', 'disabled');
        $('#GrupoIIBBCapital:input').attr('disabled', 'disabled');
        $('#FechaInicioVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
        $('#FechaFinVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
        ActivarListaIIBB(false);
    } else {
        if (valor == "2") {
            $('#IdIBCondicionPorDefecto:input').removeAttr('disabled');
            $('#FechaLimiteExentoIIBB:input').attr('disabled', 'disabled');
            $('#CoeficienteIIBBUnificado:input').removeAttr('disabled');
            $('#PorcentajeIBDirecto:input').removeAttr('disabled');
            $('#GrupoIIBB:input').removeAttr('disabled');
            $('#FechaInicioVigenciaIBDirecto:input').removeAttr('disabled');
            $('#FechaFinVigenciaIBDirecto:input').removeAttr('disabled');
            $('#PorcentajeIBDirectoCapital:input').removeAttr('disabled');
            $('#GrupoIIBBCapital:input').removeAttr('disabled');
            $('#FechaInicioVigenciaIBDirectoCapital:input').removeAttr('disabled');
            $('#FechaFinVigenciaIBDirectoCapital:input').removeAttr('disabled');
            ActivarListaIIBB(true);
        } else {
            if (valor == "3") {
                $('#IdIBCondicionPorDefecto:input').removeAttr('disabled');
                $('#FechaLimiteExentoIIBB:input').attr('disabled', 'disabled');
                $('#CoeficienteIIBBUnificado:input').removeAttr('disabled');
                $('#PorcentajeIBDirecto:input').removeAttr('disabled');
                $('#GrupoIIBB:input').removeAttr('disabled');
                $('#FechaInicioVigenciaIBDirecto:input').removeAttr('disabled');
                $('#FechaFinVigenciaIBDirecto:input').removeAttr('disabled');
                $('#PorcentajeIBDirectoCapital:input').removeAttr('disabled');
                $('#GrupoIIBBCapital:input').removeAttr('disabled');
                $('#FechaInicioVigenciaIBDirectoCapital:input').removeAttr('disabled');
                $('#FechaFinVigenciaIBDirectoCapital:input').removeAttr('disabled');
                ActivarListaIIBB(false);
            } else {
                $('#IBNumeroInscripcion').val("");
                $('#IdIBCondicionPorDefecto').val("");
                $('#CoeficienteIIBBUnificado').val("");
                $('#PorcentajeIBDirecto').val("");
                $('#GrupoIIBB').val("");
                $('#FechaInicioVigenciaIBDirecto').val("");
                $('#FechaFinVigenciaIBDirecto').val("");
                $('#PorcentajeIBDirectoCapital').val("");
                $('#GrupoIIBBCapital').val("");
                $('#FechaInicioVigenciaIBDirectoCapital').val("");
                $('#FechaFinVigenciaIBDirectoCapital').val("");

                $('#IdIBCondicionPorDefecto:input').attr('disabled', 'disabled');
                $('#FechaLimiteExentoIIBB:input').attr('disabled', 'disabled');
                $('#CoeficienteIIBBUnificado:input').attr('disabled', 'disabled');
                $('#PorcentajeIBDirecto:input').attr('disabled', 'disabled');
                $('#GrupoIIBB:input').attr('disabled', 'disabled');
                $('#FechaInicioVigenciaIBDirecto:input').attr('disabled', 'disabled');
                $('#FechaFinVigenciaIBDirecto:input').attr('disabled', 'disabled');
                $('#PorcentajeIBDirectoCapital:input').attr('disabled', 'disabled');
                $('#GrupoIIBBCapital:input').attr('disabled', 'disabled');
                $('#FechaInicioVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
                $('#FechaFinVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
                ActivarListaIIBB(false);
            }
        }

        var valor = $('#IvaExencionRetencion').is(':checked');
        if (valor) {
            $('#IvaFechaInicioExencion').val("");
            $('#IvaFechaCaducidadExencion').val("");
            $('#IvaPorcentajeExencion').val(0);

            $('#IvaFechaInicioExencion:input').attr('disabled', 'disabled');
            $('#IvaFechaCaducidadExencion:input').attr('disabled', 'disabled');
            $('#IvaPorcentajeExencion:input').attr('disabled', 'disabled');
        } else {
            $('#IvaFechaInicioExencion:input').removeAttr('disabled');
            $('#IvaFechaCaducidadExencion:input').removeAttr('disabled');
            $('#IvaPorcentajeExencion:input').removeAttr('disabled');
        };

    }
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

function ActivarListaIIBB(Activar) {
    var $td;
    if (Activar) {
        $("#ListaIIBB").unblock({
            message: "",
            theme: true,
        });
    } else {
        $("#ListaIIBB").jqGrid("clearGridData", true)
        $("#ListaIIBB").block({
            message: "",
            theme: true,
        });
    }
};
