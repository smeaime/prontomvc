
"use strict";



var ListaReq;
var ListaReq1 = "";



var CalcularItem = function (value, colname) {
    if (colname === "Cantidad") {
        var rowid = $('#Lista').getGridParam('selrow');
        value = Number(value);
        var Cantidad = value;
        //$('#Lista').jqGrid('setCell', rowid, 'Cantidad', Cantidad[0]);
    }
    return [true];
};


function CargarDetalle() {

    /*
                        $("#Lista").jqGrid().setGridParam({
                            datatype: 'json',
                            traditional: true, //problemas al usar arrays en los parametros
                            ajaxDelOptions: {traditional: true},
                            mtype: 'POST' 
                        }).trigger("reloadGrid");
    
    */

    //  $("#Lista").html("");

    $('#Lista').jqGrid({

        url: ROOT + 'ValeSalida/DetValesSalidaSinFormatoSegunListaDeItemsDeRequerimientos',
        postData: { 'idDetalleRequerimientosString': ListaReq1 },


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
            AgregarRenglonesEnBlanco({ "IdDetalleValeSalida": "0", "IdArticulo": "0", "Articulo": "" }, "#Lista");
            //CargarDetalle();
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
    })
    //.then(function () {
    //CargarDetalle();
    //      });

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



}





$(document).ready(function () {



    $("#Vale").click(function () {    //$('#Vale').on('click', function () {



        var $grid = $("#ListaReq"), i, n;
        ListaReq = $grid.jqGrid("getGridParam", "selarrrow");
        if ((ListaReq == null) || (ListaReq.length == 0)) {
            ListaReq = [rowIdContextMenu];
            if ((ListaReq == null) || (ListaReq.length == 0)) {
                alert("No hay rms elegidas " + rowIdContextMenu);
                return;
            }
        }

        ListaReq1 = ""
        for (i = 0, n = ListaReq.length; i < n; i++) {
            ListaReq1 = ListaReq1 + ListaReq[i] + ",";
        }
        if (ListaReq1.length > 0) { ListaReq1 = ListaReq1.substring(1, ListaReq1.length - 1); }


        if (false) {

            //opcion con partial page


            $("#frmVale").dialog({
                autoOpen: true,
                position: { my: "center", at: "100", of: window },
                height: 750,
                width: 900,
                resizable: true,
                //title: 'Vale',
                modal: true,
                open: function () {
                    $("#frmVale").html("");





                    $.get(
                        ROOT + 'Requerimiento/PartialPage1', //esto es un vale, no una rm. pasa que el partial está en ese directorio -habría que renombrarlo al archivo... 
                        { idDetalleRequerimientos: ListaReq1 }, function (partialView) {
                            try {
                                $("#frmVale").html(partialView);
                            }
                            catch (err) {
                            }
                            //inicializar();

                            RefrescaAnchoJqgrids();
                            deshabilitarPanelesDerecho();





                        }).then(function () {
                            //alert("hola")

                            CargarDetalle();
                        });



                },
                buttons: {
                    //"Add User": function () {
                    //    //addUserInfo();
                    //    $(this).dialog("close");
                    //},
                    //"Cancelar": function () {
                    //    $(this).dialog("close");
                    //}
                }
            });
            return false;


        }
        else {
            // opcion redirigiendo al alta de Vale

            window.location.href = ROOT + "ValeSalida/EditPendientesRm/-1?ItemsDeRm=" + ListaReq1

        }



    });











});