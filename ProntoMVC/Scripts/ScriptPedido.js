
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// http://stackoverflow.com/questions/7169227/javascript-best-practices-for-asp-net-mvc-developers
// http://stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript el truco interesante de var DED = (function() {
// http://stackoverflow.com/questions/251814/jquery-and-organized-code?lq=1   una risa

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

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


////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

var mIdControlCalidadDefault = -1;
var mDescControlCalidadDefault = "rrr";


$(function () {

    $.post(ROOT + 'Articulo/GetParametro?param=IdControlCalidadDefault',
        {},
        function (data) {
            //alert(data);
            mIdControlCalidadDefault = data;
        }
    );

})

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

function RefrescarRestoDelRenglon(rowid, name, val, iRow, iCol) {

    //    alert('RefrescarRestoDelRenglon');
    /*

    ok, la cuestion es que, usando celledit (es decir, la edicion inline por celda, no por renglon entero), cuando cambio el valor
    dentro de un autocomplete, no puedo refrescar la celda adyacente de id porque no está en modo edicion. es decir, tendría que hacerlo
    una vez que pone enter, es decir, no en el evento 'select' del autocomplete creado dentro del editoptions de la columna, sino en el afterSaveCell general de la grilla. 
    Lo que pasa es... que en el evento select sí dispongo del id del elemento elegido. En cambio, en el afterSaveCell lo debo ir a buscar de nuevo, usando el texto
    que está en pantalla. El único problema con esto es si hay descripciones repetidas.
    -Bueno, pero tambien tengo que hacer un CASE para distinguir si me estan cambiando los articulos o las unidades, etc! 
    */

    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
    var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);


    var cm = jQuery("#Lista").jqGrid("getGridParam", "colModel");
    var colName = cm[iCol]['index'];
    //alert(colName);


    switch (colName) {



    }
    //    alert(colName);

    if (colName == "ControlCalidad") {
        //       alert(UltimoIdControlCalidad);
        data['IdControlCalidad'] = UltimoIdControlCalidad;
        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

        FinRefresco();
        // aleert('sss');
        //        $.post(ROOT + 'ControlCalidad/ControlCalidades',
        //                 { term: val },
        //                   function (data) {
        //                       if (data.length > 0) {
        //                           var ui = data[0];
        //                           data['IdControlCalidad'] = ui.IdControlCalidad;

        //                           $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
        //                           FinRefresco();
        //                       }

        //                   }

        //            );
    }



    else if (colName == "Unidad") {


        data['IdUnidad'] = UltimoIdUnidad
        //  data['Unidad'] = UltimoDescUnidad

        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

        FinRefresco();

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
            { term: val }, // JSON.stringify(val)},
            function (data) {
                if (data.length > 0) {
                    var ui = data[0];
                    //alert(ui.value);



                    //var data = $('#Lista').jqGrid('getRowData', iRow);

                    sacarDeEditMode(); // me salvó esto!! (porque en el caso de que aprieten TAB, no está bueno que quede una celda en edicion mientras estas grabando)

                    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                    var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);



                    data['IdArticulo'] = ui.id;
                    data['Codigo'] = ui.codigo;

                    //quizas el problema con el tab, es que estan pasando a un campo que recien fue modificado (desde 'codigo' hacia 'descripcion')
                    // -Aun sin cambiarlo acá, el textbox en 'descripcion' deja de tener autocomplete. se rompe hasta la siguiente edicion
                    // -Además, tambien pasa cuando va desde 'descripcion' a 'fecha de entrega', porque ahí te quedas sin el plugin de fecha
                    // Sospecho un poco de cuando agrega renglones justo antes de seguir -parece que no es eso: comenté el AgregarRenglones y sigue pasando

                    //alert(ui.title);
                    data['Descripcion'] = ui.title;
                    data['PorcentajeIVA'] = ui.iva;
                    data['IdUnidad'] = ui.IdUnidad;
                    data['Unidad'] = ui.Unidad;

                    data['IdDetalleRequerimiento'] = data['IdDetalleRequerimiento'] || 0;


                    $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon


                    FinRefresco();



                }
                else {



                    alert("No existe el código"); // se está bancando que no sea identica la descripcion
                    var ui = data[0];
                    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos

                    var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
                    data['Descripcion'] = "";
                    data['IdArticulo'] = 0;
                    data['Codigo'] = "";
                    data['Cantidad'] = 0;

                    $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon


                }
            }
        );
    }
    else if (colName == "Descripcion") {   // esto siempre y cuando el cambio haya sido del nombre de articulo


        //        data['IdArticulo'] = UltimoIdArticulo
        //        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon


        $.post(ROOT + 'Articulo/GetArticulosAutocomplete2',  // ?term=' + val
            { term: val }, // JSON.stringify(val)},
            function (data) {
                if (val != "No se encontraron resultados" && (data.length == 1 || data.length > 1)) { // qué pasa si encuentra más de uno?????
                    var ui = data[0];



                    sacarDeEditMode();

                    if (ui.value == "No se encontraron resultados") {


                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);

                        data['Descripcion'] = "";
                        data['IdArticulo'] = 0;
                        data['Codigo'] = "";
                        data['Cantidad'] = 0;

                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
                        return;
                    }

                    //var data = $('#Lista').jqGrid('getRowData', iRow);



                    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                    var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);



                    data['IdArticulo'] = ui.id;
                    data['Codigo'] = ui.codigo;
                    data['Descripcion'] = ui.value; // ui.title;
                    data['PorcentajeIVA'] = ui.iva;
                    data['IdUnidad'] = ui.IdUnidad;
                    data['Unidad'] = ui.Unidad;

                    data['IdDetalleRequerimiento'] = data['IdDetalleRequerimiento'] || 0;


                    $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

                    FinRefresco();
                }
                else {

                    alert("No existe el artículo " + val); // se está bancando que no sea identica la descripcion
                    var ui = data[0];
                    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                    if (true) {

                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
                        data['Descripcion'] = "";
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
        FinRefresco()
        //alert(colName);
    }
    /// ojito con lo que pones acá!, que las llamadas a post son asincrónicas y se ejecutarán probablemente antes de que terminen
    /// ojito con lo que pones acá!, que las llamadas a post son asincrónicas y se ejecutarán probablemente antes de que terminen
    /// ojito con lo que pones acá!, que las llamadas a post son asincrónicas y se ejecutarán probablemente antes de que terminen


}



function FinRefresco() {


    calculateTotal();
    RefrescarOrigenDescripcion();
    AgregarRenglonesEnBlanco({ "IdDetallePedido": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

}






function RefrescarOrigenDescripcion() {
    //    return;

    //alert('RefrescarOrigenDescripcion');

    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos


    for (var i = 0; i < dataIds.length; i++) {


        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);


        if (!data['IdDetalleRequerimiento']) {
            //$("#Lista").jqGrid('delGridRow', dataIds[i]);
            //continue;
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
    }

}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////


function RefrescarRenglon(x) {

    //    alert('RefrescarRenglon');
    //    return;
    if ($("#editmodLista").attr('aria-hidden') == undefined || $("#editmodLista").attr('aria-hidden') == 'true') {
        // modo inline
        $("#Lista [aria-selected='true'] [name='IdUnidad']").val(x.value);
    }
    else {
        // modo form
        $('#IdUnidad').val(x.value);
        $('#Unidad').val('asdasd');
        UltimoDescUnidad = $("#Unidad option:selected").text(); // modo form. en modo inline se llama distinta la celda
        //alert("RefrescarRenglon form " + UltimoDescUnidad);
    }


}




// total generales y del pie de la grilla
function calculateTotal() {




    var totalCantidad = $('#Lista').jqGrid('getCol', 'Cantidad', false, 'sum')

    var pr, cn, st, ib, ib_, ib_t, pi, ii, st1, ib1, ib2, ii1, st2, pb, st3, tp, tg;
    st1 = 0;
    ib1 = 0;
    ib2 = 0;
    ii1 = 0;

    var pbglobal = parseFloat($("#Totales").find("#PorcentajeBonificacion").val().replace(",", ".") || 0) || 0;

    if (isNaN(pb)) { pb = 0; }
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {

        if (dataIds[i] == "") continue;

        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

        var pb = parseFloat(data['PorcentajeBonificacion'].replace(",", ".") || 0) || 0; //este es del item


        var pr = parseFloat(data['Precio'].replace(",", ".") || 0) || 0;
        var cn = parseFloat(data['Cantidad'].replace(",", ".") || 0) || 0;
        var pi = parseFloat(data['PorcentajeIva'].replace(",", ".") || 0) || 0;
        var st = Math.round(pr * cn * 10000) / 10000;

        ///////////////////////////////////////////////////////
        st1 = Math.round((st1 + st) * 10000) / 10000;

        ///////////////////////////////////////////////////////
        //bonif item
        var ib = Math.round(st * pb / 100 * 10000) / 10000;
        st = st - ib;
        // bonif global
        var bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
        st = st - bg;
        ////////////////////////////////////////////////////

        var ii = Math.round(st * pi / 100 * 10000) / 10000;
        var it = Math.round((st + ii) * 10000) / 10000;







        //        // por qu� aplica el global sobre los items? est� bien? 
        //        // y si est� bien, no debe usarse a s� mismo (como en la linea ib = parseFloat(data['ImporteBonificacion']. etc)
        //        // porque si no, se va aplicando a s� mismo cada vez que editas el item
        data['ImporteBonificacion'] = ib.toFixed(4);
        data['ImporteIva'] = ii.toFixed(4);
        data['ImporteTotalItem'] = it.toFixed(4);

        ib1 = ib1 + ib;
        ib_ = Math.round((st - ib) * pbglobal / 100 * 10000) / 10000;
        ib2 = ib2 + ib_;
        ib_t = ib1 + ib_;

        ii1 = ii1 + ii
        tp = st - ib_t + ii;




        $('#Lista').jqGrid('setRowData', dataIds[i], data);
    }
    st2 = Math.round((st1 - ib1) * 10000) / 10000;
    st3 = Math.round((st2 - ib2) * 10000) / 10000;


    $("#Subtotal1").val(st1.toFixed(4));
    $("#TotalBonificacionItems").val(ib1.toFixed(4));
    //////////////////////////
    // $("#TotalBonificacionGlobal").val(ib2.toFixed(4)); // st1 - ib1 * pbglobal
    var hh = Math.round((st1 - ib1) * pbglobal / 100 * 10000) / 10000;
    $("#TotalBonificacionGlobal").val(hh.toFixed(4));
    /////////////////////////////
    st3 = Math.round((st1 - ib1 - hh) * 10000) / 10000;
    $("#Subtotal2").val(st3.toFixed(4));

    /////////////////////////////

    $("#TotalIva").val(ii1.toFixed(4));


    /////////////////////////////
    tg = Math.round((st3 + ii1) * 10000) / 10000;
    $("#Total").val(tg.toFixed(4));

    $("#Lista").jqGrid('footerData', 'set', {
        NumeroObra: 'TOTALES', Cantidad: totalCantidad.toFixed(2),
        ImporteBonificacion: ib1.toFixed(4),
        ImporteIva: ii1.toFixed(4),
        ImporteTotalItem: tg.toFixed(4)
    });
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




/////////////////////////////////////////////////////////////////////////////////////////////
// http: //stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

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




///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////






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






///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


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

    cabecera.CotizacionMoneda = $("#CotizacionMoneda").val().replace(".", ",");

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        try {


            var saveparameters = {
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



            var iddeta = data['IdDetallePedido'];
            //alert(iddeta);
            if (!iddeta) continue;



            data1 = '{"IdPedido":"' + $("#IdPedido").val() + '",'
            for (var j = 0; j < colModel.length; j++) {
                cm = colModel[j]
                if (cm.label === 'TB') {
                    valor = data[cm.name];






                    if (cm.name === 'Cantidad') valor = valor.replace(".", ",") // parseFloat(this.value).toFixed(2) valor.replace(",", ".").toFixed(2)
                    if (cm.name === 'Precio') valor = valor.replace(".", ",")
                    if (cm.name === 'PorcentajeBonificacion') valor = valor.replace(".", ",")  // parseFloat(valor) || 0;
                    if (cm.name === 'ImporteBonificacion') valor = valor.replace(".", ",")
                    if (cm.name === 'PorcentajeIva') valor = valor.replace(".", ",")
                    if (cm.name === 'ImporteIva') valor = valor.replace(".", ",")
                    if (cm.name === 'ImporteTotalItem') valor = valor.replace(".", ",")

                    if (cm.name === 'IdDetalleRequerimiento') valor = valor.replace(".", ",")
                    //if (cm.name === 'Observaciones') {
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

                    //}
                    if (cm.name === 'Adj. 1') {
                        valor = '';
                    }


                    if (cm.name.indexOf("Fecha") !== -1) {
                        try {
                            valor = $.datepicker.formatDate("yy/mm/dd", $.datepicker.parseDate("dd/mm/yy", valor));
                        } catch (e) {
                            $.post(ROOT + "Error/JSErrorHandler", { msg: "Error al formatear como fecha " + valor });
                            valor = null;
                        }

                    }

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

                    /////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////
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

$(function () {
    var dobleclic
    var headerRow, rowHight, resizeSpanHeight;
    var grid = $("#Lista")





    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////

    function DeSerializaForm() {
        var cm, data1, data2, valor;
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
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////


    function Validar() {



        //quiz�s no est� esperando que vuelva la llamada.....

        /////////////////////////////////////////////////////////////////////////////////////////////////
        // valido el nuevo comprobante

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


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////DEFINICION DE GRILLAS   ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    $('#Lista').jqGrid({
        url: ROOT + 'Pedido/DetPedidos/',
        postData: { 'IdPedido': function () { return $("#IdPedido").val(); } },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['', 'IdDetallePedido', 'IdArticulo', 'IdUnidad', '#', 'Obra', 'Cant.', 'Un.', 'Codigo',
            'Descripción', 'Descripción', 'Precio', '% Bon.', 'Imp.Bon.', '% Iva',
            'Imp.Iva', 'Imp.Total', 'Entrega', 'Necesidad', 'Observ', 'Nro.RM',
            'ItemRM', 'Adjunto',

            'IdDetalleRequerimiento', 'IdDetallePresupuesto', 'OrigenDescripcion', 'IdCentroCosto', 'IdCalidad', 'Calidad'],
        colModel: [

            {
                formoptions: { rowpos: 1, colpos: 1 }, name: 'act', index: 'act', align: 'left',
                width: 20, hidden: true, sortable: false, editable: false

                , formatter: 'actions',
                formatoptions: {
                    editformbutton: true,
                    delbutton: false,
                    keys: false
                }
            },

            {
                name: 'IdDetallePedido', formoptions: { rowpos: 2, colpos: 1 },
                index: 'IdDetallePedido', label: 'TB', align: 'left', width: 85, editable: true,
                hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 },
                editrules: { edithidden: true, required: false }
            },
            {
                name: 'IdArticulo', formoptions: { rowpos: 3, colpos: 1 },
                index: 'IdArticulo', label: 'TB', align: 'left', width: 85, editable: true,
                hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: true }
            },
            {
                name: 'IdUnidad', formoptions: { rowpos: 4, colpos: 1 },
                index: 'IdUnidad', label: 'TB', align: 'left', width: 85, editable: true,
                hidden: true, editrules: { edithidden: true, required: false, custom: true, custom_func: mypricecheck }
            },

            {
                name: 'NumeroItem', formoptions: { rowpos: 5, colpos: 1 },
                editoptions: { disabled: true },
                label: 'TB',
                align: 'center', width: 20, editable: true, edittype: 'text', editrules: { required: false }
            },

            { name: 'NumeroObra', formoptions: { rowpos: 6, colpos: 1 }, index: 'NumeroObra', label: 'TB', align: 'center', width: 60, sortable: false, editable: false },
            {
                name: 'Cantidad', formoptions: { rowpos: 7, colpos: 1 }, index: 'Cantidad', label: 'TB', align: 'right', width: 80, editable: true, edittype: 'text',
                editoptions: {
                    defaultValue: 1, maxlength: 20, dataEvents: [{

                        //                                type: 'change', fn: function (e) { CalcularImportes(); }
                        //                                                            , 

                        type: 'keyup', fn: function (e) { CalcularImportes(); }


                    }]
                }
                , editrules: { required: true }
            },
            {
                name: 'Unidad', formoptions: { rowpos: 7, colpos: 2, label: 'Unidad' }, index: 'Unidad', align: 'left',
                width: 60, editable: true, edittype: 'select', editrules: { required: true },

                editoptions: {

                    dataUrl: ROOT + 'Articulo/Unidades',
                    dataEvents: [{
                        type: 'change', fn: function (e) {
                            //                                    RefrescarRenglon(this);
                            //                             

                            //                                    UltimoIdUnidad = this.value;
                            //$('#IdUnidad').val(this.value);

                        }
                    }]
                }
            },







            {
                name: 'Codigo', formoptions: { rowpos: 8, colpos: 1 }, index: 'Codigo', align: 'left', width: 120,
                editable: true, edittype: 'text',
                editoptions: {
                    dataInit: function (elem) {
                        var NoResultsLabel = "No se encontraron resultados"; // http://stackoverflow.com/questions/8663189/jquery-autocomplete-no-result-message

                        $(elem).autocomplete({
                            source: ROOT + "Articulo/GetCodigosArticulosAutocomplete2", minLength: 0,
                            select: function (event, ui) {
                                if (ui.item.label === NoResultsLabel) {
                                    event.preventDefault();
                                }
                                else {
                                    $("#IdArticulo").val(ui.item.id);
                                    $("#Descripcion").val(ui.item.title);
                                    $("#PorcentajeIva").val(ui.item.iva);
                                    $("#IdUnidad").val(ui.item.IdUnidad);
                                    $("#Unidad").attr("value", ui.item.IdUnidad);

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


                    ,

                    dataEvents: [{
                        type: 'change',
                        fn: function (e) {


                            // alert('aasasd');

                            $.post(ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',  // ?term=' + val
                                { term: this.value },
                                function (data) {
                                    if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                        var ui = data[0];

                                        if (ui.title == "") {
                                            alert("No existe el código"); // se está bancando que no sea identica la descripcion
                                            $("#Codigo").val("");
                                            return;
                                        }

                                        if (this.value == "No se encontraron resultados") {
                                            $("#Codigo").val("");
                                            return;
                                        }


                                        //alert('hay ' + data.length);

                                        $("#IdArticulo").val(ui.id);
                                        $("#Codigo").val(ui.value);
                                        $("#Descripcion").val(ui.title);
                                        $("#IdUnidad").val(ui.IdUnidad);
                                        $("#Unidad").val(ui.IdUnidad);
                                        UltimoIdArticulo = ui.id;
                                        UltimoIdUnidad = ui.IdUnidad;

                                    }
                                    else {

                                        alert("No existe el código"); // se está bancando que no sea identica la descripcion
                                    }
                                }
                            );



                        }
                    }]

                },
                editrules: { required: false }
            },


            {
                formoptions: { rowpos: 9, colpos: 2 }, name: 'DescripcionFalsa', index: '', editable: false, width: 350, hidden: true,
                editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
            },

            {
                name: 'Descripcion', formoptions: { rowpos: 8, colpos: 2, label: "Descripción" }, index: 'Descripcion', align: 'left', width: 350,
                hidden: false,
                editable: true, edittype: 'text',
                editoptions: {
                    rows: '1', cols: '1',
                    dataInit: function (elem) {
                        var NoResultsLabel = "No se encontraron resultados";
                        $(elem).autocomplete({
                            source: ROOT + "Articulo/GetArticulosAutocomplete2", minLength: 0,
                            select: function (event, ui) {

                                //alert(ui.item.value);

                                if (ui.item.value === NoResultsLabel) {
                                    event.preventDefault();
                                    return;
                                }


                                $("#IdArticulo").val(ui.item.id);
                                $("#Codigo").val(ui.item.codigo);
                                $("#PorcentajeIVA").val(ui.item.iva);
                                $("#IdUnidad").val(ui.item.IdUnidad);
                                $("#Unidad").val(ui.item.IdUnidad);

                                UltimoIdArticulo = ui.item.id;
                                UltimoIdUnidad = ui.item.IdUnidad;
                                // if ($("#IdUnidad") == null) $("#Unidad").val(ui.item.IdUnidad);  mvarIdUnidadCU

                            }
                            ,
                            focus: function (event, ui) {
                                if (ui.item.value === NoResultsLabel) {
                                    event.preventDefault();
                                }
                            }
                        })
                            .data("ui-autocomplete")._renderItem = function (ul, item) {
                                return $("<li></li>")
                                    .data("ui-autocomplete-item", item)
                                    .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + " [" + item.codigo + "]</b></span></a>")
                                    .appendTo(ul);
                            };
                    }
                    ,
                    dataEvents: [{
                        type: 'change',
                        fn: function (e) {

                            //alert(this.value);

                            if (this.value == "No se encontraron resultados") {
                                $("#Descripcion").val("");
                                return;
                            }

                            $.post(ROOT + 'Articulo/GetArticulosAutocomplete2',  // ?term=' + val
                                { term: this.value },
                                function (data) {
                                    if (data.length == 1 || data.length > 1) { // qué pasa si encuentra más de uno?????
                                        var ui = data[0];

                                        if (ui.codigo == "") {
                                            alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                            $("#Descripcion").val("");
                                            return;
                                        }


                                        //alert('hay ' + data.length);




                                        $("#IdArticulo").val(ui.id);
                                        $("#Codigo").val(ui.codigo);
                                        $("#IdUnidad").val(ui.IdUnidad);
                                        //$("#Unidad").val(ui.item.Unidad);
                                        $("#Unidad").val(ui.IdUnidad); // hay que ponerle el id para elegir el item... por eso es que cuando salis del form en la celda queda con el id como texto...  no?

                                        UltimoIdArticulo = ui.id;
                                        UltimoIdUnidad = ui.IdUnidad;


                                    }
                                    else {

                                        alert("No existe el artículo"); // se está bancando que no sea identica la descripcion
                                    }
                                }
                            );



                        }
                    }]


                },
                editrules: { required: true }
            },
            {
                name: 'Precio',
                formoptions: { rowpos: 9, colpos: 1 },
                index: 'Precio', label: 'TB', align: 'right', width: 100,
                editable: true, edittype: 'text',
                editoptions: {
                    defaultValue: '0.00', maxlength: 20,
                    dataEvents: [{

                        type: 'keyup', fn: function (e) { CalcularImportes(); }
                    },
                    { type: 'change', fn: function (e) { CalcularImportes(); } }

                    ]

                }, editrules: { required: false }
            },
            {
                name: 'PorcentajeBonificacion',
                formoptions: { rowpos: 10, colpos: 1 },
                index: 'PorcentajeBonificacion', label: 'TB', align: 'right', width: 100,
                editable: true, edittype: 'text',
                editoptions: {
                    maxlength: 20,
                    defaultValue: '0.00',

                    dataEvents: [{

                        type: 'keyup', fn: function (e) { CalcularImportes(); }


                    }
                    ]
                }
            }
            ,
            { name: 'ImporteBonificacion', formoptions: { rowpos: 11, colpos: 1 }, index: 'ImporteBonificacion', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled' } },
            {
                name: 'PorcentajeIva', formoptions: { rowpos: 12, colpos: 1 }, index: 'PorcentajeIva', label: 'TB',
                align: 'right', width: 100, editable: true,
                editoptions: {
                    defaultValue: '21.00',
                    maxlength: 20,

                    dataEvents: [{
                        type: 'keyup', fn: function (e) { CalcularImportes(); }


                    }]
                }
            },
            { name: 'ImporteIva', formoptions: { rowpos: 13, colpos: 1 }, index: 'ImporteIva', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled' } },
            { name: 'ImporteTotalItem', formoptions: { rowpos: 14, colpos: 1 }, index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled' } },
            {
                name: 'FechaEntrega', formoptions: { rowpos: 15, colpos: 1 },
                index: 'FechaEntrega', label: 'TB', width: 300, align: 'center',
                sorttype: 'date', editable: true,
                //formatter: FormatterFecha,
                formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: false }
            },
            {
                name: 'FechaNecesidad', formoptions: { rowpos: 15, colpos: 2 },
                index: 'FechaNecesidad', label: 'TB', width: 300, align: 'center',
                sorttype: 'date', editable: true,
                formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: false }
            },
            {
                name: 'Observaciones', formoptions: { rowpos: 16, colpos: 1 }, index: 'Observaciones',
                label: 'TB', align: 'left', width: 600, editable: true,
                // edittype: 'textarea', // no se como evitar que el inline de textarea  me haga muy alto el renglon
                editoptions: { rows: '1', cols: '2' }
                //                            http://stackoverflow.com/questions/13103544/how-to-restrict-jqgrid-textarea-height-in-grid-only
                //                            edittype: "textarea", classes: "textInDiv",
                //    formatter: function (v) {
                //        return '<div>' + $.jgrid.htmlEncode(v) + '</div>';
                //    }

            }, //editoptions: { dataInit: function (elem) { $(elem).val(inEdit ? "Modificado" : "Nuevo"); }







            {
                name: 'NumeroRequerimiento', formoptions: { rowpos: 1, colpos: 2 },
                editoptions: { rows: '1', cols: '1', disabled: true },
                index: 'NumeroRequerimiento', label: 'TB', edittype: 'text',
                align: 'right', width: 60, sortable: false, editable: true, editrules: { readonly: 'readonly' }
            },
            {
                name: 'NumeroItemRM', hidden: true, formoptions: { rowpos: 1, colpos: 3 },
                editoptions: { rows: '1', cols: '1', disabled: true },
                index: 'NumeroItemRM', label: 'TB', align: 'center', edittype: 'text',
                width: 50, sortable: false, editable: false, editrules: { readonly: 'readonly' }
            },

            {
                name: 'Adj. 1', index: 'ArchivoAdjunto1', label: 'TB', align: 'left', width: 100, editable: true, edittype: 'file',
                editoptions: {
                    enctype: "multipart/form-data", dataEvents: [{
                        type: 'change', fn: function (e) {
                            var thisval = $(e.target).val();
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
            { name: 'IdDetalleRequerimiento', label: 'TB', hidden: true, editoptions: { defaultValue: '-1' } },
            { name: 'IdDetallePresupuesto', label: 'TB', hidden: true, editoptions: { defaultValue: '-1' } },

            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////

            // radio buttons en el popup del jqgrid
            // http://www.trirand.com/jqgridwiki/doku.php?id=wiki:common_rules#custom
            {
                name: 'OrigenDescripcion', label: 'TB', formoptions: { rowpos: 11, colpos: 2, label: "Tomar" }  // "Tomar la descripción de" }
                , index: 'OrigenDescripcion',
                align: 'center', width: 35, editable: true, hidden: true, edittype: 'select', // edittype: 'custom',
                // formatter: radioFormatter, unformat: unformatRadio,
                editrules: {
                    required: true
                    //                                      , readonly: ( (OrigenDescripcionDefault==3 || true) ?  'readonly' : ''  ) 
                    //                                      , disabled: 'disabled'
                },

                editoptions: {
                    //                         readonly: true,
                    //   disabled:  ( (OrigenDescripcionDefault==3 ) ?  'disabled' : ''  )  ,
                    defaultValue: OrigenDescripcionDefault,
                    value: "1:Solo el material; 2:Solo las observaciones; 3:Material mas observaciones", size: 3
                    //,
                    //     custom_element: myelem, custom_value: myvalue
                }
            },
            { name: 'IdCentroCosto', label: 'TB', hidden: true }


            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////
            //////////////////////////////



            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////

            , {
                formoptions: { rowpos: 2, colpos: 2 }, name: 'IdControlCalidad', index: 'IdControlCalidad', label: 'TB'
                , editable: true, hidden: true
                , editoptions: {
                    disabled: 'disabled',

                    defaultValue: mIdControlCalidadDefault
                }
                //                            editrules: { edithidden: true, required: true }




            }

            , {
                name: 'ControlCalidad', formoptions: { rowpos: 12, colpos: 2 }, index: 'ControlCalidad', align: 'center', label: '',
                width: 160, editable: true, edittype: 'select', editrules: { required: false },
                editoptions: {
                    dataUrl: ROOT + 'ControlCalidad/ControlCalidades',  //  ROOT + 'ControlCalidad/ControlCalidadParaCombo',


                    //                   http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10950
                    //                   default control calidad
                    defaultValue: mDescControlCalidadDefault,


                    // $("#IdUnidad").val(ui.item.IdUnidad|| 1);
                    // $("#Unidad").attr("value", ui.item.IdUnidad|| 1);



                    dataEvents: [{
                        type: 'change', fn: function (e) {

                            //alert(this.value);
                            $('#IdControlCalidad').val(this.value);
                            UltimoIdControlCalidad = this.value;
                            //RefrescarRenglon(this);

                        }
                    }]


                }

            },
            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////


             
        ],








        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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


            // jQuery('#Lista').jqGrid('restoreCell', lastRowIndex, lastColIndex, true);

            sacarDeEditMode();


            //            var ids = jQuery("#Lista").getChangedCells('dirty'); // .jqGrid('getDataIDs');
            //            for (var i = 0; i < ids.length; i++) {



            //                grid.jqGrid('restoreRow', ids[i]);
            //            }

            //////////////////////////////////////////////////////
            //////////////////////////////////////////////////////



            dobleclic = true;
            $("#edtData").click();
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





        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //        http://stackoverflow.com/questions/9170260/jqgrid-all-rows-in-inline-edit-mode-by-default
        //                You have to enumerate all rows of grid and call editRow for every row. The code can be like the following


        gridComplete: function () {
            var ids = jQuery("#Lista").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                var be = "<input style='height:22px;width:20px;' type='button' value='E' onclick=\"jQuery('#Lista').editRow('" + cl + "',true,pickdates);\"  />";
                var se = "<input style='height:22px;width:20px;' type='button' value='S' onclick=\"jQuery('#Lista').saveRow('" + cl + "');\"  />";
                var ce = "<input style='height:22px;width:20px;' type='button' value='C' onclick=\"jQuery('#Lista').restoreRow('" + cl + "');\" />";
                jQuery("#Lista").jqGrid('setRowData', ids[i], { act: be + se + ce });
                calculateTotal();
            }
            RefrescarOrigenDescripcion();
        },


        loadComplete: function () { //si uso esto, no puedo usar tranquilo lo de aria-selected para el refresco de la edicion inline

            AgregarRenglonesEnBlanco({ "IdDetallePedido": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

            var $this = $(this), ids = $this.jqGrid('getDataIDs'), i, l = ids.length;
            for (i = 0; i < l; i++) {
                // $this.jqGrid('editRow', ids[i], true);
            }
        },




        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        //        http://stackoverflow.com/questions/7213363/jqgrid-edit-delete-button-with-each-row
        //        http://stackoverflow.com/questions/5196387/jqgrid-editactioniconscolumn-events/5204793#5204793
        //        http://www.ok-soft-gmbh.com/jqGrid/ActionButtons.htm
        //        formatter:'actions',
        //formatoptions: {
        //    keys: true,
        //    editformbutton: true
        //},

        pager: $('#ListaPager'),
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
        height: '150px', // 'auto',
        altRows: false,
        rownumbers: false,
        footerrow: true,
        userDataOnFooter: true
        , multiselect: true



        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        // http://stackoverflow.com/questions/14662632/jqgrid-celledit-in-json-data-shows-url-not-set-alert
        ,
        cellEdit: true,
        cellsubmit: 'clientArray'
        , editurl: ROOT + 'Pedido/EditGridData/' // pinta que esta es la papa: editurl con la url, y cellsubmit en clientarray
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////

    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {},
        { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //    jQuery("#Lista").jqGrid('setFrozenColumns');



    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////FIN DE DEFINICION DE GRILLALISTA   ////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////


    function QuitarRenglones(data) {

        var longitud = data.length;
        for (var i = 0; i < data.length; i++) {

            if (data[i].indexOf("usa un item de requerimiento que ya se") == -1) continue;

            var renglonrepe = parseInt(data[i]);
            // http://stackoverflow.com/questions/3791020/how-to-search-for-a-row-and-then-select-it-in-jqgrid
            var index = 6; // la columna esta es la que tiene el numero de item
            var str = renglonrepe;
            var reng = $("#Lista > tbody > tr > td:nth-child(" + index + "):contains('" + str + "')").parent();




            // podemos quitarlo o pintarlo
            if (true) {
                // jQuery("#Lista").jqGrid('rowattr', reng[0].id);
                // $("#6 td:eq(2)", grid[0]).css({ color: 'red' });
                //            
                //              $("tr.jqgrow:odd").addClass('myAltRowClass');
                //        $("#" + rowsToColor[i]).find("td").css("background-color", "red");
                //                .addClass('myAltRowClass');

                //                 jQuery("#Lista").jqGrid('setRowData', reng[0].id, "0", "", { color: 'red' });

                $("#Lista").jqGrid('setRowData', reng[0].id, false, { 'background': '#FAB1B1' });
                $("#Lista").jqGrid('setRowData', reng[0].id, false, { 'text-decoration': 'line-through' });

                // jQuery("#Lista").jqGrid('setCell', reng[0].id, "0", "", { color: 'red' });
                // jQuery("#Lista").jqGrid('setCell', reng[0].id, "4", "", { color: 'red' });
            } else {
                try {
                    jQuery("#Lista").jqGrid('delRowData', reng[0].id);
                } catch (e) {

                }
            }


        }

    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    function CopiarRM(acceptId, ui) {

        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);


        sacarDeEditMode();

        GrabarGrillaLocal()

        // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
        var getdata = jQuery("#ListaDrag").jqGrid('getRowData', acceptId);

        var j = 0, tmpdata = {}, dropname, IdRequerimiento;
        // var dropmodel = $("#ListaDrag").jqGrid('getGridParam', 'colModel');
        var grid;
        try {

            // estos son datos de cabecera que ya tengo en la grilla auxiliar
            $("#Observaciones").val(getdata['Observaciones']);
            $("#LugarEntrega").val(getdata['LugarEntrega']);
            $("#IdObra").val(getdata['IdObra']);
            $("#IdSector").val(getdata['IdSector']);

            //me traigo los datos de detalle
            var IdRequerimiento = getdata['IdRequerimiento']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Requerimiento/DetRequerimientosSinFormato/',
                data: { IdRequerimiento: IdRequerimiento },
                dataType: "Json",
                success: function (data) {

                    // agrego los items a la grilla de detalle
                    // -tiene sentido que se encargue el cliente de agregar la lista de items, cuando ya podr�a haber
                    // venido el objeto devuelto (jsoneado) ?

                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        CopiarItemRM(data, i);
                    }


                    //                var rows = $("#Lista").getGridParam("reccount");
                    //                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

                    AgregarRenglonesEnBlanco({ "IdDetallePedido": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });



                    Validar();
                }

            });




        } catch (e) {

            alert(e.message);

        }


        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }
















    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    function CopiarRMdetalle(acceptId, ui) {

        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        GrabarGrillaLocal()

        // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
        var getdata = jQuery("#ListaDrag2").jqGrid('getRowData', acceptId);

        var j = 0, dropname, IdRequerimiento;
        // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
        var grid;

        var IdRequerimiento = getdata['IdRequerimiento']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas
        //IdRequerimiento = getdata['act'];

        try {


            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Requerimiento/DetRequerimientosSinFormato/',
                data: { IdRequerimiento: IdRequerimiento },
                dataType: "Json",
                success: function (data) {

                    // agrego los items a la grilla de detalle
                    // -tiene sentido que se encargue el cliente de agregar la lista de items, cuando ya podr�a haber
                    // venido el objeto devuelto (jsoneado) ?
                    var numitem = getdata['NumeroItem'] - 1;

                    CopiarItemRM(data, numitem);
                    Validar();
                }
            })





        } catch (e) {

            alert(e.message);

        }

    }






    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////




    function CopiarItemRM(data, i) {


        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        GrabarGrillaLocal()

        var tmpdata = {};



        var longitud = data.length;


        tmpdata['IdArticulo'] = data[i].IdArticulo;
        tmpdata['Codigo'] = data[i].Codigo;
        tmpdata['Descripcion'] = data[i].Descripcion;
        tmpdata['IdUnidad'] = data[i].IdUnidad;
        tmpdata['Unidad'] = data[i].Unidad;
        tmpdata['IdDetallePedido'] = 0;
        tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
        tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
        tmpdata['NumeroItemRM'] = data[i].NumeroItem;
        tmpdata['Cantidad'] = data[i].Cantidad;
        tmpdata['NumeroObra'] = data[i].NumeroObra;

        tmpdata['Cumplido'] = data[i].Cumplido;



        ///////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////

        tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
        tmpdata['Observaciones'] = data[i].Observaciones;

        ///////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////

        if (tmpdata['Cumplido'] == 'AN' || tmpdata['Cumplido'] == 'AN') return;

        ///////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////



        if (true) {
            // fecha de hoy
            var now = new Date();
            var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
            tmpdata['FechaEntrega'] = currentDate;

            try {
                var date = new Date(parseInt((data[i].FechaEntrega || "").substr(6)));
                var displayDate = $.datepicker.formatDate("dd/mm/yy", date);  // $.datepicker.formatDate("mm/dd/yy", date);
                tmpdata['FechaNecesidad'] = displayDate;
                if (displayDate == "NaN/NaN/NaN") tmpdata['FechaNecesidad'] = currentDate;
                // displayDate;

            } catch (e) {
                tmpdata['FechaNecesidad'] = currentDate;
            }


        }
        else {
            // fecha del rm
            var date = new Date(parseInt((data[i].FechaEntrega || "").substr(6)));
            var displayDate = $.datepicker.formatDate("dd/mm/yy", date);  // $.datepicker.formatDate("mm/dd/yy", date);
            tmpdata['FechaEntrega'] = displayDate;
        }


        ///////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////

        tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;


        tmpdata['NumeroItem'] = ProximoNumeroItem();  // jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;


        ///////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////
        //http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10950
        //grabar control calidad o usar default

        if (data[i].IdControlCalidad > 0) {
            tmpdata['IdControlCalidad'] = data[i].IdControlCalidad;
            tmpdata['ControlCalidad'] = data[i].ControlCalidad;
        }
        else {
            tmpdata['IdControlCalidad'] = mIdControlCalidadDefault;
            tmpdata['ControlCalidad'] = mDescControlCalidadDefault;

        }








        var getdata = tmpdata;
        var idazar = Math.ceil(Math.random() * 1000000);


        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////



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

        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////




        //    rows = $("#Lista").getGridParam("reccount");
        //    if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);
        AgregarRenglonesEnBlanco({ "IdDetallePedido": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });





    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    function CopiarPresupuesto(acceptId, ui) {


        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        GrabarGrillaLocal()

        // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
        var getdata = jQuery("#ListaDrag3").jqGrid('getRowData', acceptId);

        var j = 0, tmpdata = {}, dropname, IdRequerimiento;
        // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
        var grid;
        try {

            // estos son datos de cabecera que ya tengo en la grilla auxiliar
            $("#Observaciones").val(getdata['Observaciones']);
            $("#LugarEntrega").val(getdata['LugarEntrega']);
            $("#IdObra").val(getdata['IdObra']);
            $("#IdSector").val(getdata['IdSector']);

            $("#IdProveedor").val(getdata['IdProveedor']);
            $("#DescripcionProveedor").val(getdata['Proveedor']);



            //me traigo los datos de detalle
            var IdPresupuesto = getdata['IdPresupuesto']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Presupuesto/DetPresupuestosSinFormato/',
                data: { IdPresupuesto: IdPresupuesto },
                dataType: "Json",
                success: function (data) {

                    // agrego los items a la grilla de detalle
                    // -tiene sentido que se encargue el cliente de agregar la lista de items, cuando ya podr�a haber
                    // venido el objeto devuelto (jsoneado) ?

                    var longitud = data.length; //si no usaste el action SinFormato, no podes hacer length
                    for (var i = 0; i < data.length; i++) {
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['Codigo'] = data[i].Codigo;
                        tmpdata['Descripcion'] = data[i].Descripcion;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        tmpdata['Unidad'] = data[i].Abreviatura;
                        tmpdata['IdDetallePedido'] = 0;
                        tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                        tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                        tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                        tmpdata['Cantidad'] = data[i].Cantidad;
                        tmpdata['NumeroObra'] = data[i].NumeroObra;

                        ///////////////////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////////////////

                        if (true) {
                            // fecha de hoy
                            var now = new Date();
                            var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                            tmpdata['FechaEntrega'] = currentDate;
                        }
                        else {
                            // fecha del rm
                            var date = new Date(parseInt(data[i].FechaEntrega.substr(6)));
                            var displayDate = $.datepicker.formatDate("dd/mm/yy", date);  // $.datepicker.formatDate("mm/dd/yy", date);
                            tmpdata['FechaEntrega'] = displayDate;
                        }
                        tmpdata['FechaNecesidad'] = displayDate;

                        ///////////////////////////////////////////////////////////////////


                        tmpdata['Precio'] = data[i].Precio;
                        tmpdata['PorcentajeBonificacion'] = data[i].PorcentajeBonificacion;
                        tmpdata['ImporteBonificacion'] = data[i].ImporteBonificacion;
                        tmpdata['ImporteIva'] = data[i].ImporteIva;
                        tmpdata['ImporteTotalItem'] = data[i].ImporteTotalItem;


                        tmpdata['Observaciones'] = data[i].Observaciones;


                        tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
                        tmpdata['NumeroItem'] = ProximoNumeroItem();   // jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                        getdata = tmpdata;
                        grid = Math.ceil(Math.random() * 1000000);
                        $("#Lista").jqGrid('addRowData', grid, getdata);
                    }


                    //                rows = $("#Lista").getGridParam("reccount");
                    //                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);
                    AgregarRenglonesEnBlanco({ "IdDetallePedido": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });




                    Validar();
                }

            });




        } catch (e) {

            alert(e.message);

        }

        var grid;
        grid = Math.ceil(Math.random() * 1000000);
        // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
        //                    $("#" + this.id).jqGrid('addRowData', grid, getdata);
        //resetAltRows.call(this);
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }







    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    function CopiarComparativa(acceptId, ui) {


        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        GrabarGrillaLocal()

        // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
        var getdata = jQuery("#ListaDrag4").jqGrid('getRowData', acceptId);

        var j = 0, tmpdata = {}, dropname, IdRequerimiento;
        // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
        var grid;
        try {

            // estos son datos de cabecera que ya tengo en la grilla auxiliar
            $("#Observaciones").val(getdata['Observaciones']);
            $("#LugarEntrega").val(getdata['LugarEntrega']);
            $("#IdObra").val(getdata['IdObra']);
            $("#IdSector").val(getdata['IdSector']);

            //me traigo los datos de detalle
            var IdComparativa = getdata['IdFactura']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Comparativa/DetComparativasSinFormato/',
                data: { IdComparativa: IdComparativa },
                dataType: "Json",
                success: function (data) {

                    // agrego los items a la grilla de detalle
                    // -tiene sentido que se encargue el cliente de agregar la lista de items, cuando ya podr�a haber
                    // venido el objeto devuelto (jsoneado) ?

                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['Codigo'] = data[i].Codigo;
                        tmpdata['Descripcion'] = data[i].Descripcion;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        tmpdata['Unidad'] = data[i].Unidad;
                        tmpdata['IdDetallePedido'] = 0;
                        tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                        tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                        tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                        tmpdata['Cantidad'] = data[i].Cantidad;
                        tmpdata['NumeroObra'] = data[i].NumeroObra;
                        tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
                        tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;


                        tmpdata['Precio'] = data[i].Precio;
                        tmpdata['PorcentajeBonificacion'] = data[i].PorcentajeBonificacion;
                        tmpdata['ImporteBonificacion'] = data[i].ImporteBonificacion;
                        tmpdata['ImporteIva'] = data[i].ImporteIva;
                        tmpdata['ImporteTotalItem'] = data[i].ImporteTotalItem;


                        getdata = tmpdata;
                        grid = Math.ceil(Math.random() * 1000000);
                        $("#Lista").jqGrid('addRowData', grid, getdata);
                    }


                    //                rows = $("#Lista").getGridParam("reccount");
                    //                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);
                    AgregarRenglonesEnBlanco({ "IdDetallePedido": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });




                    Validar();
                }

            });




        } catch (e) {

            alert(e.message);

        }

        var grid;
        grid = Math.ceil(Math.random() * 1000000);
        // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
        //                    $("#" + this.id).jqGrid('addRowData', grid, getdata);
        //resetAltRows.call(this);
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }











    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////


    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    function CopiarPedido(acceptId, ui) {


        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        sacarDeEditMode();


        GrabarGrillaLocal()

        // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
        var getdata = jQuery("#ListaDrag5").jqGrid('getRowData', acceptId);

        var j = 0, tmpdata = {}, dropname, IdRequerimiento;
        // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
        var grid;
        try {

            // estos son datos de cabecera que ya tengo en la grilla auxiliar
            $("#Observaciones").val(getdata['Observaciones']);
            $("#LugarEntrega").val(getdata['LugarEntrega']);
            $("#IdObra").val(getdata['IdObra']);
            $("#IdSector").val(getdata['IdSector']);

            $("#IdProveedor").val(getdata['IdProveedor']);
            $("#Proveedor").val(getdata['IdProveedor']);
            $("#DescripcionProveedor").val(getdata['Proveedor']);
            $("#IdComprador").val(getdata['IdComprador']);


            $("#NumeroPedido").val(getdata['Numero']);
            $("#SubNumero").val(parseInt(getdata['SubNumero']) + 1);


            //me traigo los datos de detalle
            var IdPedido = getdata['IdPedido']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas









            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Pedido/DetPedidosSinFormato/',
                data: { IdPedido: IdPedido },
                dataType: "Json",
                error: function (xhr, textStatus, exceptionThrown) {
                    alert('error');
                },
                success: function (data) {

                    var prox = ProximoNumeroItem();
                    // agrego los items a la grilla de detalle
                    // -tiene sentido que se encargue el cliente de agregar la lista de items, cuando ya podr�a haber
                    // venido el objeto devuelto (jsoneado) ?

                    var longitud = data.length;
                    for (var i = 0; i < data.length; i++) {
                        var date = new Date(parseInt(data[i].FechaEntrega.substr(6)));
                        var displayDate = $.datepicker.formatDate("dd/mm/yy", date);  // $.datepicker.formatDate("mm/dd/yy", date);
                        tmpdata['IdArticulo'] = data[i].IdArticulo;
                        tmpdata['Codigo'] = data[i].Codigo;
                        tmpdata['Descripcion'] = data[i].Descripcion;
                        tmpdata['IdUnidad'] = data[i].IdUnidad;
                        //tmpdata['Unidad'] = data[i].Unidad;
                        tmpdata['Unidad'] = data[i].Abreviatura;
                        tmpdata['IdDetallePedido'] = data[i].IdDetallePedido;
                        tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                        tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                        tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                        tmpdata['Cantidad'] = data[i].Cantidad;
                        tmpdata['NumeroObra'] = data[i].NumeroObra;
                        tmpdata['FechaEntrega'] = displayDate;
                        tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;

                        //tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                        tmpdata['NumeroItem'] = prox;
                        prox++;

                        tmpdata['Precio'] = data[i].Precio;;

                        getdata = tmpdata;
                        var idazar = Math.ceil(Math.random() * 1000000);


                        //////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////



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

                        //////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////



                    }


                    AgregarRenglonesEnBlanco({ "IdDetallePedido": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });
                    //                rows = $("#Lista").getGridParam("reccount");
                    //                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);




                    Validar();
                }

            })




        } catch (e) {

            alert(e.message);

        }

        var grid;
        grid = Math.ceil(Math.random() * 1000000);
        // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
        //                    $("#" + this.id).jqGrid('addRowData', grid, getdata);
        //resetAltRows.call(this);
        $("#gbox_grid2").css("border", "1px solid #aaaaaa");
    }











    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////






    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////grabar///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    $('#grabar2').click(function () {

        jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);


        var cabecera = SerializaForm();


        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Pedido/BatchUpdate',
            dataType: 'json',
            data: JSON.stringify(cabecera), // $.toJSON(cabecera),
            success: function (result) {
                //                    if (result) {
                //                        $('#Lista').trigger('reloadGrid');
                //                        window.location.replace(ROOT + "Pedido/index");
                //                    } else {
                //                        alert('No se pudo grabar el comprobante.');
                //                    }

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
                        // $('#Lista').trigger('reloadGrid'); // no tenes el id!!!!!
                        //si graban de nuevo, va a dar un alta!!!!


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
                    pageLayout.show('east');



                    alert(errorData.Errors.join("\n").replace(/<br\/>/g, '\n'));



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

    //    jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });
    jQuery("#Lista").jqGrid('gridResize', {});

    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////



    // get the header row which contains
    headerRow = jQuery("#Lista").closest("div.ui-jqgrid-view")
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


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////





    $("#loading").hide();

    var lastSelectedId;
    var inEdit

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

    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////


    function BorraElPrimeroAgregado() {

        var grid = $("#Lista"),
            ids = grid.jqGrid("getDataIDs");
        if (ids && ids.length > 0)
            grid.jqGrid("delRowData", ids[0]);

    }


    function ConectarGrillas1() {
        // connect grid1 with grid2
        $("#ListaDrag").jqGrid('gridDnD', {
            connectWith: '#Lista', //drag_opts:{stop:null},
            onstart: function (ev, ui) {
                sacarDeEditMode();
                //                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                //                        .addClass("ui-state-error ui-widget")
                //                        .css({ border: "5px ridge tomato" });
                //                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            beforedrop: function (ev, ui, getdata, $source, $target) {
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");

                BorraElPrimeroAgregado();

                CopiarRM(acceptId, ui);
            }
        });
    }

    function ConectarGrillas2() {
        $("#ListaDrag2").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                sacarDeEditMode();
                //                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                //                        .addClass("ui-state-error ui-widget")
                //                        .css({ border: "5px ridge tomato" });
                //                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {

                ////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////
                // El comportamiento default de las grillas conectadas es que se mueve el renglon elegido automaticamente, hermanando las columnas supongo que por nombre.
                // Como vos te encargas manualmente de copiar los renglones , podes borrar el nuevo id creado.
                // Fijate que en el metedo viejo directo en el ondrop, usas para getdata el creado en el drag; pero con el medodo de las llamadas a CopiarRMdetalle, esta a su vez llama 
                //  a CopiarItemRM, que crea el renglon desde cero (y por eso te queda uno de yapa arriba de todo).
                ////////////////////////////////////////////////////////////////////////////////////////////




                var acceptId = $(ui.draggable).attr("id");
                //alert(acceptId);
                //jQuery("#Lista").jqGrid('delRowData', acceptId);

                BorraElPrimeroAgregado();
                //                var draggedItem = ui.helper.context.id;
                //                var dragTarget = event.target.id;
                //                alert(draggedItem + " to " + dragTarget);
                ////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////



                CopiarRMdetalle(acceptId); //, ui);
                return;



                var acceptId = $(ui.draggable).attr("id");
                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                var j = 0, tmpdata = {}, dropname, IdRequerimiento;
                // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                var grid;
                try {
                    $("#Observaciones").val(getdata['Observaciones']);
                    $("#LugarEntrega").val(getdata['LugarEntrega']);
                    $("#IdObra").val(getdata['IdObra']);
                    $("#IdSector").val(getdata['IdSector']);


                    var cabecera = SerializaForm();



                    IdRequerimiento = getdata['IdRequerimiento'];
                    $.ajax({

                        type: "POST", //deber�a ser "GET", pero me queda muy larga la url http://stackoverflow.com/questions/6269683/ajax-post-request-will-not-send-json-data
                        contentType: 'application/json; charset=utf-8',
                        url: '@Url.Action("ValidarJson", "Pedido")',
                        dataType: 'json',
                        data: JSON.stringify(cabecera), // $.toJSON(cabecera),


                        error: function (xhr, textStatus, exceptionThrown) {
                            try {
                                var errorData = $.parseJSON(xhr.responseText);
                                var errorMessages = [];
                                //this ugly loop is because List<> is serialized to an object instead of an array
                                for (var key in errorData) {
                                    errorMessages.push(errorData[key]);
                                }
                                $('#result').html(errorMessages.join("<br />"));

                                $('html, body').css('cursor', 'auto');
                                $('#grabar2').attr("disabled", false).val("Aceptar");


                                $("#textoMensajeAlerta").text(errorMessages.join());
                                $("#mensajeAlerta").show();
                                alert(errorMessages.join("<br />"));

                            } catch (e) {
                                // http://stackoverflow.com/questions/15532667/asp-netazure-400-bad-request-doesnt-return-json-data
                                // si tira error de Bad Request en el II7, agregar el asombroso   <httpErrors existingResponse="PassThrough"/>

                                $('html, body').css('cursor', 'auto');
                                $('#grabar2').attr("disabled", false).val("Aceptar");

                                $("#mensajeAlerta").show(); //http://stackoverflow.com/questions/8965018/dynamically-creating-bootstrap-css-alert-messages?rq=1
                                //$(".alert").alert();
                                alert(xhr.responseText);
                            }
                        },
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
                                tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                                tmpdata['Cantidad'] = data[i].Cantidad;
                                tmpdata['NumeroObra'] = data[i].NumeroObra;
                                tmpdata['FechaEntrega'] = displayDate;
                                tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
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

    function ConectarGrillas3() {
        $("#ListaDrag3").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                    .addClass("ui-state-error ui-widget")
                    .css({ border: "5px ridge tomato" });
                $("#gbox_grid2").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");

                BorraElPrimeroAgregado();
                CopiarPresupuesto(acceptId);
                return;

                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                var j = 0, tmpdata = {}, dropname, IdPedido;
                // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                var grid;
                try {
                    $("#Numero").val(getdata['Numero']);
                    $("#SubNumero").val("99");
                    IdPedido = getdata['IdPedido'];
                    BuscarOrden(getdata['Numero']);
                    $.ajax({
                        type: "GET",
                        contentType: "application/json; charset=utf-8",
                        url: ROOT + 'Pedido/DetPedidosSinFormato/',
                        data: { IdPedido: IdPedido },
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

    function ConectarGrillas4() {
        $("#ListaDrag4").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                    .addClass("ui-state-error ui-widget")
                    .css({ border: "5px ridge tomato" });
                $("#gbox_grid4").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");

                BorraElPrimeroAgregado();
                CopiarComparativa(acceptId);
                return;

                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                var j = 0, tmpdata = {}, dropname, IdRequerimiento;
                // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
                                tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                                tmpdata['Cantidad'] = data[i].Cantidad;
                                tmpdata['NumeroObra'] = data[i].NumeroObra;
                                tmpdata['FechaEntrega'] = displayDate;
                                tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
                                tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                                getdata = tmpdata;
                                grid = Math.ceil(Math.random() * 1000000);
                                $("#Lista").jqGrid('addRowData', grid, getdata);
                            }
                        }
                    });
                } catch (e) { }
                $("#gbox_grid4").css("border", "1px solid #aaaaaa");
            }
        });
    }

    function ConectarGrillas5() {
        $("#ListaDrag5").jqGrid('gridDnD', {
            connectWith: '#Lista',
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                    .addClass("ui-state-error ui-widget")
                    .css({ border: "5px ridge tomato" });
                $("#gbox_grid5").css("border", "3px solid #aaaaaa");
            },
            ondrop: function (ev, ui, getdata) {
                var acceptId = $(ui.draggable).attr("id");

                BorraElPrimeroAgregado();
                CopiarPedido(acceptId);
                return;

                var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                var j = 0, tmpdata = {}, dropname, IdRequerimiento;
                // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
                                tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                                tmpdata['Cantidad'] = data[i].Cantidad;
                                tmpdata['NumeroObra'] = data[i].NumeroObra;
                                tmpdata['FechaEntrega'] = displayDate;
                                tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
                                tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                                getdata = tmpdata;
                                grid = Math.ceil(Math.random() * 1000000);
                                $("#Lista").jqGrid('addRowData', grid, getdata);
                            }
                        }
                    });
                } catch (e) { }
                $("#gbox_grid5").css("border", "1px solid #aaaaaa");
            }
        });
    }



    $("#FechaIngreso").datepicker({
        changeMonth: true,
        changeYear: true
    });

    //Para que haga wrap en las celdas
    $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');
    //$.jgrid.formatter.integer.thousandsSeparator=',';













    function mypricecheck(value, colname) {
        if (value <= 0)
            return [false, "Falta la unidad"];
        else
            return [true, ""];
    }




    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////






    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function PopupCentrar() {
        var grid = $("#Lista");

        //return ;
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
        var top = ((screen.height / 2) - (dlgHeight / 2) + 50) + "px";

        dlgDiv[0].style.top = top; // 500; // Math.round((parentHeight - dlgHeight) / 2) + "px";
        dlgDiv[0].style.left = left; //Math.round((parentWidth - dlgWidth) / 2) + "px";

    }





    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    $("#addData").click(function () {
        dobleclic = true;
        jQuery("#Lista").jqGrid('editGridRow', "new", {
            addCaption: "Agregar item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
            recreateForm: true,
            beforeShowForm: function (form) {
                GrabarGrillaLocal();
                PopupCentrar();

                //                    var dlgDiv = $("#editmod" + grid[0].id);
                //                    dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                //                    dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                $('#tr_IdDetallePedido', form).hide();
                $('#tr_IdArticulo', form).hide();
                $('#tr_IdUnidad', form).hide();
            },
            beforeInitData: function () {
                inEdit = false;
            },
            onInitializeForm: function (form) {
                $('#IdDetallePedido', form).val(0);
                $('#NumeroItem', form).val(jQuery("#Lista").jqGrid('getGridParam', 'records') + 1);
                $('#FechaEntrega', form).val($("#FechaIngreso").val());
            },
            afterShowForm: function (formid) {
                $('#Cantidad').focus();
            },
            afterComplete: function (response, postdata) {
                //  calculateTotal();
            },
            onClose: function (data) {
                //  RefrescarOrigenDescripcion();
                GrabarGrillaLocal()
            }


        });
    });





    $("#edtData").click(function () {

        sacarDeEditMode();

        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        if (gr != null) jQuery("#Lista").jqGrid('editGridRow', gr, {
            editCaption: "Modificacion item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true,
            closeAfterEdit: true, recreateForm: true, Top: 0,
            beforeShowForm: function (form) {
                GrabarGrillaLocal();

                PopupCentrar();



                //                    var dlgDiv = $("#editmod" + grid[0].id);
                //                    var parentDiv = dlgDiv.parent(); // div#gbox_list
                //                    var dlgWidth = dlgDiv.width();
                //                    var parentWidth = parentDiv.width();
                //                    var dlgHeight = dlgDiv.height();
                //                    var parentHeight = parentDiv.height();
                //                    dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                //                    dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                $('#tr_IdDetallePedido', form).hide();
                $('#tr_IdArticulo', form).hide();
                $('#tr_IdUnidad', form).hide();


            },
            beforeInitData: function () {
                inEdit = true;
            },
            afterComplete: function (response, postdata) {
                calculateTotal();
            },
            onClose: function (data) {
                RefrescarOrigenDescripcion();
                PonerRenglonesInline();
            },
            beforeSubmit: function (postdata, formid) {
                //alert(postdata.Unidad + " " + $("#Unidad").children("option").filter(":selected").text());
                //postdata.Unidad es un numero?????
                postdata.Unidad = $("#Unidad").children("option").filter(":selected").text()
                postdata.ControlCalidad = $("#ControlCalidad").children("option").filter(":selected").text()

                return [true, 'no se puede'];
            }
        });
        else alert("Debe seleccionar un item!");
    });

    $("#delData").click(function () {
        //var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selarrrow');

        if (gr != null) {
            jQuery("#Lista").jqGrid('delGridRow', gr,
                {
                    caption: "Borrar", msg: "Elimina el registro seleccionado?", bSubmit: "Borrar", bCancel: "Cancelar",
                    width: 300, closeOnEscape: true, reloadAfterSubmit: false,

                    beforeShowForm: function (form) {

                        $("#dData").attr("class", "btn btn-primary");
                        $("#dData").css("color", "white");
                        $("#dData").css("margin-right", "20px");
                        $("#eData").attr("class", "btn");

                    },
                    afterComplete: function (response, postdata) {
                        calculateTotal();
                    }
                });
        }
        else alert("Debe seleccionar un item!");
    });



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    function EditarItem(rowid) {
        var gr = rowid; // jQuery("#Lista").jqGrid('getGridParam',  'selrow');
        var row = jQuery("#Lista").jqGrid('getRowData', rowid);

        if (row.Cumplido == "SI") {
            alert("El item ya está cumplido")
            return;
        }

        if (gr != null) jQuery("#Lista")
            .jqGrid('editGridRow', gr,
            {
                editCaption: "", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800
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
                    AgregarRenglonesEnBlanco({ "IdDetalleRequerimiento": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });


                    //var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);
                    //data['Unidad'] = $("#Unidad").text(); ;
                    //$('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon

                    //PonerRenglonesInline();
                    // jQuery('#Lista').editRow(gr, true);
                }
                ,
                beforeSubmit: function (postdata, formid) {

                    //alert(postdata.Unidad + " " + $("#Unidad").children("option").filter(":selected").text());
                    //postdata.Unidad es un numero?????
                    postdata.Unidad = $("#Unidad").children("option").filter(":selected").text()
                    postdata.ControlCalidad = $("#ControlCalidad").children("option").filter(":selected").text()

                    return [true, 'no se puede'];
                }


            });
        else alert("Debe seleccionar un item!");

    }





    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    $("#ListaDrag").jqGrid({
        url: ROOT + 'Requerimiento/RequerimientosComprables_DynamicGridData',
        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; }, 'IdObra': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'Acciones', 'IdRequerimiento', 'Numero', 'Fecha', 'Cump.', 'Recep.', 'Entreg.', 'Impresa', 'Detalle', 'Obra', 'Pedidos', 'Comparativas',
            'Pedidos', 'Recepciones', 'Salidas', 'Libero', 'Solicito', 'Sector', 'Usuario anulo', 'Fecha anulacion', 'Motivo anulacion', 'Fechas liberacion',
            'Observaciones', 'Lugar de entrega', 'IdObra', 'IdSector'],
        colModel: [
            { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
            { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
            { name: 'IdRequerimiento', index: 'IdRequerimiento', align: 'left', width: 100, editable: false, hidden: true },
            { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'FechaRequerimiento', index: 'FechaRequerimiento', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
            { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
            { name: 'Recepcionado', index: 'Recepcionado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
            { name: 'Entregado', index: 'Entregado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
            { name: 'Impresa', index: 'Impresa', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Detalle', index: 'Detalle', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'NumeroObra', index: 'NumeroObra', align: 'left', width: 85, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Pedidos', index: 'Pedidos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Comparativas', index: 'Comparativas', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Pedidos', index: 'Pedidos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Recepciones', index: 'Recepciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Salidas', index: 'Salidas', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Libero', index: 'Libero', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: [''] }, hidden: true },
            { name: 'Solicito', index: 'Solicito', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Sector', index: 'Sector', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Usuario_anulo', index: 'Usuario_anulo', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Fecha_anulacion', index: 'Fecha_anulacion', align: 'center', width: 75, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Motivo_anulacion', index: 'Motivo_anulacion', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Fechas_liberacion', index: 'Fechas_liberacion', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'LugarEntrega', index: 'LugarEntrega', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'IdObra', index: 'IdObra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
            { name: 'IdSector', index: 'IdSector', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true }
        ],
        ondblClickRow: function (id) {
            CopiarRM(id);
        },
        loadComplete: function () {
            grid = $(this);
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },
        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroRequerimiento',
        sortorder: "desc",
        viewrecords: true,

        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        //height: '100%',

        //height: '100%',
        height: $(window).height() - ALTOLISTADO, // '100%'

        // height: $(window).height() - 350,
        //////////////////////////////


        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
        //caption: '<b>REQUERIMIENTOS RESUMIDO</b>'
    })
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    // jQuery("#ListaDrag").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });
    // jQuery("#ListaDrag").jqGrid('filterToolbar', {});
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });

    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager',
        { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
        {
            //sopt: ["cn"]
            //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
            width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
        }
    );


    jQuery("#ListaDrag").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/





    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Requerimiento/DetRequerimientosComprables_DynamicGridData',
        postData: { 'IdRequerimiento': function () { return "-1"; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'IdDetalleRequerimiento',
            'N', 'item', 'cod', 'articulo', 'cant pend.',
            'un.', 'Fecha', 'det req.', '', '',
            '', '', '', '', '',
            '', ''
            //                           'Recep.', 'Entreg.',
            //                            'N', 'Fecha', 'Cump.', 'Recep.', 'Entreg.',
            //                         'Impresa', 'Detalle'
        ],
        colModel: [
            { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
            { name: 'IdDetalleRequerimiento', index: 'IdDetalleRequerimiento', align: 'left', width: 40, editable: false, hidden: true },
            { name: 'IdArticulo', index: 'IdArticulo', align: 'right', width: 40, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'IdUnidad', index: 'IdUnidad', width: 30 },
            { name: 'NumeroItem', index: 'NumeroItem', width: 80 },
            { name: 'Cantidad', index: '', width: 40 },
            { name: 'Abreviatura', index: '', width: 100 },
            { name: 'Codigo', index: 'Articulo.Codigo', width: 100 },
            { name: '', index: '', width: 40 },

            { name: 'Descripcion', index: 'Articulo.Descripcion', width: 200 },
            { name: 'FechaEntrega', index: '', width: 40 },
            { name: 'Observaciones', index: 'Observaciones', width: 40, hidden: true },
            { name: 'Cumplido', index: '', width: 40 },
            { name: 'ArchivoAdjunto1', index: '', width: 40 },

            { name: 'OrigenDescripcion', index: 'OrigenDescripcion', width: 40 },
            { name: 'IdRequerimiento', index: 'IdRequerimiento', width: 40 },
            { name: 'NumeroRequerimiento', index: 'Requerimientos.NumeroRequerimiento' },
            { name: '', index: '' },
            { name: '', index: '' }



        ],
        ondblClickRow: function (id) {
            CopiarRMdetalle(id);
        },
        pager: $('#ListaDragPager2'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'Requerimientos.NumeroRequerimiento',
        sortorder: "desc",
        viewrecords: true,
        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        //height: '100%',
        height: $(window).height() - ALTOLISTADO, // '100%'

        altRows: false,
        emptyrecords: 'No hay registros para mostrar' //,
        //caption: '<b>REQUERIMIENTOS DETALLADO</b>'
    })
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag2").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });

    $("#ListaDrag2").remapColumns([17, 16, 4, 7, 9, 5, 6, 8, 10, 11, 15], true, true); // cambiar el orden de las columnas  -parece que arruina el ancho de las columnas



    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });

    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2',
        { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
        {
            //sopt: ["cn"]
            //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
            width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
        }
    );


    jQuery("#ListaDrag2").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/







    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    $("#ListaDrag3").jqGrid({
        url: ROOT + 'Presupuesto/Presupuestos_DynamicGridData',

        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },

        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdPresupuesto', 'Numero', 'Orden', 'Fecha', 'Proveedor', 'Validez', 'Bonif.', '% Iva', 'Mon', 'Subtotal', 'Imp.Bon.', 'Imp.Iva', 'Imp.Total',
            'Plazo_entrega', 'Condicion_compra', 'Garantia', 'Lugar_entrega', 'Comprador', 'Aprobo', 'Referencia', 'Detalle', 'Contacto', 'Observaciones', ''],
        colModel: [
            { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
            { name: 'IdPresupuesto', index: 'IdPresupuesto', align: 'left', width: 100, editable: false, hidden: true },
            { name: 'Numero', index: 'Numero', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'Orden', index: 'SubNumero', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'FechaIngreso', index: 'FechaIngreso', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
            { name: 'Proveedor', index: 'Proveedor.RazonSocial', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Validez', index: 'Validez', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Bonificacion', index: 'Bonificacion', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'PorcentajeIva1', index: 'PorcentajeIva1', align: 'right', width: 40, editable: false, hidden: true },
            { name: 'Moneda', index: 'Moneda', align: 'center', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Subtotal', index: 'Subtotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'ImporteBonificacion', index: 'ImporteBonificacion', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'ImporteIva1', index: 'ImporteIva1', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'PlazoEntrega', index: 'PlazoEntrega', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'CondicionCompra', index: 'CondicionCompra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Garantia', index: 'Garantia', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'LugarEntrega', index: 'LugarEntrega', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Comprador', index: 'Comprador.Nombre', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Aprobo', index: 'Aprobo', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Referencia', index: 'Referencia', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Detalle', index: 'Detalle', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Contacto', index: 'Contacto', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'IdProveedor', index: 'IdProveedor' }
        ],


        ondblClickRow: function (id) {
            CopiarPresupuesto(id);
        },

        pager: $('#ListaDragPager3'),


        rowNum: 15,
        rowList: [10, 20, 50, 100],
        sortname: 'Numero',
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
        userDataOnFooter: true
        // ,caption: '<b>FACTURAS</b>'

        , gridview: true
        , multiboxonly: true
        , multipleSearch: true



        //footerrow: true,
        //userDataOnFooter: true,
        //caption: '<b>SOLICITUDES DE COTIZACION</b>'
    });
    jQuery("#ListaDrag3").jqGrid('navGrid', '#ListaDragPager3', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //        jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });

    jQuery("#ListaDrag3").jqGrid('navGrid', '#ListaDragPager3',
        { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
        {
            //sopt: ["cn"]
            //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
            width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
        }
    );


    jQuery("#ListaDrag3").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/









    //$("#ListaDrag3").jqGrid({
    //    url: ROOT + 'Presupuesto/Presupuestos_DynamicGridData',

    //    postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
    //    datatype: 'json',
    //    mtype: 'POST',
    //    cellEdit: false,
    //    colNames: ['Acciones', 'IdPresupuesto', 'Numero', 'Orden', 'Fecha', 'Proveedor', 'Validez', 'Bonif.', '% Iva', 'Mon', 'Subtotal', 'Imp.Bon.', 'Imp.Iva', 'Imp.Total',
    //                   'Plazo_entrega', 'Condicion_compra', 'Garantia', 'Lugar_entrega', 'Comprador', 'Aprobo', 'Referencia', 'Detalle', 'Contacto', 'Observaciones', ''],
    //    colModel: [
    //                    { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
    //                    {name: 'IdPresupuesto', index: 'IdPresupuesto', align: 'left', width: 100, editable: false, hidden: true },
    //                    { name: 'Numero', index: 'Numero', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'Orden', index: 'Orden', align: 'right', width: 20, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'FechaIngreso', index: 'FechaIngreso', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
    //                    { name: 'Proveedor', index: 'Proveedor', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Validez', index: 'Validez', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Bonificacion', index: 'Bonificacion', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'PorcentajeIva1', index: 'PorcentajeIva1', align: 'right', width: 40, editable: false, hidden: true },
    //                    { name: 'Moneda', index: 'Moneda', align: 'center', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Subtotal', index: 'Subtotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'ImporteBonificacion', index: 'ImporteBonificacion', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'ImporteIva1', index: 'ImporteIva1', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'PlazoEntrega', index: 'PlazoEntrega', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'CondicionCompra', index: 'CondicionCompra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Garantia', index: 'Garantia', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'LugarEntrega', index: 'LugarEntrega', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Comprador', index: 'Comprador', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Aprobo', index: 'Aprobo', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Referencia', index: 'Referencia', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Detalle', index: 'Detalle', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Contacto', index: 'Contacto', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'IdProveedor', index: 'IdProveedor' }
    //                ],
    //    ondblClickRow: function (id) {
    //        CopiarPresupuesto(id);
    //    },
    //    pager: $('#ListaDragPager3'),
    //    rowNum: 15,
    //    rowList: [10, 20, 50],
    //    sortname: 'Numero',
    //    sortorder: "desc",
    //    viewrecords: true,
    //    ///////////////////////////////
    //    width: 'auto', // 'auto',
    //    autowidth: true,
    //    shrinkToFit: false,
    //    //////////////////////////////
    //    height: '100%',
    //    altRows: false,
    //    emptyrecords: 'No hay registros para mostrar' // ,
    //    // caption: '<b>SOLICITUDES DE COTIZACION</b>'
    //})
    //jQuery("#ListaDrag3").jqGrid('navGrid', '#ListaDragPager3', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    ////jQuery("#ListaDrag3").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });






    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    $("#ListaDrag4").jqGrid({
        url: ROOT + 'Comparativa/Comparativas_DynamicGridData',

        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['', '', '', 'Circuito Firmas Completo', 'IdComparativa', 'Numero', 'Fecha Comparativa',

            'Tipo seleccion',
            'Confecciono',
            'Aprobo',
            'Monto previsto',
            'Monto p/cpra',

            'Cant.Sol.',
            'Archivo adjunto 1',
            'Archivo adjunto 2',
            'Anulada',
            'Fecha anulacion',

            'Anulo',
            'Motivo anulacion'


        ],




        colModel: [
            { name: 'editar', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
            { name: 'Imprimir', index: 'Imprimir', align: 'center', width: 40, sortable: false, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Imprimir")'} },
            { name: 'firmar', index: 'Imprimir', align: 'center', width: 0, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Imprimir")'} },

            {
                name: 'CircuitoFirmasCompleto', index: 'CircuitoFirmasCompleto', align: 'left', width: 0, hidden: true,
                editable: false, search: true, searchoptions: { sopt: ['cn'] }
            },

            { name: 'IdFactura', index: 'IdFactura', align: 'left', width: 0, editable: false, hidden: true },
            { name: 'TipoABC', index: 'TipoABC', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'PuntoVenta', index: 'PuntoVenta', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },

            { name: '', index: '', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: '', index: '', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } },



            { name: '', index: '', align: 'left', width: 500, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn'] } }




        ],
        ondblClickRow: function (id) {
            CopiarComparativa(id);
        },
        pager: $('#ListaDragPager4'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'Numero',
        sortorder: "desc",
        viewrecords: true,
        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        //height: '100%',
        height: $(window).height() - ALTOLISTADO, // '100%'

        altRows: false,
        emptyrecords: 'No hay registros para mostrar' //,
        //caption: '<b>COMPARATIVAS</b>'
    })
    jQuery("#ListaDrag4").jqGrid('navGrid', '#ListaDragPager4', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag4").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    $("#ListaDrag5").jqGrid({
        url: ROOT + 'Pedido/Pedidos_DynamicGridData',

        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },


        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdPedido', 'Numero', 'Sub', 'Fecha', 'Salida',
            'Cumplido', 'RMs', 'Obras', 'Proveedor', 'Total',
            'Bonif.', 'IVA', 'Moneda', 'Comprador', 'Aprobo',
            'Items', 'idaux', 'Comparativa', 'TipCompra', 'Observaciones',
            'Detcondcompra', 'PedExterior', 'IdPedAbierto', 'Licitacion', 'Impresa',
            'Anuló', 'Fecha Anulacion', 'MotivAn', 'ImpInts', 'Equipos',
            'CircFirmComp', '', '', '', 'Web'

        ],
        colModel: [

            { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, frozen: true, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
            { name: 'IdPedido', index: 'IdPedido', align: 'left', width: 100, editable: false, hidden: true },
            { name: 'Numero', index: 'Numero', align: 'right', width: 70, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'SubNumero', index: 'Numero', align: 'right', width: 30, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'FechaPedido', index: 'Orden', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
            { name: 'FechaSalida', index: 'FechaIngreso', width: 100, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },

            { name: 'Cumplido', index: 'Proveedor', align: 'left', width: 40, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'RMs', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Obras', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Proveedor', index: 'zzzzzz', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'TotalPedido', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'Bonificacion', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'TotalIva1', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'IdMoneda', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'IdComprador', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Aprobo', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'cantitems', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'idaux', index: 'zzzzzz', align: 'left', width: 100, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'NumeroComparativa', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'IdTipoCompraRM', index: 'zzzzzz', align: 'left', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'Observaciones', index: 'zzzzzz', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'DetalleCondicionCompra', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },


            { name: 'PedidoExterior', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'IdPedidoAbierto', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'NumeroLicitacion', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Impresa', index: 'zzzzzz', align: 'left', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'UsuarioAnulacion', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'FechaAnulacion', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'MotivoAnulacion', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'ImpuestosInternos', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'Equipos', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'CircuitoFirmasCompleto', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
            { name: 'IdCodigoIva', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'IdComprador', index: 'IdComprador', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn'] } },

            { name: 'IdProveedor', index: 'IdProveedor', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn'] } },


            { name: '', index: '', align: 'left', width: 100, hidden: false, editable: false, search: true, searchoptions: { sopt: ['cn'] } }


        ],



        ondblClickRow: function (id) {
            CopiarPedido(id);
        },
        loadComplete: function () {
            grid = $("ListaDrag5");
            //   $("#ListaDrag5 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },

        pager: $('#ListaDragPager5'),

        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroPedido', // 'FechaRecibo,NumeroRecibo',
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
        userDataOnFooter: true
        // ,caption: '<b>FACTURAS</b>'

        , gridview: true
        , multiboxonly: true
        , multipleSearch: true





    });

    jQuery("#ListaDrag5").jqGrid('bindKeys');

    jQuery("#ListaDrag5").jqGrid('navGrid', '#ListaPager',
        { csv: true, refresh: true, add: false, edit: false, del: false }, {}, {}, {},
        {
            //sopt: ["cn"]
            //sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni'],
            width: 700, closeOnEscape: true, closeAfterSearch: true, multipleSearch: true, overlay: false
        }
    );


    jQuery("#ListaDrag5").filterToolbar({
        stringResult: true, searchOnEnter: true,
        defaultSearch: 'cn',
        enableClear: false
    }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/











    //$("#ListaDrag5").jqGrid({
    //    url: ROOT + 'Pedido/Pedidos_DynamicGridData',

    //    postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
    //    datatype: 'json',
    //    mtype: 'POST',
    //    cellEdit: false,
    //    colNames: ['Acciones',
    //                'IdPedido', 'Numero', 'Sub.', 'Fecha', 'Salida',
    //                'Cumplido', '', '', 'Proveedor', '',
    //                'Bonificacion', '', '', '', '',
    //                'Cant.', '', '', '', '', '', '', '',
    //                 '', '', '', '', '',
    //                '', '', '', '', '', ''

    //                ],
    //    colModel: [
    //                    { name: 'act', index: 'act', align: 'center', width: 50, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
    //                    {name: 'IdPedido', index: 'IdPedido', align: 'left', width: 50, editable: false, hidden: true },
    //                    { name: 'Numero', index: 'Numero', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                     { name: 'SubNumero', index: 'Numero', align: 'right', width: 50, frozen: true, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'FechaPedido', index: 'Orden', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
    //                    { name: 'FechaSalida', index: 'FechaIngreso', width: 50, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },

    //                    { name: 'Cumplido', index: 'Proveedor', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'RMs', index: 'zzzzzz', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Obras', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Proveedor', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'TotalPedido', index: 'zzzzzz', align: 'right', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },

    //                    { name: 'Bonificacion', index: 'zzzzzz', align: 'right', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'TotalIva1', index: 'zzzzzz', align: 'right', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'IdMoneda', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Comprador', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Aprobo', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },

    //                    { name: 'cantitems', index: 'zzzzzz', align: 'right', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'idaux', index: 'zzzzzz', align: 'left', width: 0, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'NumeroComparativa', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'IdTipoCompraRM', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Observaciones', index: 'zzzzzz', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },



    //                    { name: 'DetalleCondicionCompra', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'PedidoExterior', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'IdPedidoAbierto', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'NumeroLicitacion', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Impresa', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'UsuarioAnulacion', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'FechaAnulacion', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'MotivoAnulacion', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'ImpuestosInternos', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'Auxiliar1', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'CircuitoFirmasCompleto', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'IdCodigoIva', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                    { name: 'IdComprador', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },

    //                    { name: 'IdProveedor', index: 'zzzzzz', align: 'left', width: 0, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} }


    //                ],
    //    ondblClickRow: function (id) {
    //        CopiarPedido(id);
    //    },
    //    loadComplete: function () {
    //        grid = $("ListaDrag5");
    //        //   $("#ListaDrag5 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
    //    },

    //    pager: $('#ListaDragPager5'),
    //    rowNum: 15,
    //    rowList: [10, 20, 50],
    //    sortname: 'NumeroPedido',
    //    sortorder: "desc",
    //    viewrecords: true,


    //    ///////////////////////////////
    //    width: 'auto', // 'auto',
    //    autowidth: true,
    //    shrinkToFit: false,
    //    //////////////////////////////
    //    height: '100%',
    //    altRows: false,
    //    emptyrecords: 'No hay registros para mostrar' //,


    //})
    //jQuery("#ListaDrag5").jqGrid('navGrid', '#ListaDragPager5', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //// jQuery("#ListaDrag5").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //    // make grid2 sortable
    //    $("#Lista").jqGrid('sortableRows', {
    //        update: function () {
    //            resetAltRows.call(this.parentNode);
    //        }
    //    });




    $("#Bonificacion").change(function () {
        calculateTotal();
    });

    $("#IdMoneda").change(function () {
        var fecha = $("#FechaIngreso").val();
        var IdMoneda = $("#IdMoneda").val();
        if (IdMoneda != 1) {
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Moneda/Moneda_Cotizacion',
                data: { fecha: fecha, IdMoneda: IdMoneda },
                dataType: "json",
                success: function (data) {
                    if (data > 0) {
                        var Cotizacion = data; // data[0]["Cotizacion"];
                        $("#CotizacionMoneda").val(Cotizacion);
                    }
                    else {
                        alert('No hay cotizacion');
                        $('#IdMoneda').val("");
                        $('#CotizacionMoneda').val("");
                    }
                }
            });
        }
        else {
            $('#CotizacionMoneda').val("1");
        }
    });

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('RMs Res.');
    $('a#a_panel_este_tab1').attr('title', 'Requerimientos Resumidos');
    $('a#a_panel_este_tab2').text('RMs Det.');
    $('a#a_panel_este_tab2').attr('title', 'Requerimientos detallados');
    $('a#a_panel_este_tab3').text('Presupuestos');
    $('a#a_panel_este_tab4').text('Comparativas');
    $('a#a_panel_este_tab4').attr('title', 'Comparativas');
    $('a#a_panel_este_tab4').remove();
    $('a#a_panel_este_tab5').text('Pedidos');


    ConectarGrillas1();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });

    $('#a_panel_este_tab2').click(function () {
        ConectarGrillas2();
    });

    $('#a_panel_este_tab3').click(function () {
        ConectarGrillas3();
    });

    $('#a_panel_este_tab4').click(function () {
        ConectarGrillas4();
    });

    $('#a_panel_este_tab5').click(function () {
        ConectarGrillas5();
    });
















    $("#BuscadorPanelDerecho").change(function () {


        var grid = jQuery("#ListaDrag");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
            {
                filters: '',
                searchField: 'NumeroRequerimiento', // Codigo
                searchOper: 'eq',
                searchString: $("#BuscadorPanelDerecho").val()
            });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1 }]);


        var grid = jQuery("#ListaDrag2");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
            {
                filters: '',
                searchField: 'NumeroRequerimiento',
                searchOper: 'eq',
                searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
            });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1 }]);



        var grid = jQuery("#ListaDrag3");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
            {
                filters: '',
                searchField: 'Numero',
                searchOper: 'eq',
                searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
            });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1 }]);


        var grid = jQuery("#ListaDrag4");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
            {
                filters: '',
                searchField: 'Numero', // 'NumeroComparativa',
                searchOper: 'eq',
                searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
            });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1 }]);


        var grid = jQuery("#ListaDrag5");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
            {
                filters: '',
                searchField: 'NumeroPedido',
                searchOper: 'eq',
                searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
            });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1 }]);







        //<select><option value="NumeroRequerimiento" selected="selected">N°</option><option value="Detalle">Detalle</option><option value="NumeroObra">Obra</option><option value="Sector">Sector</option><option value="Observaciones">Observaciones</option><option value="LugarEntrega">Lugar de necesidad</option></select>
    });








    function pickdates(id) {
        jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
    }





});





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// total del item
function CalcularImportes() {

    var pbglobal = parseFloat($("#Totales").find("#PorcentajeBonificacion").val().replace(",", ".") || 0) || 0;


    if ($("#editmodLista").attr('aria-hidden') == undefined || $("#editmodLista").attr('aria-hidden') == 'true') {
        // $("#Lista [name='Precio']") // si esta en modo inline....
        // http://stackoverflow.com/questions/2109754/jqgrid-reload-grid-after-successfull-inline-update-inline-creation-of-record
        // jQuery("#grid_id").jqGrid('editRow', rowid, keys, oneditfunc, succesfunc, url, extraparam, aftersavefunc, errorfunc, afterrestorefunc);


        //var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');


        //  var sss = $("input:focus").closest("tr");
        //[aria-selected='true']


        // no debo usar "aria-selected": el renglon que está siendo editado no necesariamente está marcado con "check" de elegido. -ademas, puede haber más de un elegido! 
        // -sí, es verdad... más aún: puede haber más de un renglon en modo de edicion!!! -Entonces? cómo sé cuál ha sido la última celda modificada (sin grabar todavía), y su renglon?

        try {
            var pb = parseFloat($("#Lista [aria-selected='true'] [name='PorcentajeBonificacion']").val().replace(",", ".") || 0) || 0; //este es del item
            if (isNaN(pb)) { pb = 0; }
            var pr = parseFloat($("#Lista [aria-selected='true'] [name='Precio']").val().replace(",", ".") || 0) || 0;
            var cn = parseFloat($("#Lista [aria-selected='true'] [name='Cantidad']").val().replace(",", ".") || 0) || 0;
            var pi = parseFloat($("#Lista [aria-selected='true'] [name='PorcentajeIva']").val().replace(",", ".") || 0) || 0;
            var st = Math.round(pr * cn * 10000) / 10000;


            ///////////////////////////////////////////////////////
            //bonif item
            var ib = Math.round(st * pb / 100 * 10000) / 10000;
            st = st - ib;
            // bonif global
            var bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
            st = st - bg;
            ////////////////////////////////////////////////////



            var ii = Math.round(st * pi / 100 * 10000) / 10000;
            var it = Math.round((st + ii) * 10000) / 10000;



            $("#Lista  [aria-selected='true'] [name='ImporteBonificacion']").val(ib.toFixed(4));
            $("#Lista [aria-selected='true']  [name='ImporteIva']").val(ii.toFixed(4));
            $("#Lista [aria-selected='true']  [name='ImporteTotalItem']").val(it.toFixed(4));
        } catch (e) {

            LogJavaScript("Error en Script Pedido   ", e);

        }


        return false;
    }





    var pb = parseFloat($("#PorcentajeBonificacion").val().replace(",", ".") || 0) || 0; //este es del item
    if (isNaN(pb)) { pb = 0; }
    var pr = parseFloat($("#Precio").val().replace(",", ".") || 0) || 0;
    var cn = parseFloat($("#Cantidad").val().replace(",", ".") || 0) || 0;
    var pi = parseFloat($("#PorcentajeIva").val().replace(",", ".") || 0) || 0;
    var st = Math.round(pr * cn * 10000) / 10000;


    ///////////////////////////////////////////////////////
    //bonif item
    var ib = Math.round(st * pb / 100 * 10000) / 10000;
    st = st - ib;
    // bonif global
    var bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
    st = st - bg;
    ////////////////////////////////////////////////////



    var ii = Math.round(st * pi / 100 * 10000) / 10000;
    var it = Math.round((st + ii) * 10000) / 10000;



    $("#ImporteBonificacion").val(ib.toFixed(4));
    $("#ImporteIva").val(ii.toFixed(4));
    $("#ImporteTotalItem").val(it.toFixed(4));
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




