





/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// http://stackoverflow.com/questions/7169227/javascript-best-practices-for-asp-net-mvc-developers
// http://stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript el truco interesante de var DED = (function() {
// http://stackoverflow.com/questions/251814/jquery-and-organized-code?lq=1   una risa

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////



//$(document).ready(function () {
//    /////////////////////////////////////////////////////////////////////////////////////////////////
//    /////////////////////////////////////////////////////////////////////////////////////////////////
//    alert("HOla");
//});

function SerializaForm() {
    var colModel = jQuery("#Lista").jqGrid('getGridParam', 'colModel');

    var cabecera = $("#formid").serializeObject();
    cabecera.DetalleComparativas = [];

    return cabecera;



    var s = { IdPresupuesto: 0, Estado: "" };
    cabecera.DetalleComparativas.push(s);
    //    cabecera.IdConfecciono = 2;

    // http://stackoverflow.com/questions/1297044/reload-a-loaded-jqgrid-with-a-different-table-data
    // RefrescoGrillaConOtroDatasource

    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        try {
            $('#Lista').jqGrid('saveRow', dataIds[i], false, 'clientArray');
            var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

            data1 = '{"IdComparativa":"' + $("#IdComparativa").val() + '",'
            for (var j = 0; j < colModel.length; j++) {
                cm = colModel[j]
                if (cm.label === 'TB') {
                    valor = data[cm.name];


                    /////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////
                    data1 = data1 + '"' + cm.name + '":"' + valor + '",';
                }
            }



            data1 = data1.substring(0, data1.length - 1) + '}';
            data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
            data2 = JSON.parse(data1);
            cabecera.DetalleComparativas.push(data2);
        }
        catch (ex) {
            alert("No se pudo grabar el comprobante. " + ex);
            return;
        }
    }


    return cabecera;
}



function DeserializaJqgrid(ret) {

    var grida = $('#Lista');

    grida.jqGrid('clearGridData');

    for (var i = 0; i < ret.records; i++) {
        var r = ret.rows[i].cell;
        var ccc = {

            IdDetalleComparativa: r[1],
            IdArticulo: r[2],
            IdPresupuesto: r[3],
            Codigo: r[4],
            Descripcion: r[5],
            Cantidad: r[6],

            PrecioA: r[7],
            Total_A: r[8],
            Check_A: r[9],

            PrecioB: r[10],
            Total_B: r[11],
            Check_B: r[12],

            PrecioC: r[13],
            Total_C: r[14],
            Check_C: r[15],

            PrecioD: r[16],
            Total_D: r[17],
            Check_D: r[18],

            PrecioE: r[19],
            Total_E: r[20],
            Check_E: r[21],

            PrecioF: r[22],
            Total_F: r[23],
            Check_F: r[24],

            PrecioG: r[25],
            Total_G: r[26],
            Check_G: r[27],

            PrecioH: r[28],
            Total_H: r[29],
            Check_H: r[30]

        };





        if (i == 0) {
            if (ccc.PrecioA == "") {
                $("#Lista").hideCol("PrecioA");
                $("#Lista").hideCol("Total_A");
                $("#Lista").hideCol("Check_A");
            }
            else {

                $("#Lista").showCol("PrecioA");
                $("#Lista").showCol("Total_A");
                $("#Lista").showCol("Check_A");
            }

            if (ccc.PrecioB == "") {
                $("#Lista").hideCol("PrecioB");
                $("#Lista").hideCol("Total_B");
                $("#Lista").hideCol("Check_B");
            }
            else {

                $("#Lista").showCol("PrecioB");
                $("#Lista").showCol("Total_B");
                $("#Lista").showCol("Check_B");
            }



            if (ccc.PrecioC == "") {
                $("#Lista").hideCol("PrecioC");
                $("#Lista").hideCol("Total_C");
                $("#Lista").hideCol("Check_C");
            }
            else {

                $("#Lista").showCol("PrecioC");
                $("#Lista").showCol("Total_C");
                $("#Lista").showCol("Check_C");
            }



            if (ccc.PrecioD == "") {
                $("#Lista").hideCol("PrecioD");
                $("#Lista").hideCol("Total_D");
                $("#Lista").hideCol("Check_D");
            }
            else {

                $("#Lista").showCol("PrecioD");
                $("#Lista").showCol("Total_D");
                $("#Lista").showCol("Check_D");
            }

            if (ccc.PrecioE == "") {
                $("#Lista").hideCol("PrecioE");
                $("#Lista").hideCol("Total_E");
                $("#Lista").hideCol("Check_E");
            }
            else {

                $("#Lista").showCol("PrecioE");
                $("#Lista").showCol("Total_E");
                $("#Lista").showCol("Check_E");
            }

            if (ccc.PrecioF == "") {
                $("#Lista").hideCol("PrecioF");
                $("#Lista").hideCol("Total_F");
                $("#Lista").hideCol("Check_F");
            }
            else {

                $("#Lista").showCol("PrecioF");
                $("#Lista").showCol("Total_F");
                $("#Lista").showCol("Check_F");
            }

            if (ccc.PrecioG == "") {
                $("#Lista").hideCol("PrecioG");
                $("#Lista").hideCol("Total_G");
                $("#Lista").hideCol("Check_G");
            }
            else {

                $("#Lista").showCol("PrecioG");
                $("#Lista").showCol("Total_G");
                $("#Lista").showCol("Check_G");
            }

            if (ccc.PrecioH == "") {
                $("#Lista").hideCol("PrecioH");
                $("#Lista").hideCol("Total_H");
                $("#Lista").hideCol("Check_H");
            }
            else {

                $("#Lista").showCol("PrecioH");
                $("#Lista").showCol("Total_H");
                $("#Lista").showCol("Check_H");
            }

        }


        grida.addRowData(i + 1, ccc);
    }
    alto();
    funccheck();
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function funccheck() {
    /////////////////////////////////////////
    // checks de encabezado
    /////////////////////////////////////////
    $("#Lista [id=1] input:checkbox").each(function (index) {
        $(this).change(function (e) {

            //            var table = $(e.target).closest('table');
            //            $('td input:checkbox', table).attr('checked', e.target.checked);

            var c = e.target.checked;



            if (c) {
                $("input:checked").prop('checked', false);
                $("#Lista [id=1] input:checkbox").prop('checked', false);
                $(e.target).prop('checked', true);
            }


            var desc = $(e.target.parentElement).attr('aria-describedby');


            var grid = $("#Lista");
            var ids = grid.getDataIDs();
            var rengs = ids.length;

            for (i = 2; i < rengs - 6; i++) {
                var ret = [];
                $("#Lista   [id=" + i + "] [aria-describedby=" + desc + "] input:checkbox").prop('checked', c);
            }

        })

    });

    /////////////////////////////////////////
    // desmarcar el resto de los checks del mismo renglon
    /////////////////////////////////////////
    $("#Lista input:checkbox").change(function (e) {
        //        var table = $(e.target).closest('table');
        //        $('td input:checkbox', table).attr('checked', e.target.checked);

        //        $(this).parents("tr :checkbox").prop('checked', false);  // destildo el resto del renglon
        var c = e.target.checked;

        if (c) {
            var i = $(e.target.parentElement.parentElement).attr('id');
            $("#Lista   [id=" + i + "]  input:checkbox").prop('checked', false);
            $(e.target).prop('checked', true);
        }



    });
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function alto() {
    var grid = $("#Lista");
    var ids = grid.getDataIDs();
    grid.setRowData(ids[0], false, { height: 50 });





    $("#Lista [id=1]").css('white-space', 'normal !important');




    var rengs = ids.length;
    $("#Lista [id=" + (rengs - 6) + " ] :checkbox").hide();
    $("#Lista [id=" + (rengs - 5) + " ] :checkbox").hide();
    $("#Lista [id=" + (rengs - 4) + " ] :checkbox").hide();
    $("#Lista [id=" + (rengs - 3) + " ] :checkbox").hide();
    $("#Lista [id=" + (rengs - 2) + " ] :checkbox").hide();
    $("#Lista [id=" + (rengs - 1) + " ] :checkbox").hide();
    $("#Lista [id=" + (rengs - 0) + " ] :checkbox").hide();

    //                    for (var i = 0; i < ids.length; i++) {
    //                        grid.setRowData(ids[i], false, { height: 20 + i * 2 });
    //                    }
    //            }
}



function SerializaFormConGrilla() {


    var cabecera = SerializaForm();

    var grida = $('#Lista');

    var dat = grida.jqGrid('getRowData'); //al no pasarle el parametro de idrow, me trae la grilla entera

    var ret;



    var dataParaPostear = {
        o: cabecera,
        grilla: dat // g //grilla2 //dat
    }; // el secreto es juntar  todos los parametros, y hacer el stringify al final
    // -ok, el objeto comparativa llega bien, pero el array de los renglones de la grilla no 
    // http://stackoverflow.com/questions/2203912/asp-net-mvc-ajax-json-post-array
    // http://theycallmemrjames.blogspot.com.ar/2010/05/aspnet-mvc-and-jquery-part-4-advanced.html



    return dataParaPostear;

}

function CargarGrillaManualmente(IdPresupuesto) { //lo hago manualmente porque tuve mil problemas para pasar el objeto Comparativa como parametro de los reload de la jqgrid

    //    var myData = [
    //    { Name: "VIA XP", TesttiefeName: "Alle SW-Produkte", Std: true, IsFachlicheTests: false, RowVersion: "20FC31" },
    //    { Name: "KUBUS", TesttiefeName: "Alle SW-Produkte", Std: false, IsFachlicheTests: true, RowVersion: "20FC32" }
    //];


    var cabecera = SerializaForm();

    //    var s = { IdPresupuesto: IdPresupuesto, Estado: "" };
    //    cabecera.DetalleComparativas.push(s);

    //    var oj = { o: cabecera, IdComparativa: 2 };
    //    var ojeto = JSON.stringify(oj);  // pinta que tenes que stringifyar el objeto final!!!!!
    //var ojeto = $.toJSON({ o: cabecera, IdComparativa: 2 });
    //data: { json_1:$.toJSON(data_1), json_2:$.toJSON(data_2) },

    var grida = $('#Lista');


    /////////////////////////////////////////////////////////////////////////////////

    var dat = grida.jqGrid('getRowData'); //al no pasarle el parametro de idrow, me trae la grilla entera
    var grilla2 = JSON.stringify(dat);
    ///////////////////////////////////////////////////////////////////////////////


    var ret;


    // los temitas que tengo por pasar más de un parametro 
    // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
    //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
    //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
    //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
    //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)
    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)
    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)


    var dataParaPostear = {
        o: cabecera,
        grilla: dat // g //grilla2 //dat
    }; // el secreto es juntar  todos los parametros, y hacer el stringify al final
    // -ok, el objeto comparativa llega bien, pero el array de los renglones de la grilla no 
    // http://stackoverflow.com/questions/2203912/asp-net-mvc-ajax-json-post-array
    // http://theycallmemrjames.blogspot.com.ar/2010/05/aspnet-mvc-and-jquery-part-4-advanced.html







    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        // url: ROOT + 'Comparativa/BatchUpdate',
        url: ROOT + 'Comparativa/ArmarGrillaSegunPresupuestosHackeada2?IdPresupuestoAgregado=' + IdPresupuesto, // + '&grilla=' + grilla,

        dataType: 'json',

        //  traditional: true,

        data: JSON.stringify(dataParaPostear),
        //        {
        //            // los temitas que tengo por pasar más de un parametro 
        //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
        //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
        //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
        //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
        //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
        //            // http://stackoverflow.com/questions/9771680/mvc3-complex-json-list-binding
        //            'o': JSON.stringify(cabecera),
        //            'grilla': grilla
        //        },
        //        //            'IdPresupuestoAgregado': IdPresupuesto       }
        //ojeto, // $.toJSON(cabecera),
        success: function (result) {
            ret = result;


            // http://stackoverflow.com/questions/4739535/jqgrid-load-array-data
            // What you need is just use the following localReader



            //            for (var i = 0; i <= ret.length; i++) {
            //                grida.addRowData(i + 1, ret[i]);
            //            }

            DeserializaJqgrid(ret);


            //                for (var c = 0; c <= ret.rows[i].lenght; c++) {
            //                    
            //                }



        }

        ,
        beforeSend: function () {
            //$('.loading').html('some predefined loading img html');
        $("#loading").show();




    },
    complete: function () {
        $("#loading").hide();
    }




    });


    // http://stackoverflow.com/questions/2746980/how-to-suppress-jqgrid-from-initially-loading-data
    // http://stackoverflow.com/questions/2728234/jqgrid-tabletogrid-options-parameter/2729305#2729305


}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
function CopiarPresupuesto(acceptId, ui) {

    // var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
    var getdata = jQuery("#ListaDrag3").jqGrid('getRowData', acceptId);

    var j = 0, tmpdata = {}, dropname, IdRequerimiento;
    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
    var grid;
    //  try {

    // estos son datos de cabecera que ya tengo en la grilla auxiliar
    $("#Observaciones").val(getdata['Observaciones']);
    $("#LugarEntrega").val(getdata['LugarEntrega']);
    $("#IdObra").val(getdata['IdObra']);
    $("#IdSector").val(getdata['IdSector']);

    $("#IdProveedor").val(getdata['IdProveedor']);
    $("#DescripcionProveedor").val(getdata['Proveedor']);



    //me traigo los datos de detalle
    IdPresupuesto = getdata['IdPresupuesto']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas



    CargarGrillaManualmente(IdPresupuesto);
    return;


    var cabecera = SerializaForm();

    ///////////////////////////////////////////////////////////////////////////
    var grida = $('#Lista');


    ////////////////////////////////////////
    //grida.clearGridData();
    //grida.setGridParam({ url:});
    //grida.setGridParam({ postData: { 'o': JSON.stringify(cabecera)} });
    // grida.setGridParam({ postData: JSON.stringify(cabecera) });

    //    grida.jqGrid('setGridParam', { datatype: 'json', page: 1, url: ROOT + 'Comparativa/ArmarGrillaSegunPresupuestosHackeada2/',
    //        postData: JSON.stringify(cabecera)
    //    });


    //grida.jqGrid('setGridParam', 'postData', { 'o': JSON.stringify(cabecera) });
    // la grilla está llamando a ArmarGrillaSegunPresupuestos con los parametros normales de paginacion... (sord, sidx, IdComparativa...) además del 'o'
    // -no hay manera de resetear esos parametros?
    // http://stackoverflow.com/questions/7516354/how-do-we-clear-grid-parameters-in-jqgrid
    // http://stackoverflow.com/a/7522029
    ///////////////////////////////////////////


    // grida.setGridParam({ datatype: 'json' });
    grida.jqGrid().trigger('reloadGrid');

    ////////////////////////////////////////




    //  } catch (e) { }

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





function calculateTotal() {
    var totalCantidad = grid.jqGrid('getCol', 'Cantidad', false, 'sum')

    var pr, cn, st, ib, ib_, ib_t, pi, ii, st1, ib1, ib2, ii1, st2, pb, st3, tp, tg;
    st1 = 0;
    ib1 = 0;
    ib2 = 0;
    ii1 = 0;
    pi = 0;

    ////////////////////////////////////////////////////////////////////////////////////////////
    var mvarIVANoDiscriminado = 0;
    bMostrarIVA = $("#TipoABC").val() == "A";
    PorcentajeIva1 = 21; //  parseFloat($("#PorcentajeIva1").val().replace(",", "."));
    PorcentajeIva2 = 21; //  parseFloat($("#PorcentajeIva2").val().replace(",", "."));
    var codigoiva = $("#IdCodigoIva").val();
    if (codigoiva == 1) {
        pi = PorcentajeIva1;
    }
    else if (codigoiva == 2) {
        mvarIVA1 = Math.round(mvarNetoGravado * PorcentajeIva1 / 100);
        mvarIVA2 = Math.round(mvarNetoGravado * PorcentajeIva2 / 100);
        //                mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva1) / 100, mvarDecimales) + 
        //                                Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva2) / 100, mvarDecimales)
        mvarIVANoDiscriminado = 0;
        pi = 0;
    }
    else if (codigoiva == 9) {
        mvarIVANoDiscriminado = Math.round(mvarNetoGravado - (mvarNetoGravado / (1 + PorcentajeIva1) / 100));
        $("#IVANoDiscriminado").val(mvarIVANoDiscriminado);
    }
    else {
        pi = 0;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////

    pb = 0; // parseFloat($("#PorcentajeBonificacion").val().replace(",", "."));
    if (isNaN(pb)) { pb = 0; }
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        pr = 0; // parseFloat(data['PrecioUnitario'].replace(",", "."));
        if (isNaN(pr)) { pr = 0; }
        cn = parseFloat((data['Cantidad']).replace(",", "."));
        if (isNaN(cn)) { cn = 0; }
        ///////////////////////////////////////
        // subtotal
        st = Math.round(pr * cn * 10000) / 10000;   // subtotal del item
        st1 = Math.round((st1 + st) * 10000) / 10000;  // sumatoria de los subtotales de items
        ///////////////////////////////////////
        // bonificacion

        // esta es la bonificacion del item (el item tiene un %bonif individual. El importe lo calculó "calculateItem", no? -no si lo muestra por primera vez
        // ib = parseFloat(data['ImporteBonificacion'].replace(",", "."));
        var pbi = 0; // parseFloat(data['Bonificacion'].replace(",", "."));
        var ib = Math.round(st * pbi / 100 * 10000) / 10000; // recalculo el importe bonif de item, porque si es la primera vez 
        //                                                          que se muestra el formulario, no pasé por calculateItem


        if (isNaN(ib)) { ib = 0; }
        ib1 = ib1 + ib; // ib1 va sumando los importes de bonificacion individual
        ib_ = Math.round((st - ib) * pb / 100 * 10000) / 10000;  // esta es la bonificacion global que se aplica al item una vez que se le restó su bonif individual
        ib2 = ib2 + ib_; // ib2 va sumando los importes de bonif globales
        ib_t = ib + ib_; // esto es la bonif final del item (por indiv + global)
        ///////////////////////////////////////////
        // iva
        // pi = parseFloat(data['PorcentajeIva'].replace(",", ".")); //este es por item

        if (isNaN(pi)) { pi = 0; }
        ii = Math.round((st - ib - ib_) * pi / 100 * 10000) / 10000;
        ii1 = ii1 + ii


        tp = st - ib_t + ii;

        ///////////////////////////////////////////
        ///////////////////////////////////////////
        if (false) // actualizo los items. Podría llamar desde esta funcion a la calculateItem....
        {
            data['ImporteBonificacion'] = ib_t.toFixed(4);
            data['ImporteIva'] = ii.toFixed(4);
        }
        data['ImporteTotalItem'] = (st - ib).toFixed(4); // ojo. el importe total del item debe aparecer sin la bonificacion?
        $('#Lista').jqGrid('setRowData', dataIds[i], data);


    }
    st2 = Math.round((st1 - ib1) * 10000) / 10000; //subtotal - las bonificaciones por item
    st3 = Math.round((st2 - ib2) * 10000) / 10000; //subtotal - las bonificaciones por item - las bonif globales
    tg = Math.round((st3 + ii1) * 10000) / 10000;  //subtotal - las bonificaciones por item - las bonif globales + iva



    ////////////////////////////////////////////////////////////////////////////////////////////
    bMostrarIVA = $("#TipoABC").val() == "A";
    PorcentajeIva1 = 21; //  parseFloat($("#PorcentajeIva1").val().replace(",", "."));
    PorcentajeIva2 = 21; // parseFloat($("#PorcentajeIva2").val().replace(",", "."));
    if (codigoiva == 2) {
        mvarIVA1 = Math.round(mvarNetoGravado * PorcentajeIva1 / 100);
        mvarIVA2 = Math.round(mvarNetoGravado * PorcentajeIva2 / 100);
        //                mvarPartePesos = mvarPartePesos + Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva1) / 100, mvarDecimales) + 
        //                                Math.Round((mvarPartePesos + (mvarParteDolares * .Cotizacion)) * Val(.PorcentajeIva2) / 100, mvarDecimales)
        mvarIVANoDiscriminado = 0;
    }
    else if (codigoiva == 3) {
    }
    else if (codigoiva == 9) {
        mvarIVANoDiscriminado = Math.round(mvarNetoGravado - (mvarNetoGravado / (1 + PorcentajeIva1) / 100));
        $("#IVANoDiscriminado").val(mvarIVANoDiscriminado);
    }


    //            if (bMostrarIVA) {
    //                pi = parseFloat($("#PorcentajeIva1").val().replace(",", ".")); // este es el global (ponerlo afuera del bucle)
    //            }
    //            else {
    //                pi = 0;
    //            }

    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    mvarNetoGravado = tg;

    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    //percepcion ing brutos 1 2 3
    //por cada uno de los tres, hay que verificar fecha vigencia, tope, conveniomultilateral,
    //            percepIIBB = cmbCategoriaIIBB1.SelectedValue
    //            mvarPorcentajeIBrutos
    //    mvarPorcentajeIBrutos1 = parseFloat($("#Cliente_IBCondicionCat1_AlicuotaPercepcion").val().replace(",", "."));
    //    mvarPorcentajeIBrutos2 = parseFloat($("#Cliente_IBCondicionCat2_AlicuotaPercepcion").val().replace(",", "."));
    //    mvarPorcentajeIBrutos3 = parseFloat($("#Cliente_IBCondicionCat3_AlicuotaPercepcion").val().replace(",", "."));
    //    ibgbrut1 = roundNumber((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos1 / 100, 2) || 0;
    //    ibgbrut2 = roundNumber((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2) || 0;
    //    ibgbrut3 = roundNumber((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2) || 0;
    //    $("#PercepIIBB").val(ibgbrut1 + ibgbrut2 + ibgbrut3)
    //    ////////////////////////////////////////////////////////////////////////////////////////////
    //    ////////////////////////////////////////////////////////////////////////////////////////////
    //    //percepcion iva
    //    var mvarPercepcionIVA = 0;
    //    mvarEsAgenteRetencionIVA = $("#Cliente_EsAgenteRetencionIVA").val();
    //    mvarBaseMinimaParaPercepcionIVA = parseFloat($("#Cliente_BaseMinimaParaPercepcionIVA").val().replace(",", ".")) || 0; ;
    //    mvarPorcentajePercepcionIVA = parseFloat($("#Cliente_PorcentajePercepcionIVA").val().replace(",", ".")) || 0; ;
    //    if (mvarEsAgenteRetencionIVA == "SI" && mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA) {
    //        mvarPercepcionIVA = roundNumber(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, 2);

    //    }
    //    mvarPercepcionIVA = mvarPercepcionIVA || 0;
    //    $("#PercepcionIVA").val(mvarPercepcionIVA);
    //    ////////////////////////////////////////////////////////////////////////////////////////////
    //    ////////////////////////////////////////////////////////////////////////////////////////////    
    //    op1 = parseFloat($("#OtrasPercepciones1").val().replace(",", ".")) || 0;
    //    op2 = parseFloat($("#OtrasPercepciones2").val().replace(",", ".")) || 0;
    //    op3 = parseFloat($("#OtrasPercepciones3").val().replace(",", ".")) || 0;
    //    tg = tg + op1 + op2 + op3 + ibgbrut1 + ibgbrut2 + ibgbrut3 + mvarPercepcionIVA;

    //    $("#Subtotal1").val(st2.toFixed(4).replace(",", "."));
    //    $("#TotalBonificacionItems").val(ib1.toFixed(4).replace(",", "."));
    //    $("#ImporteBonificacionTotal").val(ib2.toFixed(4).replace(",", "."));
    //    $("#Subtotal2").val(st3.toFixed(4).replace(",", "."));
    //    $("#ImporteIva1").val(ii1.toFixed(4).replace(",", "."));
    //    $("#ImporteTotal").val(tg.toFixed(4).replace(",", "."));

    grid.jqGrid('footerData', 'set', { NumeroObra: 'TOTALES', Cantidad: totalCantidad.toFixed(2), ImporteBonificacion: ib1.toFixed(4), ImporteIva: ii1.toFixed(4), ImporteTotalItem: st2.toFixed(4) });
};


function calculateItem() {
    var pb = parseFloat($("#Bonificacion").val());
    if (isNaN(pb)) { pb = 0; }
    var pr = parseFloat($("#PrecioUnitario").val());
    var cn = parseFloat($("#Cantidad").val());
    var pi = parseFloat($("#PorcentajeIva1").val());  // parseFloat($("#PorcentajeIva").val()); para el porcentaje de iva, usamos el global de la factura
    var st = Math.round(pr * cn * 10000) / 10000;
    var ib = Math.round(st * pb / 100 * 10000) / 10000;
    st = (st - ib) || 0;
    var ii = Math.round(st * pi / 100 * 10000) / 10000;
    var it = Math.round((st + ii) * 10000) / 10000;
    $("#ImporteBonificacion").val(ib.toFixed(4));
    $("#ImporteIva").val(ii.toFixed(4));
    //////////////////////////////////////////////////////////////////////
    // TOTAL ITEM
    // en facturas, el total del item se pone sin el iva (por lo menos el que se muestra en pantalla) 
    //-efectivamente... esta columna solo es de la grilla: la tabla detfacturas no desnormaliza en una columna 
    // aparte el total del item con o sin iva o bonificacion
    // $("#ImporteTotalItem").val(it.toFixed(4)); // <-- es decir, este no va
    $("#ImporteTotalItem").val(st.toFixed(4));


    calculateTotal();  // no encuentro la manera de refrescar el total despues de la edicion, y ni de esta manera funciona!
}



function copiarListaDrag(rowid) {

    var getdata = $("#ListaDrag").jqGrid('getRowData', rowid);

    var s;

    if ($("#IdCliente").val() == "") {
        $("#IdCliente").val(getdata['IdCliente']);
        $("#Cliente").val(getdata['Cliente']);
        $("#DescripcionCliente").val(getdata['Cliente']);
        s = getdata['Cliente'];
    }


    // var companyList = $("#DescripcionCliente").autocomplete;
    // companyList.autocomplete('option', 'change').call(companyList);

    var j = 0, tmpdata = {}, dropname;
    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
        tmpdata['PrecioUnitario'] = getdata['Precio'];
        tmpdata['Cantidad'] = getdata['Cantidad'];

        tmpdata['Costo'] = 0;
        tmpdata['Bonificacion'] = 0; // getdata['Bonificacion'];


        tmpdata['IdUnidad'] = getdata['IdUnidad']; // data[i].IdUnidad;
        tmpdata['Unidad'] = getdata['Unidad']; // data[i].Unidad;
        tmpdata['IdDetalleFactura'] = 0;
        tmpdata['IdDetalleRemito'] = 0;  //data[i].IdDetalleRemito;

        // tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
        getdata = tmpdata;
        grid = Math.ceil(Math.random() * 1000000);
        //  $("#Lista").jqGrid('addRowData', grid, getdata);




        getdata = tmpdata;
    } catch (e) { }
    var grid;
    grid = Math.ceil(Math.random() * 1000000);

    $("#Lista").jqGrid('addRowData', grid, getdata);
    //resetAltRows.call(this);
    $("#gbox_grid2").css("border", "1px solid #aaaaaa");


    ActualizarDatosCliente(s);

};

function copiarListaDrag2(rowid) {


    var getdata = $("#ListaDrag2").jqGrid('getRowData', rowid);
    var s;

    if ($("#IdCliente").val() == "") {
        $("#IdCliente").val(getdata['IdCliente']);
        $("#Cliente").val(getdata['RazonSocial']);
        $("#DescripcionCliente").val(getdata['RazonSocial']);
        s = getdata['RazonSocial'];
    }

    var j = 0, tmpdata = {}, dropname;
    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
        tmpdata['Descripcion'] = getdata['Articulo']; // getdata['Descripcion'];
        tmpdata['PrecioUnitario'] = 0; // getdata['Precio'];
        tmpdata['Cantidad'] = getdata['Cantidad'];
        tmpdata['Costo'] = 0;
        tmpdata['Bonificacion'] = 0; // getdata['Bonificacion'];



        tmpdata['IdUnidad'] = getdata['IdUnidad']; // data[i].IdUnidad;
        tmpdata['Unidad'] = getdata['Unidad']; // data[i].Unidad;
        tmpdata['IdDetalleFactura'] = 0;
        tmpdata['IdDetalleRemito'] = getdata['IdDetalleRemito']; // data[i].IdDetalleRemito;

        // tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
        getdata = tmpdata;
        grid = Math.ceil(Math.random() * 1000000);
        //$("#Lista").jqGrid('addRowData', grid, getdata);






        getdata = tmpdata;
    } catch (e) { }
    var grid;
    grid = Math.ceil(Math.random() * 1000000);
    // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData
    $("#Lista").jqGrid('addRowData', grid, getdata);
    //resetAltRows.call(this);
    $("#gbox_grid2").css("border", "1px solid #aaaaaa");

    ActualizarDatosCliente(s);

}


$(document).ready(function () {

   // $("#tabs-east").children().css("background-color", "red");


    // "use strict";

    var lastSelectedId;
    var inEdit;
    grid = $("#Lista");

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
            $(elem).focus();
        }, 100);
    };


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    $("#FechaFactura").datepicker({
        changeMonth: true,
        changeYear: true
        //numberOfMonths: 2,
    });
    $("#FechaVencimiento").datepicker({
        changeMonth: true,
        changeYear: true
        //numberOfMonths: 2,
    });




    $("#IdMoneda").change(function () {
        var fecha = $("#FechaFactura").val();
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
                        jAlert('No hay cotizacion', 'Cotizaciones');
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





    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    $(window).load(function () {
        CargarGrillaManualmente();

        $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');

    });

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    //Para que haga wrap en las celdas
    //$.jgrid.formatter.integer.thousandsSeparator=',';

    $('#Lista').jqGrid({
        // url: ROOT + 'Comparativa/DetComparativaParaJQgrid/',
        //    url: ROOT + 'Comparativa/ArmarGrillaSegunPresupuestosHackeada2/',

        datatype: 'json',
        mtype: 'POST',
        postData: {
            IdComparativa: function () { return $("#IdComparativa").val(); },
            ogg: function () { return JSON.stringify(SerializaForm()); }
            //ogg: function () { return SerializaForm(); }
            ///JSON.stringify(SerializaForm())
        }

        ,



        // editurl: ROOT + 'Factura/EditGridData/',

        colNames: ['Acciones', 'IdDetalleFactura', 'IdArticulo', 'IdPresupuesto', '#',

                       'cód.', 'Descripcion', 'cant.', 'Un.',

                        '', '', '',
                        '', '', '',
                      '', '', '',
                       '', '', '',
                       '', '', '',
                       '', '', '',
                       '', '', '',
                       '', '', ''

                       ],




        colModel: [
                        { name: 'act', index: 'act', align: 'left', width: 70, sortable: false, editable: false, hidden: true },
                        { name: 'IdDetalleComparativa', index: 'IdDetalleFactura', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: false} },
                        { name: 'IdArticulo', index: 'IdArticulo', label: 'TB', align: 'left', width: 85,
                            editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: false }
                        },
                        { name: 'IdPresupuesto', index: 'IdPresupuesto', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: false} },
        //{ name: 'Eliminado', index: 'Eliminado', label:'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true} },
                        {name: 'NumeroItem', index: 'NumeroItem', label: 'TB', align: 'left', width: 20, editable: false, hidden: false, classes: 'cvteste' },

                        { name: 'Codigo', index: 'Codigo', align: 'left', width: 30, editable: true, edittype: 'text', classes: 'cvteste',
                            editoptions: {
                                dataInit: function (elem) {
                                    $(elem).autocomplete({
                                        source: ROOT + 'Articulo/GetCodigosArticulosAutocomplete2',
                                        minLength: 3,
                                        select: function (event, ui) {
                                            $("#IdArticulo").val(ui.item.id);
                                            $("#Descripcion").val(ui.item.title);
                                            $("#IdUnidad").val(ui.item.idunidad);
                                            $("#Unidad").val(ui.item.idunidad);
                                        },
                                        autoFocus: true
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
                        { name: 'Descripcion', index: 'Descripcion', align: 'left', width: 150, editable: true, edittype: 'text', frozen: true, classes: 'cvteste',
                            editoptions: {
                                dataInit: function (elem) {
                                    $(elem).autocomplete({
                                        source: ROOT + 'Articulo/GetArticulosAutocomplete2',

                                        minLength: 0,
                                        select: function (event, ui) {
                                            $("#IdArticulo").val(ui.item.id);
                                            $("#Codigo").val(ui.item.codigo);
                                            $("#IdUnidad").val(ui.item.IdUnidad);
                                            $("#Unidad").val(ui.item.IdUnidad);
                                        },
                                        autoFocus: true
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
                          { name: 'Cantidad', index: 'Cantidad', label: 'TB', align: 'right', width: 50, classes: 'cvteste',
                              editable: true, edittype: 'text', editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { calculateItem(); } }] }, editrules: { required: false }
                          }, //, unformat:numUnformat
                        {name: 'Unidad', index: 'IdUnidad', align: 'left', width: 30, editable: true, edittype: 'select', editrules: { required: false }, classes: 'cvteste',
                        editoptions: {
                            dataUrl: ROOT + 'Articulo/Unidades',


                            dataEvents: [{ type: 'change', fn: function (e) { $('#IdUnidad').val(this.value); } }]
                        }
                    },


                    { name: 'PrecioA', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 120, editable: true, editoptions: { disabled: 'disabled'} },
                    { name: 'Total_A', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled'} },
                             { name: 'Check_A', index: 'Check_A', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                                 editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30,
                                 formatter: "checkbox", formatoptions: { disabled: false }
                             },




                    { name: 'PrecioB', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 120, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Total_B', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Check_B', index: 'Check_B', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30, classes: 'cvteste',
                        formatter: "checkbox", formatoptions: { disabled: false }
                    },
                    { name: 'PrecioC', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 120, editable: true, editoptions: { disabled: 'disabled'} },
                    { name: 'Total_C', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled'} },
                    { name: 'Check_C', index: 'Check_C', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 30,
                        formatter: "checkbox", formatoptions: { disabled: false }
                    },
                    { name: 'PrecioD', index: 'PrecioD', label: 'TB', align: 'right', width: 120, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Total_D', index: 'Total_D', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Check_D', index: 'Check_D', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 50, classes: 'cvteste',
                        formatter: "checkbox", formatoptions: { disabled: false }
                    },
                    { name: 'PrecioE', index: 'PrecioE', label: 'TB', align: 'right', width: 120, editable: true, editoptions: { disabled: 'disabled'} },
                    { name: 'Total_E', index: 'Total_E', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled'} },
                    { name: 'Check_E', index: 'Check_E', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 50,
                        formatter: "checkbox", formatoptions: { disabled: false }
                    },
                    { name: 'PrecioF', index: 'PrecioF', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Total_F', index: 'Total_F', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Check_F', index: 'Check_F', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 50,
                        formatter: "checkbox", formatoptions: { disabled: false }
                    },
                    { name: 'PrecioG', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled'} },
                    { name: 'Total_G', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled'} },
                    { name: 'Check_G', index: 'Check_G', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 50,
                        formatter: "checkbox", formatoptions: { disabled: false }
                    },
                    { name: 'PrecioH', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Total_H', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 40, editable: true, editoptions: { disabled: 'disabled' }, classes: 'cvteste' },
                    { name: 'Check_H', index: 'Check_H', // http://stackoverflow.com/questions/928919/jqgrid-with-an-editable-checkbox-column
                        editable: true, edittype: 'checkbox', editoptions: { value: "True:False" }, width: 50,
                        formatter: "checkbox", formatoptions: { disabled: false }
                    }





                    ],
        onSelectRow: function (id) {

            if (false) {
                if (id && id !== lastSelectedId) {
                    if (typeof lastSelectedId !== "undefined") {
                        grid.jqGrid('restoreRow', lastSelectedId);
                    }

                    jQuery('#Lista').restoreRow(lastSelectedId);  // para inline
                    lastSelectedId = id;
                }

                // ver qu� columna es
                jQuery('#Lista').editRow(id, true);  // para inline

            }

        },
        gridComplete: function () {

            // $("#Lista").jqGrid('clearGridData');
            // CargarGrillaManualmente(-1); //hay que arreglar esto para no tener que hacerlo así// ademas si lo pones aca se hace recursivo

            //alto();


        },

        afterSaveCell: function (rowid, name, val, iRow, iCol) {
            calculateTotal();
        },
        afterSubmit: function (response, postdata) {
            calculateTotal();
        },
        afterComplete: function (response, postdata, formid) {
            //CargarGrillaManualmente(-1);
            calculateTotal();
        },
        onClose: function (data) {
            calculateTotal();
        }
        ,

        afterShowForm: function (formid) {
            //calculateTotal();

        }
        ,


        beforeShowForm: function (form) {
            // "editmodlist" //http://stackoverflow.com/questions/3967488/how-to-center-jqgrid-popup-modal-window
            var dlgDiv = $("#editmod" + grid[0].id);
            var parentDiv = dlgDiv.parent(); // div#gbox_list
            var dlgWidth = dlgDiv.width();
            var parentWidth = parentDiv.width();
            var dlgHeight = dlgDiv.height();
            var parentHeight = parentDiv.height();
            // TODO: change parentWidth and parentHeight in case of the grid
            //       is larger as the browser window
            dlgDiv[0].style.top = Math.round((parentHeight - dlgHeight) / 2) + "px";
            dlgDiv[0].style.left = Math.round((parentWidth - dlgWidth) / 2) + "px";
        },
        pager: $('#ListaPager'),
        rowNum: 100,
        sortname: 'NumeroItem',
        sortorder: 'asc',
        viewrecords: true,
        width: 'auto',
        height: 350, // 'auto',
        //altRows: false,
        ////////////////////////
        autowidth: true,
        shrinkToFit: false,
        ////////////////////////
        footerrow: false,
        userDataOnFooter: false,
        loadonce: true

        //para sacar el icono de resize, tenes que eliminar el metodo "gridResize"
        //        http://stackoverflow.com/questions/8983899/how-to-remove-hide-the-resize-button-in-jqgrid-jquery
        //            caption: ''  '<b>ITEMS DEL Factura</b>'

    });

    //    jQuery("#Lista").jqGrid('setFrozenColumns');






    function numUnformat(cellvalue, options, rowObject) {
        return cellvalue.replace(",", ".");
    }

    $("#addData").click(function () {
        jQuery("#Lista").jqGrid('editGridRow', "new", { addCaption: "Agregar registro", bSubmit: "Aceptar", bCancel: "Cancelar", width: 1200, reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
            recreateForm: true,
            beforeShowForm: function (form) {
                var dlgDiv = $("#editmod" + grid[0].id);
                dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
            },
            beforeInitData: function () {
                inEdit = false;
            },
            onInitializeForm: function (form) {
                $('#IdDetalleFactura', form).val(0);
            }
            //beforeShowForm: function (form) { $('#tr_IdDetalleFactura', form).hide(); }
        });
    });

    $("#edtData").click(function () {
        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        if (gr != null) jQuery("#Lista").jqGrid('editGridRow', gr,
                { editCaption: "Modificar registro", bSubmit: "Aceptar",
                    bCancel: "Cancelar", width: 1200, reloadAfterSubmit: false, closeOnEscape: true,
                    viewPagerButtons: true, // no me los está mostrando 

                    closeAfterEdit: true, recreateForm: true, Top: 0,
                    beforeShowForm: function (form) {
                        // "editmodlist"
                        var dlgDiv = $("#editmod" + grid[0].id);
                        var parentDiv = dlgDiv.parent(); // div#gbox_list
                        var dlgWidth = dlgDiv.width();
                        var parentWidth = parentDiv.width();
                        var dlgHeight = dlgDiv.height();
                        var parentHeight = parentDiv.height();
                        dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                        dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                    },
                    beforeInitData: function () {
                        inEdit = true;
                    },

                    onClose: function () {
                        calculateTotal();
                    }
                });
        else alert("Debe seleccionar un item!");
    });

    $("#delData").click(function () {
        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
        if (gr != null) {
            //jQuery("#Lista").jqGrid('setRowData',gr,{Eliminado:"true"});
            //$("#"+gr).hide();  
            jQuery("#Lista").jqGrid('delGridRow', gr, { caption: "Borrar", msg: "Elimina el registro seleccionado?", bSubmit: "Borrar", bCancel: "Cancelar", width: 1200, closeOnEscape: true, reloadAfterSubmit: true });
        }
        else alert("Debe seleccionar un item!");
    });


    //jQuery("#Lista").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });











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



    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////


    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////





    getColumnIndexByName = function (grid, columnName) {
        var cm = grid.jqGrid('getGridParam', 'colModel'), i, l = cm.length;
        for (i = 0; i < l; i++) {
            if (cm[i].name === columnName) {
                return i; // return the index
            }
        }
        return -1;
    };

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








    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    $("#ListaDrag").jqGrid({
        url: ROOT + 'Factura/OrdenesCompraPendientesFacturar',

        datatype: 'json',
        mtype: 'POST',
        cellEdit: true,

        colNames: ['', 'IdDetalleOrdenCompra', 'IdArticulo', 'Codigo', 'Articulo', 'Precio', 'Cantidad', 'IdUnidad', 'Unidad', 'Cliente', 'IdCliente'],
        colModel: [
                        { name: 'act', index: 'acc', align: 'left', width: 25, editable: false, hidden: false },
                        { name: 'IdDetalleOrdenCompra', IdDetalleOrdenCompra: 'Codigo', hidden: true, width: 100, align: 'left', search: true, stype: 'text' },
                        { name: 'IdArticulo', index: 'IdArticulo', width: 100, align: 'left', hidden: true, search: true, stype: 'text' },
                        { name: 'Codigo', index: 'Codigo', width: 100, align: 'left', search: true, stype: 'text' },

                        { name: 'Descripcion', index: 'Descripcion', width: 100, align: 'left', search: true, stype: 'text' },
                        { name: 'Precio', index: 'Precio', width: 100, align: 'left', search: true, stype: 'text' },
                        { name: 'Cantidad', index: 'Cantidad', width: 100, align: 'left', search: true, stype: 'text' },
                         { name: 'IdUnidad', index: 'IdUnidad', align: 'left', width: 100, editable: false, hidden: true },
                                    { name: 'Unidad', index: 'Unidad', align: 'left', width: 100, editable: false, hidden: false },
                        { name: 'Cliente', index: 'Cliente', width: 100, align: 'left', search: true, stype: 'text' },
                        { name: 'IdCliente', index: 'IdCliente', width: 100, align: 'left', search: true, hidden: true, stype: 'text' }
            ],

        gridComplete: function () {
            var ids = jQuery("#ListaDrag").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                be = "<input style='height:22px;width:20px;' type='button' value='<<' onclick=\"copiarListaDrag('" + cl + "');\"  />";
                jQuery("#ListaDrag").jqGrid('setRowData', ids[i], { act: be });
                //                    jQuery("#Lista").jqGrid('editRow', ids[i], false);
                //calculateTotal();
            }
        },
        loadComplete: function () {
            grid = $("ListaDrag");
            $("#ListaDrag td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        },




    pager: $('#ListaDragPager'),


    rowNum: 15,
    rowList: [10, 20, 50, 100],
    sortname: 'IdOrdenCompra',
    sortorder: "desc",
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
         ,caption: '<b>Ordenes de compra pendientes de facturar</b>'

    , gridview: true
    , multiboxonly: true
    , multipleSearch: true

    })


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



    //////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////



    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Factura/RemitosPendienteFacturacion',

        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; }, 'IdObra': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: true,




        colNames: ['Acciones', 'IdDetalleRemito', 'IdArticulo', 'Codigo', 'Articulo', 'Precio', 'Cantidad', 'IdUnidad', 'Unidad', 'IdCliente', 'RazonSocial'],
        colModel: [
                                    { name: 'act', index: 'act', align: 'center', width: 120, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                                    {name: 'IdDetalleRemito', index: 'IdDetalleRemito', align: 'left', width: 100, editable: false, hidden: true },

                                    { name: 'IdArticulo', index: 'IdArticulo', align: 'left', width: 100, hidden: true, editable: false, hidden: true },
                                    { name: 'Codigo', index: 'Codigo', align: 'left', width: 100, editable: false, hidden: false },
                                    { name: 'Articulo', index: 'Articulo', align: 'left', width: 100, editable: false, hidden: false },
                                    { name: 'Precio', index: 'Precio', align: 'left', width: 100, editable: false, hidden: true },
                                    { name: 'Cantidad', index: 'Cantidad', align: 'left', width: 100, editable: false, hidden: false },
                                    { name: 'IdUnidad', index: 'IdUnidad', align: 'left', width: 100, editable: false, hidden: true },
                                    { name: 'Unidad', index: 'Unidad', align: 'left', width: 100, editable: false, hidden: false },
                                    { name: 'IdCliente', index: 'IdCliente', align: 'left', width: 100, hidden: true, editable: false, hidden: true },
                                    { name: 'RazonSocial', index: 'RazonSocial', align: 'left', width: 100, editable: false, hidden: false }
                                ],
        pager: $('#ListaDragPager2'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'IdRemito',
        sortorder: "desc",
        viewrecords: true,
        width: 'auto',
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar',
        caption: '<b>Remitos pendientes de facturar</b>',
        gridComplete: function () {
            var ids = jQuery("#ListaDrag2").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                be = "<input style='height:22px;width:20px;' type='button' value='<<' onclick=\"copiarListaDrag2('" + cl + "');\"  />";
                jQuery("#ListaDrag2").jqGrid('setRowData', ids[i], { act: be });
                //                    jQuery("#Lista").jqGrid('editRow', ids[i], false);
                //calculateTotal();
            }
        },
        loadComplete: function () {
            grid = $("ListaDrag2");
            $("#ListaDrag2 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
        }

    })
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag2").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





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
        cellEdit: false,
        colNames: ['Acciones', 'IdPresupuesto', 'Numero', 'Orden', 'Fecha', 'Proveedor', 'Validez', 'Bonif.', '% Iva', 'Mon', 'Subtotal', 'Imp.Bon.', 'Imp.Iva', 'Imp.Total',
                       'Plazo_entrega', 'Condicion_compra', 'Garantia', 'Lugar_entrega', 'Comprador', 'Aprobo', 'Referencia', 'Detalle', 'Contacto', 'Observaciones', ''],
        colModel: [
            {
                name: 'act', index: 'act', align: 'center', width: 40,
                sortable: false, editable: false, search: false, hidden: true
            }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                        {name: 'IdPresupuesto', index: 'IdPresupuesto', align: 'left', width: 100, editable: false, hidden: true },
                        { name: 'Numero', index: 'Numero', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
                        { name: 'Orden', index: 'SubNumero', align: 'right', width: 20, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                        { name: 'FechaIngreso', index: 'FechaIngreso', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                        { name: 'Proveedor', index: 'Proveedor.RazonSocial', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                        { name: 'Validez', index: 'Validez', align: 'left', width: 150, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Bonificacion', index: 'Bonificacion', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
                        { name: 'PorcentajeIva1', index: 'PorcentajeIva1', align: 'right', width: 40, editable: false, hidden: true },
                        { name: 'Moneda', index: 'Moneda', align: 'center', width: 30, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Subtotal', index: 'Subtotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
                        { name: 'ImporteBonificacion', index: 'ImporteBonificacion', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
                        { name: 'ImporteIva1', index: 'ImporteIva1', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
                        { name: 'ImporteTotal', index: 'ImporteTotal', align: 'right', width: 70, editable: false, search: true, searchoptions: { sopt: ['cn','eq'] } },
                        { name: 'PlazoEntrega', index: 'PlazoEntrega', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'CondicionCompra', index: 'CondicionCompra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Garantia', index: 'Garantia', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'LugarEntrega', index: 'LugarEntrega', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Comprador', index: 'Comprador', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Aprobo', index: 'Aprobo', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Referencia', index: 'Referencia', align: 'left', width: 100, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Detalle', index: 'Detalle', align: 'left', width: 400, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Contacto', index: 'Contacto', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'Observaciones', index: 'Observaciones', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn']} },
                        { name: 'IdProveedor', index: 'IdProveedor' }
                    ],

        onSelectRow: function (id) {
            CopiarPresupuesto(id);

            //                    if (id && id !== lastSelectedId) {
            //                        if (typeof lastSelectedId !== "undefined") {
            //                            grid.jqGrid('restoreRow', lastSelectedId);
            //                        }
            //                        lastSelectedId = id;
            //                        calculateTotal();
            //                    }
        },


        ondblClickRow: function (id) {

        },

        loadComplete: function () {
            grid = $("ListaDrag3");
            // $("#ListaDrag3 td", grid[0]).css({ background: 'rgb(234, 234, 234)' });
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





    })


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






    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








    function ConectarGrillas1() {
        // connect grid1 with grid2
        $("#ListaDrag").jqGrid('gridDnD', {
            connectWith: '#Lista', //drag_opts:{stop:null},
            onstart: function (ev, ui) {
                ui.helper.removeClass("ui-state-highlight myAltRowClass")
                                    .addClass("ui-state-error ui-widget")
                                    .css({
                                        border: "5px ridge tomato"
                                    });
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

                $("#IdCliente").val(getdata['IdCliente']);
                $("#Cliente").val(getdata['Cliente']);
                $("#DescripcionCliente").val(getdata['Cliente']);
                var s = getdata['Cliente'];

                // var companyList = $("#DescripcionCliente").autocomplete;
                // companyList.autocomplete('option', 'change').call(companyList);

                var j = 0, tmpdata = {}, dropname;
                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
                    tmpdata['PrecioUnitario'] = getdata['Precio'];
                    tmpdata['Cantidad'] = getdata['Cantidad'];

                    tmpdata['Costo'] = 0;
                    tmpdata['Bonificacion'] = 0; // getdata['Bonificacion'];


                    tmpdata['IdUnidad'] = getdata['IdUnidad']; // data[i].IdUnidad;
                    tmpdata['Unidad'] = getdata['Unidad']; // data[i].Unidad;
                    tmpdata['IdDetalleFactura'] = 0;
                    tmpdata['IdDetalleRemito'] = 0;  //data[i].IdDetalleRemito;

                    // tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                    getdata = tmpdata;
                    grid = Math.ceil(Math.random() * 1000000);
                    //  $("#Lista").jqGrid('addRowData', grid, getdata);




                    getdata = tmpdata;
                } catch (e) { }
                var grid;
                grid = Math.ceil(Math.random() * 1000000);
                // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData
                $("#" + this.id).jqGrid('addRowData', grid, getdata);
                //resetAltRows.call(this);
                $("#gbox_grid2").css("border", "1px solid #aaaaaa");


                ActualizarDatosCliente(s);

            },
            ondblClickRow: function (rowid) {
                // var data = $('#grdSearchResults').getRowData(rowid);

                var acceptId = $(ui.draggable).attr("id");
                // var getdata = ui.draggable.parent().parent().jqGrid('getRowData',acceptId);
                var getdata = $('#grdSearchResults').getRowData(rowid);

                var j = 0, tmpdata = {}, dropname;
                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                try {
                    tmpdata['IdArticulo'] = getdata['IdArticulo'];
                    tmpdata['Codigo'] = getdata['Codigo'];

                    getdata = tmpdata;
                } catch (e) { }
                var grid;
                grid = Math.ceil(Math.random() * 1000000);
                // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData
                $("#" + this.id).jqGrid('addRowData', grid, getdata);
                //resetAltRows.call(this);
                $("#gbox_grid2").css("border", "1px solid #aaaaaa");
            }
        });

        // make grid2 sortable
        //        $("#Lista").jqGrid('sortableRows', {
        //            update: function () {
        //                resetAltRows.call(this.parentNode);
        //            }
        //        });
    }


    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

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

                $("#IdCliente").val(getdata['IdCliente']);
                $("#Cliente").val(getdata['RazonSocial']);
                $("#DescripcionCliente").val(getdata['RazonSocial']);
                var s = getdata['RazonSocial'];

                var j = 0, tmpdata = {}, dropname;
                var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
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
                    tmpdata['Descripcion'] = getdata['Articulo']; // getdata['Descripcion'];
                    tmpdata['PrecioUnitario'] = 0; // getdata['Precio'];
                    tmpdata['Cantidad'] = getdata['Cantidad'];
                    tmpdata['Costo'] = 0;
                    tmpdata['Bonificacion'] = 0; // getdata['Bonificacion'];



                    tmpdata['IdUnidad'] = getdata['IdUnidad']; // data[i].IdUnidad;
                    tmpdata['Unidad'] = getdata['Unidad']; // data[i].Unidad;
                    tmpdata['IdDetalleFactura'] = 0;
                    tmpdata['IdDetalleRemito'] = getdata['IdDetalleRemito']; // data[i].IdDetalleRemito;

                    // tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                    getdata = tmpdata;
                    grid = Math.ceil(Math.random() * 1000000);
                    //$("#Lista").jqGrid('addRowData', grid, getdata);




                    getdata = tmpdata;
                } catch (e) { }
                var grid;
                grid = Math.ceil(Math.random() * 1000000);
                // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData
                $("#" + this.id).jqGrid('addRowData', grid, getdata);
                //resetAltRows.call(this);
                $("#gbox_grid2").css("border", "1px solid #aaaaaa");

                ActualizarDatosCliente(s);

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


    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Ordenes de compra pendientes');
    $('a#a_panel_este_tab2').text('Remitos pendientes');



    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').remove();
    $('a#a_panel_este_tab2').remove();
    $('a#a_panel_este_tab3').text('Presup');
    $('a#a_panel_este_tab4').text('Comp');
    $('a#a_panel_este_tab5').remove();  //    $('a#a_panel_este_tab5').text('Ped');


    ///////
    // elijo el tab
    //var index = $('#tabs-east a[href="#a_panel_este_tab3"]').parent().index();
    // $('#tabs-east').tabs("option", "active", index)
    $('#tabsDelPanel').tabs("option", "active", 2)
    ///////////

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



    //    /////////////////////////////////////////////////////////////////////////////////////////////////
    //    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    //    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    //    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    // GRABADO: llamando a BatchUpdate
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////

    $("#grabar3").click(function () {
        TestPostDeContenidoDeGrilla();
    })

    $("#grabar2").click(function () {
        //  http://stackoverflow.com/questions/10744694/submitting-jqgrid-row-data-from-view-to-controller-what-method
        //  http://stackoverflow.com/questions/6798671/how-to-submit-local-jqgrid-data-and-form-input-elements?answertab=votes#tab-top




        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Comparativa/BatchUpdateConGrilla',
            dataType: 'json',
            data: JSON.stringify(SerializaFormConGrilla()),

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
                        window.location = (ROOT + "Comparativa/Edit/" + result.IdComparativa);

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




    //////////////////////////////////////////////////////////////////






});


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
//        jQuery(function ($) {
////            
////             Convert <select> elements to Dropdown Group
////           
////             Author: John Rocela 2012 
////          
//            $('select').each(function (i, e) {
//                if (!($(e).data('convert') == 'no')) {
//                    $(e).hide().wrap('<div class="btn-group" id="select-group-' + i + '" />');
//                    var select = $('#select-group-' + i);
//                    var current = ($(e).val()) ? $(e).val() : '&nbsp;';
//                    select.html('<input type="hidden" value="' + $(e).val() + '" name="' + $(e).attr('name') + '" id="' + $(e).attr('id') + '" class="' + $(e).attr('class') + '" /><a class="btn" href="javascript:;">' + current + '</a><a class="btn dropdown-toggle" data-toggle="dropdown" href="javascript:;"><span class="caret"></span></a><ul class="dropdown-menu"></ul>');
//                    $(e).find('option').each(function (o, q) {
//                        select.find('.dropdown-menu').append('<li><a href="javascript:;" data-value="' + $(q).attr('value') + '">' + $(q).text() + '</a></li>');
//                        if ($(q).attr('selected')) select.find('.dropdown-menu li:eq(' + o + ')').click();
//                    });
//                    select.find('.dropdown-menu a').click(function () {
//                        select.find('input[type=hidden]').val($(this).data('value')).change();
//                        select.find('.btn:eq(0)').text($(this).text());
//                    });
//                }
//            });
//        });
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////





function TestPostDeContenidoDeGrilla() {
    r = {

        IdDetalleComparativa: 1,
        IdPresupuesto: 1,
        IdDetallePresupuesto: 1,
        IdArticulo: 1,
        IdUnidad: 1,

        Codigo: 1,
        Descripcion: 1,
        Cantidad: 1,
        DescUnidad: 1,

        PrecioA: 1,
        Total_A: 1,
        Check_A: 1,

        PrecioB: 1,
        Total_B: 1,
        Check_B: 1,

        PrecioC: 1,
        Total_C: 1,
        Check_C: 1,

        PrecioD: 1,
        Total_D: 1,
        Check_D: 1
    };
    g = [];
    g.push(r);
    g.push(r);

    var ojeto = { IdComparativa: 5454, grilla: g };
    var oooo = { o: ojeto };

    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)
    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)
    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)
    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)
    // es muccho MUCHO muy importante que las propiedades y la clase esten como PUBLIC ! (y quizas tambien haya que poner los get y set)

    $.ajax({
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        // url: ROOT + 'Comparativa/BatchUpdate',
        url: ROOT + 'Comparativa/PostGrilla ',

        dataType: 'json',

        //  traditional: true,

        data: JSON.stringify(ojeto),
        success: function (result) {
            ret = result;


            // http://stackoverflow.com/questions/4739535/jqgrid-load-array-data
            // What you need is just use the following localReader




        }

    });

}
