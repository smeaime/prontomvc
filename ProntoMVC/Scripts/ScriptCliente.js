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
        if (jQuery("#ListaDireccionesEntrega").find(target).length) {
            $grid = $('#ListaDireccionesEntrega');
            grillaenfoco = true;
        }
        if (jQuery("#ListaDireccionesAdicionales").find(target).length) {
            $grid = $('#ListaDireccionesAdicionales');
            grillaenfoco = true;
        }
        if (jQuery("#ListaTelefonosAdicionales").find(target).length) {
            $grid = $('#ListaTelefonosAdicionales');
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
        url: ROOT + 'Cliente/DetContactos/',
        postData: { 'IdCliente': function () { return $("#IdCliente").val(); } },
        editurl: ROOT + 'Cliente/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleCliente', 'Contacto', 'Puesto', 'Telefono', 'Email'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleCliente', index: 'IdDetalleCliente', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
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
        sortname: 'IdDetalleCliente',
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

    $('#ListaDireccionesEntrega').jqGrid({
        url: ROOT + 'Cliente/DetLugaresEntrega/',
        postData: { 'IdCliente': function () { return $("#IdCliente").val(); } },
        editurl: ROOT + 'Cliente/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleClienteLugarEntrega', 'IdLocalidadEntrega', 'IdProvinciaEntrega', 'Direccion', 'Localidad', 'Provincia'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleClienteLugarEntrega', index: 'IdDetalleClienteLugarEntrega', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdLocalidadEntrega', index: 'IdLocalidadEntrega', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdProvinciaEntrega', index: 'IdProvinciaEntrega', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'DireccionEntrega', index: 'DireccionEntrega', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    {
                        name: 'Localidad', index: 'Localidad', align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Localidad/GetLocalidades',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaDireccionesEntrega').getGridParam('selrow');
                                    $('#ListaDireccionesEntrega').jqGrid('setCell', rowid, 'IdLocalidadEntrega', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Provincia', index: 'Provincia', align: 'left', width: 300, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Provincia/GetProvincias',
                            dataInit: function (elem) {
                                $(elem).width(290);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaDireccionesEntrega').getGridParam('selrow');
                                    $('#ListaDireccionesEntrega').jqGrid('setCell', rowid, 'IdProvinciaEntrega', this.value);
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
        pager: $('#PagerDireccionesEntrega'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleClienteLugarEntrega',
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
        caption: '<b>DETALLE DIRECCIONES DE ENTREGA</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaDireccionesEntrega").jqGrid('navGrid', '#PagerDireccionesEntrega', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaDireccionesEntrega").jqGrid('navButtonAdd', '#PagerDireccionesEntrega',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar direccion",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaDireccionesEntrega"));
                                     },
                                 });
    jQuery("#ListaDireccionesEntrega").jqGrid('navButtonAdd', '#PagerDireccionesEntrega',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaDireccionesEntrega"));
                                     },
                                 });
    jQuery("#ListaDireccionesEntrega").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });

    $('#ListaDireccionesAdicionales').jqGrid({
        url: ROOT + 'Cliente/DetDirecciones/',
        postData: { 'IdCliente': function () { return $("#IdCliente").val(); } },
        editurl: ROOT + 'Cliente/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleClienteLugarEntrega', 'IdLocalidad', 'IdProvincia', 'IdPais', 'Direccion', 'Localidad', 'Provincia', 'Pais'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleClienteLugarEntrega', index: 'IdDetalleClienteLugarEntrega', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdLocalidad', index: 'IdLocalidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdProvincia', index: 'IdProvincia', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'IdPais', index: 'IdPais', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true }, label: 'TB' },
                    { name: 'Direccion', index: 'Direccion', width: 200, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    {
                        name: 'Localidad', index: 'Localidad', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Localidad/GetLocalidades',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaDireccionesAdicionales').getGridParam('selrow');
                                    $('#ListaDireccionesAdicionales').jqGrid('setCell', rowid, 'IdLocalidad', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Provincia', index: 'Provincia', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Provincia/GetProvincias',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaDireccionesAdicionales').getGridParam('selrow');
                                    $('#ListaDireccionesAdicionales').jqGrid('setCell', rowid, 'IdProvincia', this.value);
                                }
                            }]
                        },
                    },
                    {
                        name: 'Pais', index: 'Pais', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, label: 'TB',
                        editoptions: {
                            dataUrl: ROOT + 'Pais/GetPaises',
                            dataInit: function (elem) {
                                $(elem).width(190);
                            },
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#ListaDireccionesAdicionales').getGridParam('selrow');
                                    $('#ListaDireccionesAdicionales').jqGrid('setCell', rowid, 'IdPais', this.value);
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
        afterEditCell: function (rowid, cellName, cellValue, iRow, iCol) {
            //if (cellName == 'FechaVencimiento') {
            //    jQuery("#" + iRow + "_FechaVencimiento", "#ListaDireccionesAdicionales").datepicker({ dateFormat: "dd/mm/yy" });
            //}
        },
        pager: $('#PagerDireccionesAdicionales'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleClienteDireccion',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '100px', // 'auto',
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
        caption: '<b>DETALLE DE DIRECCIONES ADICIONALES</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaDireccionesAdicionales").jqGrid('navGrid', '#PagerDireccionesAdicionales', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaDireccionesAdicionales").jqGrid('navButtonAdd', '#PagerDireccionesAdicionales',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar direccion",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaDireccionesAdicionales"));
                                     },
                                 });
    jQuery("#ListaDireccionesAdicionales").jqGrid('navButtonAdd', '#PagerDireccionesAdicionales',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaDireccionesAdicionales"));
                                     },
                                 });
    jQuery("#ListaDireccionesAdicionales").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 50, maxHeight: 100 });

    $('#ListaTelefonosAdicionales').jqGrid({
        url: ROOT + 'Cliente/DetTelefonos/',
        postData: { 'IdCliente': function () { return $("#IdCliente").val(); } },
        editurl: ROOT + 'Cliente/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleClienteTelefono', 'Detalle', 'Telefono'],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleClienteTelefono', index: 'IdDetalleClienteTelefono', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'Detalle', index: 'Detalle', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' },
                    { name: 'Telefono', index: 'Telefono', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB' }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
        },
        pager: $('#PagerTelefonosAdicionales'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'IdDetalleClienteTelefono',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        height: '100px', // 'auto',
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
        caption: '<b>DETALLE DE TELEFONOS ADICIONALES</b>',
        cellEdit: true,
        cellsubmit: 'clientArray'
    });
    jQuery("#ListaTelefonosAdicionales").jqGrid('navGrid', '#PagerTelefonosAdicionales', { refresh: false, add: false, edit: false, del: false, search: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    jQuery("#ListaTelefonosAdicionales").jqGrid('navButtonAdd', '#PagerTelefonosAdicionales',
                                 {
                                     caption: "", buttonicon: "ui-icon-plus", title: "Agregar telefono",
                                     onClickButton: function () {
                                         AgregarItemVacio(jQuery("#ListaTelefonosAdicionales"));
                                     },
                                 });
    jQuery("#ListaTelefonosAdicionales").jqGrid('navButtonAdd', '#PagerTelefonosAdicionales',
                                 {
                                     caption: "", buttonicon: "ui-icon-trash", title: "Eliminar",
                                     onClickButton: function () {
                                         EliminarSeleccionados(jQuery("#ListaTelefonosAdicionales"));
                                     },
                                 });
    jQuery("#ListaTelefonosAdicionales").jqGrid('gridResize', { minWidth: 350, maxWidth: 910, minHeight: 100, maxHeight: 500 });

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        var cm, colModel, dataIds, data1, data2, valor, valor2, iddeta, i, j, nuevo;
        var cabecera = $("#formid").serializeObject();
        //cabecera.IdProveedor = $("#IdProveedor").val();

        valor = $("#Subcodigo").val();
        if (valor.length != 2) {
            cabecera.Codigo = "";
        }
        else {
            valor = valor.toUpperCase();
            valor2 = $("#CodigoCliente").val();
            if (valor2.length != 0) {
                valor2 = new Array(5 - valor2.length).join("0") + valor2;
                cabecera.Codigo = valor + valor2;
            } else {
                cabecera.Codigo = "";
            }
        }

        var chk = $('#RegistrarMovimientosEnCuentaCorriente').is(':checked');
        if (chk) {
            cabecera.RegistrarMovimientosEnCuentaCorriente = "NO";
        } else {
            cabecera.RegistrarMovimientosEnCuentaCorriente = "SI";
        };
        var chk = $('#EsAgenteRetencionIVA').is(':checked');
        if (chk) {
            cabecera.EsAgenteRetencionIVA = "SI";
        } else {
            cabecera.EsAgenteRetencionIVA = "NO";
        };
        var chk = $('#OperacionesMercadoInternoEntidadVinculada').is(':checked');
        if (chk) {
            cabecera.OperacionesMercadoInternoEntidadVinculada = "SI";
        } else {
            cabecera.OperacionesMercadoInternoEntidadVinculada = "NO";
        };

        cabecera.DetalleClientesContactos = [];
        $grid = $('#ListaContactos');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleCliente'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleCliente":"' + iddeta + '",';
                data1 = data1 + '"IdCliente":"' + $("#IdCliente").val() + '",';
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
                cabecera.DetalleClientesContactos.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleClientesLugaresEntregas = [];
        $grid = $('#ListaDireccionesEntrega');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleClienteLugarEntrega'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleClienteLugarEntrega":"' + iddeta + '",';
                data1 = data1 + '"IdCliente":"' + $("#IdCliente").val() + '",';
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
                cabecera.DetalleClientesLugaresEntregas.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleClientesDirecciones = [];
        $grid = $('#ListaDireccionesAdicionales');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleClienteDireccion'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleClienteDireccion":"' + iddeta + '",';
                data1 = data1 + '"IdCliente":"' + $("#IdCliente").val() + '",';
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
                cabecera.DetalleClientesDirecciones.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
                return;
            }
        };

        cabecera.DetalleClientesTelefonos = [];
        $grid = $('#ListaTelefonosAdicionales');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleClienteTelefono'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleClienteTelefono":"' + iddeta + '",';
                data1 = data1 + '"IdCliente":"' + $("#IdCliente").val() + '",';
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
                cabecera.DetalleClientesTelefonos.push(data2);
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
            url: ROOT + 'Cliente/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Cliente: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    if ($('#Eventual').val() == "SI") {
                        window.location = (ROOT + "Cliente/EditEventual/" + result.IdCliente);
                    } else {
                        window.location = (ROOT + "Cliente/Edit/" + result.IdCliente);
                    }
                } else {
                    alert('No se pudo grabar el cliente.');
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
        if (e.target.hash == "#contactos") {
            jQuery("#ListaContactos").setGridWidth(900);
        }
        if (e.target.hash == "#lugaresentrega") {
            jQuery("#ListaDireccionesEntrega").setGridWidth(900);
        }
        if (e.target.hash == "#direccionestelefonos") {
            jQuery("#ListaDireccionesAdicionales").setGridWidth(900);
            jQuery("#ListaTelefonosAdicionales").setGridWidth(900);
        }
    })

    $('#EsAgenteRetencionIVA').change(function () {
        ConfigurarControles();
    });

    $("input[name=IBCondicion]:radio").change(function () {
        ConfigurarControles();
    })

});

function ConfigurarControles() {
    var valor = "";
    
    var valor = $('#EsAgenteRetencionIVA').is(':checked');
    if (valor) {
        $('#BaseMinimaParaPercepcionIVA').val(0);
        $('#PorcentajePercepcionIVA').val(0);

        $('#BaseMinimaParaPercepcionIVA:input').attr('disabled', 'disabled');
        $('#PorcentajePercepcionIVA:input').attr('disabled', 'disabled');
    } else {
        $('#BaseMinimaParaPercepcionIVA:input').removeAttr('disabled');
        $('#PorcentajePercepcionIVA:input').removeAttr('disabled');
    };

    valor = $("input[name='IBCondicion']:checked").val();
    if (valor == "1") {
        $('#IdIBCondicionPorDefecto').val("");
        $('#IdIBCondicionPorDefecto2').val("");
        $('#IdIBCondicionPorDefecto3').val("");
        $('#PorcentajeIBDirecto').val("");
        $('#FechaInicioVigenciaIBDirecto').val("");
        $('#FechaFinVigenciaIBDirecto').val("");
        $('#GrupoIIBB').val("");
        $('#PorcentajeIBDirectoCapital').val("");
        $('#FechaInicioVigenciaIBDirectoCapital').val("");
        $('#FechaFinVigenciaIBDirectoCapital').val("");
        $('#GrupoIIBBCapital').val("");
        
        $('#IdIBCondicionPorDefecto:input').attr('disabled', 'disabled');
        $('#IdIBCondicionPorDefecto2:input').attr('disabled', 'disabled');
        $('#IdIBCondicionPorDefecto3:input').attr('disabled', 'disabled');
        $('#PorcentajeIBDirecto:input').attr('disabled', 'disabled');
        $('#FechaInicioVigenciaIBDirecto:input').attr('disabled', 'disabled');
        $('#FechaFinVigenciaIBDirecto:input').attr('disabled', 'disabled');
        $('#GrupoIIBB:input').attr('disabled', 'disabled');
        $('#PorcentajeIBDirectoCapital:input').attr('disabled', 'disabled');
        $('#FechaInicioVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
        $('#FechaFinVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
        $('#GrupoIIBBCapital:input').attr('disabled', 'disabled');
    } else {
        if (valor == "2") {
            $('#IdIBCondicionPorDefecto:input').removeAttr('disabled');
            $('#IdIBCondicionPorDefecto2:input').removeAttr('disabled');
            $('#IdIBCondicionPorDefecto3:input').removeAttr('disabled');
            $('#PorcentajeIBDirecto:input').removeAttr('disabled');
            $('#FechaInicioVigenciaIBDirecto:input').removeAttr('disabled');
            $('#FechaFinVigenciaIBDirecto:input').removeAttr('disabled');
            $('#GrupoIIBB:input').removeAttr('disabled');
            $('#PorcentajeIBDirectoCapital:input').removeAttr('disabled');
            $('#FechaInicioVigenciaIBDirectoCapital:input').removeAttr('disabled');
            $('#FechaFinVigenciaIBDirectoCapital:input').removeAttr('disabled');
            $('#GrupoIIBBCapital:input').removeAttr('disabled');
        } else {
            if (valor == "3") {
                $('#IdIBCondicionPorDefecto:input').removeAttr('disabled');
                $('#IdIBCondicionPorDefecto2:input').removeAttr('disabled');
                $('#IdIBCondicionPorDefecto3:input').removeAttr('disabled');
                $('#PorcentajeIBDirecto:input').removeAttr('disabled');
                $('#FechaInicioVigenciaIBDirecto:input').removeAttr('disabled');
                $('#FechaFinVigenciaIBDirecto:input').removeAttr('disabled');
                $('#GrupoIIBB:input').removeAttr('disabled');
                $('#PorcentajeIBDirectoCapital:input').removeAttr('disabled');
                $('#FechaInicioVigenciaIBDirectoCapital:input').removeAttr('disabled');
                $('#FechaFinVigenciaIBDirectoCapital:input').removeAttr('disabled');
                $('#GrupoIIBBCapital:input').removeAttr('disabled');
            } else {
                $('#IdIBCondicionPorDefecto').val("");
                $('#IdIBCondicionPorDefecto2').val("");
                $('#IdIBCondicionPorDefecto3').val("");
                $('#PorcentajeIBDirecto').val("");
                $('#FechaInicioVigenciaIBDirecto').val("");
                $('#FechaFinVigenciaIBDirecto').val("");
                $('#GrupoIIBB').val("");
                $('#PorcentajeIBDirectoCapital').val("");
                $('#FechaInicioVigenciaIBDirectoCapital').val("");
                $('#FechaFinVigenciaIBDirectoCapital').val("");
                $('#GrupoIIBBCapital').val("");
        
                $('#IdIBCondicionPorDefecto:input').attr('disabled', 'disabled');
                $('#IdIBCondicionPorDefecto2:input').attr('disabled', 'disabled');
                $('#IdIBCondicionPorDefecto3:input').attr('disabled', 'disabled');
                $('#PorcentajeIBDirecto:input').attr('disabled', 'disabled');
                $('#FechaInicioVigenciaIBDirecto:input').attr('disabled', 'disabled');
                $('#FechaFinVigenciaIBDirecto:input').attr('disabled', 'disabled');
                $('#GrupoIIBB:input').attr('disabled', 'disabled');
                $('#PorcentajeIBDirectoCapital:input').attr('disabled', 'disabled');
                $('#FechaInicioVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
                $('#FechaFinVigenciaIBDirectoCapital:input').attr('disabled', 'disabled');
                $('#GrupoIIBBCapital:input').attr('disabled', 'disabled');
            }
        }
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
