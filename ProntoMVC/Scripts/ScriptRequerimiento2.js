$(function () {
    $("#loading").hide();

    
    'use strict';


    var $grid = "", lastSelectedId, lastSelectediCol, lastSelectediRow, lastSelectediCol2, lastSelectediRow2, inEdit, selICol, selIRow, gridCellWasClicked = false, grillaenfoco = false, dobleclic;
    var headerRow, rowHight, resizeSpanHeight;
    var idaux = 0, detalle = "";

    if ($("#IdRequerimiento").val() <= 0) {
        $("#anular").attr('disabled', 'disabled');
    }

    if ($("#Cumplido").val() == "AN") {
        $("#grabar2").prop("disabled", true);
        $("#anular").prop("disabled", true);
        $(":input").attr("disabled", "disabled");
        $("#RManulada").html("RM ANULADA el " + $("#FechaAnulacion").val() + ", Motivo : " + $("#MotivoAnulacion").val() + ", Usuario : " + $("#UsuarioAnulacion").val());
        $("#RManulada").show();
    }

    //TraerNumeroComprobante()

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
        grid.jqGrid('setCell', Id, 'OrigenDescripcion', 1);
        grid.jqGrid('setCell', Id, 'TiposDeDescripcion', "Solo material");
        grid.jqGrid('setCell', Id, 'Cantidad', 0);
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

                            jQuery('#Lista').jqGrid('restoreCell', lastSelectediRow, lastSelectediCol, true);

                            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

                            data['IdArticulo'] = ui.id;
                            data['Codigo'] = ui.codigo;
                            data['Articulo'] = ui.title;
                            data['IdUnidad'] = ui.IdUnidad;
                            data['Unidad'] = ui.Unidad;
                            data['IdDetalleRequerimiento'] = data['IdDetalleRequerimiento'] || 0;
                            data['IdControlCalidad'] = ui.IdControlCalidad;
                            data['DescripcionControlCalidad'] = ui.ControlCalidad;
                            data['OrigenDescripcion'] = ui.IdCuantificacion;
                            if (ui.IdCuantificacion == 1) { data['TiposDeDescripcion'] = "Solo material"; };
                            if (ui.IdCuantificacion == 2) { data['TiposDeDescripcion'] = "Solo observaciones"; };
                            if (ui.IdCuantificacion == 3) { data['TiposDeDescripcion'] = "Material + observaciones"; };

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

                            jQuery('#Lista').jqGrid('restoreCell', lastSelectediRow, lastSelectediCol, true);

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
                            data['IdDetalleRequerimiento'] = data['IdDetalleRequerimiento'] || 0;
                            data['IdControlCalidad'] = ui.IdControlCalidad;
                            data['DescripcionControlCalidad'] = ui.ControlCalidad;
                            data['OrigenDescripcion'] = ui.IdCuantificacion;
                            if (ui.IdCuantificacion == 1) { data['TiposDeDescripcion'] = "Solo material"; };
                            if (ui.IdCuantificacion == 2) { data['TiposDeDescripcion'] = "Solo observaciones"; };
                            if (ui.IdCuantificacion == 3) { data['TiposDeDescripcion'] = "Material + observaciones"; };

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
        else if (colName == "Cantidad") {
            var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
            var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

            if (data['NumeroItem'] == "") {
                data['NumeroItem'] = ProximoItem();
                $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); 
            }
            if (data['FechaEntrega'] == "") {
                var now = new Date();
                var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                data['FechaEntrega'] = currentDate;
                $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data);
            }
            if (data['OrigenDescripcion'] == "") {
                data['OrigenDescripcion'] = "1";
                data['TiposDeDescripcion'] = "Solo material";
                $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data);
            }
        }
        else {
            FinRefresco()
        }
    }

    function FinRefresco() {
        calculaTotal();
        //RefrescarOrigenDescripcion();
        AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Articulo": "" }, "#Lista");
    }

    function ProximoItem() {
        var items = jQuery("#Lista").jqGrid('getCol', 'NumeroItem', false, 'max')
        return (items || 0) + 1;
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////DEFINICION DE GRILLAS   //////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#Lista').jqGrid({
        url: ROOT + 'Requerimiento/DetRequerimientos/',
        postData: { 'IdRequerimiento': function () { return $("#IdRequerimiento").val(); } },
        //editurl: ROOT + 'Requerimiento/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleRequerimiento', 'IdRequerimiento', 'IdArticulo', 'IdUnidad', 'IdControlCalidad', 'OrigenDescripcion', 
                   'Nro. item', 'Cant.', 'Un.', 'Codigo', 'Articulo', 'Observaciones', 'Tipos de descripcion', 'Fecha entrega', 'Cump.', 'Control de calidad', 
                   'Agregar adjunto', 'Archivo adjunto 1', 'Archivo adjunto 2', 'Archivo adjunto 3', 'Archivo adjunto 4', 'Archivo adjunto 5', 'Archivo adjunto 6', 'Archivo adjunto 7',
                   'Archivo adjunto 8', 'Archivo adjunto 9', 'Archivo adjunto 10'
        ],
        colModel: [
                    { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                    { name: 'IdDetalleRequerimiento', index: 'IdDetalleRequerimiento', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true } },
                    { name: 'IdRequerimiento', index: 'IdRequerimiento', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdArticulo', index: 'IdArticulo', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdUnidad', index: 'IdUnidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'IdControlCalidad', index: 'IdControlCalidad', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    { name: 'OrigenDescripcion', index: 'OrigenDescripcion', editable: true, hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }, label: 'TB' },
                    {
                        name: 'NumeroItem', index: 'NumeroItem', width: 50, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
                        editoptions: {
                            maxlength: 3, defaultValue: '0.00',
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
                        name: 'Cantidad', index: 'Cantidad', width: 70, align: 'right', editable: true, editrules: { required: false, number: true }, edittype: 'text', label: 'TB',
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
                        name: 'Unidad', index: 'Unidad', align: 'left', width: 50, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, 
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
                    {
                        name: 'Codigo', index: 'Codigo', width: 120, align: 'center', editable: true, editrules: { required: false }, edittype: 'text', 
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
                        name: 'Articulo', index: 'Articulo', align: 'left', width: 400, hidden: false, editable: true, edittype: 'text', editrules: { required: true },
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
                        name: 'Observaciones', index: 'Observaciones', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'textarea', label: 'TB',
                        editoptions: {
                            dataEvents: [{
                                type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); }
                            },
                            ]
                        },
                    },
                    {
                        name: 'TiposDeDescripcion', index: 'TiposDeDescripcion', align: 'left', width: 200, editable: true, hidden: false, edittype: 'select', editrules: { required: false }, 
                        editoptions: {
                            dataUrl: ROOT + 'Articulo/GetTiposDeDescripcion',
                            dataInit: function (elem) { $(elem).width(145); },
                            dataEvents: [
                                { type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } },
                                {
                                    type: 'change', fn: function (e) {
                                        var rowid = $('#Lista').getGridParam('selrow');
                                        $('#Lista').jqGrid('setCell', rowid, 'OrigenDescripcion', this.value);
                                    }
                                }]
                        },
                    },
                    {
                        name: 'FechaEntrega', index: 'FechaEntrega', label: 'TB', width: 250, align: 'center', sorttype: 'date', editable: true,
                        formatoptions: { newformat: 'dd/mm/yy', defaultvalue: null }, datefmt: 'dd/mm/yy',
                        editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: false }
                    },
                    { name: 'Cumplido', index: 'Cumplido', width: 60, align: 'center', editable: true, hidden: false, editoptions: { disabled: 'disabled', defaultValue: 0 }, label: 'TB' },
                    {
                        name: 'DescripcionControlCalidad', index: 'DescripcionControlCalidad', align: 'center', label: '', width: 100, editable: true, edittype: 'select', editrules: { required: false },
                        editoptions: {
                            dataUrl: ROOT + 'ControlCalidad/ControlCalidades',
                            dataEvents: [{
                                type: 'change', fn: function (e) {
                                    var rowid = $('#Lista').getGridParam('selrow');
                                    $('#Lista').jqGrid('setCell', rowid, 'IdControlCalidad', this.value);
                                }
                            }]
                        }
                    },
                    { name: 'AgregarAdjunto', index: 'AgregarAdjunto', align: 'left', width: 100, hidden: true, sortable: false, editable: true },
                    //{
                    //    name: 'AgregarAdjunto', index: 'AgregarAdjunto', label: 'TB', align: 'left', width: 90, editable: true, edittype: 'file',
                    //    editoptions: {
                    //        enctype: "multipart/form-data", dataEvents: [{
                    //            type: 'change', fn: function (e) {
                    //                var i, data;
                    //                var thisval = $(e.target).val();
                    //                var thisval2 = thisval.replace(/C:\\fakepath\\/i, '')
                    //                var rowid = $('#Lista').getGridParam('selrow');
                    //                data = $('#Lista').jqGrid('getRowData', rowid);

                    //                for (i = 1; i <= 10; i++) {
                    //                    if (data['ArchivoAdjunto'+i].length == 0) {
                    //                        $('#Lista').jqGrid('setCell', rowid, 'ArchivoAdjunto'+i, thisval2);
                    //                        break
                    //                    }
                    //                }
                    //                if (i > 10) { alert("No hay mas adjuntos disponibles") }
                    //            }
                    //        }]
                    //    }
                    //},
                    {
                        name: 'ArchivoAdjunto1', index: 'ArchivoAdjunto1', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto2', index: 'ArchivoAdjunto2', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto3', index: 'ArchivoAdjunto3', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto4', index: 'ArchivoAdjunto4', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto5', index: 'ArchivoAdjunto5', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto6', index: 'ArchivoAdjunto6', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto7', index: 'ArchivoAdjunto7', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto8', index: 'ArchivoAdjunto8', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto9', index: 'ArchivoAdjunto9', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    },
                    {
                        name: 'ArchivoAdjunto10', index: 'ArchivoAdjunto10', width: 300, align: 'left', editable: true, editrules: { required: false }, edittype: 'text', label: 'TB',
                        editoptions: { dataEvents: [{ type: 'focusout', fn: function (e) { $('#Lista').jqGrid("saveCell", lastSelectediRow, lastSelectediCol); } }, ] },
                    }
        ],
        onCellSelect: function (rowid, iCol, cellcontent, e) {
            var $this = $(this);
            var iRow = $('#' + $.jgrid.jqID(rowid))[0].rowIndex;
            lastSelectedId = rowid;
            lastSelectediCol = iCol;
            lastSelectediRow = iRow;
            //var cm = jQuery("#Lista").jqGrid("getGridParam", "colModel");
            //if (cm[iCol].name == "ArchivoAdjunto1") {
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
            calculaTotal();
        },
        gridComplete: function () {
            calculaTotal();
        },

        loadComplete: function () { 
            AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Articulo": "" }, "#Lista");
        },
        pager: $('#ListaPager1'),
        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'NumeroItem',
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
        url: ROOT + 'Articulo/Articulos_DynamicGridData',
        datatype: 'json',
        mtype: 'POST',
        postData: { 'FechaInicial': function () { return $("#FechaInicial").val(); }, 'FechaFinal': function () { return $("#FechaFinal").val(); }, 'IdObra': function () { return $("#IdObra").val(); } },
        colNames: ['', '', 'Codigo', 'Numero inventario', 'Descripcion', 'Rubro', 'Subrubro', '', '', '', '', '', '', '', '', 'Unidad'],
        colModel: [
                    { name: 'Edit', index: 'Edit', width: 50, align: 'left', sortable: false, search: false, hidden: true },
                    { name: 'IdArticulo', index: 'IdArticulo', width: 1, align: 'left', sortable: false, search: false, hidden: true },
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
            copiarArticulo(id);
        },
        loadComplete: function () {
            grid = $("ListaDrag");
        },
        pager: '#ListaDragPager', // $(),
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
    jQuery("#ListaDrag").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $('#ListaDrag2').jqGrid({
        url: ROOT + 'Requerimiento/Requerimientos_DynamicGridData',
        postData: {
            'FechaInicial': function () { return $("#FechaInicial").val(); },
            'FechaFinal': function () { return $("#FechaFinal").val(); },
            'IdObra': function () { return $("#IdObra").val(); },
            'bAConfirmar': function () {
                return $('#bAConfirmar').is(":checked");
            },
            'bALiberar': function () {
                return $('#bALiberar').is(":checked");
            }
        },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', '', 'IdRequerimiento', 'Numero', 'Fecha', 'Vs', 'Cump.', 'Recep.', 'Entreg.', 'Impresa', 'Detalle', 'Obra', 'Presupuestos', 'Comparativas', 'Pedidos', 'Recepciones',
                   'Salidas', 'Items', 'Liberado por', 'Fecha aprobacion', 'Solicito', 'Sector', 'Equipos destino', 'Usuario anulo', 'Fecha anulacion', 'Motivo anulacion', 'Tipo compra',
                   'Comprador', 'Fechas liberacion para compra', 'Detalle imputacion', 'Observaciones', 'Circ. firmas completo', 'Firmas'],
        colModel: [
                    { name: 'act', index: 'act', align: 'center', width: 50, sortable: false, editable: false, search: false, frozen: true, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                    { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, frozen: true, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                    { name: 'IdRequerimiento', index: 'IdRequerimiento', align: 'left', width: 0, editable: false, hidden: true, frozen: true },
                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 80, editable: false, frozen: true, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'FechaRequerimiento', index: 'FechaRequerimiento', width: 100, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false, frozen: false },
                    { name: 'NumeradorEliminacionesFirmas', index: 'NumeradorEliminacionesFirmas', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Recepcionado', index: 'Recepcionado', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Entregado', index: 'Entregado', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Impresa', index: 'Impresa', align: 'center', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Detalle', index: 'Detalle', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Obra', index: 'Obra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Presupuestos', index: 'Presupuestos', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Comparativas', index: 'Comparativas', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Pedidos', index: 'Pedidos', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Recepciones', index: 'Recepciones', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Salidas', index: 'Salidas', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'CantidadItems', index: 'CantidadItems', width: 50, align: 'right', editable: false, frozen: true, search: true, searchoptions: { sopt: ['eq'] } },
                    { name: 'LiberadoPor', index: 'LiberadoPor', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: [''] } },
                    { name: 'FechaAprobacion', index: 'FechaAprobacion', width: 100, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false, frozen: false },
                    { name: 'SolicitadaPor', index: 'SolicitadaPor', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Sector', index: 'Sector', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'EquipoDestino', index: 'EquipoDestino', width: 100, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'UsuarioAnulacion', index: 'UsuarioAnulacion', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'FechaAnulacion', index: 'FechaAnulacion', width: 100, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false, frozen: false },
                    { name: 'MotivoAnulacion', index: 'MotivoAnulacion', width: 300, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'TipoCompra', index: 'TipoCompra', width: 200, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Comprador', index: 'Comprador', width: 150, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'FechasLiberacionCompra', index: 'FechasLiberacionCompra', width: 200, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'DetalleImputacion', index: 'DetalleImputacion', width: 200, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Observaciones', index: 'Observaciones', width: 300, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'CircuitoFirmasCompleto', index: 'CircuitoFirmasCompleto', width: 80, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Firmas', index: 'Firmas', width: 300, align: 'left', editable: false, search: true, searchoptions: { sopt: ['cn'] } }

        ],
        ondblClickRow: function (id) {
            copiarRM(id);
        },
        loadComplete: function () {
            grid = $("ListaDrag2");
        },
        pager: $('#ListaDragPager2'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroRequerimiento', // 'FechaRecibo,NumeroRecibo',
        sortorder: 'desc',
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
    });
    jQuery("#ListaDrag").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    });

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Articulos');
    $('a#a_panel_este_tab2').text('Requerimientos');

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

    function copiarArticulo(id) {
        try {
            jQuery('#Lista').jqGrid('saveCell', lastSelectediRow, lastSelectediCol);
        } catch (e) {
            LogJavaScript("Error en Script copiarArticulo   ", e);
        }

        GrabarGrillaLocal()

        var acceptId = id;
        var getdata = $("#ListaDrag").jqGrid('getRowData', acceptId);
        var j = 0, tmpdata = {}, dropname;
        var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');
        var prox = ProximoNumeroItem();
        try {
            tmpdata['IdArticulo'] = getdata['IdArticulo'];
            tmpdata['Codigo'] = getdata['Codigo'];
            tmpdata['Descripcion'] = getdata['Descripcion'];
            tmpdata['OrigenDescripcion'] = 1;
            var now = new Date();
            var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
            tmpdata['FechaEntrega'] = currentDate;
            tmpdata['IdUnidad'] = getdata['IdUnidad'];
            tmpdata['Unidad'] = getdata['Unidad'];
            tmpdata['IdDetalleRequerimiento'] = 0;
            tmpdata['Cantidad'] = 0;
            tmpdata['NumeroItem'] = prox++;
            getdata = tmpdata;
        } catch (e) { }

        var idazar = Math.ceil(Math.random() * 1000000);
        // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
        ///////////////
        // paso 1: borrar el renglon vacío de yapa que agrega el D&D (pero no el dblClick) -pero cómo sabés que estás en modo D&D?
        ///////////////
        var segundorenglon = $($("#Lista")[0].rows[1]).attr("id")
        // var segundorenglon = $($("#Lista")[0].rows[pos+2]).attr("id") // el segundo renglon
        //alert(segundorenglon);
        if (segundorenglon.indexOf("dnd") != -1) {
            // tiró el renglon en modo dragdrop, no hizo dobleclic
            $("#Lista").jqGrid('delRowData', segundorenglon);
        }
        //var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
        //var data = $('#Lista').jqGrid('getRowData', dataIds[1]);
        ///////////////
        // paso 2: agregar en el ultimo lugar antes de los renglones vacios
        ///////////////
        //acá hay un problemilla... si el tipo está usando el DnD, se crea un renglon libre arriba de todo...

        var pos = TraerPosicionLibre();
        if (pos == null) {
            $("#Lista").jqGrid('addRowData', idazar, getdata, "first")
        }
        else {
            $("#Lista").jqGrid('addRowData', idazar, getdata, "after", pos); // como hago para escribir en el primer renglon usando 'after'? paso null?
        }
        //$("#Lista").jqGrid('addRowData', idazar, getdata, "last");
        // http: //stackoverflow.com/questions/8517988/how-to-add-new-row-in-jqgrid-in-middle-of-grid
        // $("#Lista").jqGrid('addRowData', grid, getdata, 'first');  // usar por ahora 'first'   'after' : 'before'; 'last' : 'first';
        //resetAltRows.call(this);
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
        //RefrescarOrigenDescripcion();

        AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });
    }

    function copiarRM(id) {
        var longitud, i;

        jQuery('#Lista').jqGrid('saveCell', lastSelectediRow, lastSelectediCol);

        GrabarGrillaLocal()

        var acceptId = id;
        var getdata = $("#ListaDrag2").jqGrid('getRowData', acceptId);
        var j = 0, tmpdata = {}, dropname, IdRequerimiento;
        var dropmodel = $("#ListaDrag2").jqGrid('getGridParam', 'colModel');
        var grid;
        try {
            IdRequerimiento = getdata['IdRequerimiento'];

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Requerimiento/RequerimientoSinFormato/',
                data: { IdRequerimiento: IdRequerimiento },
                dataType: "Json",
                success: function (data) {
                    i = 0;
                    $("#Observaciones").val(data[i].Observaciones);
                    $("#LugarEntrega").val(data[i].LugarEntrega);
                    $("#IdObra").val(data[i].IdObra);
                    $("#Obra").val(data[i].Obra);
                    $("#IdSector").val(data[i].IdSector);
                    $("#Sector").val(data[i].Sector);
                    $("#Detalle").val(data[i].Detalle);
                    $("#IdTipoCompra").val(data[i].IdTipoCompra);
                    $("#TipoCompra").val(data[i].TipoCompra);
                    $("#IdEquipoDestino").val(data[i].IdEquipoDestino);
                    $("#EquipoDestino").val(data[i].EquipoDestino);
                }
            });

            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Requerimiento/DetRequerimientosSinFormato/',
                data: { IdRequerimiento: IdRequerimiento },
                dataType: "Json",
                success: function (data) {
                    var prox = ProximoNumeroItem();
                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        tmpdata['IdDetalleRequerimiento'] = 0;
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['Codigo'] = data[i].Codigo;
                        tmpdata['Articulo'] = data[i].Articulo;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        tmpdata['Unidad'] = data[i].Unidad;
                        tmpdata['Cantidad'] = data[i].CantidadPendiente;
                        tmpdata['Observaciones'] = data[i].Observaciones;
                        tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
                        tmpdata['TiposDeDescripcion'] = data[i].TiposDeDescripcion;
                        tmpdata['IdControlCalidad'] = data[i].IdControlCalidad;
                        tmpdata['DescripcionControlCalidad'] = data[i].DescripcionControlCalidad;
                        tmpdata['ArchivoAdjunto1'] = data[i].ArchivoAdjunto1;
                        tmpdata['ArchivoAdjunto2'] = data[i].ArchivoAdjunto2;
                        tmpdata['ArchivoAdjunto3'] = data[i].ArchivoAdjunto3;
                        tmpdata['ArchivoAdjunto4'] = data[i].ArchivoAdjunto4;
                        tmpdata['ArchivoAdjunto5'] = data[i].ArchivoAdjunto5;
                        tmpdata['ArchivoAdjunto6'] = data[i].ArchivoAdjunto6;
                        tmpdata['ArchivoAdjunto7'] = data[i].ArchivoAdjunto7;
                        tmpdata['ArchivoAdjunto8'] = data[i].ArchivoAdjunto8;
                        tmpdata['ArchivoAdjunto9'] = data[i].ArchivoAdjunto9;
                        tmpdata['ArchivoAdjunto10'] = data[i].ArchivoAdjunto10;

                        tmpdata['NumeroItem'] = prox;

                        var now = new Date();
                        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                        tmpdata['FechaEntrega'] = currentDate;

                        prox++;
                        getdata = tmpdata;
                        var idazar = Math.ceil(Math.random() * 1000000);

                        var segundorenglon = $($("#Lista")[0].rows[1]).attr("id")
                        if (segundorenglon.indexOf("dnd") != -1) {
                            $("#Lista").jqGrid('delRowData', segundorenglon);
                        }
                        var pos = TraerPosicionLibreRM();
                        if (pos == null) {
                            $("#Lista").jqGrid('addRowData', idazar, getdata, "first")
                        }
                        else {
                            $("#Lista").jqGrid('addRowData', idazar, getdata, "after", pos); // como hago para escribir en el primer renglon usando 'after'? paso null?
                        }
                    }
                    //RefrescarOrigenDescripcion();
                    //BorrarRenglonesVacios();
                    AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });
                }
            });
        } catch (e) { }
    }


    ////////////////////////////////////////////////////////// CHANGES //////////////////////////////////////////////////////////

    //$("#IdPuntoVenta").change(function () {
    //    TraerNumeroComprobante()
    //});

    $('#fileupload').fileupload({
        dataType: 'json',
        url: ROOT + 'Home/UploadFiles',
        autoUpload: true,
        done: function (e, data) {
            //var i = ProximoAdjuntoLibre();
            //if (i == 0) {
            //    alert("No hay mas adjuntos disponibles");
            //    return
            //}
            //$("#ArchivoAdjunto" + i).val(data.result.name)

            var i, data, data2;
            var rowid = $('#Lista').getGridParam('selrow');

            if (rowid == null) {
                alert("No selecciono el item donde agregar el adjunto");
                return
            }

            data2 = $('#Lista').jqGrid('getRowData', rowid);

            for (i = 1; i <= 10; i++) {
                if (data2['ArchivoAdjunto'+i].length == 0) {
                    $('#Lista').jqGrid('setCell', rowid, 'ArchivoAdjunto' + i, data.result.name);
                    break
                }
            }
            if (i > 10) { alert("No hay mas adjuntos disponibles para el item seleccionado") }
        }
    }).on('fileuploadprogressall', function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('.progress .progress-bar').css('width', progress + '%');
    });

    ////////////////////////////////////////////////////////// SERIALIZACION //////////////////////////////////////////////////////////

    function SerializaForm() {
        saveEditedCell("");

        calculaTotal();

        var cm, colModel, dataIds, data1, data2, valor, iddeta, i, j, nuevo, BienesOServicios="";

        var cabecera = $("#formid").serializeObject();

        cabecera.IdRequerimiento = $("#IdRequerimiento").val();
        cabecera.NumeroRequerimiento = $("#NumeroRequerimiento").val();
        cabecera.FechaRequerimiento = $("#FechaRequerimiento").datepicker("getDate");
        cabecera.LugarEntrega = $("#LugarEntrega").val();
        cabecera.Observaciones = $("#Totales").find("#Observaciones").val();
        cabecera.IdObra = $("#IdObra").val();
        cabecera.IdSector = $("#IdSector").val();
        cabecera.IdSolicito = $("#IdSolicito").val();
        cabecera.Aprobo = $("#Aprobo").val();
        cabecera.Detalle = $("#Detalle").val();
        cabecera.Cumplido = $("#Cumplido").val();
        cabecera.FechaAnulacion = $("#FechaAnulacion").val();
        cabecera.UsuarioAnulacion = $("#UsuarioAnulacion").val();
        cabecera.MotivoAnulacion = $("#MotivoAnulacion").val();

        cabecera.DetalleRequerimientos = [];
        $grid = $('#Lista');
        nuevo = -1;
        colModel = $grid.jqGrid('getGridParam', 'colModel');
        dataIds = $grid.jqGrid('getDataIDs');
        for (i = 0; i < dataIds.length; i++) {
            try {
                data = $grid.jqGrid('getRowData', dataIds[i]);
                iddeta = data['IdDetalleRequerimiento'];
                if (!iddeta) {
                    iddeta = nuevo;
                    nuevo--;
                }

                data1 = '{"IdDetalleRequerimiento":"' + iddeta + '",';
                data1 = data1 + '"IdRequerimiento":"' + $("#IdRequerimiento").val() + '",';
                for (j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') {
                        valor = data[cm.name];
                        if (valor.substring(0, 2) == "<a") {
                            valor = valor.split(">")[1].split("<")[0]
                            };
                        data1 = data1 + '"' + cm.index + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetalleRequerimientos.push(data2);
            }
            catch (ex) {
                alert("SerializaForm(): No se pudo serializar el comprobante." + ex);
                return;
            }
        };

        return cabecera;
    }

    $('#grabar2').click(function () {
        calculaTotal()

        var cabecera = SerializaForm();

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Requerimiento/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify({ Requerimiento: cabecera }),
            success: function (result) {
                if (result) {
                    $('html, body').css('cursor', 'auto');
                    window.location = (ROOT + "Requerimiento/Edit/" + result.IdRequerimiento);
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

    //idaux = $("#IdRequerimiento").val();
    //if (idaux <= 0) {
    //    ActivarControles(true);
    //} else {
    //    ActivarControles(false);
    //}
});

function ActualizarDatos() {
    var IdCodigoIva = 0, Letra = "B", id = 0, IdRequerimiento = 0;

    calculaTotal();
}

calculaTotal = function () {
    var dataIds = $('#Lista').jqGrid('getDataIDs'); 
    var totalCantidad = 0;

    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        var cant = parseFloat(data['Cantidad'].replace(",", ".")) || 0;
        totalCantidad += cant;
    }

    $('#Lista').jqGrid('footerData', 'set', { NumeroItem: 'TOTAL', Cantidad: totalCantidad });
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
        $("#FechaRequerimiento").prop("disabled", true);
        //jQuery("input[name='BienesOServicios']").each(function (i) {
        //    jQuery(this).prop("disabled", true);
        //})
    }
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
    var radiohtml='';
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

function GrabarGrillaLocal() {
    var $this = $('#Lista')
    var ids = $this.jqGrid('getDataIDs'), i, l = ids.length;

    for (i = 0; i < l; i++) {
        try {
            var rowdata = $('#Lista').jqGrid('saveRow', ids[i]);
        } catch (e) {
            $('#Lista').jqGrid('restoreRow', ids[i]);
            continue;
        }
    }
}

function BorrarRenglonesVacios() {
    var grid = jQuery("#Lista")
    var rows = $("#Lista").getGridParam("reccount");
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

        if (data['Articulo'] == "") {
            var item = $($("#Lista")[0].rows[1]).attr("id")
            $("#Lista").jqGrid('delRowData', item);
        }
    }
}

function TraerPosicionLibreRM() {
    var grid = jQuery("#Lista")
    var rows = $("#Lista").getGridParam("reccount");
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        var desc = data['Articulo'];
        if (desc == "") break;
    }

    if (i == 0) return null;
    if (i == dataIds.length) i = dataIds.length - 1;

    return $($("#Lista")[0].rows[i]).attr("id");
}
