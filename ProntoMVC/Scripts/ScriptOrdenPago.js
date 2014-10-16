
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// http://stackoverflow.com/questions/7169227/javascript-best-practices-for-asp-net-mvc-developers
// http://stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript el truco interesante de var DED = (function() {
// http://stackoverflow.com/questions/251814/jquery-and-organized-code?lq=1   una risa

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////



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

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        try {


            saveparameters = {
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

            data1 = '{"IdPedido":"' + $("#IdPedido").val() + '",'
            for (var j = 0; j < colModel.length; j++) {
                cm = colModel[j]
                if (cm.label === 'TB') {
                    valor = data[cm.name];






                    if (cm.name === 'Cantidad') valor = valor.replace(".", ",")
                    if (cm.name === 'Precio') valor = valor.replace(".", ",")
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


                    if (cm.name.indexOf("Fecha") !== -1) valor = $.datepicker.formatDate("yy/mm/dd", $.datepicker.parseDate("dd/mm/yy", valor));

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

    // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
    var getdata = jQuery("#ListaDrag").jqGrid('getRowData', acceptId);

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
        IdRequerimiento = getdata['IdRequerimiento']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


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


                rows = $("#Lista").getGridParam("reccount");
                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);




                Validar();
            }

        });




    } catch (e) { }


    $("#gbox_grid2").css("border", "1px solid #aaaaaa");
}










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
    tmpdata['IdDetallePedido'] = 0;
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
function CopiarPedido(acceptId, ui) {

    // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
    var getdata = jQuery("#ListaDrag5").jqGrid('getRowData', acceptId);

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
        $("#Proveedor").val(getdata['IdProveedor']);
        $("#DescripcionProveedor").val(getdata['Proveedor']);
        $("#IdComprador").val(getdata['IdComprador']);


        $("#NumeroPedido").val(getdata['Numero']);
        $("#SubNumero").val(parseInt(getdata['SubNumero']) + 1);


        //me traigo los datos de detalle
        IdPedido = getdata['IdPedido']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: ROOT + 'Pedido/DetPedidosSinFormato/',
            data: { IdPedido: IdPedido },
            dataType: "Json",
            success: function (data) {

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
                    tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;

                    tmpdata['Precio'] = data[i].Precio; ;

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




///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

$(function () {


    $('#grabar2').click(function () {

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
                $('#grabar2').attr("disabled", true).val("Espere...");

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

    var lastSelectedId;
    var inEdit
    var dobleclic
    var headerRow, rowHight, resizeSpanHeight;
    grid = $("#Lista")

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



    $("#FechaIngreso").datepicker({
        changeMonth: true,
        changeYear: true
    });

    //Para que haga wrap en las celdas
    $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');
    //$.jgrid.formatter.integer.thousandsSeparator=',';



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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


        url: ROOT + 'OrdenPago/DetOrdenesPago/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetallePedido', 'IdArticulo', 'IdUnidad', '#', 'Obra', 'Cant.', 'Un.', 
        'Imputación',
        'Descripción', 'Número ', 'Fecha', 'Importe', 'Imp.Bon.', '% Iva',
                       'Imp.Iva', 'Imp.Total', 'Entrega', 'Necesidad', 'Observ', 'Nro.RM',
                       'ItemRM', 'Adj1',

                       'IdDetalleRequerimiento', 'IdDetallePresupuesto', 'OrigenDescripcion', 'IdCentroCosto'],
        colModel: [
                        { name: 'act', formoptions: { rowpos: 1, colpos: 1 }, index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                        { name: 'IdDetallePedido', formoptions: { rowpos: 2, colpos: 1 },
                            index: 'IdDetallePedido', label: 'TB', align: 'left', width: 85, editable: true,
                            hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }
                        },
                        { name: 'IdArticulo', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdArticulo', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: true} },
                        { name: 'IdUnidad', formoptions: { rowpos: 4, colpos: 1 },
                            index: 'IdUnidad', label: 'TB', align: 'left', width: 85, editable: true,
                            hidden: true, editrules: { edithidden: true, required: true }
                        },

                        { name: 'NumeroItem', formoptions: { rowpos: 5, colpos: 1 },
                            editoptions: { disabled: true }, frozen: true, hidden: true,
                            formoptions: { rowpos: 1, colpos: 1 }, index: 'NumeroItem', label: 'TB',
                            align: 'right', width: 20, editable: true, edittype: 'text', editrules: { required: true }
                        },

                        { name: 'NumeroObra', formoptions: { rowpos: 6, colpos: 1 }, index: 'NumeroObra', label: 'TB', align: 'center', width: 60, hidden: true, sortable: false, editable: false },
                        { name: 'Cantidad', formoptions: { rowpos: 7, colpos: 1 }, index: 'Cantidad', label: 'TB', align: 'right', width: 80, hidden: true, editable: true, edittype: 'text',
                            editoptions: { defaultValue: 1, maxlength: 20, dataEvents: [{

                                //                                type: 'change', fn: function (e) { CalcularImportes(); }
                                //                                                            , 

                                type: 'keyup', fn: function (e) { CalcularImportes(); }


                            }]
                            }
                            , editrules: { required: true }
                        },
                        { name: 'Unidad', formoptions: { rowpos: 7, colpos: 2 }, index: 'Unidad', align: 'center', hidden: true,
                            width: 30, editable: true, edittype: 'select', editrules: { required: true },
                            editoptions: {

                                dataUrl: ROOT + 'Articulo/Unidades',
                                dataEvents: [{ type: 'change', fn: function (e) {
                                    RefrescarRenglon(this);
                                    //                                    try {
                                    //                                        $('#IdUnidad').val(this.value);   //si está en modo inline, no te va a dar BOLA!!!!!!!
                                    //                                    } catch (e) {
                                    //                                        // $("#Lista [name='IdUnidad']").val(this.value);
                                    //                                    }
                                    //                                    // $("#Lista [name='IdUnidad']").val(this.value); // no sé qué renglon está elegido


                                }
                                }]
                            }
                        },
                        { name: 'Imputacion', formoptions: { rowpos: 8, colpos: 1 }, index: 'Codigo', align: 'left', width: 120,
                            editable: true, edittype: 'text',
                            editoptions: {
                                dataInit: function (elem) {
                                    $(elem).autocomplete({
                                        source: ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',

                                        minLength: 0,
                                        select: function (event, ui) {
                                            $("#IdArticulo").val(ui.item.id);
                                            $("#Descripcion").val(ui.item.title);
                                            $("#PorcentajeIva").val(ui.item.iva);
                                            $("#IdUnidad").val(ui.item.IdUnidad);
                                            $("#Unidad").attr("value", ui.item.IdUnidad);
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
                            { formoptions: { rowpos: 9, colpos: 2 }, name: 'DescripcionFalsa', index: '', editable: false, width: 100,
                                editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
                            },

                        { name: 'Descripcion', formoptions: { rowpos: 8, colpos: 2, label: "Descripción" }, index: 'Descripcion', align: 'left',
                            hidden: true,
                            editable: true, edittype: 'text',
                            editoptions: { rows: '1', cols: '1',
                                dataInit: function (elem) {
                                    $(elem).autocomplete({

                                        source: ROOT + 'Articulo/GetArticulosAutocomplete2',
                                        minLength: 0,
                                        select: function (event, ui) {
                                            $("#IdArticulo").val(ui.item.id);
                                            $("#Codigo").val(ui.item.codigo);
                                            $("#PorcentajeIVA").val(ui.item.iva);
                                            $("#IdUnidad").val(ui.item.IdUnidad);
                                            $("#Unidad").val(ui.item.IdUnidad);

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
                         { name: 'FechaEntrega', formoptions: { rowpos: 15, colpos: 1 },
                             index: 'FechaEntrega', label: 'TB', width: 150, align: 'center',
                             sorttype: 'date', editable: true, hidden: false,
                             formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                             editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: false }
                         },
                        {
                            name: 'Precio',
                            formoptions: { rowpos: 9, colpos: 1 },
                            index: 'Precio', label: 'TB', align: 'right', width: 100,
                            editable: true, edittype: 'text',
                            editoptions: { defaultValue: '0.00', maxlength: 20,
                                dataEvents: [{

                                    type: 'keyup', fn: function (e) { CalcularImportes(); }
                                },
                                { type: 'change', fn: function (e) { CalcularImportes(); } }

                                ]

                            }, editrules: { required: true }
                        },
                        {
                            name: 'PorcentajeBonificacion',
                            formoptions: { rowpos: 10, colpos: 1 },
                            index: 'PorcentajeBonificacion', label: 'TB', align: 'right', width: 100, hidden: false,
                            editable: true, edittype: 'text',
                            editoptions: { maxlength: 20,
                                defaultValue: '0.00',

                                dataEvents: [{

                                    type: 'keyup', fn: function (e) { CalcularImportes(); }


                                }
                                ]
                            }
                        }
                        ,
                        { name: 'ImporteBonificacion', formoptions: { rowpos: 11, colpos: 1 }, index: 'ImporteBonificacion', label: 'TB', align: 'right', hidden: false,
                         width: 100, editable: true, editoptions: { disabled: 'disabled'} },
                        { name: 'PorcentajeIva', formoptions: { rowpos: 12, colpos: 1 }, index: 'PorcentajeIva', label: 'TB', hidden: false,
                            align: 'right', width: 100, editable: true,
                            editoptions: {
                                defaultValue: '21.00',
                                maxlength: 20,

                                dataEvents: [{
                                    type: 'keyup', fn: function (e) { CalcularImportes(); }


                                }]
                            }
                        },
                        { name: 'ImporteIva', formoptions: { rowpos: 13, colpos: 1 }, index: 'ImporteIva', label: 'TB', align: 'right', width: 100, hidden: false, editable: true, editoptions: { disabled: 'disabled'} },
                        { name: 'ImporteTotalItem', formoptions: { rowpos: 14, colpos: 1 }, index: 'ImporteTotalItem', label: 'TB', align: 'right', hidden: true, width: 100, editable: true, editoptions: { disabled: 'disabled'} },
                     
                        { name: 'FechaNecesidad', formoptions: { rowpos: 15, colpos: 2 },
                            index: 'FechaNecesidad', label: 'TB', width: 300, align: 'center',
                            sorttype: 'date', editable: true, hidden: true,
                            formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy',
                            editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }, editrules: { required: false }
                        },
                        { name: 'Observaciones', formoptions: { rowpos: 16, colpos: 1 }, index: 'Observaciones',
                            label: 'TB', align: 'left', width: 600, editable: true,
                            // edittype: 'textarea', no se como evitar que el inline de textarea no me haga muy alto el renglon
                            editoptions: { rows: '1', cols: '40' }
                        }, //editoptions: { dataInit: function (elem) { $(elem).val(inEdit ? "Modificado" : "Nuevo"); }

                        {name: 'NumeroRequerimiento', formoptions: { rowpos: 1, colpos: 2 },
                        editoptions: { rows: '1', cols: '1', disabled: true }, hidden: true,
                        index: 'NumeroRequerimiento', label: 'TB', edittype: 'text',
                        align: 'right', width: 40, sortable: false, editable: true, editrules: { readonly: 'readonly' }
                    },
                        { name: 'NumeroItemRM', hidden: true, formoptions: { rowpos: 1, colpos: 3 }, hidden: true,
                            editoptions: { rows: '1', cols: '1', disabled: true },
                            index: 'NumeroItemRM', label: 'TB', align: 'right', edittype: 'text',
                            width: 50, sortable: false, editable: false, editrules: { readonly: 'readonly' }
                        },

                        { name: 'Adj. 1', index: 'ArchivoAdjunto1', label: 'TB', align: 'left', width: 100, editable: true, edittype: 'file', hidden: true,
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
                    { name: 'IdCentroCosto', label: 'TB', hidden: false }


        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////


                    ],

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
            //jQuery('#Lista').editRow(id, true);  // para inline
            jQuery('#Lista').editRow(id, true, null, null, null, {}, calculateTotal);
            //jQuery("#grid_id").jqGrid('editRow', rowid, keys, oneditfunc, succesfunc, url, extraparam, aftersavefunc, errorfunc, afterrestorefunc);
        },


        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //        http://stackoverflow.com/questions/9170260/jqgrid-all-rows-in-inline-edit-mode-by-default
        //                You have to enumerate all rows of grid and call editRow for every row. The code can be like the following


        loadComplete: function () { //si uso esto, no puedo usar tranquilo lo de aria-selected para el refresco de la edicion inline
//            var $this = $(this), ids = $this.jqGrid('getDataIDs'), i, l = ids.length;
//            for (i = 0; i < l; i++) {
//                $this.jqGrid('editRow', ids[i], true);
//            }
        },
        //        //or the following

        //loadComplete: function () {
        //    var $this = $(this), rows = this.rows, l = rows.length, i, row;
        //    for (i = 0; i < l; i++) {
        //        row = rows[i];
        //        if ($.inArray('jqgrow', row.className.split(' ')) >= 0) {
        //            $this.jqGrid('editRow', row.id, true);
        //        }
        //    }
        //}

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////




        ondblClickRow: function (id) {
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
                be = "<input style='height:22px;width:20px;' type='button' value='E' onclick=\"jQuery('#Lista').editRow('" + cl + "',true,pickdates);\"  />";
                se = "<input style='height:22px;width:20px;' type='button' value='S' onclick=\"jQuery('#Lista').saveRow('" + cl + "');\"  />";
                ce = "<input style='height:22px;width:20px;' type='button' value='C' onclick=\"jQuery('#Lista').restoreRow('" + cl + "');\" />";
                jQuery("#Lista").jqGrid('setRowData', ids[i], { act: be + se + ce });
                calculateTotal();
            }
            RefrescarOrigenDescripcion();
        },

        afterSaveCell: function (rowid, name, val, iRow, iCol) {
            calculateTotal();
            RefrescarOrigenDescripcion();
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
        height: '200px', // 'auto',
        altRows: false,
        rownumbers: true,
        footerrow: true,
        userDataOnFooter: true
        //loadonce: true,
        // caption: '<b>ITEMS DE LA SOLICITUD DE COTIZACION</b>'
    });
    jQuery("#Lista").jqGrid('navGrid', '#ListaPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#Lista").jqGrid('setFrozenColumns');


    function unformatNumber(cellvalue, options, rowObject) {
        return cellvalue.replace(",", ".");
    }

    function formatNumber(cellvalue, options, rowObject) {
        return cellvalue.replace(".", ",");
    }





    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
        var top = (screen.height / 2) - (dlgHeight / 2) + "px";

        dlgDiv[0].style.top = top; // 500; // Math.round((parentHeight - dlgHeight) / 2) + "px";
        dlgDiv[0].style.left = left; //Math.round((parentWidth - dlgWidth) / 2) + "px";

    }

    $("#addData").click(function () {
        dobleclic = true;
        jQuery("#Lista").jqGrid('editGridRow', "new", { addCaption: "Agregar item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
            recreateForm: true,
            beforeShowForm: function (form) {

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
            }


        });
    });

    $("#edtData").click(function () {


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
                    calculateTotal();
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
        url: ROOT + 'Requerimiento/Requerimientos',
        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; }, 'IdObra': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'Acciones', 'IdRequerimiento', 'Numero', 'Fecha', 'Cump.', 'Recep.', 'Entreg.', 'Impresa', 'Detalle', 'Obra', 'Pedidos', 'Comparativas',
                       'Pedidos', 'Recepciones', 'Salidas', 'Libero', 'Solicito', 'Sector', 'Usuario anulo', 'Fecha anulacion', 'Motivo anulacion', 'Fechas liberacion',
                       'Observaciones', 'Lugar de entrega', 'IdObra', 'IdSector'],
        colModel: [
                        { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'IdRequerimiento', index: 'IdRequerimiento', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'FechaRequerimiento', index: 'FechaRequerimiento', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: false },
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

        height: '100%',
        // height: $(window).height() - 350,
        //////////////////////////////


        altRows: false,
        emptyrecords: 'No hay registros para mostrar'//,
        //caption: '<b>REQUERIMIENTOS RESUMIDO</b>'
    })
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    // jQuery("#ListaDrag").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });



    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Requerimiento/DetRequerimientos',
        postData: { 'IdRequerimiento': function () { return "-1"; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: false,
        colNames: ['Acciones', 'IdDetalleRequerimiento',
                         'N', 'Fecha', 'Cump.', 'Recep.', 'Entreg.',
                           'N', 'Fecha', 'Cump.', 'Recep.', 'Entreg.',
                            'N', 'Fecha', 'Cump.', 'Recep.', 'Entreg.',
                         'Impresa', 'Detalle'
                      ],
        colModel: [
                        { name: 'act', index: 'act', align: 'center', width: 40, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'IdDetalleRequerimiento', index: 'IdRequerimiento', align: 'left', width: 40, editable: false, hidden: true },
                        { name: 'IdArticulo', index: 'NumeroRequerimiento', align: 'right', width: 40, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                        { name: 'IdUnidad', index: '', width: 30 },
                        { name: 'NumeroItem', index: '', width: 80 },
                        { name: 'Cantidad', index: '', width: 40 },
                        { name: 'Abreviatura', index: '', width: 40 },
                        { name: 'Codigo', index: '', width: 40 },
                        { name: '', index: '', width: 40 },

                           { name: 'Descripcion', index: '', width: 80 },
                        { name: 'FechaEntrega', index: '', width: 40 },
                        { name: 'Observaciones', index: '', width: 40 },
                        { name: 'Cumplido', index: '', width: 40 },
                        { name: 'ArchivoAdjunto1', index: '', width: 40 },

                         { name: 'OrigenDescripcion', index: '', width: 40 },
                        { name: 'IdRequerimiento', index: '', width: 40 },
                        { name: '', index: '' },
                        { name: '', index: '' },
                        { name: '', index: '' }



                    ],
        ondblClickRow: function (id) {
            CopiarRMdetalle(id);
        },
        pager: $('#ListaDragPager2'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'NumeroRequerimiento',
        sortorder: "desc",
        viewrecords: true,
        ///////////////////////////////
        //width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar' //,
        //caption: '<b>REQUERIMIENTOS DETALLADO</b>'
    })
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag2").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });
    $("#ListaDrag2").remapColumns([15, 4, 7, 9, 5, 6, 8, 10, 11], true, true); // cambiar el orden de las columnas  -parece que arruina el ancho de las columnas



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




    $("#ListaDrag4").jqGrid({
        url: ROOT + 'Comparativa/Comparativas',

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
                    {name: 'Imprimir', index: 'Imprimir', align: 'center', width: 40, sortable: false, editable: false, search: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Imprimir")'} },
                    {name: 'firmar', index: 'Imprimir', align: 'center', width: 0, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Imprimir")'} },

                    {name: 'CircuitoFirmasCompleto', index: 'CircuitoFirmasCompleto', align: 'left', width: 0, hidden: true,
                    editable: false, search: true, searchoptions: { sopt: ['cn'] }
                },

                    { name: 'IdFactura', index: 'IdFactura', align: 'left', width: 0, editable: false, hidden: true },
                    { name: 'TipoABC', index: 'TipoABC', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },
                    { name: 'PuntoVenta', index: 'PuntoVenta', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['eq']} },

                    { name: '', index: '', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },

                    { name: '', index: '', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} },



                    { name: '', index: '', align: 'left', width: 500, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                    { name: '', index: '', align: 'left', width: 0, editable: false, search: true, searchoptions: { sopt: ['cn']} }




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
        // width: 'auto', // 'auto',
        //autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar' //,
        //caption: '<b>COMPARATIVAS</b>'
    })
    jQuery("#ListaDrag4").jqGrid('navGrid', '#ListaDragPager4', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
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
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // make grid2 sortable
    $("#Lista").jqGrid('sortableRows', {
        update: function () {
            resetAltRows.call(this.parentNode);
        }
    });

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
        calculateTotal();
    });

    $("#IdMoneda").change(function () {
        var fecha = $("#FechaIngreso").val();
        var IdMoneda = $("#IdMoneda").val();
        if (IdMoneda != 1) {
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Moneda/Moneda_Cotizacion/',
                data: { fecha: fecha, IdMoneda: IdMoneda },
                dataType: "json",
                success: function (data) {
                    if (data.length > 0) {
                        var Cotizacion = data[0]["Cotizacion"];
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
    $('a#a_panel_este_tab1').text('RMRes');
    $('a#a_panel_este_tab2').text('RMDet');
    $('a#a_panel_este_tab3').text('Presup');
    $('a#a_panel_este_tab4').text('Comp');
    //$('a#a_panel_este_tab5').remove();  //    
    $('a#a_panel_este_tab5').text('Ped');


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
               { filters: '',
                   searchField: 'NumeroRequerimiento', // Codigo
                   searchOper: 'eq',
                   searchString: $("#BuscadorPanelDerecho").val()
               });
        grid.jqGrid('setGridParam', { search: true, postData: postdata });
        grid.trigger("reloadGrid", [{ page: 1}]);


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
                   searchField: 'Numero', // 'NumeroComparativa',
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





});

function pickdates(id) {
    jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
}

function RefrescarRenglon(x) {

    if ($("#editmodLista").attr('aria-hidden') == undefined || $("#editmodLista").attr('aria-hidden') == 'true') {
        $("#Lista [aria-selected='true'] [name='IdUnidad']").val(x.value);
    }
    else {
        $('#IdUnidad').val(x.value);
    }


}



// total del item
function CalcularImportes() {



    var pbglobal = 0; //  parseFloat($("#Totales").find("#PorcentajeBonificacion").val().replace(",", ".") || 0) || 0;


    if ($("#editmodLista").attr('aria-hidden') == undefined || $("#editmodLista").attr('aria-hidden') == 'true') {
        // $("#Lista [name='Precio']") // si esta en modo inline....
        // http://stackoverflow.com/questions/2109754/jqgrid-reload-grid-after-successfull-inline-update-inline-creation-of-record
        // jQuery("#grid_id").jqGrid('editRow', rowid, keys, oneditfunc, succesfunc, url, extraparam, aftersavefunc, errorfunc, afterrestorefunc);


        //var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');


        //  var sss = $("input:focus").closest("tr");
        //[aria-selected='true']


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
        bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
        st = st - bg;
        ////////////////////////////////////////////////////



        var ii = Math.round(st * pi / 100 * 10000) / 10000;
        var it = Math.round((st + ii) * 10000) / 10000;



        $("#Lista  [aria-selected='true'] [name='ImporteBonificacion']").val(ib.toFixed(4));
        $("#Lista [aria-selected='true']  [name='ImporteIva']").val(ii.toFixed(4));
        $("#Lista [aria-selected='true']  [name='ImporteTotalItem']").val(it.toFixed(4));





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
    bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
    st = st - bg;
    ////////////////////////////////////////////////////



    var ii = Math.round(st * pi / 100 * 10000) / 10000;
    var it = Math.round((st + ii) * 10000) / 10000;



    $("#ImporteBonificacion").val(ib.toFixed(4));
    $("#ImporteIva").val(ii.toFixed(4));
    $("#ImporteTotalItem").val(it.toFixed(4));
}




// total generales y del pie de la grilla
calculateTotal = function () {
    var totalCantidad = $('#Lista').jqGrid('getCol', 'Cantidad', false, 'sum')

    var pr, cn, st, ib, ib_, ib_t, pi, ii, st1, ib1, ib2, ii1, st2, pb, st3, tp, tg;
    st1 = 0;
    ib1 = 0;
    ib2 = 0;
    ii1 = 0;

    var pbglobal = 0; // parseFloat($("#Totales").find("#PorcentajeBonificacion").val().replace(",", ".") || 0) || 0;

    if (isNaN(pb)) { pb = 0; }
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
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
        bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
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

    $("#Lista").jqGrid('footerData', 'set', { NumeroObra: 'TOTALES', Cantidad: totalCantidad.toFixed(2),
        ImporteBonificacion: ib1.toFixed(4),
        ImporteIva: ii1.toFixed(4),
        ImporteTotalItem: tg.toFixed(4)
    });
};

getColumnIndexByName = function (grid, columnName) {
    var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
    for (i = 0; i < l; i++) {
        if (cm[i].name === columnName) {
            return i; // return the index
        }
    }
    return -1;
},

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
            CopiarRM(acceptId, ui);
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



        tipoDesc = data['OrigenDescripcion'] || 1;
        sDesc = data['Descripcion'];
        sObs = data['Observaciones'];


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








///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$(function () {

    $('#ListaValores').jqGrid({
        url: ROOT + 'OrdenPago/DetOrdenesPagoValores/',
        postData: { 'IdOrdenPago': function () { return $("#IdOrdenPago").val(); } },
        editurl: ROOT + 'OrdenPago/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetallePedido', 'IdArticulo', 'IdUnidad', 'Tipo', 'Interno', 'Número', 'Vence', 'Banco / Caja',
        'Importe', '', '', ''],
        colModel: [
                        { name: 'act', formoptions: { rowpos: 1, colpos: 1 }, index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false, frozen: true },
                        { name: 'IdDetallePedido', formoptions: { rowpos: 2, colpos: 1 },
                            index: 'IdDetallePedido', label: 'TB', align: 'left', width: 85, editable: true, frozen: true,
                            hidden: true, editoptions: { disabled: 'disabled', defaultValue: 0 }, editrules: { edithidden: true, required: true }
                        },
                        { name: 'IdArticulo', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdArticulo', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: true} },
                        { name: 'IdUnidad', formoptions: { rowpos: 4, colpos: 1 },
                            index: 'IdUnidad', label: 'TB', align: 'left', width: 85, editable: true, frozen: true,
                            hidden: true, editrules: { edithidden: true, required: true }
                        },

                        { name: 'Tipo', formoptions: { rowpos: 5, colpos: 1 }, frozen: true, 
                            editoptions: { disabled: true },
                            formoptions: { rowpos: 1, colpos: 1 }, index: 'NumeroItem', label: 'TB',
                            align: 'right', width: 20, editable: true, edittype: 'text', editrules: { required: true }
                        },

                        { name: 'Interno', formoptions: { rowpos: 6, colpos: 1 }, index: 'NumeroObra', label: 'TB', align: 'center', width: 60, sortable: false, frozen: true, editable: false },
                        { name: 'Número', formoptions: { rowpos: 7, colpos: 1 }, index: 'Cantidad', label: 'TB', align: 'right', frozen: true, width: 120, editable: true, edittype: 'text',
                            editoptions: { defaultValue: 1, maxlength: 20, dataEvents: [{

                                //                                type: 'change', fn: function (e) { CalcularImportes(); }
                                //                                                            , 

                                type: 'keyup', fn: function (e) { CalcularImportes(); }


                            }]
                            }
                            , editrules: { required: true }
                        },
                        { name: 'Vence', formoptions: { rowpos: 7, colpos: 2 }, index: 'Unidad', align: 'center',
                            width: 120, editable: true, edittype: 'select', editrules: { required: true },
                            editoptions: {

                                dataUrl: ROOT + 'Articulo/Unidades',
                                dataEvents: [{ type: 'change', fn: function (e) {
                                    RefrescarRenglon(this);
                                    //                                    try {
                                    //                                        $('#IdUnidad').val(this.value);   //si está en modo inline, no te va a dar BOLA!!!!!!!
                                    //                                    } catch (e) {
                                    //                                        // $("#ListaValores [name='IdUnidad']").val(this.value);
                                    //                                    }
                                    //                                    // $("#ListaValores [name='IdUnidad']").val(this.value); // no sé qué renglon está elegido


                                }
                                }]
                            }
                        },
                        { name: 'Caja', formoptions: { rowpos: 8, colpos: 1 }, index: 'Codigo', align: 'left', width: 200,
                            editable: true, edittype: 'text',
                            editoptions: {
                                dataInit: function (elem) {
                                    $(elem).autocomplete({
                                        source: ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',

                                        minLength: 0,
                                        select: function (event, ui) {
                                            $("#IdArticulo").val(ui.item.id);
                                            $("#Descripcion").val(ui.item.title);
                                            $("#PorcentajeIva").val(ui.item.iva);
                                            $("#IdUnidad").val(ui.item.IdUnidad);
                                            $("#Unidad").attr("value", ui.item.IdUnidad);
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

                        { formoptions: { rowpos: 9, colpos: 2 }, name: 'DescripcionFalsa', index: '', editable: false, width: 150, hidden: false,
                            editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
                        },

                            { formoptions: { rowpos: 9, colpos: 2 }, name: 'DescripcionFalsa', index: '', editable: false, width: 150, hidden:false,
                                editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: false }
                            },

                        { name: 'Descripcion', formoptions: { rowpos: 8, colpos: 2, label: "Descripción" }, index: 'Descripcion', align: 'left',
                            hidden: false,
                            editable: true, edittype: 'text',
                            editoptions: { rows: '1', cols: '1',
                                dataInit: function (elem) {
                                    $(elem).autocomplete({

                                        source: ROOT + 'Articulo/GetArticulosAutocomplete2',
                                        minLength: 0,
                                        select: function (event, ui) {
                                            $("#IdArticulo").val(ui.item.id);
                                            $("#Codigo").val(ui.item.codigo);
                                            $("#PorcentajeIVA").val(ui.item.iva);
                                            $("#IdUnidad").val(ui.item.IdUnidad);
                                            $("#Unidad").val(ui.item.IdUnidad);

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
                        {
                            name: 'Precio',
                            formoptions: { rowpos: 9, colpos: 1 },
                            index: 'Precio', label: 'TB', align: 'right', width: 100,
                            editable: true, edittype: 'text', hidden: true,
                            editoptions: { defaultValue: '0.00', maxlength: 20,
                                dataEvents: [{

                                    type: 'keyup', fn: function (e) { CalcularImportes(); }
                                },
                                { type: 'change', fn: function (e) { CalcularImportes(); } }

                                ]

                            }, editrules: { required: true }
                        }
                       
        //////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////


                    ],

        onSelectRow: function (id, status, e) {
            if (dobleclic) {
                dobleclic = false;
                return;
            }


            if (id && id !== lastSelectedId) {
                if (typeof lastSelectedId !== "undefined") {
                    grid.jqGrid('restoreRow', lastSelectedId);
                }

                jQuery('#ListaValores').restoreRow(lastSelectedId);  // para inline
                lastSelectedId = id;
            }

            // ver qu� columna es
            //jQuery('#ListaValores').editRow(id, true);  // para inline
            jQuery('#ListaValores').editRow(id, true, null, null, null, {}, calculateTotal);
            //jQuery("#grid_id").jqGrid('editRow', rowid, keys, oneditfunc, succesfunc, url, extraparam, aftersavefunc, errorfunc, afterrestorefunc);
        },


        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //        http://stackoverflow.com/questions/9170260/jqgrid-all-rows-in-inline-edit-mode-by-default
        //                You have to enumerate all rows of grid and call editRow for every row. The code can be like the following


        loadComplete: function () { //si uso esto, no puedo usar tranquilo lo de aria-selected para el refresco de la edicion inline
//            var $this = $(this), ids = $this.jqGrid('getDataIDs'), i, l = ids.length;
//            for (i = 0; i < l; i++) {
//                $this.jqGrid('editRow', ids[i], true);
//            }
        },
        //        //or the following

        //loadComplete: function () {
        //    var $this = $(this), rows = this.rows, l = rows.length, i, row;
        //    for (i = 0; i < l; i++) {
        //        row = rows[i];
        //        if ($.inArray('jqgrow', row.className.split(' ')) >= 0) {
        //            $this.jqGrid('editRow', row.id, true);
        //        }
        //    }
        //}

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////




        ondblClickRow: function (id) {
            dobleclic = true;
            $("#edtData").click();
        },

        onClose: function (data) {
            RefrescarOrigenDescripcion();
        },

        gridComplete: function () {
            var ids = jQuery("#ListaValoresValores").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                be = "<input style='height:22px;width:20px;' type='button' value='E' onclick=\"jQuery('#ListaValores').editRow('" + cl + "',true,pickdates);\"  />";
                se = "<input style='height:22px;width:20px;' type='button' value='S' onclick=\"jQuery('#ListaValores').saveRow('" + cl + "');\"  />";
                ce = "<input style='height:22px;width:20px;' type='button' value='C' onclick=\"jQuery('#ListaValores').restoreRow('" + cl + "');\" />";
                jQuery("#ListaValores").jqGrid('setRowData', ids[i], { act: be + se + ce });
                calculateTotal();
            }
            RefrescarOrigenDescripcion();
        },

        afterSaveCell: function (rowid, name, val, iRow, iCol) {
            calculateTotal();
            RefrescarOrigenDescripcion();
        },



        //        http://stackoverflow.com/questions/7213363/jqgrid-edit-delete-button-with-each-row
        //        http://stackoverflow.com/questions/5196387/jqgrid-editactioniconscolumn-events/5204793#5204793
        //        http://www.ok-soft-gmbh.com/jqGrid/ActionButtons.htm
        //        formatter:'actions',
        //formatoptions: {
        //    keys: true,
        //    editformbutton: true
        //},

        pager: $('#ListaValoresPager'),
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
        //loadonce: true,
        // caption: '<b>ITEMS DE LA SOLICITUD DE COTIZACION</b>'
    });
    jQuery("#ListaValores").jqGrid('navGrid', '#ListaValoresPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //    jQuery("#ListaValores").jqGrid('setFrozenColumns');
    //$("#ListaValores").filterToolbar();
    $("#ListaValores").setFrozenColumns();




})

