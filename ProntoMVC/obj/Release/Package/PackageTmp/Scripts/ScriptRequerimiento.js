

"use strict";

///////////////////////////////////////////////////////////////////////////



var UltimoIdUnidad
var UltimoIdArticulo
var UltimoDescUnidad
var UltimoIdControlCalidad

var inEdit

var lastColIndex;
var lastRowIndex;
var lastSelectedId;


function calculateTotal() {
    //        var totalCantidad = grid.jqGrid('getCol', 'Cantidad', false, 'sum') || 0;

    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos

    var totalCantidad = 0;

    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);


        var cant = parseFloat(data['Cantidad'].replace(",", ".")) || 0;
        totalCantidad += cant;
    }



    $('#Lista').jqGrid('footerData', 'set', { NumeroItem: 'TOTAL', Cantidad: totalCantidad });

};


function initDateEdit(elem) {
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


function RefrescarRestoDelRenglon(rowid, name, val, iRow, iCol) {




    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
    var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);


    var cm = jQuery("#Lista").jqGrid("getGridParam", "colModel");
    var colName = cm[iCol]['index'];
    //alert(colName);


    switch (colName) {



    }


    if (colName == "ControlCalidad") {
        //  alert(colName);

        data['IdControlCalidad'] = UltimoIdControlCalidad;
        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

        FinRefresco();
        //         return;

        //        $.post(ROOT + 'ControlCalidad/GetControlCalidadesAutocomplete',
        //                 { term: val },
        //                   function (data) {
        //                       if (data.length > 0) {
        //                           var ui = data[0];
        //                           //alert(ui.IdControlCalidad);
        //                           data['IdControlCalidad'] = ui.value;

        //                           $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
        //                           FinRefresco();
        //                       }

        //                   }

        //            );
    }

    else if (colName == "Unidad") {

        data['IdUnidad'] = UltimoIdUnidad
        data['Unidad'] = UltimoDescUnidad
        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

        FinRefresco();
        //         return;

        //        $.post(ROOT + 'Articulo/Unidades',  // ?term=' + val
        //                {term: val }, // JSON.stringify(val)},
        //                function (data) {
        //                    if (data.length > 0) {

        //                    el tema es que esta accion no es autocomplete, trae todas las unidades

        //                        var ui = data[0];
        //                        alert(ui.IdUnidad);
        //                        data['IdUnidad'] = ui.IdUnidad;

        //                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
        //                        FinRefresco();
        //                    }
        //                }
        //        );
    }



    else if (colName == "Codigo") {

        //alert(iCol);
        //  if (iCol == 12) {   // esto siempre y cuando el cambio haya sido del nombre de articulo


        $.post(ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',  // ?term=' + val
                {term: val }, // JSON.stringify(val)},
                function (data) {
                    if (data.length > 0) {
                        var ui = data[0];
                        //alert(ui.value);



                        //var data = $('#Lista').jqGrid('getRowData', iRow);



                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);



                        data['IdArticulo'] = ui.id;
                        data['Codigo'] = ui.codigo;
                        data['Descripcion'] = ui.title;
                        data['PorcentajeIVA'] = ui.iva;
                        data['IdUnidad'] = ui.IdUnidad;
                        data['Unidad'] = ui.Unidad;

                        data['IdDetalleRequerimiento'] = data['IdDetalleRequerimiento'] || 0;


                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
                    }
                    else {

                        // hay que cancelar la grabacion
                    }
                }
        );
    }


    else if (colName == "Descripcion") {   // esto siempre y cuando el cambio haya sido del nombre de articulo


//        data['IdArticulo'] = UltimoIdArticulo
//        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon


        $.post(ROOT + 'Articulo/GetArticulosAutocomplete2',  // ?term=' + val
                {term: val }, // JSON.stringify(val)},
                function (data) {
                    if (data.length > 0) {
                        var ui = data[0];
                        //alert(ui.value);



                        //var data = $('#Lista').jqGrid('getRowData', iRow);


                
                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);



                        data['IdArticulo'] = ui.id;
                        data['Codigo'] = ui.codigo;
                        data['Descripcion'] = ui.title;
                        data['PorcentajeIVA'] = ui.iva;
                        data['IdUnidad'] = ui.IdUnidad;
                        data['Unidad'] = ui.Unidad;

                        data['IdDetalleRequerimiento'] = data['IdDetalleRequerimiento'] || 0;


                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

                        FinRefresco();
                    }
                    else {

                        // hay que cancelar la grabacion
                    }
                }
        );







        //        $.post(ROOT + 'Articulo/GetArticulosAutocomplete2',  // ?term=' + val
        //                {term: val }, // JSON.stringify(val)},
        //                function (data) {
        //                    if (data.length > 0) {
        //                        var ui = data[0];
        //                        // alert(ui.value);



        //                        //var data = $('#Lista').jqGrid('getRowData', iRow);



        //                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
        //                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

        //                        data['IdArticulo'] = ui.id;
        //                        data['Codigo'] = ui.codigo;
        //                        data['PorcentajeIVA'] = ui.iva;
        //                        data['IdUnidad'] = ui.IdUnidad;
        //                        data['Unidad'] = ui.Unidad;

        //                        data['IdDetalleRequerimiento'] = data['IdDetalleRequerimiento'] || 0;

        //                        var now = new Date();
        //                        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
        //                        if (data['FechaEntrega'] == "") data['FechaEntrega'] = currentDate;

        //                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
        //                        FinRefresco();
        //                    }
        //                    else {

        //                        // hay que cancelar la grabacion
        //                    }
        //                }
        //        );

    }
    else if (colName == "Cantidad") { }

    else {
     //   alert(colName);
    }

}



function FinRefresco() {
    calculateTotal();
    RefrescarOrigenDescripcion();
    AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

}


function RefrescarRenglon(x) {

    //    if ($("#editmodLista").attr('aria-hidden') == undefined || $("#editmodLista").attr('aria-hidden') == 'true') {
    //        $("#Lista [aria-selected='true'] [name='IdUnidad']").val(x.value);
    //    }
    //    else {
    //        $('#IdUnidad').val(x.value);
    //    }


}


















function SerializaForm() {

    var colModel = jQuery("#Lista").jqGrid('getGridParam', 'colModel');
    var cabecera = { "IdRequerimiento": "", "NumeroRequerimiento": "", "FechaRequerimiento": "", "LugarEntrega": "", "Observaciones": "", "IdObra": "", "IdSector": "", "IdSolicito": "",
        "Aprobo": "", "Detalle": "", "Cumplido": "", "FechaAnulacion": "", "UsuarioAnulacion": "", "MotivoAnulacion": "", "DetalleRequerimientos": []
    };

    var cm, data1, data2, valor;

    cabecera.IdRequerimiento = $("#IdRequerimiento").val();
    cabecera.NumeroRequerimiento = $("#NumeroRequerimiento").val();
    cabecera.FechaRequerimiento = $("#FechaRequerimiento").datepicker("getDate");
    // cabecera.FechaRequerimiento = $("#FechaRequerimiento").val();
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

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        try {
            try {
                $('#Lista').jqGrid('saveRow', dataIds[i], false, 'clientArray');
            } catch (e) {
                $('#Lista').jqGrid('restoreRow', dataIds[i]);
                continue;
            }

            var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

            var iddeta = data['IdDetalleRequerimiento'];
            //alert(iddeta);
            if (!iddeta) continue;


            data1 = '{"IdRequerimiento":"' + $("#IdRequerimiento").val() + '",'
            for (var j = 0; j < colModel.length; j++) {
                cm = colModel[j]
                if (cm.label === 'TB') {
                    valor = data[cm.name];

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

                    if (cm.name.indexOf("Fecha") !== -1) valor = $.datepicker.formatDate("yy/mm/dd", $.datepicker.parseDate("dd/mm/yy", valor));

                    if (cm.name === 'Cantidad') valor = valor.replace(".", ",");

                    if (cm.name === 'ArchivoAdjunto1') valor = "";

                    if (cm.name === 'Observaciones') {
                        //     s = 0
                    }

                    try {
                        // replace() solo reemplaza la primera aparicion !!!!!!!!
                        // http://stackoverflow.com/questions/1144783/replacing-all-occurrences-of-a-string-in-javascript

                        valor = replaceAll('"', '\\"', valor);
                        valor = replaceAll('\t', '\\t', valor);
                        valor = replaceAll('\n', '\\n', valor);
                        //                                   valor = valor.replace('\t', '\\t');
                        //                                   valor = valor.replace('\n', '\\n');
                        //                                   valor = valor.replace('\r', '\\r');
                        // http://stackoverflow.com/questions/983451/where-can-i-find-a-list-of-escape-characters-required-for-my-json-ajax-return-ty
                    } catch (e) {
                        //    
                    }
                    //          



                    if (cm.name === 'Cumplido' && cabecera.Cumplido === 'AN') valor = 'AN'


                    // if (cm.name === 'IdControlCalidad') valor = 'AN'



                    data1 = data1 + '"' + cm.name + '":"' + valor + '",';


                }
            }
            data1 = data1.substring(0, data1.length - 1) + '}';
            data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
            data2 = JSON.parse(data1);
            cabecera.DetalleRequerimientos.push(data2);
        }
        catch (ex) {
            $('#Lista').jqGrid('restoreRow', dataIds[i]);
            alert("No se pudo grabar el comprobante. " + ex);
            return;
        }
    }


    return cabecera;
}




$(function () {




    //        $("body").on({
    //            ajaxStart: function () {
    //                $(this).addClass("loading");
    //            },
    //            ajaxStop: function () {
    //                $(this).removeClass("loading");
    //            }
    //        });  






    var dobleclic
    var headerRow, rowHight, resizeSpanHeight;
    var grid = $("#Lista")


    pageLayout.show('east', true);
    pageLayout.open('east');


    pageLayout.options.center.onresize = function () { RefrescaAnchoGrillaDetalle(); };


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






    $("#FechaRequerimiento").datepicker({
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd/mm/yy'
        //numberOfMonths: 2,
    });

    //Para que haga wrap en las celdas
    $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');
    //$.jgrid.formatter.integer.thousandsSeparator=',';

    function radioFormatter(cellvalue, options, rowObject) {
        var radioName = "radio" + rowObject.id;
        if (cellvalue == null) {
            cellvalue = false;
        }
        return "<input type='radio' name='" + radioName + "' value='" + cellvalue + "'/>";
    };

    function unformatRadio(cellvalue, options) {
        var value = $(cellvalue).val();
        if (value == undefined) {
            value = false;
        }
        return value;
    }





    $('#Lista').jqGrid({
        url: ROOT + 'Requerimiento/DetRequerimientos/',
        postData: { 'IdRequerimiento': function () { return $("#IdRequerimiento").val(); } },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdDetalleRequerimiento', 'IdArticulo', 'IdUnidad', '#', 'Cant.', 'Un.', 'Codigo',
                     'Artículo', 'Descripción', 'Entrega', 'Observaciones',
                       'Cump', 'Adjunto', 'OrigenDescripcion', '', 'IdCalidad', 'Calidad'],
        colModel: [
                        { formoptions: { rowpos: 1, colpos: 1 }, name: 'act', index: 'act', align: 'centre',
                            width: 30,
                             hidden: true, sortable: false, editable: false

                         , formatter: 'actions',
                            formatoptions: {
                                editformbutton: false,
                                editbutton: false, 
                                delbutton: true,
                                keys: false
                            }
                        },

                        { formoptions: { rowpos: 1, colpos: 2 }, name: 'IdDetalleRequerimiento', index: 'IdDetalleRequerimiento', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false} },
                        { formoptions: { rowpos: 2, colpos: 1 }, name: 'IdArticulo', index: 'IdArticulo', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: true} },
                        { formoptions: { rowpos: 2, colpos: 2 }, name: 'IdUnidad', index: 'IdUnidad', label: 'TB',
                            align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
                        },
        //{ name: 'Eliminado', index: 'Eliminado', label:'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true} },


                        {name: 'NumeroItem'
                            , formoptions: { rowpos: 3, colpos: 1 }
                            , index: 'NumeroItem'
                            , label: 'TB', align: 'center', width: 40,
                        editable: true, edittype: 'text',
                        editrules: { readonly: 'readonly' }
                    },
        ////////////////////////////////////////////
        // http://www.trirand.com/jqgridwiki/doku.php?id=wiki:predefined_formatter
                        {name: 'Cantidad', formoptions: { rowpos: 9, colpos: 1 }, index: 'Cantidad', label: 'TB', align: 'right', width: 60,
                        editable: true, edittype: 'text', editoptions: { maxlength: 20 }, editrules: { required: true }


                        // formatter:'number', formatoptions: {decimalSeparator:".", thousandsSeparator: "", decimalPlaces: 4}
                        //formatter:'currency', formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 2, prefix: "$ ",defaultValue: '0.00'}
                        // formatter: numFormat, unformat: numUnformat  
                    }, //, unformat:numUnformat
        ////////////////////////////////////////////
                        {name: 'Unidad', formoptions: { rowpos: 9, colpos: 2 }, index: 'Unidad', align: 'left',
                        width: 60, editable: true, edittype: 'select', editrules: { required: true },
                        editoptions: { dataUrl: ROOT + 'Articulo/Unidades',
                            dataEvents: [{ type: 'change', fn: function (e) {

                                RefrescarRenglon(this);
                                //  UltimoIdArticulo=ui.item.id;
                                UltimoIdUnidad = this.value;
                                $('#IdUnidad').val(this.value);
                                //UltimoDescUnidad
                            }
                            }]


                        }

                    },



                        { name: 'Codigo', formoptions: { rowpos: 5, colpos: 1 }, index: 'Codigo', align: 'left',
                            width: 100, editable: true, edittype: 'text',
                            editoptions: {
                                dataInit: function (elem) {
                                    var NoResultsLabel = "No Results"; // http://stackoverflow.com/questions/8663189/jquery-autocomplete-no-result-message

                                    $(elem).autocomplete({
                                        source: ROOT + "Articulo/GetCodigosArticulosAutocomplete2", minLength: 0,
                                        select: function (event, ui) {
                                            if (ui.item.label === NoResultsLabel) {
                                                event.preventDefault();
                                            }
                                            else {
                                                $("#IdArticulo").val(ui.item.id);
                                                $("#Descripcion").val(ui.item.title);
                                                //                                                $("#IdUnidad").val(ui.item.idunidad || 1);
                                                //                                                $("#Unidad").val(ui.item.idunidad || 1);

                                                $("#IdUnidad").val(ui.item.IdUnidad);
                                                $("#Unidad").val(ui.item.IdUnidad);

                                                UltimoIdArticulo = ui.item.id;
                                                UltimoIdUnidad = ui.item.IdUnidad;


                                                // $("#IdUnidad").val(ui.item.IdUnidad|| 1);
                                                // $("#Unidad").attr("value", ui.item.IdUnidad|| 1);

                                            }
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
                                            .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + " " + item.title + "</b></span></a>")
                                            .appendTo(ul);
                                    };
                                }
                            },
                            editrules: { required: false }
                        },
                        { formoptions: { rowpos: 6, colpos: 2 }, name: 'DescripcionFalsa', index: '', editable: false, width: 400
                            , hidden: true //lo pongo en hidden porque edu me aclara que no juntamos la descripcion + observacion en el abm, solo en la impresion
                            , editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
                        },

                        { name: 'Descripcion', formoptions: { rowpos: 5, colpos: 2, label: "Descripción" }, index: 'Descripcion', align: 'left', width: 450,
                            hidden: false,
                            editable: true, edittype: 'text',
                            editoptions: { rows: '1', cols: '1',
                                dataInit: function (elem) {
                                    $(elem).autocomplete({ source: ROOT + "Articulo/GetArticulosAutocomplete2", minLength: 0,
                                        select: function (event, ui) {



                                            $("#IdArticulo").val(ui.item.id);
                                            $("#Codigo").val(ui.item.codigo);
                                            $("#IdUnidad").val(ui.item.IdUnidad);
                                            //$("#Unidad").val(ui.item.Unidad);
                                            $("#Unidad").val(ui.item.IdUnidad); // hay que ponerle el id para elegir el item... por eso es que cuando salis del form en la celda queda con el id como texto...  no?

                                            UltimoIdArticulo = ui.item.id;
                                            UltimoIdUnidad = ui.item.IdUnidad;


                                            // if ($("#IdUnidad") == null) $("#Unidad").val(ui.item.IdUnidad);  mvarIdUnidadCU

                                        }
                                    })
                                    .data("ui-autocomplete")._renderItem = function (ul, item) {
                                        return $("<li></li>")
                                            .data("ui-autocomplete-item", item)
                                            .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + " [" + item.codigo + "]</b></span></a>")
                                            .appendTo(ul);
                                    };
                                }
                            },
                            editrules: { required: true }
                        },
        //{ name: 'Descripcion', index: 'Descripcion', align: 'left', width: 300, editable: true, edittype: 'select', editoptions: { dataUrl: '@Url.Action("Articulos")' }, editrules: { required: true} },
                        {name: 'FechaEntrega', formoptions: { rowpos: 3, colpos: 2 }, index: 'FechaEntrega', label: 'TB', width: 250, align: 'center', sorttype: 'date', editable: true,
                        formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: true }
                    },
        //                        { name: 'Adjunto', index: 'Adjunto', align: 'left', width: 67, align: 'center', formatter: 'checkbox', editable: true, edittype: 'checkbox', hidden: true, 
        //                            editoptions: { value: "True:False", //value: 'Yes:No', defaultValue: 'Si', 
        //                                            dataEvents: [{ type: 'change', fn: function (e) {
        //                                                                var thisval=$(e.target).val();
        //                                                                if( $(this).is(':checked')) {$("#ArchivoAdjunto1").show();}
        //                                                                else {$("#ArchivoAdjunto1").hide();} 
        //                                                                }
        //                                                         }] 
        //                                             }
        //                        }, 

        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////

                        {formoptions: { rowpos: 11, colpos: 1, label: 'Obs' }, name: 'Observaciones', index: 'Observaciones',

                        classes: "textInDiv", // http://stackoverflow.com/questions/13103544/how-to-restrict-jqgrid-textarea-height-in-grid-only
                        //                                formatter: function (v) {
                        //                                    return '<div>' + $.jgrid.htmlEncode(v) + '</div>';
                        //                                },
                        label: 'TB', align: 'left', editable: true
                        ///////////////////////////////////////////////////////////
                        /////////////////////////////////////////////////////////
                         , edittype: 'text'  // para que no deforme el inline, 
                        // ,hidden: true  //aparecerá en el form pero no en la grilla, tal como la columna Descripcion
                        ///////////////////////////////////////////////////////////
                        // , edittype: 'textarea'
                               , width: 300
                        ///////////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////////
                        , editoptions: { rows: '4', cols: '40' }



                    },



        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////




                        {formoptions: { rowpos: 21, colpos: 1 }, name: 'Cumplido', index: 'Cumplido', label: 'TB', align: 'center', width: 50, sortable: false, editable: false },
                        { name: 'ArchivoAdjunto1', index: 'ArchivoAdjunto1', label: 'TB', align: 'left', width: 100, editable: true, edittype: 'file',
                            formoptions: { rowpos: 22, colpos: 1 },
                            editoptions: { enctype: "multipart/form-data", dataEvents: [{ type: 'change', fn: function (e) {
                                var thisval = $(e.target).val();
                                //var filed=$('#ArchivoAdjunto1').attr('value');
                                if ($(this).val() != "") {
                                    $("#Adjunto").checked = true;
                                }
                                else {
                                    $("#Adjunto").checked = false;
                                }
                            }
                            }]
                            }
                        },
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////

        // radio buttons en el popup del jqgrid
        // http://www.trirand.com/jqgridwiki/doku.php?id=wiki:common_rules#custom
                    {

                    name: 'OrigenDescripcion', label: 'TB'
                            , formoptions: { rowpos: 11, colpos: 2, label: "Tomar la descripción de" }
                            , index: 'OrigenDescripcion',
                    align: 'center', width: 35, editable: true, hidden: true, edittype: 'select', // edittype: 'custom',
                    // formatter: radioFormatter, unformat: unformatRadio,
                    editrules: { required: true
                        //                                      , readonly: ( (OrigenDescripcionDefault==3 || true) ?  'readonly' : ''  )                , disabled: 'disabled'
                    },
                    editoptions: {
                        //                         readonly: true,
                        //   disabled:  ( (OrigenDescripcionDefault==3 ) ?  'disabled' : ''  )  ,
                        defaultValue: OrigenDescripcionDefault,
                        value: "1:Solo el material; 2:Solo las observaciones; 3:Material mas observaciones", size: 3
                        //,
                        //     custom_element: myelem, custom_value: myvalue
                    }

                }


        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
                , { name: 'IdRequerimiento', index: 'IdRequerimiento', label: 'TB', hidden: true }

                , { formoptions: { rowpos: 2, colpos: 2 }, name: 'IdControlCalidad', index: 'IdControlCalidad', label: 'TB', hidden: true
                    //                    align: 'left', width: 85, editable: true, hidden: true, 
                    //                    editoptions: { disabled: 'disabled' }, 
                    //                            editrules: { edithidden: true, required: true }
                }

               , { name: 'ControlCalidad', formoptions: { rowpos: 12, colpos: 2 }, index: 'ControlCalidad', align: 'center', label: '',
                   width: 150, editable: true, edittype: 'select', editrules: { required: false },
                   editoptions: { dataUrl: ROOT + 'ControlCalidad/ControlCalidades', //  ROOT + 'ControlCalidad/ControlCalidadParaCombo',


                       // $("#IdUnidad").val(ui.item.IdUnidad|| 1);
                       // $("#Unidad").attr("value", ui.item.IdUnidad|| 1);



                       dataEvents: [{ type: 'change', fn: function (e) {

                           $('#IdControlCalidad').val(this.value);
                           UltimoIdControlCalidad = this.value;

                           RefrescarRenglon(this);

                       }
                       }]


                   }

               },
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////



                    ],


        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        onSelectRow: function (id, status, e) {
            if (dobleclic) {
                dobleclic = false;
                return;
            }


            if (id && id !== lastSelectedId) {
                if (typeof lastSelectedId !== "undefined") {
                    grid.jqGrid('restoreRow', lastSelectedId);
                }

                jQuery('#Lista').restoreRow(lastSelectedId);  // para inline
                lastSelectedId = id;
            }

            // ver qu� columna es
            // jQuery('#Lista').editRow(id, true);  // para inline


        },

        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
            lastRowIndex = iRow;
            lastColIndex = iCol;
        },


        ondblClickRow: function (id) {



            //////////////////////////////////////////////////////
            //////////////////////////////////////////////////////
            //            if (typeof lastSelectedId !== "undefined") {
            //                // grid.jqGrid('saveRow', lastSelectedId);
            //                grid.jqGrid('restoreRow', lastSelectedId);
            //            }


            // http://stackoverflow.com/questions/9508882/how-to-close-cell-editor
            // http://www.trirand.com/jqgridwiki/doku.php?id=wiki:cell_editing


            jQuery('#Lista').jqGrid('restoreCell', lastRowIndex, lastColIndex, true);

            //            var ids = jQuery("#Lista").getChangedCells('dirty'); // .jqGrid('getDataIDs');
            //            for (var i = 0; i < ids.length; i++) {



            //                grid.jqGrid('restoreRow', ids[i]);
            //            }

            //////////////////////////////////////////////////////
            //////////////////////////////////////////////////////



            dobleclic = true;
            //$("#edtData").click();

            EditarItem(id);
        },

        onClose: function (data) {
            RefrescarOrigenDescripcion();
        },


        afterEditCell: function (rowid, cellname, value, iRow, iCol) {

            var $input = $("#" + iRow + "_" + cellname);
            $input.select(); // acá me marca el texto

            //http://jsfiddle.net/ironicmuffin/7dGrp/
            //http://fiddle.jshell.net/qLQRA/show/

            // alert('hola'); 
        },

        afterSaveCell: function (rowid, name, val, iRow, iCol) {


            RefrescarRestoDelRenglon(rowid, name, val, iRow, iCol);
        },


        beforeSaveCell: function (rowid, name, val, iRow, iCol) {

            // RefrescarRestoDelRenglon
        },











        beforeShowForm: function (form) {


            /// PopupCentrar()??????

            //            var dlgDiv = $("#editmod" + grid[0].id);
            //            var parentDiv = dlgDiv.parent(); // div#gbox_list
            //            var dlgWidth = dlgDiv.width();
            //            var parentWidth = parentDiv.width();
            //            var dlgHeight = dlgDiv.height();
            //            var parentHeight = parentDiv.height();
            //            // TODO: change parentWidth and parentHeight in case of the grid
            //            //       is larger as the browser window
            //            dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2) + "px";
            //            dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2) + "px";



        },







        gridComplete: function () {
            var ids = jQuery("#Lista").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                var be = "<input style='height:22px;width:20px;' type='button' value='E' onclick=\"jQuery('#Lista').editRow('" + cl + "',true,pickdates);\"  />";
                var se = "<input style='height:22px;width:20px;' type='button' value='S' onclick=\"jQuery('#Lista').saveRow('" + cl + "');\"  />";
                var ce = "<input style='height:22px;width:20px;' type='button' value='C' onclick=\"jQuery('#Lista').restoreRow('" + cl + "');\" />";
                jQuery("#Lista").jqGrid('setRowData', ids[i], { act: be + se + ce });
                //                    jQuery("#Lista").jqGrid('editRow', ids[i], false);
                calculateTotal();
            }

            RefrescarOrigenDescripcion();


            //return;

            //AgregarRenglonesEnBlanco();

            for (var i = 0; i < ids.length; i++) {
                // http: //stackoverflow.com/questions/17818891/disable-a-row-in-jqgrid
                var row = jQuery("#Lista").jqGrid('getRowData', ids[i]);

                if (row.Cumplido == "SI") {
                    //alert(row.Cumplido);
                    // $(row).addClass('not-editable-row');
                    $('#' + ids[i]).addClass('not-editable-row');
                }

            }

            return;


        },

        loadComplete: function (data) {
            //seleccionar primer renglon

            if (true) {
                $("#Lista").jqGrid('setSelection', $("#Lista").getDataIDs()[0]);
                AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

                var $this = $(this), ids = $this.jqGrid('getDataIDs'), i, l = ids.length;
                for (i = 0; i < l; i++) {
                    //       $this.jqGrid('editRow', ids[i], true);
                }
            }

            //            rows = $("#Lista").getGridParam("reccount");
            //            if (rows >= 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

        },
        //            pager: $('#ListaPager'),



        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        rowNum: 100,
        rowList: [10, 20, 50, 100],
        sortname: 'NumeroItem',
        sortorder: 'asc',
        viewrecords: true,

        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        height: '200px', // 'auto',
        altRows: false,

        footerrow: true,
        userDataOnFooter: true

           , rownumbers: false
        , multiselect: true


        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        // http://stackoverflow.com/questions/14662632/jqgrid-celledit-in-json-data-shows-url-not-set-alert
         ,
        cellEdit: true,
        cellsubmit: 'clientArray'
        , editurl: ROOT + 'Requerimiento/EditGridData/' // pinta que esta es la papa: editurl con la url, y cellsubmit en clientarray
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////




        //,
        //loadonce: true,
        // caption: '<b>ITEMS DEL REQUERIMIENTO</b>'
    });

    //        jQuery("#grid_id").jqGrid('navGrid',pagerid, {});
    //jQuery("#grid_id").jqGrid('inlineNav',pagerid, parameters);



    //        http: //stackoverflow.com/questions/11387621/how-to-handle-resize-event-with-a-resize-bar


    /*
    myLayout = $('body').layout({
    onresize: function () {
    alert('whenever anything on layout is redrawn.')
    }
    })
    */




    $("#BuscadorPanelDerecho").change(function () {


        var grid = jQuery("#ListaDrag");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                   searchField: 'Descripcion', // Codigo
                   searchOper: 'contains',
                   searchString: $("#BuscadorPanelDerecho").val()
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);


        var grid = jQuery("#ListaDrag2");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                   searchField: 'NumeroRequerimiento', // Codigo
                   searchOper: 'eq',
                   searchString: $("#BuscadorPanelDerecho").val()
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);

    });




    $(window).bind('resize', function () {
        $("#Lista").setGridWidth($(window).width());
    }).trigger('resize');





    function myelem(value, options) {
        var el = document.createElement("input");
        el.type = "text";
        el.value = value;
        return el;
    }

    function myvalue(elem, operation, value) {
        if (operation === 'get') {
            return $(elem).val();
        } else if (operation === 'set') {
            $('input', elem).val(value);
        }
    }

    function numUnformat(cellvalue, options, rowObject) {
        return cellvalue.replace(",", ".");
    }

    function numFormat(cellvalue, options, rowObject) {
        return cellvalue.replace(".", ",");
    }


    //    $("#Lista").jqGrid("inlineNav", "#pager", { addParams: { position: "last"} }); //para que los nuevos renglones aparezcan al final (MODO INLINE)
    // $("#Lista").jqGrid('FormToGrid', rowid, formid, mode, position); //para que los nuevos renglones aparezcan al final (MODO FORM)

    $("#addData").click(function () {
        dobleclic = true;
        jQuery("#Lista").jqGrid('editGridRow', "new",
                { addCaption: "", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false,
                    //                addParams: { position: "last"},
                    closeOnEscape: true,
                    closeAfterAdd: true,
                    recreateForm: true,
                    beforeShowForm: function (form) {

                        GrabarGrillaLocal();
                        PopupCentrar();

                        $('#tr_IdDetalleRequerimiento', form).hide();
                        $('#tr_IdArticulo', form).hide();
                        $('#tr_IdUnidad', form).hide();
                    },
                    beforeInitData: function () {
                        inEdit = false;
                    },
                    onInitializeForm: function (form) {
                        $('#IdDetalleRequerimiento', form).val(0);
                        $('#NumeroItem', form).val(ProximoNumeroItem());
                        $('#NumeroItem').attr('readonly', 'readonly');


                        /////////////////////////////////////////////////////////////////////////////////


                        var now = new Date();
                        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();

                        //$('#OrigenDescripcion', form).val( OrigenDescripcionDefault);
                        //                    $('#OrigenDescripcion', form).val('Material mas observaciones');
                        //                    $('#OrigenDescripcion', form).val('3');


                        $('#FechaEntrega', form).val(currentDate);
                        $('#Cantidad', form).val(1);
                        $('#Unidad', form).val(1);
                        //                      mvarAux = BuscarClaveINI("Dias default para fecha necesidad en RM")
                        //                      If Len(mvarAux) > 0 Then
                        //                         DTFields(0).Value = DateAdd("d", Val(mvarAux), Me.FechaRequerimiento)
                        //                      Else
                        //                         DTFields(0).Value = Date
                        //                      End If
                    },

                    onClose: function (data) {
                        GrabarGrillaLocal()
                        RefrescarOrigenDescripcion();
                        PonerRenglonesInline();
                        //jQuery('#Lista').saveRow(id, true); 
                    }

                });
    });





    $("#edtData").click(function () {

        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        EditarItem(gr)


    });




    $("#delData").click(function () {
        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        if (gr != null) {
            //jQuery("#Lista").jqGrid('setRowData',gr,{Eliminado:"true"});
            //$("#"+gr).hide();  
            if (false) {
                jQuery("#Lista").jqGrid('delGridRow', gr, { caption: "Borrar", msg: "Elimina el registro seleccionado?",
                    bSubmit: "Borrar", bCancel: "Cancelar", width: 300, closeOnEscape: true, reloadAfterSubmit: false
                });
            }
            else {

                var $grid = $("#Lista");
                var righe = $grid.jqGrid("getGridParam", "selarrrow");

                if ((righe == null) || (righe.length == 0)) {
                    return false;
                }


                for (var i = righe.length - 1; i >= 0; i--) {
                    $grid.delRowData(righe[i]);
                }


            }
        }
        else alert("Debe seleccionar un item!");
    });







    $('#grabar2').click(function () {

        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);


        var cabecera = SerializaForm();


        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Requerimiento/BatchUpdate',   // '@Url.Action("BatchUpdate", "Requerimiento")',
            dataType: 'json',
            data:  //  $.toJSON(cabecera),
                        JSON.stringify(cabecera),
            success: function (result) {
                if (result) {
                    $('#Lista').trigger('reloadGrid');

                    $('html, body').css('cursor', 'auto');
                    //  window.location = (ROOT + "Requerimiento/index");
                    window.location = (ROOT + "Requerimiento/Edit/" + result.IdRequerimiento);

                } else {


                    alert('No se pudo grabar el comprobante.');
                    $('.loading').html('');

                    $('html, body').css('cursor', 'auto');
                    $('#grabar2').attr("disabled", false).val("Aceptar");
                }






            },



            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $("#loading").show();
                $('#grabar2').attr("disabled", true).val("Espere...");




            },
            complete: function () {
                $("#loading").hide();
            },
            //                error: function (xhr, textStatus, exceptionThrown) {
            //                try {
            //                    var errorData = $.parseJSON(xhr.responseText);
            //                    var errorMessages = [];
            //                    //this ugly loop is because List<> is serialized to an object instead of an array
            //                    for (var key in errorData) {
            //                        errorMessages.push(errorData[key]);
            //                    }
            //                    $('#result').html(errorMessages.join("<br />"));

            //                    $('html, body').css('cursor', 'auto');
            //                    $('#grabar2').attr("disabled", false).val("Aceptar");
            //                    alert(errorMessages.join("<br />"));
            //                } catch (e) {
            //    // http://stackoverflow.com/questions/15532667/asp-netazure-400-bad-request-doesnt-return-json-data
            //                   // si tira error de Bad Request en el II7, agregar el asombroso   <httpErrors existingResponse="PassThrough"/>
            //                    
            //                    $('html, body').css('cursor', 'auto');
            //                    $('#grabar2').attr("disabled", false).val("Aceptar");
            //                    alert(xhr.responseText);
            //                }
            //                


            //                }



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
                    //alert(errorMessages.join("<br />"));

                    // $("#textoMensajeAlerta").html(errorMessages.join("<br />"));
                    //$('#result').html(errorMessages.join("<br />"));
                    //$("#textoMensajeAlerta").html(xhr.responseText);
                    $("#textoMensajeAlerta").html(errorData.Errors.join("<br />"));
                    $("#mensajeAlerta").show();
                } catch (e) {
                    // http://stackoverflow.com/questions/15532667/asp-netazure-400-bad-request-doesnt-return-json-data
                    // si tira error de Bad Request en el II7, agregar el asombroso   <httpErrors existingResponse="PassThrough"/>

                    $('html, body').css('cursor', 'auto');
                    $('#grabar2').attr("disabled", false).val("Aceptar");


                    //alert(xhr.responseText);


                    $("#textoMensajeAlerta").html(xhr.responseText);
                    $("#mensajeAlerta").show();
                }







            }





        });
    });

    jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });

    // get the header row which contains
    headerRow = grid.closest("div.ui-jqgrid-view")
            .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

    // increase the height of the resizing span
    resizeSpanHeight = 'height: ' + headerRow.height() + 'px !important; cursor: col-resize;';
    headerRow.find("span.ui-jqgrid-resize").each(function () {
        this.style.cssText = resizeSpanHeight;
    });

    // set position of the dive with the column header text to the middle
    rowHight = headerRow.height();
    headerRow.find("div.ui-jqgrid-sortable").each(function () {
        var ts = $(this);
        ts.css('top', (rowHight - ts.outerHeight()) / 2 + 'px');
    });

    $("#ListaDrag").jqGrid({
        url: ROOT + "Articulo/ArticulosGridData2",
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['IdArticulo', 'Codigo', 'Material', 'IdUnidad', 'Un.'],
        colModel: [
                        { name: 'IdArticulo', index: 'IdArticulo', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Codigo', index: 'Codigo', width: 100, align: 'left', search: true, stype: 'text' },
                        { name: 'Descripcion', index: 'Descripcion', width: 3000, align: 'left', search: true, stype: 'text',
                            editable: false, edittype: 'text', editoptions: { maxlength: 250 }, editrules: { required: true }
                        },
                        { name: 'IdUnidad', index: 'IdUnidad', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Unidad', index: 'Unidad', width: 100, align: 'left', search: true, stype: 'text' },
            ],
        ondblClickRow: function (id) {
            copiarArticulo(id);
        },

        loadComplete: function () {
            grid = $("ListaDrag");
            // $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'Descripcion',
        sortorder: "asc",
        viewrecords: true,




        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,


        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar'
        //,
        // caption: '<b>Artículos</b>'
    })

    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    // jQuery("#ListaDrag").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });

    // $("#ListaDrag").filterToolbar();
    $("#ListaDrag").setFrozenColumns();






    var prmSearch = { multipleSearch: false, overlay: true, sopt: ["cn"], width: 500, closeOnEscape: true, closeAfterSearch: true };


    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Requerimiento/Requerimientos',
        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; }, 'IdObra': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'Acciones', 'IdRequerimiento', 'N°', 'Fecha', 'Cump.', 'Recep.', 'Entreg.', 'Impresa', 'Detalle', 'Obra', 'Presupuestos', 'Comparativas',
                       'Pedidos', 'Recepciones', 'Salidas', 'Libero', 'Solicito', 'Sector', 'Usuario_anulo', 'Fecha_anulacion', 'Motivo_anulacion', 'Fechas_liberacion',
                       'Observaciones', 'Lugar de necesidad', 'IdObra', 'IdSector'],
        colModel: [
                        { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'act', index: 'act', align: 'center', width: 0, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'IdRequerimiento', index: 'IdRequerimiento', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'FechaRequerimiento', index: 'FechaRequerimiento', width: 80, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Recepcionado', index: 'Recepcionado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Entregado', index: 'Entregado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Impresa', index: 'Impresa', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Detalle', index: 'Detalle', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'NumeroObra', index: 'NumeroObra', align: 'left', width: 155, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Presupuestos', index: 'Presupuestos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Comparativas', index: 'Comparativas', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Pedidos', index: 'Pedidos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Recepciones', index: 'Recepciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Salidas', index: 'Salidas', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Libero', index: 'Libero', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: [''] }, hidden: true },
                        { name: 'Solicito', index: 'Solicito', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Sector', index: 'Sector', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Usuario_anulo', index: 'Usuario_anulo', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Fecha_anulacion', index: 'Fecha_anulacion', align: 'center', width: 75, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Motivo_anulacion', index: 'Motivo_anulacion', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Fechas_liberacion', index: 'Fechas_liberacion', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'LugarEntrega', index: 'LugarEntrega', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdObra', index: 'IdObra', align: 'left', width: 200, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdSector', index: 'IdSector', align: 'left', width: 200, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn']} }
                    ],

        ondblClickRow: function (id) {
            //$("#ListaDrag2").jqGrid('gridDnD', 'ondrop');
            // $('#ListaDrag2').trigger("ondrop");
            copiarRM(id);
        },
        loadComplete: function () {
            grid = $("ListaDrag2");
            // $("#ListaDrag2 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });

            AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

            // rows = $("#Lista").getGridParam("reccount");
            //if (rows >= 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

        },

        pager: $('#ListaDragPager2'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroRequerimiento',
        sortorder: "desc",
        viewrecords: true,

        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,

        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar'
        //,            caption: '<b>REQUERIMIENTOS</b>'
    })

    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2',
         { refresh: true, add: false, edit: false, del: false }, {}, {}, {},
          prmSearch);

    //$("#ListaDrag2").filterToolbar();
    $("#ListaDrag2").setFrozenColumns();
    // jQuery("#ListaDrag2").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });




    ///////////////////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    // buscador aparte

    var grid22 = $("#ListaDrag2")
    //            // create the searching dialog
    //        grid22.searchGrid(prmSearch);

    //        // find the div which contain the searching dialog
    var searchDialog = $("#fbox_" + grid22[0].id);

    //        // make the searching dialog non-popup
    //        searchDialog.css({position:"relative", "z-index":"auto"})

    var dlgDiv = $("#fbox_" + grid22[0].id);

    var parentDiv = dlgDiv.parent(); // div#gbox_list
    var dlgWidth = dlgDiv.width();
    var parentWidth = parentDiv.width();
    var dlgHeight = dlgDiv.height();
    var parentHeight = parentDiv.height();

    var left = (screen.width / 2) - (dlgWidth / 2) + "px";
    var top = (screen.height / 2) - (dlgHeight / 2) + "px";

    try {
        dlgDiv[0].style.top = top; // 500; // Math.round((parentHeight - dlgHeight) / 2) + "px";
        dlgDiv[0].style.left = left; //Math.round((parentWidth - dlgWidth) / 2) + "px";

    } catch (e) {

    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////      ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////



    //    // make grid2 sortable
    //    $("#Lista").jqGrid('sortableRows', {
    //        update: function () {
    //            //resetAltRows.call(this.parentNode);
    //        }
    //    });


    $("#IdSolicito").change(function () {
        // ActualizarSector();
    });


    function ActualizarSector() {
        var IdObra = $('#IdObra').val();
        $.getJSON(ROOT + 'Requerimiento\Obras',
                        { IdObra: IdObra },
                        function (cities) {
                            if (cities.length == 0) {
                                // nonononon, lo que pasa es que aca no deberia dejar elegir un punto de venta que no permite la condicion iva
                                // en otras palabras, no tendría que darse nunca esta posiblidad
                                // alert('Elija otro punto de venta');
                                //                                $('#PuntoVenta').val('');
                                //                                $('#NumeroFactura').val('');
                                //                                $('#TipoABC').val('-');
                                return;
                            }
                            var p = cities[0].sector;
                            $('#IdSector').val(p);
                            var l = cities[0].solicito;
                            $('#IdSolicito').val(l);
                        }
            );
        calculateTotal();
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////

    $("#Aprobo").change(function () {
        var IdAprobo = $("#Aprobo > option:selected").attr("value");
        var Aprobo = $("#Aprobo > option:selected").html();
        $("#Aux1").val(IdAprobo);
        $("#Aux2").val(Aprobo);
        $("#Aux3").val("");
        $("#Aux10").val("");
        $('#dialog-password').data('Combo', 'Aprobo');
        $('#dialog-password').dialog('open');
        $('#mySelect').focus(); // esto es clave, para que no me cierre el cuadro de dialogo al recibir un posible enter apretado en el change
    });

    $("#anular").click(function () {
        $("#Aux1").val("");
        $("#Aux2").val("");
        $("#Aux3").val("");
        $("#Aux10").val("anularRM");
        $('#dialog-password').dialog('open');
        $('#mySelect').focus(); // esto es clave, para que no me cierre el cuadro de dialogo al recibir un posible enter apretado en el change
    });


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Artículos');
    $('a#a_panel_este_tab2').text('Requerimientos');
    $('a#a_panel_este_tab3').hide();

    ConectarGrillas1();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });

    $('#a_panel_este_tab2').click(function () {
        ConectarGrillas2();
    });








    RefrescaAnchoGrillaDetalle();



    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: ROOT + 'Requerimiento/Autorizaciones/',
        data: { IdRequerimiento: $("#IdRequerimiento").val() },
        dataType: "Json",
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                var j = i + 1;
                $("#chk" + j).attr('checked', true);
                $("#chk" + j).attr('title', data[i].Nombre);
            }


        }
    });
    Aprobado();

    function Aprobado() {
        if ($('#Aprobo').val() != "") {
            //if ($('#FechaAprobacion').val() != null) {
            $("#chk0").attr('checked', true);
            var Aprobo = $("#Aprobo > option:selected").html();
            $("#chk0").attr('title', Aprobo);
        }
        else {
            $("#chk0").attr('checked', false);
            $("#chk0").attr('title', "");
        }
    }


    // vuelvo a llenar el mySelect (se hace por primera vez en el Layout) porque no sé qué pasa que algo me lo vacía
    $.post(ROOT + 'Empleado/EmpleadosParaCombo/',
            function (data) {
                var select = $('#mySelect').empty();
                for (var i = 0; i < data.length; i++) {
                    select.append('<option value="' + data[i].IdEmpleado + '">' + data[i].Nombre + '</option>');
                }
            }, "json");



    function pickdates(id) {
        jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
    }

    function formEdit() {
        $('input[name=rdEditApproach]').attr('disabled', true);
        $('#Lista').navGrid(
                '#Lista',
        //enabling buttons
                {add: true, del: true, edit: true, search: false },
        //edit option
                {width: 'auto' },
        //add options
                {width: 'auto', url: '/Home/AddProduct/' },
        //delete options
                {url: '/Home/DeleteProduct/' });
    };








    function getColumnIndexByName(grid, columnName) {
        var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
        for (i = 0; i < l; i++) {
            if (cm[i].name === columnName) {
                return i; // return the index
            }
        }
        return -1;
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

    if ($("#IdRequerimiento").val() <= 0) {
        $("#anular").attr('disabled', 'disabled');
    }
    else {
    }

    if ($("#Cumplido").val() == "AN") {
        $(":input").attr("disabled", "disabled");
        $("#RManulada").html("RM ANULADA el " + $("#FechaAnulacion").val() + ", Motivo : " + $("#MotivoAnulacion").val() + ", Usuario : " + $("#UsuarioAnulacion").val());
        $("#RManulada").show();
    }

    function ConectarGrillas1() {
        // connect grid1 with grid2
        $("#ListaDrag").jqGrid('gridDnD', {
            connectWith: '#Lista', //drag_opts:{stop:null},
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                        .addClass("ui-state-error ui-widget")
                        .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            beforedrop: function (ev, ui, getdata, $source, $target) {
                //                var names = $target.jqGrid('getCol', 'name2');
                //                if ($.inArray(getdata.name2, names) >= 0) {
                //                    // prevent data for dropping
                //                    ui.helper.dropped = false;
                //                    alert("The row is already in the destination grid");
                //                }
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");
                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                var j = 0, tmpdata = {}, dropname;
                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                var prox = ProximoNumeroItem();
                try {
                    //					for (var key in getdata) {
                    //						if(getdata.hasOwnProperty(key) && dropmodel[j]) {
                    //							dropname = dropmodel[j].name;
                    //							tmpdata[dropname] = getdata[key];
                    //						}
                    //						j++;
                    //					}
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
                var grid;
                grid = Math.ceil(Math.random() * 1000000);
                // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
                $("#" + this.id).jqGrid('addRowData', grid, getdata);
                //resetAltRows.call(this);
                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
                RefrescarOrigenDescripcion();

            }
        });
    }





    function ProximoNumeroItem() {
        //  return jQuery("#Lista").jqGrid('getGridParam', 'records')   + 1;

        var totalCantidad = grid.jqGrid('getCol', 'NumeroItem', false, 'max')
        return (totalCantidad || 0) + 1;
    }


    function ConectarGrillas2() {
        var grid = $("#ListaDrag2");

        $("#ListaDrag2").jqGrid('gridDnD', {
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
                var j = 0, tmpdata = {}, dropname, IdRequerimiento;
                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                var grid;
                try {
                    $("#Observaciones").val(getdata['Observaciones']);
                    $("#LugarEntrega").val(getdata['LugarEntrega']);
                    $("#IdObra").val(getdata['IdObra']);
                    $("#IdSector").val(getdata['IdSector']);

                    IdRequerimiento = getdata['IdRequerimiento'];
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
                                tmpdata['IdArticulo'] = data[i].IdArticulo;
                                tmpdata['Codigo'] = data[i].Codigo;
                                tmpdata['Descripcion'] = data[i].Descripcion;
                                tmpdata['IdUnidad'] = data[i].IdUnidad;
                                tmpdata['Unidad'] = data[i].Unidad;
                                tmpdata['IdDetalleRequerimiento'] = 0;

                                tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
                                tmpdata['Cantidad'] = data[i].Cantidad;
                                tmpdata['Observaciones'] = data[i].Observaciones;
                                tmpdata['NumeroItem'] = prox;

                                var now = new Date();
                                var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                                tmpdata['FechaEntrega'] = currentDate;

                                prox++;
                                getdata = tmpdata;
                                grid = Math.ceil(Math.random() * 1000000);
                                $("#Lista").jqGrid('addRowData', grid, getdata);
                            }
                            RefrescarOrigenDescripcion();
                        }
                    });
                } catch (e) { }
                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
            }

        });
    }



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    function copiarArticulo(id) {

        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        GrabarGrillaLocal()



        var acceptId = id;
        var getdata = $("#ListaDrag").jqGrid('getRowData', acceptId);
        var j = 0, tmpdata = {}, dropname;
        var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');
        var prox = ProximoNumeroItem();
        try {
            //					for (var key in getdata) {
            //						if(getdata.hasOwnProperty(key) && dropmodel[j]) {
            //							dropname = dropmodel[j].name;
            //							tmpdata[dropname] = getdata[key];
            //						}
            //						j++;
            //					}
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
        var grid;
        grid = Math.ceil(Math.random() * 1000000);
        // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
        $("#Lista").jqGrid('addRowData', grid, getdata);
        //resetAltRows.call(this);
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
        RefrescarOrigenDescripcion();

        AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

        //        rows = $("#Lista").getGridParam("reccount");
        //        if (rows >= 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

    }

    function copiarRM(id) {

        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        GrabarGrillaLocal()

        var acceptId = id;
        var getdata = $("#ListaDrag2").jqGrid('getRowData', acceptId);
        var j = 0, tmpdata = {}, dropname, IdRequerimiento;
        var dropmodel = $("#ListaDrag2").jqGrid('getGridParam', 'colModel');
        var grid;
        try {
            $("#Observaciones").val(getdata['Observaciones']);
            $("#LugarEntrega").val(getdata['LugarEntrega']);
            $("#IdObra").val(getdata['IdObra']);
            $("#IdSector").val(getdata['IdSector']);

            IdRequerimiento = getdata['IdRequerimiento'];
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
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['Codigo'] = data[i].Codigo;
                        tmpdata['Descripcion'] = data[i].Descripcion;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        tmpdata['Unidad'] = data[i].Unidad;
                        tmpdata['IdDetalleRequerimiento'] = 0;

                        tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
                        tmpdata['Cantidad'] = data[i].Cantidad;
                        tmpdata['Observaciones'] = data[i].Observaciones;
                        tmpdata['NumeroItem'] = prox;

                        var now = new Date();
                        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                        tmpdata['FechaEntrega'] = currentDate;

                        prox++;
                        getdata = tmpdata;
                        grid = Math.ceil(Math.random() * 1000000);
                        $("#Lista").jqGrid('addRowData', grid, getdata);
                    }
                    RefrescarOrigenDescripcion();

                    AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

                    //                    rows = $("#Lista").getGridParam("reccount");
                    //                    if (rows >= 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

                }
            });
        } catch (e) { }
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////



});





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



function RefrescarOrigenDescripcion() {

    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos


    for (var i = 0; i < dataIds.length; i++) {


        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);


        if (!data['IdDetalleRequerimiento']) {
            //$("#Lista").jqGrid('delGridRow', dataIds[i]);
            continue;
        }

        if (!data['IdArticulo']) {
            //$("#Lista").jqGrid('delGridRow', dataIds[i]);
            continue;
        }


        // if (OrigenDescripcionDefault == 3) { data['OrigenDescripcion'] = 3 };



        var tipoDesc = data['OrigenDescripcion'] || 1;
        var sDesc = data['Descripcion'];
        var sObs = data['Observaciones'];


        ///////////////////////////////////////////

        // "0:Solo el material; 1:Solo las observaciones; 2:Material mas observaciones"

        if (tipoDesc == 1 || tipoDesc == "Solo el material") {
            data['DescripcionFalsa'] = sDesc;
        }
        else if (tipoDesc == 2 || tipoDesc == "Solo las observaciones") {
            data['DescripcionFalsa'] = sObs;
        }
        else if (tipoDesc == 3 || tipoDesc == "Material mas observaciones") {
            data['DescripcionFalsa'] = sDesc + ' ' + sObs;
        }

        $('#Lista').jqGrid('setRowData', dataIds[i], data); // vuelvo a grabar el renglon
        //$('#Lista').jqGrid('saveRow', dataIds[i]);
    }

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




function EditarItem(rowid) {
    var gr = rowid; // jQuery("#Lista").jqGrid('getGridParam',  'selrow');
    var row = jQuery("#Lista").jqGrid('getRowData', rowid);

    if (row.Cumplido == "SI") {
        alert("El item ya está cumplido")
        return;
    }

    if (gr != null) jQuery("#Lista")
                                    .jqGrid('editGridRow', gr,
                                                { editCaption: "", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800
                                                    , reloadAfterSubmit: false, closeOnEscape: true,
                                                    closeAfterEdit: true, recreateForm: true, Top: 0,
                                                    beforeShowForm: function (form) {
                                                        GrabarGrillaLocal();

                                                        PopupCentrar();

                                                        $('#NumeroItem').attr('readonly', 'readonly');

                                                        $('#tr_IdDetalleRequerimiento', form).hide();
                                                        $('#tr_IdArticulo', form).hide();
                                                        $('#tr_IdUnidad', form).hide();
                                                    },
                                                    beforeInitData: function () {
                                                        inEdit = true;
                                                    }
                                                 ,
                                                    onClose: function (data) {
                                                        RefrescarOrigenDescripcion();
                                                        PonerRenglonesInline();
                                                        // jQuery('#Lista').editRow(gr, true);
                                                    }

                                                });
    else alert("Debe seleccionar un item!");

}


function PopupCentrar() {
    var grid = $("#Lista");
    var dlgDiv = $("#editmod" + grid[0].id);

    $("#editmod" + grid[0].id).find('.ui-datepicker-trigger').attr("class", "btn btn-primary");

    //            $("#editmod" + grid[0].id + " [type=button]").attr("class", "btn btn-primary");
    //            $(":button").attr("class", "btn btn-primary");
    $("#editmod" + grid[0].id).find('#FechaEntrega').width(160);

    $("#editmod" + grid[0].id).find('.ui-datepicker-trigger').attr("class", "btn btn-primary");
    $("#sData").attr("class", "btn btn-primary");
    $("#sData").css("color", "white");
    $("#sData").css("margin-right", "20px");
    $("#cData").attr("class", "btn");

    //            $("#editmod" + grid[0].id).find(":hr").remove();

    $("#editmod" + grid[0].id).find('.ui-icon-disk').remove();
    $("#editmod" + grid[0].id).find('.ui-icon-close').remove();

    //                    $("#sData").addClass("btn");
    //                    $("#cData").addClass("btn");


    var parentDiv = dlgDiv.parent(); // div#gbox_list
    var dlgWidth = dlgDiv.width();
    var parentWidth = parentDiv.width();
    var dlgHeight = dlgDiv.height();
    var parentHeight = parentDiv.height();

    var left = (screen.width / 2) - (dlgWidth / 2) + "px";
    var top = (screen.height / 2) - (dlgHeight / 2) + "px";

    dlgDiv[0].style.top = top; // 500; // Math.round((parentHeight - dlgHeight) / 2) + "px";
    dlgDiv[0].style.left = left; //Math.round((parentWidth - dlgWidth) / 2) + "px";

}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
