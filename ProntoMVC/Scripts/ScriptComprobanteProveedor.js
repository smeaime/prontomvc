
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







////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// total generales y del pie de la grilla
function CalcularTodos() {

    var DECIMALES = 2;


    var totalCantidad = $('#Lista').jqGrid('getCol', 'Importe', false, 'sum')

    var colnames = $("#Lista").jqGrid('getGridParam', 'colNames');

    var pr, cn, st, ib, ib_, ib_t, pi, ii, st1, ib1, ib2, ii1, st2, pb, st3, tp, tg;
    st1 = 0;
    ib1 = 0;
    ib2 = 0;
    ii1 = 0;
    pb = parseFloat($("#PorcentajeBonificacion").val().replace(",", "."));
    if (isNaN(pb)) { pb = 0; }
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        pr = parseFloat(data['Importe'].replace(",", "."));
        if (isNaN(pr)) { pr = 0; }
        cn = 1 // parseFloat(data['Cantidad'].replace(",", "."));
        if (isNaN(cn)) { cn = 0; }
        st = Math.round(pr * cn * 10000) / 10000;
        st1 = Math.round((st1 + st) * 10000) / 10000;
        ////////////////////////////////////////////////////
        ////////////////////////////////////////////////////
        var pbi = parseFloat(data['PorcentajeBonificacion'].replace(",", ".")) || 0;
        ib = Math.round(st * pbi / 100 * 10000) / 10000;    //  parseFloat(data['ImporteBonificacion'].replace(",", "."));
        if (isNaN(ib)) { ib = 0; }
        ib1 = ib1 + ib;
        ib_ = Math.round((st - ib) * pb / 100 * 10000) / 10000;
        ib2 = ib2 + ib_;
        ib_t = (ib1 + ib_) || 0;
        ////////////////////////////////////////////////////
        ////////////////////////////////////////////////////

        pi = 0;


        for (var ii = 1; ii <= 10; ii++) {
            if (data['AplicarIVA' + ii] == "True") {


              //  metodo normal
              //   pi += parseFloat(data['IVAComprasPorcentaje' + ii].replace(",", ".") || 0);


              // metodo feo: en lugar de tomar el porcentaje de iva desde la celda adyacente, lo traigo del encabezado. en realidad, este metodo es 
              // más feo, pero me libera, por ahora, de agregar datos al poner renglones en blanco del lado del cliente
                var index = getColumnSrcIndexByName($("#Lista"), 'AplicarIVA' + ii);
                //está desfasado el indice por lo que dice Oleg: http://stackoverflow.com/questions/5476068/jqgrid-get-all-grids-column-names
                //The only small problem is that the array columnNames will contain up to three empty first elements in case of you use rownumbers:true, multiselect:true or subGrid:true parameters. 
                pi += parseFloat(colnames[index+2].replace(",", ".") || 0);

            }
        }

//        if (data['AplicarIVA2'] == "True") pi += parseFloat(data['IVAComprasPorcentaje2'].replace(",", "."));
//        if (data['AplicarIVA3'] == "True") pi += parseFloat(data['IVAComprasPorcentaje3'].replace(",", "."));
//        if (data['AplicarIVA4'] == "True") pi += parseFloat(data['IVAComprasPorcentaje4'].replace(",", "."));
//        // pi = parseFloat(data['PorcentajeIva'].replace(",", "."));
        data['PorcentajeIva'] = pi.toFixed(DECIMALES) || 0;
        ////////////////////////////////////////////////////


        ii = (Math.round((st - ib - ib_) * pi / 100 * 10000) / 10000) || 0;
        ii1 = ii1 + ii
        tp = (st - ib_t + ii) || 0;
        // por qu� aplica el global sobre los items? est� bien? 
        // y si est� bien, no debe usarse a s� mismo (como en la linea ib = parseFloat(data['ImporteBonificacion']. etc)
        // porque si no, se va aplicando a s� mismo cada vez que editas el item


        data['ImporteBonificacion'] = ib_t.toFixed(DECIMALES) || 0;
        data['ImporteIva'] = ii.toFixed(DECIMALES) || 0;
        data['ImporteTotalItem'] = tp.toFixed(DECIMALES) || 0;
        $('#Lista').jqGrid('setRowData', dataIds[i], data);
    }
    st2 = Math.round((st1 - ib1) * 10000) / 10000;
    st3 = Math.round((st2 - ib2) * 10000) / 10000;
    tg = Math.round((st3 + ii1) * 10000) / 10000;




    $("#Subtotal1").val(st1.toFixed(DECIMALES));
    $("#TotalBonificacionItems").val(ib1.toFixed(DECIMALES));
    $("#TotalBonificacionGlobal").val(ib2.toFixed(DECIMALES));
    $("#Subtotal2").val(st3.toFixed(DECIMALES));
    $("#TotalIva").val(ii1.toFixed(DECIMALES));
    $("#Total").val(tg.toFixed(DECIMALES));

    $("#TotalTitulo").val("Total " + tg.toFixed(DECIMALES));



    $('#Lista').jqGrid('footerData', 'set', { NumeroObra: 'TOTALES', Importe: totalCantidad.toFixed(DECIMALES),
        ImporteBonificacion: ib1.toFixed(DECIMALES),
        ImporteIva: ii1.toFixed(DECIMALES),
        ImporteTotalItem: tg.toFixed(DECIMALES)
    });
};


var getColumnSrcIndexByName = function (grid, columnName) {
    var cm = grid.jqGrid('getGridParam', 'colModel'),
        i = 0, index = 0, l = cm.length, cmName;
    while (i < l) {
        cmName = cm[i].name;
        i++;
        if (cmName === columnName) {
            return index;
        } else if (cmName !== 'rn' && cmName !== 'cb' && cmName !== 'subgrid') {
            index++;
        }
    }
    return -1;
};



// total del item -ok, pero para recalcular en el popup form del jqgrid, no en la celledit
function CalcularItem() {
    var pbglobal = parseFloat($("#Totales").find("#PorcentajeBonificacion").val().replace(",", ".") || 0);
    //var pbglobal = 0; //  parseFloat($("#PorcentajeBonificacion").val().replace(",", "."));


    var pb = parseFloat($("#PorcentajeBonificacion").val() || 0); //este es del item
    if (isNaN(pb)) { pb = 0; }
    var pr = parseFloat($("#Precio").val());
    var cn = parseFloat($("#Cantidad").val());
    var pi = parseFloat($("#PorcentajeIva").val());
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


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




function RefrescarRestoDelRenglon(rowid, name, val, iRow, iCol) {

    /*

    ok, la cuestion es que, usando celledit (es decir, la edicion inline por celda, no por renglon entero), cuando cambio el valor
    dentro de un autocomplete, no puedo refrescar la celda adyacente de id porque no está en modo edicion. es decir, tendría que hacerlo
    una vez que pone enter, es decir, no en el evento 'select' del autocomplete creado dentro del editoptions de la columna, sino en el afterSaveCell general de la grilla. 
    Lo que pasa es... que en el evento select sí dispongo del id del elemento elegido. En cambio, en el afterSaveCell lo debo ir a buscar de nuevo, usando el texto
    que está en pantalla. El único problema con esto es si hay descripciones repetidas.
    -Bueno, pero tambien tengo que hacer un CASE para distinguir si me estan cambiando los articulos o las unidades, etc! 


    y si uso un renglon temporal global?

    */

    var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
    var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);


    var cm = jQuery("#Lista").jqGrid("getGridParam", "colModel");
    var colName = cm[iCol]['index'];
    //alert(colName);


    switch (colName) {



    }
    //    alert(colName);

    if (colName == "Descripcion") {

        // alert(iCol);
        //  if (iCol == 12) {   // esto siempre y cuando el cambio haya sido del nombre de articulo


        $.post(ROOT + 'Cuenta/GetCuentasAutocomplete',  // ?term=' + val
                {term: val }, // JSON.stringify(val)},
                function (data) {
                    if (data.length > 0) {
                        var ui = data[0];
                        // alert(ui.value);



                        //var data = $('#Lista').jqGrid('getRowData', iRow);

                        sacarDeEditMode(); // me salvó esto!! (porque en el caso de que aprieten TAB, no está bueno que quede una celda en edicion mientras estas grabando)

                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);



                        data['IdCuenta'] = ui.id;
                        data['Codigo'] = ui.codigo;
                        data['Descripcion'] = ui.title;

                        data['IdDetalleComprobanteProveedor'] = data['IdDetalleComprobanteProveedor'] || 0;


                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
 FinRefresco();
                    }
                    else {

                        // hay que cancelar la grabacion
                    }
                }
        );
    }


    if (colName == "Codigo") {

        // alert(iCol);
        //  if (iCol == 12) {   // esto siempre y cuando el cambio haya sido del nombre de articulo


        $.post(ROOT + 'Cuenta/GetCodigosCuentasAutocomplete2',  // ?term=' + val
                {term: val }, // JSON.stringify(val)},
                function (data) {
                    if (data.length > 0) {
                        var ui = data[0];
  sacarDeEditMode();
                        // alert(ui.value);



                        //var data = $('#Lista').jqGrid('getRowData', iRow);



                        var dataIds = $('#Lista').jqGrid('getDataIDs'); // me traigo los datos
                        var data = $('#Lista').jqGrid('getRowData', dataIds[iRow - 1]);




                        data['IdCuenta'] = ui.id;
                        data['Codigo'] = ui.codigo;
                        data['Descripcion'] = ui.title;

                        data['IdDetalleComprobanteProveedor'] = data['IdDetalleComprobanteProveedor'] || 0;


                        $('#Lista').jqGrid('setRowData', dataIds[iRow - 1], data); // vuelvo a grabar el renglon
                    }
                    else {

                        // hay que cancelar la grabacion
                    }
                }
        );
    }


    /// ojito con lo que pones acá!, que las llamadas a post son asincrónicas y se ejecutarán probablemente antes de que terminen
    /// ojito con lo que pones acá!, que las llamadas a post son asincrónicas y se ejecutarán probablemente antes de que terminen
    /// ojito con lo que pones acá!, que las llamadas a post son asincrónicas y se ejecutarán probablemente antes de que terminen




    CalcularTodos();
    RefrescarOrigenDescripcion();
}


function FinRefresco() {
    CalcularTodos();
    RefrescarOrigenDescripcion();
            AgregarRenglonesEnBlanco({ "IdDetalleComprobanteProveedor": "0", "IdCuenta": "0", "Precio": "0", "Descripcion": "" });

}




function SerializaForm() {



    //$("#Lista").getChangedCells('dirty')
    //jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);





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
    cabecera.DetalleComprobantesProveedores = [];


    cabecera.IdProveedor = $("#IdProveedor").val();
    // como no le encontre la vuelta a automatizar la serializacion de inputs disableados, los pongo manualmente
    // como no le encontre la vuelta a automatizar la serializacion de inputs disableados, los pongo manualmente
    //cabecera.NumeroFactura = $("#NumeroFactura").val();

    //            cabecera.IdPedido = $("#IdPedido").val();
    //            cabecera.Numero = $("#Numero").val();
    //            cabecera.SubNumero = $("#SubNumero").val();
    cabecera.FechaIngreso = FechaIngles($("#FechaIngreso").val());
    //            cabecera.IdProveedor = $("#IdProveedor").val();
    //            cabecera.Validez = $("#Validez").val();
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

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        try {
            try {
                $('#Lista').jqGrid('saveRow', dataIds[i], false, 'clientArray');
            } catch (e) {
                $('#Lista').jqGrid('restoreRow', dataIds[i]);
                //                alert("SerializaForm(): problema al hacer saverow de un renglon inline en modo edicion.  " + e);
                //                return;
                continue;
            }


            var data = $('#Lista').jqGrid('getRowData', dataIds[i]);


            var iddeta = data['IdDetalleComprobanteProveedor'];
            //alert(iddeta);
            if (!iddeta) continue;


            data1 = '{"IdComprobanteProveedor":"' + $("#IdComprobanteProveedor").val() + '",'
            for (var j = 0; j < colModel.length; j++) {
                cm = colModel[j]
                if (cm.label === 'TB') {
                    valor = data[cm.name];






                    if (cm.name === 'Cantidad') valor = valor.replace(".", ",")
                    if (cm.name === 'Importe') valor = valor.replace(".", ",")
                    if (cm.name === 'Importe') valor = valor.replace(".", ",")
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

                    if (cm.name.indexOf("AplicarIVA") >= 0) {
                        valor = (data[cm.name] == 'True' ? 'SI' : 'NO');
                    }


                    //                    AplicarIVA1=                      Check_Iva1
                    //                    AplicarIVA2 = Check_Iva2

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
            cabecera.DetalleComprobantesProveedores.push(data2);
        }
        catch (ex) {
            $('#Lista').jqGrid('restoreRow', dataIds[i]);
            alert("SerializaForm(): No se pudo serializar el comprobante. Quizas convenga grabar todos los renglones de la jqgrid (saverow) antes de hacer el post ajax. En cuanto sacas los renglones del modo edicion, no tira más este error  " + ex);
            return;
        }
    }


    return cabecera;

}
$(function () {




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
    //////////////////////////DEFINICION DE GRILLAS   ///////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    

    $('#Lista').jqGrid({
        url: ROOT + 'ComprobanteProveedor/DetComprobantesProveedor/',
        postData: { 'IdComprobanteProveedor': function () { return $("#IdComprobanteProveedor").val(); } },
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleComprobanteProveedor', 'IdCuenta', 'IdUnidad', '#', 'Obra', 'Cant.', 'Un.', 'cód.',
        'Cuenta', 'Cuenta', 'Importe'

             , '', '', '', ''
                       , '', '', '', ''
                      , '', '', '', ''
                      , '', '', '', ''
                      , '', '', '', ''

                       , '', '', '', ''
                       , '', '', '', ''
                      , '', '', '', ''
                      , '', '', '', ''
                         , '', '', '', ''

        , '% Bon.', 'Imp.Bon.', '% Iva',
                       'Imp.Iva', 'Imp.Total', 'Entrega', 'Necesidad', 'Observ', 'Nro.RM',
                       'ItemRM', 'Adj1',

                       'IdDetalleRequerimiento', 'IdDetallePresupuesto', 'OrigenDescripcion', 'IdCentroCosto'


                       ],
        colModel: [
                        { name: 'act', formoptions: { rowpos: 1, colpos: 1 }, index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                        { name: 'IdDetalleComprobanteProveedor', formoptions: { rowpos: 2, colpos: 1 },
                            index: 'IdDetalleComprobanteProveedor', label: 'TB', align: 'left', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: false }
                        },
                        { name: 'IdCuenta', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdCuenta', label: 'TB',
                            align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
                        },
                        { name: 'IdUnidad', formoptions: { rowpos: 4, colpos: 1 },
                            index: 'IdUnidad', label: 'TB', align: 'left', width: 85, editable: true,
                            hidden: true, editrules: { edithidden: true, required: false }
                        },

                        { name: 'NumeroItem', formoptions: { rowpos: 5, colpos: 1 },
                            editoptions: { disabled: true },
                            index: 'NumeroItem', label: 'TB',
                            align: 'right', width: 20, hidden: true, editable: true, edittype: 'text', editrules: { required: false }
                        },

                        { name: 'NumeroObra', formoptions: { rowpos: 6, colpos: 1 }, index: 'NumeroObra', label: 'TB', align: 'center', width: 60, sortable: false, hidden: true, editable: false },

                        { name: 'Cantidad', formoptions: { rowpos: 7, colpos: 1 }, index: 'Cantidad', label: 'TB'
                            , align: 'right', width: 80, editable: true, hidden: true, edittype: 'currency',
                            editoptions: { maxlength: 20,
                                defaultValue: '0.00',
                                dataEvents: [{ type: 'change', fn: function (e) { CalcularItem(); } }]
                            }
                            , editrules: { required: false }

                            // decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, prefix: "", suffix:""
                                        , defaultValue: 0

                        },







                        { name: 'Unidad', formoptions: { rowpos: 7, colpos: 2 }, index: 'Unidad', align: 'center',
                            width: 60, editable: true, hidden: true, edittype: 'select', editrules: { required: false },
                            editoptions: {

                                dataUrl: ROOT + 'Articulo/Unidades',
                                dataEvents: [{ type: 'change', fn: function (e) { $('#IdUnidad').val(this.value); } }]
                            }
                        },
                        { name: 'Codigo', formoptions: { rowpos: 8, colpos: 1 }, index: 'Codigo', align: 'center', width: 80, editable: true, edittype: 'text',
                            editoptions: {
                                dataInit: function (elem) {
                                    $(elem).autocomplete({
                                        source: ROOT + 'Cuenta/GetCodigosCuentasAutocomplete2',

                                        minLength: 3,
                                        select: function (event, ui) {

                                            $("#IdCuenta").val(ui.item.id);
                                            $("#CodigoCuenta").val(ui.item.codigo); // por qué acá traes la propiedad codigo en lugar de value? -porque sugiero un texto pero al seleccionar solo tomo un pedazo
                                            $("#Descripcion").val(ui.item.title);
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
                            { formoptions: { rowpos: 9, colpos: 2 }, name: 'DescripcionFalsa', index: '', editable: false, hidden: true, width: 400,
                                editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
                            },

                        { name: 'Descripcion', formoptions: { rowpos: 8, colpos: 2, label: "Descripción" }, index: 'Descripcion', align: 'left', width: 400,
                            hidden: false,
                            editable: true, edittype: 'text',
                            editoptions: { rows: '1', cols: '1',
                                dataInit: function (elem) {
                                    $(elem).autocomplete({

                                        source: ROOT + 'Cuenta/GetCuentasAutocomplete',
                                        minLength: 0,
                                        select: function (event, ui) {
                                            // cómo hago si la modificacion se hizo en modo inline??????


                                            //if ($($("#Lista").jqGrid("getInd", rowid, true)).attr("editable") === "1") {
                                            // the row having id=rowid is in editing mode


                                            //                                            }
                                            //                                          else {

                                            $("#IdCuenta").val(ui.item.id);
                                            $("#CodigoCuenta").val(ui.item.codigo); // por qué acá traes la propiedad codigo en lugar de value? -porque sugiero un texto pero al seleccionar solo tomo un pedazo
                                            $("#Descripcion").val(ui.item.title);
                                            //}

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
                            editrules: { required: false }
                        },
                        { name: 'Importe', formoptions: { rowpos: 9, colpos: 1 },
                            index: 'Importe', label: 'TB', align: 'right', width: 100, editable: true, edittype: 'text',
                            //formatter: 'number',
                            formatter: numFormat, unformat: numUnformat,
                            editoptions: { defaultValue: '0.00', maxlength: 20,



                                dataEvents: [
                                        {
                                            type: 'change', fn: function (e) { CalcularItem(); }
                                        },

                                         {
                                             type: 'keydown',
                                             fn: function (e) {
                                                 var key = e.charCode || e.keyCode;
                                                 if (key == 13)//enter
                                                 {
                                                     // setTimeout("jQuery('#inventuraGrid').editCell(" + selIRow + " + 1, " + selICol + ", true);", 100);
                                                     //  alert(key);
                                                 }
                                             }
                                         }
                                ]





                            }, editrules: { required: false }
                        }












        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////




                    , { name: 'AplicarIVA1', index: 'Check_1', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', width: 30, classes: 'cvteste', align: 'center', label: 'TB',

                        formatter: "checkbox", //boolformatter, // cboxFormatter, // "checkbox",

                        formatoptions: { disabled: false }

                        , editoptions: { value: "True:False" }

                        , formoptions: { rowpos: 29, colpos: 1 }
                    }

                    , { name: 'desc1', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras1', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje1', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA2', index: 'Check_2', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", // cboxFormatter,
                        formatoptions: { disabled: false }
                        , formoptions: { rowpos: 30, colpos: 1 }
                    }

                    , { name: 'desc2', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras2', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje2', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA3', index: 'Check_2', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                   , formoptions: { rowpos: 31, colpos: 1 }
                    }

                    , { name: 'desc3', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras3', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje3', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA4', index: 'Check_4', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                        , formoptions: { rowpos: 32, colpos: 1 }
                    }
                    , { name: 'desc4', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras4', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje4', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA5', index: 'Check_5', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                           , formoptions: { rowpos: 33, colpos: 1 }
                    }
                    , { name: 'desc5', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras5', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje5', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA6', index: 'Check_6', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                          , formoptions: { rowpos: 34, colpos: 1 }
                    }
                    , { name: 'desc6', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras6', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje6', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA7', index: 'Check_7', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                            , formoptions: { rowpos: 35, colpos: 1 }
                    }
                    , { name: 'desc7', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras7', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje7', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA8', index: 'Check_8', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                           , formoptions: { rowpos: 36, colpos: 1 }
                    }
                    , { name: 'desc8', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras8', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje8', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA9', index: 'Check_9', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                           , formoptions: { rowpos: 37, colpos: 1 }
                    }
                    , { name: 'desc9', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras9', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje9', index: '', hidden: true, editable: false, edittype: 'text' }


                    , { name: 'AplicarIVA10', index: 'Check_10', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste', align: 'center', label: 'TB',
                        formatter: "checkbox", formatoptions: { disabled: false }
                                           , formoptions: { rowpos: 38, colpos: 1 }
                    }
                    , { name: 'desc10', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IdCuentaIvaCompras10', index: '', hidden: true, editable: false, edittype: 'text' }
                    , { name: 'IVAComprasPorcentaje10', index: '', hidden: true, editable: false, edittype: 'text' }
                    ,
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////



                        {
                        name: 'PorcentajeBonificacion',
                        formoptions: { rowpos: 10, colpos: 1 },
                        index: 'PorcentajeBonificacion', label: 'TB', align: 'right', width: 50,
                        editable: true, edittype: 'text',
                        editoptions: { maxlength: 20,
                            defaultValue: '0.00'
                        },
                        dataEvents: [{ type: 'change', fn: function (e) { CalcularItem(); } }]
                    }
                        ,
                        { name: 'ImporteBonificacion', formoptions: { rowpos: 11, colpos: 1 }, index: 'ImporteBonificacion', label: 'TB', align: 'right', width: 50, editable: true, editoptions: { disabled: 'disabled'} },
                        { name: 'PorcentajeIva', formoptions: { rowpos: 12, colpos: 1 }, index: 'PorcentajeIva', label: 'TB',
                            align: 'right', width: 100, editable: false,
                            editoptions: {
                                defaultValue: '21.00',
                                maxlength: 20
                            },
                            dataEvents: [{ type: 'change', fn: function (e) { CalcularItem(); } }]
                        },

                        { name: 'ImporteIva', formoptions: { rowpos: 13, colpos: 1 }, index: 'ImporteIva', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled'} },
                        { name: 'ImporteTotalItem', formoptions: { rowpos: 14, colpos: 1 }, index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled'} },
                        { name: 'FechaEntrega', formoptions: { rowpos: 15, colpos: 1 },
                            index: 'FechaEntrega', label: 'TB', width: 300, align: 'center',
                            sorttype: 'date', editable: true,
                            formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                            editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: false }
                        },
                        { name: 'FechaNecesidad', formoptions: { rowpos: 15, colpos: 2 },
                            index: 'FechaNecesidad', label: 'TB', width: 300, align: 'center',
                            sorttype: 'date', editable: true,
                            formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                            editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: false }
                        },
                        { name: 'Observaciones', formoptions: { rowpos: 16, colpos: 1 }, index: 'Observaciones',
                            label: 'TB', align: 'left', width: 600, editable: true,
                            // edittype: 'textarea', no se como evitar que el inline de textarea no me haga muy alto el renglon
                            editoptions: { rows: '1', cols: '40' }
                        }, //editoptions: { dataInit: function (elem) { $(elem).val(inEdit ? "Modificado" : "Nuevo"); }

                        {name: 'NumeroRequerimiento', formoptions: { rowpos: 1, colpos: 2 }, hidden: true,
                        editoptions: { rows: '1', cols: '1', disabled: true },
                        index: 'NumeroRequerimiento', label: 'TB', edittype: 'text',
                        align: 'right', width: 40, sortable: false, editable: false, editrules: { readonly: 'readonly' }
                    },
                        { name: 'NumeroItemRM', hidden: true, formoptions: { rowpos: 1, colpos: 3 },
                            editoptions: { rows: '1', cols: '1', disabled: true },
                            index: 'NumeroItemRM', label: 'TB', align: 'right', edittype: 'text',
                            width: 50, sortable: false, editable: false, editrules: { readonly: 'readonly' }
                        },

                        { name: 'Adj. 1', index: 'ArchivoAdjunto1', label: 'TB', align: 'left', width: 100, editable: true, edittype: 'file',
                            editoptions: { enctype: "multipart/form-data", dataEvents: [{ type: 'change', fn: function (e) {
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
                        { name: 'IdDetalleRequerimiento', label: 'TB', hidden: true, editoptions: { defaultValue: '-1'} },
                        { name: 'IdDetallePresupuesto', label: 'TB', hidden: true, editoptions: { defaultValue: '-1'} },

        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////

        // radio buttons en el popup del jqgrid
        // http://www.trirand.com/jqgridwiki/doku.php?id=wiki:common_rules#custom
                        {name: 'OrigenDescripcion', label: 'TB', formoptions: { rowpos: 11, colpos: 2, label: "Tomar"}  // "Tomar la descripción de" }
                        , index: 'OrigenDescripcion',
                        align: 'center', width: 35, editable: true, hidden: true, edittype: 'select', // edittype: 'custom',
                        // formatter: radioFormatter, unformat: unformatRadio,
                        editrules: { required: true
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



                    ],




        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////


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

            // http://stackoverflow.com/questions/8333933/highlight-cell-value-on-doubleclick-for-copy
            //selectText(e.target);
        },

        ondblClickRow: function (id) {

            //////////////////////////////////////////////////////
            //////////////////////////////////////////////////////
            //            if (typeof lastSelectedId !== "undefined") {
            //                // grid.jqGrid('saveRow', lastSelectedId);
            //                grid.jqGrid('restoreRow', lastSelectedId);
            //            }


            //            var ids = jQuery("#Lista").jqGrid('getDataIDs');
            //            for (var i = 0; i < ids.length; i++) {

            //                grid.jqGrid('restoreRow', ids[i]);
            //            }

            //////////////////////////////////////////////////////
            //////////////////////////////////////////////////////


            jQuery('#Lista').jqGrid('restoreCell', lastRowIndex, lastColIndex, true);




            dobleclic = true;
            $("#edtData").click();
        },

        onClose: function (data) {
            RefrescarOrigenDescripcion();
        },

        gridComplete: function () {
            var ids = jQuery("#Lista").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                var be = "<input style='height:22px;width:20px;' type='button' value='E' onclick=\"jQuery('#Lista').editRow('" + cl + "',true,pickdates);\"  />";
                var se = "<input style='height:22px;width:20px;' type='button' value='S' onclick=\"jQuery('#Lista').saveRow('" + cl + "');\"  />";
                var ce = "<input style='height:22px;width:20px;' type='button' value='C' onclick=\"jQuery('#Lista').restoreRow('" + cl + "');\" />";
                jQuery("#Lista").jqGrid('setRowData', ids[i], { act: be + se + ce });
                CalcularTodos();
            }
            RefrescarOrigenDescripcion();

            for (var i = 1; i <= 10; i++) {
                var data = $('#Lista').jqGrid('getRowData', ids[0]);
                jQuery("#Lista").jqGrid('setLabel', 'AplicarIVA' + i, data['IVAComprasPorcentaje' + i]);
                if (!data['IdCuentaIvaCompras' + i]) $("#Lista").hideCol("AplicarIVA" + i);
            }
        },


        afterEditCell: function (rowid, cellname, value, iRow, iCol) {
        
            var $input = $("#" + iRow + "_" + cellname);
            $input.select(); // acá me marca el texto

            //http://jsfiddle.net/ironicmuffin/7dGrp/
            //http://fiddle.jshell.net/qLQRA/show/

            // alert('hola'); 
        },

        afterSaveCell: function (rowid, name, val, iRow, iCol) {
            //alert('afterSaveCell');
            RefrescarRestoDelRenglon(rowid, name, val, iRow, iCol);
            CalcularTodos();

            // RefrescarOrigenDescripcion();
        },


        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //        http://stackoverflow.com/questions/9170260/jqgrid-all-rows-in-inline-edit-mode-by-default
        //                You have to enumerate all rows of grid and call editRow for every row. The code can be like the following


        loadComplete: function () { //si uso esto, no puedo usar tranquilo lo de aria-selected para el refresco de la edicion inline

            AgregarRenglonesEnBlanco({ "IdDetalleComprobanteProveedor": "0", "IdCuenta": "0", "Precio": "0", "Descripcion": "" });

            var $this = $(this), ids = $this.jqGrid('getDataIDs'), i, l = ids.length;
            for (i = 0; i < l; i++) {
                // $this.jqGrid('editRow', ids[i], true);
            }
        },
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
        rownumbers: true,
        footerrow: true,
        userDataOnFooter: true
                     , multiselect: true

        //loadonce: true,
        // caption: '<b>ITEMS DE LA SOLICITUD DE COTIZACION</b>'




        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        // http://stackoverflow.com/questions/14662632/jqgrid-celledit-in-json-data-shows-url-not-set-alert
         ,
        cellEdit: true,
        cellsubmit: 'clientArray'
        , editurl: ROOT + 'ComprobanteProveedor/EditGridData/' // pinta que esta es la papa: editurl con la url, y cellsubmit en clientarray
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////

    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {},
                                { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //    jQuery("#Lista").jqGrid('setFrozenColumns');

    jQuery("#Lista").jqGrid('bindKeys', {
        "onEnter": function (rowid) {
            //            if(rowid && rowid!==lastSel){
            //                jQuery(this).restoreRow(lastSel);
            //                lastSel=rowid;
            //            }
            //            jQuery(this).editRow(rowid, true, null, null, '', null, function() {
            //                $('#2').click();
            //                alert ('aftersavefunc');
            //            });

            alert("You enter a row with id:" + rowid);
        },
        onSpace: null,
        onLeftKey: null, onRightKey: null,
        scrollingRows: true
    });

    // http://stackoverflow.com/questions/2022069/jqgrid-navigate-rows-using-up-down-arrow-keys
    // http://www.trirand.com/jqgridwiki/doku.php?id=wiki%3amethods
    $("#Lista").bind('keydown', function (e) {
        //if (e.keyCode == 38 || e.keyCode == 40)
        // alert('hola'); // e.preventDefault();
    });



    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////FIN DE DEFINICION DE GRILLALISTA   ////////////////////////////////////////////////
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
function CopiarRMdetalle(acceptId, ui) {

    // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
    var getdata = jQuery("#ListaDrag2").jqGrid('getRowData', acceptId);

    var j = 0, dropname, IdRequerimiento;
    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
    var grid;

    IdRequerimiento = getdata['IdRequerimiento']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas
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
                numitem = getdata['NumeroItem'] - 1;

                CopiarItemRM(data, numitem);
                Validar();
            }
        })





    } catch (e) { }

}






///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////




function CopiarItemRM(data, i) {

    var tmpdata = {};



    var longitud = data.length;


    tmpdata['IdArticulo'] = data[i].IdArticulo;
    tmpdata['Codigo'] = data[i].Codigo;
    tmpdata['Descripcion'] = data[i].Descripcion;
    tmpdata['IdUnidad'] = data[i].IdUnidad;
    tmpdata['Unidad'] = data[i].Unidad;
    tmpdata['IdDetalleComprobanteProveedor'] = 0;
    tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
    tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
    tmpdata['NumeroItemRM'] = data[i].NumeroItem;
    tmpdata['Cantidad'] = data[i].Cantidad;
    tmpdata['NumeroObra'] = data[i].NumeroObra;




    ///////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////

    tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
    tmpdata['Observaciones'] = data[i].Observaciones;

    ///////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////

    if (true) {
        // fecha de hoy
        var now = new Date();
        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
        tmpdata['FechaEntrega'] = currentDate;


        var date = new Date(parseInt((data[i].FechaEntrega || "").substr(6)));
        var displayDate = $.datepicker.formatDate("dd/mm/yy", date);  // $.datepicker.formatDate("mm/dd/yy", date);
        tmpdata['FechaNecesidad'] = displayDate;
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
    tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;


    ///////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////



    getdata = tmpdata;
    gridceil = Math.ceil(Math.random() * 1000000);
    $("#Lista").jqGrid('addRowData', gridceil, getdata);



    rows = $("#Lista").getGridParam("reccount");
    if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);





}

///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
function CopiarPresupuesto(acceptId, ui) {

    // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
    var getdata = jQuery("#ListaDrag3").jqGrid('getRowData', acceptId);

    var j = 0, tmpdata = {}, dropname, IdRequerimiento;
    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
        IdPresupuesto = getdata['IdPresupuesto']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


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
                    tmpdata['IdDetalleComprobanteProveedor'] = 0;
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


                    tmpdata['Importe'] = data[i].Precio;
                    tmpdata['PorcentajeBonificacion'] = data[i].PorcentajeBonificacion;
                    tmpdata['ImporteBonificacion'] = data[i].ImporteBonificacion;
                    tmpdata['ImporteIva'] = data[i].ImporteIva;
                    tmpdata['ImporteTotalItem'] = data[i].ImporteTotalItem;


                    tmpdata['Observaciones'] = data[i].Observaciones;


                    tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
                    tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                    getdata = tmpdata;
                    grid = Math.ceil(Math.random() * 1000000);
                    $("#Lista").jqGrid('addRowData', grid, getdata);
                }


                rows = $("#Lista").getGridParam("reccount");
                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);




                Validar();
            }

        });




    } catch (e) { }

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

    // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
    var getdata = jQuery("#ListaDrag4").jqGrid('getRowData', acceptId);

    var j = 0, tmpdata = {}, dropname, IdRequerimiento;
    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
    var grid;
    try {

        // estos son datos de cabecera que ya tengo en la grilla auxiliar
        $("#Observaciones").val(getdata['Observaciones']);
        $("#LugarEntrega").val(getdata['LugarEntrega']);
        $("#IdObra").val(getdata['IdObra']);
        $("#IdSector").val(getdata['IdSector']);

        //me traigo los datos de detalle
        IdComparativa = getdata['IdFactura']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


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
                    tmpdata['IdDetalleComprobanteProveedor'] = 0;
                    tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                    tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                    tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                    tmpdata['Cantidad'] = data[i].Cantidad;
                    tmpdata['NumeroObra'] = data[i].NumeroObra;
                    tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
                    tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;


                    tmpdata['Importe'] = data[i].Precio;
                    tmpdata['PorcentajeBonificacion'] = data[i].PorcentajeBonificacion;
                    tmpdata['ImporteBonificacion'] = data[i].ImporteBonificacion;
                    tmpdata['ImporteIva'] = data[i].ImporteIva;
                    tmpdata['ImporteTotalItem'] = data[i].ImporteTotalItem;


                    getdata = tmpdata;
                    grid = Math.ceil(Math.random() * 1000000);
                    $("#Lista").jqGrid('addRowData', grid, getdata);
                }


                rows = $("#Lista").getGridParam("reccount");
                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);




                Validar();
            }

        });




    } catch (e) { }

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
function CopiarCuenta(acceptId, ui) {



    jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

    var getdata = $("#ListaDrag").jqGrid('getRowData', acceptId);
    var j = 0, tmpdata = {}, dropname;
    // var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
    //var prox = ProximoNumeroItem();
    try {
        //					for (var key in getdata) {
        //						if(getdata.hasOwnProperty(key) && dropmodel[j]) {
        //							dropname = dropmodel[j].name;
        //							tmpdata[dropname] = getdata[key];
        //						}
        //						j++;
        //					}
        tmpdata['IdDetalleComprobanteProveedor'] = 0;

        tmpdata['IdCuenta'] = getdata['IdCuenta'];
        tmpdata['Codigo'] = getdata['Codigo'];
        tmpdata['Descripcion'] = getdata['Cuenta'];
        //        tmpdata['OrigenDescripcion'] = 1;
        //        var now = new Date();
        //        var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
        //        tmpdata['FechaEntrega'] = currentDate;
        //        tmpdata['IdUnidad'] = getdata['IdUnidad'];
        //        tmpdata['Unidad'] = getdata['Unidad'];
        //        tmpdata['IdDetalleRequerimiento'] = 0;
        //        tmpdata['Cantidad'] = 0;
        //        tmpdata['NumeroItem'] = prox++;
        getdata = tmpdata;
    } catch (e) { }
    var grid;
    grid = Math.ceil(Math.random() * 1000000);
    // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)


    // o agarrar la primera linea vacía:
    $("#Lista").jqGrid('addRowData', grid, getdata);
    //$("#Lista").jqGrid('addRowData', grid, getdata, "first");





    //resetAltRows.call(this);
    $("#gbox_grid2").css("border", "1px solid #aaaaaa");




    RefrescarOrigenDescripcion();
    AgregarRenglonesEnBlanco({ "IdDetalleComprobanteProveedor": "0", "IdCuenta": "0", "Precio": "0", "Descripcion": "" });


    //   var rows = $("#Lista").getGridParam("reccount");
    //    if (rows > 4) $("#Lista").jqGrid('setGridHeight', rows * 40, true);




    // Validar();



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




    $("#grabar244").click(function () {
        $("#grabar2").click();
    })




    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            url: ROOT + 'ComprobanteProveedor/BatchUpdate',
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
                        window.location = (ROOT + "ComprobanteProveedor/Edit/" + result.IdComprobanteProveedor);

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
            }
                ,
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

});

///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////


$(function () {     // lo mismo que $(document).ready(function () {


    $("#loading").hide();

    var inEdit
    var dobleclic
    var headerRow, rowHight, resizeSpanHeight;
    var grid = $("#Lista")

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



    //Para que haga wrap en las celdas
    $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');
    //$.jgrid.formatter.integer.thousandsSeparator=',';



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////







    function cboxFormatter(cellvalue, options, rowObject) {
        // me está funcionando el onclick solo cuando lo hago con el mouse directo. Pero si entro a la celda en modo edicion, el onclick no reacciona 
        // http://www.trirand.com/blog/?page_id=393/bugs/cant-click-on-checkbox-in-cell-edit-mode/
        // http://www.trirand.com/blog/?page_id=393/feature-request/make-disabled-checkbox-of-the-checkbox-formatter-clickable/
        return '<input type="checkbox"' + (cellvalue ? ' checked="checked"' : '') +
      'onclick="  "   />';

        //        return '<input type="checkbox"' + (cellvalue ? ' checked="checked"' : '') +
        //      'onclick=" CalcularTodos(); "/>';

    }

    var boolformatter = function (rowObject, cellValue, options) {
        cellValue = cellValue + '';
        cellValue = cellValue.toLowerCase();
        var checked = cellValue.search(/(false|0|no|off|n)/i) < 0 ? ' checked="checked"' : '';
        var inputControl = '<input id="' + options.rowId + options.colModel.name + '" class="view" type="checkbox" ' + checked + ' value="' + cellValue + ' />';
        $(inputControl).click(function () {
            MakeCellEditable(options.rowId, options.colModel.name);
        });
        $(rowObject).html(inputControl);
    }

    function MakeCellEditable(rowId, colName) {
        // http://www.trirand.com/blog/?page_id=393/bugs/celledit-not-firing-with-fomatter-checkbox-set/
        var item = '#ListTrafficLines';
        var rowids = $(item).getDataIDs();
        var colModel = $(item).getGridParam().colModel;
        for (var i = 0; i < rowids.length; i++) {
            if (rowId == rowids[i]) {
                for (var j = 0; j < colModel.length; j++) {
                    if (colModel[j].name == colName) {
                        // Put cell in editmode.
                        // If the edit (third param) is set to false the cell is just selected and not edited.
                        // If set to true the cell is selected and edited.
                        $(item).editCell(i, j, true);
                        // Let the grid know that the cell has been changed without having to push enter button or click another cell.
                        $(item).saveCell(i, j);
                    }
                }
            }
        }
        alert('CalcularTodos');
        CalcularTodos();
    }


    ////////////////////////////////////////////////////////////
    // http: //stackoverflow.com/questions/8333933/highlight-cell-value-on-doubleclick-for-copy
    function selectText(element) {
        var doc = element.ownerDocument, selection, range;
        if (doc.body.createTextRange) { // ms
            range = doc.body.createTextRange();
            range.moveToElementText(element);
            range.select();
        } else if (window.getSelection) {
            selection = window.getSelection();
            if (selection.setBaseAndExtent) { // webkit
                selection.setBaseAndExtent(element, 0, element, 1);
            } else { // moz, opera
                range = doc.createRange();
                range.selectNodeContents(element);
                selection.removeAllRanges();
                selection.addRange(range);
            }
        }
    };


    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    // para que apenas escriba, entre la celda en modo edicion (como en excel)


    $("#Lista").keypress(function (e) {
        //        alert(e.keyCode);


        //        if (isPrintableKeyCode(e)) {
        //            var grid = jQuery('#Lista');
        //            var sel_id = grid.jqGrid('getGridParam', 'selrow');
        //            var myCellData = grid.jqGrid('getCell', sel_id, 'MyColName');
        //            alert(myCellData)
        //            //$('#Lista').editCell(" + selIRow + " + 1, " + selICol + ", true);
        //        }


    });



    function isPrintableKeyCode(e) {
        var keycode = e.keyCode;

        var valid =
        (keycode > 47 && keycode < 58) || // number keys
        keycode == 32 || keycode == 13 || // spacebar & return key(s) (if you want to allow carriage returns)
        (keycode > 64 && keycode < 91) || // letter keys
        (keycode > 95 && keycode < 112) || // numpad keys
        (keycode > 185 && keycode < 193) || // ;=,-./` (in order)
        (keycode > 218 && keycode < 223);   // [\]' (in order)

        return valid;
    };

    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////



    //    function AgregarRenglonesEnBlanco(data) {
    //        var grid = jQuery("#Lista")
    //        pageSize = parseInt(grid.jqGrid("getGridParam", "rowNum"))

    //        rows = $("#Lista").getGridParam("reccount");


    //        // jQuery("#Lista").jqGrid('getGridParam', 'records')
    //        emptyRows = 3 - rows; // -data.rows.length; // pageSize - data.rows.length;

    //        if (emptyRows > 0) {
    //            for (var i = 1; i <= emptyRows; i++)

    //            //                    // adjust the counts at lower right
    //            //                    grid.jqGrid("setGridParam", {
    //            //                        reccount: grid.jqGrid("getGridParam", "reccount") - emptyRows,
    //            //                        records: grid.jqGrid("getGridParam", "records") - emptyRows
    //            //                    });
    //            //                    grid[0].updatepager();



    //                grid.jqGrid("addRowData", "empty_" + i, { "IdDetalleComprobanteProveedor": "0", "IdCuenta": "0", "Precio": "0", "Descripcion": "" });

    //        }

    //        if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);
    //    }

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    function PopupCentrar() {
        //return ;
        var grid = jQuery("#Lista")
        var dlgDiv = $("#editmod" + grid[0].id);


        ///////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////

        //http://stackoverflow.com/questions/2879207/jqgrid-scrollable-dialog/
        //http://stackoverflow.com/questions/6601434/jqgrid-how-to-do-form-edit-if-all-fields-do-not-fit-to-screen
        // dlgDiv.css("max-height", "500px");
        //dlgDiv.css("overflow-y", "auto");
        //$("#editcntLista").css("overflow-y", "auto");
        ///////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////



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

        ///////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////


        //                    $("#sData").addClass("btn");
        //                    $("#cData").addClass("btn");


        var parentDiv = dlgDiv.parent(); // div#gbox_list
        var dlgWidth = dlgDiv.width();
        var parentWidth = parentDiv.width();
        var dlgHeight = dlgDiv.height();
        var parentHeight = parentDiv.height();

        var left = (screen.width / 2) - (dlgWidth / 2) + "px";
        var top =( (screen.height / 2) - (dlgHeight / 2)  + 50 )+ "px";

        dlgDiv[0].style.top = top ; // 500; // Math.round((parentHeight - dlgHeight) / 2) + "px";
        dlgDiv[0].style.left = left; //Math.round((parentWidth - dlgWidth) / 2) + "px";

    }





    $("#addData").click(function () {
        jQuery("#Lista").jqGrid('editGridRow', "new", { addCaption: "Agregar item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
            recreateForm: true,
            beforeShowForm: function (form) {

                PopupCentrar();

                //                    var dlgDiv = $("#editmod" + grid[0].id);
                //                    dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                //                    dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                $('#tr_IdDetalleComprobanteProveedor', form).hide();
                $('#tr_IdCuenta', form).hide();
                $('#tr_IdUnidad', form).hide();
            },
            beforeInitData: function () {
                inEdit = false;
            },
            onInitializeForm: function (form) {
                $('#IdDetalleComprobanteProveedor', form).val(0);
                $('#NumeroItem', form).val(jQuery("#Lista").jqGrid('getGridParam', 'records') + 1);
                $('#FechaEntrega', form).val($("#FechaIngreso").val());
            },
            afterShowForm: function (formid) {
                $('#Cantidad').focus();
            },
            afterComplete: function (response, postdata) {
                //  CalcularTodos();
            },
            onClose: function (data) {
                //  RefrescarOrigenDescripcion();
            }


        });
    });

    $("#edtData").click(function () {



        if (typeof lastSelectedId !== "undefined") {
            // grid.jqGrid('saveRow', lastSelectedId);
            grid.jqGrid('restoreRow', lastSelectedId);
        }


        var ids = jQuery("#Lista").jqGrid('getDataIDs');
        for (var i = 0; i < ids.length; i++) {

            grid.jqGrid('restoreRow', ids[i]);
        }




        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        if (gr != null) jQuery("#Lista").jqGrid('editGridRow', gr, { editCaption: "Modificacion item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true,
            closeAfterEdit: true, recreateForm: true, Top: 0,
            beforeShowForm: function (form) {
                PopupCentrar();



                //                    var dlgDiv = $("#editmod" + grid[0].id);
                //                    var parentDiv = dlgDiv.parent(); // div#gbox_list
                //                    var dlgWidth = dlgDiv.width();
                //                    var parentWidth = parentDiv.width();
                //                    var dlgHeight = dlgDiv.height();
                //                    var parentHeight = parentDiv.height();
                //                    dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                //                    dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                $('#tr_IdDetalleComprobanteProveedor', form).hide();
                $('#tr_IdCuenta', form).hide();
                $('#tr_IdUnidad', form).hide();


            },
            beforeInitData: function () {
                inEdit = true;
            },
            afterComplete: function (response, postdata) {
                CalcularTodos();
            },
            onClose: function (data) {
                RefrescarOrigenDescripcion();
            }
        });
        else alert("Debe seleccionar un item!");
    });

    $("#delData").click(function () {
        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        if (gr != null) {
            jQuery("#Lista").jqGrid('delGridRow', gr,
            { caption: "Borrar", msg: "Elimina el registro seleccionado?", bSubmit: "Borrar", bCancel: "Cancelar",
                width: 300, closeOnEscape: true, reloadAfterSubmit: false,

                beforeShowForm: function (form) {

                    $("#dData").attr("class", "btn btn-primary");
                    $("#dData").css("color", "white");
                    $("#dData").css("margin-right", "20px");
                    $("#eData").attr("class", "btn");

                },
                afterComplete: function (response, postdata) {
                    CalcularTodos();
                }
            });
        }
        else alert("Debe seleccionar un item!");
    });



    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });

    //    // get the header row which contains
    //    headerRow = grid.closest("div.ui-jqgrid-view")
    //            .find("table.ui-jqgrid-htable>thead>tr.ui-jqgrid-labels");

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

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    // http://stackoverflow.com/questions/5328072/can-jqgrid-support-dropdowns-in-the-toolbar-filter-fields

    var categoriesStr = ":All;1:sport;2:science";
    var subcategories = ["All", "football", "formel 1", "physics", "mathematics"];
    var subcategoriesStr = ":All;1:football;2:formel 1;3:physics;4:mathematics";

    var mydata = [
        { id: "1", Name: "Miroslav Klose", Category: "sport", Subcategory: "football" },
        { id: "2", Name: "Michael Schumacher", Category: "sport", Subcategory: "formula 1" },
        { id: "3", Name: "Albert Einstein", Category: "science", Subcategory: "physics" },
        { id: "4", Name: "Blaise Pascal", Category: "science", Subcategory: "mathematics" }
    ],
    grid = $("#ListaDrag"),
    getUniqueNames = function (columnName) {
        var texts = grid.jqGrid('getCol', columnName), uniqueTexts = [],
            textsLength = texts.length, text, textsMap = {}, i;
        for (i = 0; i < textsLength; i++) {
            text = texts[i];
            if (text !== undefined && textsMap[text] === undefined) {
                // to test whether the texts is unique we place it in the map.
                textsMap[text] = true;
                uniqueTexts.push(text);
            }
        }
        return uniqueTexts;
    },
    buildSearchSelect = function (uniqueNames) {
        var values = ":All";
        $.each(uniqueNames, function () {
            values += ";" + this + ":" + this;
        });
        return values;
    },
    setSearchSelect = function (columnName) {
        $("#ListaDrag").setColProp(columnName,
                    {
                        stype: 'select',
                        searchoptions: {
                            value: buildSearchSelect(getUniqueNames(columnName)),
                            sopt: ['eq']
                        }
                    }
        );
    };



    //////////////
    //    setSearchSelect('TiposCuentaGrupos');


    //    $("#ListaDrag").setColProp('TiposCuentaGrupos',
    //            {
    //                searchoptions: {
    //                    sopt: ['cn'],
    //                    dataInit: function (elem) {
    //                        $(elem).autocomplete({
    //                            source: getUniqueNames('TiposCuentaGrupos'),
    //                            delay: 0,
    //                            minLength: 0
    //                        });
    //                    }
    //                }
    //            });












    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    var myGrid = $('#ListaDrag'),
    decodeErrorMessage = function (jqXHR, textStatus, errorThrown) {
        var html, errorInfo, i, errorText = textStatus + '\n' + errorThrown;
        if (jqXHR.responseText.charAt(0) === '[') {
            try {
                errorInfo = $.parseJSON(jqXHR.responseText);
                errorText = "";
                for (i = 0; i < errorInfo.length; i++) {
                    if (errorText.length !== 0) {
                        errorText += "<hr/>";
                    }
                    errorText += errorInfo[i].Source + ": " + errorInfo[i].Message;
                }
            }
            catch (e) { }
        } else {
            html = /<body.*?>([\s\S]*)<\/body>/.exec(jqXHR.responseText);
            if (html !== null && html.length > 1) {
                errorText = html[1];
            }
        }
        return errorText;
    };


    myGrid.jqGrid({
        //        url: ROOT + 'Cuenta/Cuentas',
        url: ROOT + 'jqGridPaginacion/DynamicGridData',
        postData: { 'FechaInicial': function () { return ""; },
            'FechaFinal': function () { return ""; },
            'IdObra': function () { return ""; }
        },


        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,

        colNames: ['ver', '<<', 'IdRequerimiento', 'Cuenta', 'cód.',

            'Grupo', 'Obra', 'CdeGasto', '', '',

            'Cump.', 'Recep.', 'Entreg.', 'Impresa', 'Detalle',
             'Obra', 'Pedidos', 'Comparativas', 'Pedidos', 'Recepciones',
              'Salidas', 'Libero', 'Solicito', 'Sector', 'Usuario anulo', 'Fecha anulacion', 'Motivo anulacion', 'Fechas liberacion',
                       'Observaciones', 'Lugar de entrega', 'IdObra', 'IdSector'],
        colModel: [
                        { name: 'accion', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: '', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'IdCuenta', key: true, index: 'IdRequerimiento', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Cuenta', index: 'Descripcion', align: 'left', width: 200, editable: false, search: true, searchoptions: { clearSearch: false, searchOperators: true, sopt: ['cn']} },
                        { name: 'Codigo', index: 'Codigo', align: 'center', width: 50, editable: false, search: true, searchoptions: { clearSearch: false, searchOperators: true, sopt: ['eq']} },


                        { name: 'TiposCuentaGrupos',     // http://stackoverflow.com/questions/5328072/can-jqgrid-support-dropdowns-in-the-toolbar-filter-fields

                            index: 'TiposCuentaGrupos', align: 'center', width: 100, editable: false, search: true,

                            //formatter:'select',     stype: 'select', // http://stackoverflow.com/questions/5328072/can-jqgrid-support-dropdowns-in-the-toolbar-filter-fields
                            searchoptions: { sopt: ['cn']

                                //, value: categoriesStr
                            }, hidden: false




                        },
                        { name: 'Obra', index: 'Obra', align: 'center', width: 100, editable: false, search: true, hidden: false,
                            searchoptions: {
                                sopt: ['cn'],
                                dataInit: function (elem) {
                                    // it demonstrates custom item rendering  http://stackoverflow.com/questions/7392236/jqgrid-with-autocompletion-cant-parse-data-from-controller-to-view/7392816#7392816
                                    //                                    $(elem).autocomplete({ source:  ROOT + 'Articulo/GetObrasAutocomplete2' })
                                    //                                                                .data("autocomplete")._renderItem = function (ul, item) {
                                    //                                                                    return $("<li></li>")
                                    //                                                                        .data("item.autocomplete", item)
                                    //                                                                        .append("<a><span style='display:inline-block;width:60px;'><b>" +
                                    //                                                                                item.value + "</b></span>" + item.title + "</a>")
                                    //                                                                        .appendTo(ul);
                                    //                                                                };




                                    $(elem).autocomplete({
                                        source: ROOT + 'Articulo/GetObrasAutocomplete2'

                                        //,minLength: 3
                                        //                                                                        ,select: function (event, ui) {

                                        //                                                                            $("#IdCuenta").val(ui.item.id);
                                        //                                                                            $("#CodigoCuenta").val(ui.item.codigo); // por qué acá traes la propiedad codigo en lugar de value? -porque sugiero un texto pero al seleccionar solo tomo un pedazo
                                        //                                                                            $("#Descripcion").val(ui.item.title);
                                        //                                                                        }
                                    })
                                    .data("ui-autocomplete")._renderItem = function (ul, item) {
                                        return $("<li></li>")
                                            .data("ui-autocomplete-item", item)
                                            .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.value + " " + item.title + "</b></span></a>")
                                            .appendTo(ul);
                                    };




                                }
                            }


                        },
                        { name: 'CdeGasto', index: 'CuentasGasto', align: 'center', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: '', index: '', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: '', index: '', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },


                        { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'nc', 'bw', 'bn', 'eq', 'ne', 'ew', 'en', 'lt', 'le', 'gt', 'ge'] }, hidden: false },
                        { name: 'Recepcionado', index: 'Recepcionado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Entregado', index: 'Entregado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
                        { name: 'Impresa', index: 'Impresa', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'Detalle', index: 'Detalle', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },

                        { name: 'NumeroObra', index: 'NumeroObra', align: 'left', width: 85, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Pedidos', index: 'Pedidos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
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
                        { name: 'IdObra', index: 'IdObra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                        { name: 'IdSector', index: 'IdSector', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true }
                    ],


        onSelectRow: function (id, status, e) {
            CopiarCuenta(id);
        },
        ondblClickRow: function (id) {
            //  CopiarCuenta(id); //prefiero que copie con solo hacer clic  -y quizás hace el drag inutil, en especial cuando las grillas son fijas
        },



        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'Codigo',
        sortorder: "asc",
        viewrecords: true,

        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        //height: '100%',

        height: '100%',
        // height: $(window).height() - 350,
        //////////////////////////////


        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
        //caption: '<b>REQUERIMIENTOS RESUMIDO</b>'

        , multipleSearch: true,

        toppager: true,

        //recreateFilter:true,



        // jsonReader: { cell: "" }, // esto no funciona usando el formato de retorno con tipo "jqGridJson", quizá funciona con el original de Oleg  que devuelve directo el objeto a Json http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644

        loadError: function (jqXHR, textStatus, errorThrown) {
            // remove error div if exist
            $('#' + this.id + '_err').remove();
            // insert div with the error description before the grid
            myGrid.closest('div.ui-jqgrid').before(
            '<div id="' + this.id + '_err" style="max-width:' + this.style.width +
            ';"><div class="ui-state-error ui-corner-all" style="padding:0.7em;float:left;"><span class="ui-icon ui-icon-alert" style="float:left; margin-right: .3em;"></span><span style="clear:left">' +
                        decodeErrorMessage(jqXHR, textStatus, errorThrown) + '</span></div><div style="clear:left"/></div>')
        },
        loadComplete: function () {
            // remove error div if exist
            grid = $(this);
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
            $('#' + this.id + '_err').remove();
        }




    });
    //jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //$("#ListaDrag").filterToolbar({ searchOnEnter: true, enableClear: false });    // usar search: true, searchoptions: { sopt: ['cn']} o  { sopt: ['eq']}
    //    $("#ListaDrag").setFrozenColumns();

    myGrid.jqGrid('navGrid', '#ListaDragPager', { add: false, edit: false, del: false },
              {}, {}, {}, { multipleSearch: true, overlay: false });

    myGrid.filterToolbar({ stringResult: true, searchOnEnter: true, defaultSearch: 'cn', enableClear: false }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/
    //myGrid.filterToolbar({  });
    myGrid.jqGrid('navButtonAdd', '#ListaDragPager',
            { caption: "Filter", title: "Toggle Searching Toolbar",
                buttonicon: 'ui-icon-pin-s',
                onClickButton: function () { myGrid[0].toggleToolbar(); }
            });

    //        http://stackoverflow.com/questions/11247191/searchstring-searchfield-and-searchoper-returned-as-empty-from-jqgrid-in-asp-ne
    //        You use multipleSearch: true searching option. It allows to create more powerful queries, but it uses another format 
    //        of parameters. Instead of three parameters searchString, searchField and searchOper will be used one filters parameter 
    //        which represent in form of JSON string the full information about the filter. See the documentation for more information.

    //        In the answer for example you will find the code which demonstrate how one can parse the filters parameter and 
    //        create the corresponding filtering of the data in case of usage Entity Framework for access to the database.
    //  http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644







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


    //$("#ListaDrag2").jqGrid({
    //    url: ROOT + 'Requerimiento/DetRequerimientos',
    //    postData: { 'IdRequerimiento': function () { return "-1"; } },
    //    datatype: 'json',
    //    mtype: 'POST',
    //    cellEdit: false,
    //    colNames: ['Acciones', 'IdDetalleRequerimiento',
    //                     'N�', 'Fecha', 'Cump.', 'Recep.', 'Entreg.',
    //                       'N�', 'Fecha', 'Cump.', 'Recep.', 'Entreg.',
    //                        'N�', 'Fecha', 'Cump.', 'Recep.', 'Entreg.',
    //                     'Impresa', 'Detalle'
    //                  ],
    //    colModel: [
    //                    { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
    //                    {name: 'IdDetalleRequerimiento', index: 'IdRequerimiento', align: 'left', width: 40, editable: false, hidden: true },
    //                    { name: 'IdArticulo', index: 'NumeroRequerimiento', align: 'right', width: 40, editable: false, search: true, searchoptions: { sopt: ['eq']} },
    //                    { name: 'IdUnidad', index: '', width: 30 },
    //                    { name: 'NumeroItem', index: '', width: 80 },
    //                    { name: 'Cantidad', index: '', width: 40 },
    //                    { name: 'Abreviatura', index: '', width: 40 },
    //                    { name: 'Codigo', index: '', width: 40 },
    //                    { name: '', index: '', width: 40 },

    //                       { name: 'Descripcion', index: '', width: 80 },
    //                    { name: 'FechaEntrega', index: '', width: 40 },
    //                    { name: 'Observaciones', index: '', width: 40 },
    //                    { name: 'Cumplido', index: '', width: 40 },
    //                    { name: 'ArchivoAdjunto1', index: '', width: 40 },

    //                     { name: 'OrigenDescripcion', index: '', width: 40 },
    //                    { name: 'IdRequerimiento', index: '', width: 40 },
    //                    { name: '', index: '' },
    //                    { name: '', index: '' },
    //                    { name: '', index: '' }



    //                ],
    //    ondblClickRow: function (id) {
    //        CopiarRMdetalle(id);
    //    },
    //    pager: $('#ListaDragPager2'),
    //    rowNum: 15,
    //    rowList: [10, 20, 50],
    //    sortname: 'NumeroRequerimiento',
    //    sortorder: "desc",
    //    viewrecords: true,
    //    ///////////////////////////////
    //    //width: 'auto', // 'auto',
    //    autowidth: true,
    //    shrinkToFit: false,
    //    //////////////////////////////
    //    height: '100%',
    //    altRows: false,
    //    emptyrecords: 'No hay registros para mostrar' //,
    //    //caption: '<b>REQUERIMIENTOS DETALLADO</b>'
    //})
    //jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    ////jQuery("#ListaDrag2").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });
    //$("#ListaDrag2").remapColumns([15, 4, 7, 9, 5, 6, 8, 10, 11], true, true); // cambiar el orden de las columnas  -parece que arruina el ancho de las columnas



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    $("#ListaDrag3").jqGrid({
        url: ROOT + 'Presupuesto/Presupuestos',

        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'IdPresupuesto', 'Numero', 'Orden', 'Fecha', 'Proveedor', 'Validez', 'Bonif.', '% Iva', 'Mon', 'Subtotal', 'Imp.Bon.', 'Imp.Iva', 'Imp.Total',
                       'Plazo_entrega', 'Condicion_compra', 'Garantia', 'Lugar_entrega', 'Comprador', 'Aprobo', 'Referencia', 'Detalle', 'Contacto', 'Observaciones', ''],
        colModel: [
                        { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'IdPresupuesto', index: 'IdPresupuesto', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Numero', index: 'Numero', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'Orden', index: 'Orden', align: 'right', width: 20, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'FechaIngreso', index: 'FechaIngreso', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Proveedor', index: 'Proveedor', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Validez', index: 'Validez', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Bonificacion', index: 'Bonificacion', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'PorcentajeIva1', index: 'PorcentajeIva1', align: 'right', width: 40, editable: false, hidden: true },
                        { name: 'Moneda', index: 'Moneda', align: 'center', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Subtotal', index: 'Subtotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'ImporteBonificacion', index: 'ImporteBonificacion', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'ImporteIva1', index: 'ImporteIva1', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'PlazoEntrega', index: 'PlazoEntrega', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'CondicionCompra', index: 'CondicionCompra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Garantia', index: 'Garantia', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'LugarEntrega', index: 'LugarEntrega', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Comprador', index: 'Comprador', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Aprobo', index: 'Aprobo', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Referencia', index: 'Referencia', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Detalle', index: 'Detalle', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Contacto', index: 'Contacto', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdProveedor', index: 'IdProveedor' }
                    ],
        ondblClickRow: function (id) {
            CopiarPresupuesto(id);
        },
        pager: $('#ListaDragPager3'),
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
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar' // ,
        // caption: '<b>SOLICITUDES DE COTIZACION</b>'
    })
    jQuery("#ListaDrag3").jqGrid('navGrid', '#ListaDragPager3', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag3").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });






    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    //$("#ListaDrag4").jqGrid({
    //    url: ROOT + 'Comparativa/Comparativas',

    //    postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
    //    datatype: 'json',
    //    mtype: 'POST',
    //    cellEdit: false,
    //    colNames: ['', '', '', 'Circuito Firmas Completo', 'IdComparativa', 'Numero', 'Fecha Comparativa',

    //        'Tipo seleccion',
    //                        'Confecciono',
    //                        'Aprobo',
    //                         'Monto previsto',
    //         'Monto p/cpra',

    //         'Cant.Sol.',
    //         'Archivo adjunto 1',
    //         'Archivo adjunto 2',
    //         'Anulada',
    //         'Fecha anulacion',

    //         'Anulo',
    //         'Motivo anulacion'


    //        ],




    //    colModel: [
    //                { name: 'editar', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
    //                {name: 'Imprimir', index: 'Imprimir', align: 'center', width: 40, sortable: false, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Imprimir")'} },
    //                {name: 'firmar', index: 'Imprimir', align: 'center', width: 0, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Imprimir")'} },

    //                {name: 'CircuitoFirmasCompleto', index: 'CircuitoFirmasCompleto', align: 'left', width: 0, hidden: true,
    //                editable: false, search: true, searchoptions: { sopt: ['cn'] }
    //            },

    //                { name: 'IdFactura', index: 'IdFactura', align: 'left', width: 0, editable: false, hidden: true },
    //                { name: 'TipoABC', index: 'TipoABC', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },
    //                { name: 'PuntoVenta', index: 'PuntoVenta', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },

    //                { name: '', index: '', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },

    //                { name: '', index: '', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },



    //                { name: '', index: '', align: 'left', width: 500, editable: false, search: true, searchoptions: { sopt: ['cn']} },
    //                { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} }




    //                ],
    //    ondblClickRow: function (id) {
    //        CopiarComparativa(id);
    //    },
    //    pager: $('#ListaDragPager4'),
    //    rowNum: 15,
    //    rowList: [10, 20, 50],
    //    sortname: 'Numero',
    //    sortorder: "desc",
    //    viewrecords: true,
    //    ///////////////////////////////
    //    // width: 'auto', // 'auto',
    //    //autowidth: true,
    //    shrinkToFit: false,
    //    //////////////////////////////
    //    height: '100%',
    //    altRows: false,
    //    emptyrecords: 'No hay registros para mostrar' //,
    //    //caption: '<b>COMPARATIVAS</b>'
    //})
    //jQuery("#ListaDrag4").jqGrid('navGrid', '#ListaDragPager4', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag4").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    $("#ListaDrag5").jqGrid({
        url: ROOT + 'Pedido/Pedidos',

        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones',
                    'IdPedido', 'Numero', 'Sub.', 'Fecha', 'Salida',
                    'Cumplido', '', '', 'Proveedor', '',
                    'Bonificacion', '', '', '', '',
                    'Cant.', '', '', '', '', '', '', '',
                     '', '', '', '', '',
                    '', '', '', '', '', ''

                    ],
        colModel: [
                        { name: 'act', index: 'act', align: 'center', width: 300, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'IdPedido', index: 'IdPedido', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Numero', index: 'Numero', align: 'right', width: 300, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                         { name: 'SubNumero', index: 'Numero', align: 'right', width: 30, frozen: true, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'FechaPedido', index: 'Orden', align: 'right', width: 100, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'FechaSalida', index: 'FechaIngreso', width: 100, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },

                        { name: 'Cumplido', index: 'Proveedor', align: 'left', width: 40, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'RMs', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Obras', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Proveedor', index: 'zzzzzz', align: 'left', width: 300, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'TotalPedido', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn']} },

                        { name: 'Bonificacion', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'TotalIva1', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdMoneda', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Comprador', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Aprobo', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },

                        { name: 'cantitems', index: 'zzzzzz', align: 'right', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'idaux', index: 'zzzzzz', align: 'left', width: 100, editable: false, hidden: true, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'NumeroComparativa', index: 'zzzzzz', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdTipoCompraRM', index: 'zzzzzz', align: 'left', width: 60, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Observaciones', index: 'zzzzzz', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn']} },



                        { name: 'DetalleCondicionCompra', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'PedidoExterior', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdPedidoAbierto', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'NumeroLicitacion', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Impresa', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'UsuarioAnulacion', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'FechaAnulacion', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'MotivoAnulacion', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'ImpuestosInternos', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Auxiliar1', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'CircuitoFirmasCompleto', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdCodigoIva', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdComprador', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} },

                        { name: 'IdProveedor', index: 'zzzzzz', align: 'left', width: 100, hidden: true, editable: false, search: true, searchoptions: { sopt: ['cn']} }


                    ],
        ondblClickRow: function (id) {
            CopiarPedido(id);
        },
        loadComplete: function () {
            grid = $("ListaDrag5");
            $("#ListaDrag5 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },

        pager: $('#ListaDragPager5'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroPedido',
        sortorder: "desc",
        viewrecords: true,
        width: 'auto',
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar' //,
        //caption: '<b>PEDIDOS</b>' 
    })
    jQuery("#ListaDrag5").jqGrid('navGrid', '#ListaDragPager5', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    // jQuery("#ListaDrag5").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // http: //stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript?rq=1
    var DED = (function () {

        var private_var;

        function private_method() {
            // do stuff here
        }

        return {
            method_1: function () {
                // do stuff here
            },
            method_2: function () {
                // do stuff here
            }
        };
    })();



    $("#BuscadorPanelDerecho").change(function () {


        var grid = jQuery("#ListaDrag");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                   searchField: 'Descripcion', // Codigo
                   searchOper: 'eq',
                   searchString: $("#BuscadorPanelDerecho").val()
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);

        //        http://stackoverflow.com/questions/11247191/searchstring-searchfield-and-searchoper-returned-as-empty-from-jqgrid-in-asp-ne
        //        You use multipleSearch: true searching option. It allows to create more powerful queries, but it uses another format 
        //        of parameters. Instead of three parameters searchString, searchField and searchOper will be used one filters parameter 
        //        which represent in form of JSON string the full information about the filter. See the documentation for more information.

        //        In the answer for example you will find the code which demonstrate how one can parse the filters parameter and 
        //        create the corresponding filtering of the data in case of usage Entity Framework for access to the database.
        //  http://stackoverflow.com/questions/5500805/asp-net-mvc-2-0-implementation-of-searching-in-jqgrid/5501644#5501644



        var grid = jQuery("#ListaDrag2");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                   searchField: 'NumeroRequerimiento',
                   searchOper: 'eq',
                   searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);



        var grid = jQuery("#ListaDrag3");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                   searchField: 'Numero',
                   searchOper: 'eq',
                   searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);


        var grid = jQuery("#ListaDrag4");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                   searchField: 'Numero',
                   searchOper: 'eq',
                   searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);


        var grid = jQuery("#ListaDrag5");
        var postdata = grid.jqGrid('getGridParam', 'postData');
        jQuery.extend(postdata,
               { filters: '',
                   searchField: 'NumeroPedido',
                   searchOper: 'eq',
                   searchString: parseInt($("#BuscadorPanelDerecho").val(), 10) || 0
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);







        //<select><option value="NumeroRequerimiento" selected="selected">N°</option><option value="Detalle">Detalle</option><option value="NumeroObra">Obra</option><option value="Sector">Sector</option><option value="Observaciones">Observaciones</option><option value="LugarEntrega">Lugar de necesidad</option></select>
    });



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Cuentas');
    $('a#a_panel_este_tab1').remove();
    $('a#a_panel_este_tab2').text('RMDet');
    $('a#a_panel_este_tab2').remove();  //    
    $('a#a_panel_este_tab3').text('Items de presup de obra');
    //$('a#a_panel_este_tab3').remove();  //    
    $('a#a_panel_este_tab4').text('Recepciones');
    //$('a#a_panel_este_tab4').remove();  //    
    $('a#a_panel_este_tab5').text('Pedidos');
    //$('a#a_panel_este_tab5').remove();  //    


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




    // esto es lo que hacía que dragearas un renglon
    // make grid2 sortable
    //    $("#Lista").jqGrid('sortableRows', {
    //        update: function () {
    //            resetAltRows.call(this.parentNode);
    //        }
    //    });










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




    $("#Aprobo").change(function () {
        var IdAprobo = $("#Aprobo > option:selected").attr("value");
        var Aprobo = $("#Aprobo > option:selected").html();
        $("#Aux1").val(IdAprobo);
        $("#Aux2").val(Aprobo);
        $("#Aux3").val("");
        $("#Aux10").val("");
        $('#dialog-password').data('Combo', 'Aprobo');
        $('#dialog-password').dialog('open');
    });

    $("#Bonificacion").change(function () {
        CalcularTodos();
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









    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




});





function pickdates(id) {
    jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
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




///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////





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
        },
        ondrop: function (ev, ui, getdata) {
            var acceptId = $(ui.draggable).attr("id");
            CopiarCuenta(acceptId, ui);
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
                            tmpdata['IdDetalleComprobanteProveedor'] = 0;
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
            var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
            var j = 0, tmpdata = {}, dropname, IdPedido;
            var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
                            tmpdata['IdDetalleComprobanteProveedor'] = 0;
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
                        var longitud = data.length;
                        for (var i = 0; i < data.length; i++) {
                            var date = new Date(parseInt(data[i].FechaEntrega.substr(6)));
                            var displayDate = $.datepicker.formatDate("mm/dd/yy", date);
                            tmpdata['IdArticulo'] = data[i].IdArticulo;
                            tmpdata['Codigo'] = data[i].Codigo;
                            tmpdata['Descripcion'] = data[i].Descripcion;
                            tmpdata['IdUnidad'] = data[i].IdUnidad;
                            tmpdata['Unidad'] = data[i].Unidad;
                            tmpdata['IdDetalleComprobanteProveedor'] = 0;
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
                        var longitud = data.length;
                        for (var i = 0; i < data.length; i++) {
                            var date = new Date(parseInt(data[i].FechaEntrega.substr(6)));
                            var displayDate = $.datepicker.formatDate("mm/dd/yy", date);
                            tmpdata['IdArticulo'] = data[i].IdArticulo;
                            tmpdata['Codigo'] = data[i].Codigo;
                            tmpdata['Descripcion'] = data[i].Descripcion;
                            tmpdata['IdUnidad'] = data[i].IdUnidad;
                            tmpdata['Unidad'] = data[i].Unidad;
                            tmpdata['IdDetalleComprobanteProveedor'] = 0;
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






function RefrescarOrigenDescripcion() {

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


