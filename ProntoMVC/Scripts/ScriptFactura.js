





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



function calculateTotal() {
    grid = $("#Lista");
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
    PorcentajeIva1 = parseFloat($("#PorcentajeIva1").val().replace(",", "."));
    PorcentajeIva2 = parseFloat($("#PorcentajeIva2").val().replace(",", "."));
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

    pb = parseFloat($("#PorcentajeBonificacion").val().replace(",", "."));
    if (isNaN(pb)) { pb = 0; }
    var dataIds = $('#Lista').jqGrid('getDataIDs');
    for (var i = 0; i < dataIds.length; i++) {
        var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
        pr = parseFloat(data['PrecioUnitario'].replace(",", "."));
        if (isNaN(pr)) { pr = 0; }
        cn = parseFloat(data['Cantidad'].replace(",", "."));
        if (isNaN(cn)) { cn = 0; }
        ///////////////////////////////////////
        // subtotal
        st = Math.round(pr * cn * 10000) / 10000;   // subtotal del item
        st1 = Math.round((st1 + st) * 10000) / 10000;  // sumatoria de los subtotales de items
        ///////////////////////////////////////
        // bonificacion

        // esta es la bonificacion del item (el item tiene un %bonif individual. El importe lo calculó "calculateItem", no? -no si lo muestra por primera vez
        // ib = parseFloat(data['ImporteBonificacion'].replace(",", "."));
        var pbi = parseFloat(data['Bonificacion'].replace(",", "."));
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
    PorcentajeIva1 = parseFloat($("#PorcentajeIva1").val().replace(",", "."));
    PorcentajeIva2 = parseFloat($("#PorcentajeIva2").val().replace(",", "."));
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
    mvarPorcentajeIBrutos1 = parseFloat($("#Cliente_IBCondicionCat1_AlicuotaPercepcion").val().replace(",", "."));
    mvarPorcentajeIBrutos2 = parseFloat($("#Cliente_IBCondicionCat2_AlicuotaPercepcion").val().replace(",", "."));
    mvarPorcentajeIBrutos3 = parseFloat($("#Cliente_IBCondicionCat3_AlicuotaPercepcion").val().replace(",", "."));
    ibgbrut1 = roundNumber((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos1 / 100, 2) || 0;
    ibgbrut2 = roundNumber((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos2 / 100, 2) || 0;
    ibgbrut3 = roundNumber((mvarNetoGravado - mvarIVANoDiscriminado) * mvarPorcentajeIBrutos3 / 100, 2) || 0;
    $("#PercepIIBB").val(ibgbrut1 + ibgbrut2 + ibgbrut3)
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    //percepcion iva
    var mvarPercepcionIVA = 0;
    mvarEsAgenteRetencionIVA = $("#Cliente_EsAgenteRetencionIVA").val();
    mvarBaseMinimaParaPercepcionIVA = parseFloat($("#Cliente_BaseMinimaParaPercepcionIVA").val().replace(",", ".")) || 0; ;
    mvarPorcentajePercepcionIVA = parseFloat($("#Cliente_PorcentajePercepcionIVA").val().replace(",", ".")) || 0; ;
    if (mvarEsAgenteRetencionIVA == "SI" && mvarNetoGravado >= mvarBaseMinimaParaPercepcionIVA) {
        mvarPercepcionIVA = roundNumber(mvarNetoGravado * mvarPorcentajePercepcionIVA / 100, 2);

    }
    mvarPercepcionIVA = mvarPercepcionIVA || 0;
    $("#PercepcionIVA").val(mvarPercepcionIVA);
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////    
    op1 = parseFloat($("#OtrasPercepciones1").val().replace(",", ".")) || 0;
    op2 = parseFloat($("#OtrasPercepciones2").val().replace(",", ".")) || 0;
    op3 = parseFloat($("#OtrasPercepciones3").val().replace(",", ".")) || 0;
    tg = tg + op1 + op2 + op3 + ibgbrut1 + ibgbrut2 + ibgbrut3 + mvarPercepcionIVA;

    $("#Subtotal1").val(st2.toFixed(4).replace(",", "."));
    $("#TotalBonificacionItems").val(ib1.toFixed(4).replace(",", "."));
    $("#ImporteBonificacionTotal").val(ib2.toFixed(4).replace(",", "."));
    $("#Subtotal2").val(st3.toFixed(4).replace(",", "."));
    $("#ImporteIva1").val(ii1.toFixed(4).replace(",", "."));
    $("#ImporteTotal").val(tg.toFixed(4).replace(",", "."));

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
                        alert('No hay cotizacion', 'Cotizaciones');
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
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    //Para que haga wrap en las celdas
    $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');
    //$.jgrid.formatter.integer.thousandsSeparator=',';

    $('#Lista').jqGrid({
        url: ROOT + 'Factura/DetFacturas/',
        postData: { 'IdFactura': function () { return $("#IdFactura").val(); } },
        editurl: ROOT + 'Factura/EditGridData/',
        datatype: 'json',
        mtype: 'POST',
        colNames: ['Acciones', 'IdDetalleFactura', 'IdArticulo', 'IdUnidad', 'NumeroItem', 'Codigo', 'Descripcion', 'cant.', 'Un.',
                       "Costo", 'Precio U.', 'Bonif.', 'Total', 'Observaciones', 'ImporteBonificacion'],




        colModel: [
                        { name: 'act', index: 'act', align: 'left', width: 70, sortable: false, editable: false, hidden: true },
                        { name: 'IdDetalleFactura', index: 'IdDetalleFactura', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: true} },
                        { name: 'IdArticulo', index: 'IdArticulo', label: 'TB', align: 'left', width: 85,
                            editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: true }
                        },
                        { name: 'IdUnidad', index: 'IdUnidad', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: true} },
        //{ name: 'Eliminado', index: 'Eliminado', label:'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true} },
                        {name: 'NumeroItem', index: 'NumeroItem', label: 'TB', align: 'left', width: 85, editable: false, hidden: true },

                        { name: 'Codigo', index: 'Codigo', align: 'left', width: 80, editable: true, edittype: 'text',
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
                            editrules: { required: true }
                        },
                        { name: 'Descripcion', index: 'Descripcion', align: 'left', width: 300, editable: true, edittype: 'text', // formoptions: { rowpos: 1, colpos: 2 },
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
                            editrules: { required: true }
                        },
                          { name: 'Cantidad', index: 'Cantidad', label: 'TB', align: 'right', width: 50, editable: true, edittype: 'text', editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { calculateItem(); } }] }, editrules: { required: true} }, //, unformat:numUnformat
                        {name: 'Unidad', index: 'IdUnidad', align: 'left', width: 30, editable: true, edittype: 'select', editrules: { required: true },
                        editoptions: {
                            dataUrl: ROOT + 'Articulo/Unidades',


                            dataEvents: [{ type: 'change', fn: function (e) { $('#IdUnidad').val(this.value); } }]
                        }
                    },

                          { name: 'Costo', index: 'Cantidad', label: 'TB', align: 'right', width: 30, editable: true, edittype: 'text', editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { calculateItem(); } }] }, editrules: { required: false} }, //, unformat:numUnformat
                          
                          {name: 'PrecioUnitario', index: 'PrecioUnitario', label: 'TB', align: 'right', width: 80,
                          editable: true, edittype: 'text', editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { calculateItem(); } }] }
                          , editrules: { required: true}
                      }, //, unformat:numUnformat

                          {name: 'Bonificacion', index: 'Bonificacion', label: 'TB', align: 'right', width: 20, editable: true, edittype: 'text', editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { calculateItem(); } }] }, editrules: { required: false} }, //, unformat:numUnformat

                        {name: 'ImporteTotalItem', index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 80, editable: true, editoptions: { disabled: 'disabled'} },

                             { name: 'Observaciones', index: 'Observaciones', label: 'TB', align: 'left', width: 0, hidden: false, editable: true, edittype: 'textarea'
                             
                             // , formoptions: { rowpos: 15, colpos: 2 }
                               ,editoptions: { rows: '4', cols: '80'} //editoptions: { dataInit: function (elem) { $(elem).val(inEdit ? "Modificado" : "Nuevo"); }
                             }

        ,


                                { name: 'ImporteBonificacion', index: 'ImporteBonificacion', label: 'TB', align: 'right', hidden: true, width: 60, editable: true, editoptions: { disabled: 'disabled'} },
        //                        { name: 'PorcentajeIva', index: 'PorcentajeIva', label: 'TB', align: 'right', width: 0, hidden: true, editable: true, editoptions: { disabled: 'disabled'} },
        //                        { name: 'ImporteIva', index: 'ImporteIva', label: 'TB', align: 'right', width: 0, hidden: true, editable: true, editoptions: { disabled: 'disabled'} },




        //                        { name: 'FechaEntrega', index: 'FechaEntrega', label: 'TB', width: 75, align: 'center', sorttype: 'date', editable: true, hidden: true,
        //                            formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit }
        //                        },
        //                        { name: 'AdjuntoNombre', hidden: true //, index: 'AdjuntoNombre', align: 'left', width: 67, align: 'center',
        //                            //                            formatter: 'checkbox', editable: true,
        //                            //                            edittype: 'checkbox', editoptions: { value: 'Si:No', defaultValue: 'Si' }
        //                        }

                    ],
        onSelectRow: function (id) {
            if (id && id !== lastSelectedId) {
                if (typeof lastSelectedId !== "undefined") {
                    grid.jqGrid('restoreRow', lastSelectedId);
                }
                lastSelectedId = id;
                calculateTotal();
            }
        },
        gridComplete: function () {
            var ids = jQuery("#Lista").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                be = "<input  style='height:22px;width:20px;' type='button' value='E' onclick=\"jQuery('#Lista').editRow('" + cl + "',true,pickdates);\"  />";
                se = "<input style='height:22px;width:20px;' type='button' value='S' onclick=\"jQuery('#Lista').saveRow('" + cl + "');\"  />";
                ce = "<input style='height:22px;width:20px;' type='button' value='C' onclick=\"jQuery('#Lista').restoreRow('" + cl + "');\" />";
                jQuery("#Lista").jqGrid('setRowData', ids[i], { act: be + se + ce });
                //                    jQuery("#Lista").jqGrid('editRow', ids[i], false);
                calculateTotal();
            }

            AgregarRenglonesEnBlanco();

        },

        afterSaveCell: function (rowid, name, val, iRow, iCol) {
            calculateTotal();

            rows = $("#Lista").getGridParam("reccount");
            if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

        },
        afterSubmit: function (response, postdata) {
            calculateTotal();
        },
        afterComplete: function (response, postdata, formid) {
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

        ondblClickRow: function (rowid, iRow, iCol, e) {
            $("#edtData").click();
        },


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
        height: 100, // 'auto',
        altRows: false,
        ////////////////////////
        autowidth: true,
        shrinkToFit: false,
        ////////////////////////
        footerrow: true,
        userDataOnFooter: false,
        loadonce: true

        ///////
        , cellEdit: true
        , cellsubmit: 'clientArray'
        , editurl: ROOT + 'Requerimiento/EditGridData/' // pinta que esta es la papa: editurl con la url, y cellsubmit en clientarray

//                cellurl: 'se/ref_mgmnt_save.php'/*,



        //para sacar el icono de resize, tenes que eliminar el metodo "gridResize"
        //        http://stackoverflow.com/questions/8983899/how-to-remove-hide-the-resize-button-in-jqgrid-jquery
        //            caption: ''  '<b>ITEMS DEL Factura</b>'

    });










    function numUnformat(cellvalue, options, rowObject) {
        return cellvalue.replace(",", ".");
    }




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
        jQuery("#Lista").jqGrid('editGridRow', "new", { addCaption: "Agregar registro", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
            recreateForm: true,
            beforeShowForm: function (form) {
//                var dlgDiv = $("#editmod" + grid[0].id);
//                dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
//                dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";


                PopupCentrar();
                                        $('#tr_IdDetallePedido', form).hide();
                                        $('#tr_IdArticulo', form).hide();
                                        $('#tr_IdUnidad', form).hide();
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
                    bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true,
                    viewPagerButtons: true, // no me los está mostrando 

                    closeAfterEdit: true, recreateForm: true, Top: 0,
                    beforeShowForm: function (form) {
                        PopupCentrar();
                        $('#tr_IdDetallePedido', form).hide();
                        $('#tr_IdArticulo', form).hide();
                        $('#tr_IdUnidad', form).hide();

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
            jQuery("#Lista").jqGrid('delGridRow', gr, { caption: "Borrar", msg: "Elimina el registro seleccionado?", bSubmit: "Borrar", bCancel: "Cancelar", width: 800, closeOnEscape: true, reloadAfterSubmit: true });
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
        cellEdit: false,

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


        pager: $('#ListaDragPager'),
        rowNum: 15,
        rowList: [10, 20, 50],
        sortname: 'IdOrdenCompra',
        sortorder: "desc",
        viewrecords: true,





        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar', // ,


//        caption: '<b>Ordenes de compra pendientes de facturar</b>',



        gridComplete: function () {
            var ids = jQuery("#ListaDrag").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                be = "<input class='btn btn-mini' style='height:22px;width:20px;' type='button' value='<<' onclick=\"copiarListaDrag('" + cl + "');\"  />";
                jQuery("#ListaDrag").jqGrid('setRowData', ids[i], { act: be });
                //                    jQuery("#Lista").jqGrid('editRow', ids[i], false);
                //calculateTotal();
            }
        }
    })



    //////////////////////////////////////////////////////////////////////
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag").jqGrid('gridResize', { minWidth: 300, maxWidth: 1500, minHeight: 80, maxHeight: 800 });
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

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
        $("#Lista").jqGrid('sortableRows', {
            update: function () {
                resetAltRows.call(this.parentNode);
            }
        });
    }






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
        cellEdit: false,




        colNames: ['', 'IdDetalleRemito', 'IdArticulo', 'Codigo', 'Articulo', 'Precio', 'Cantidad', 'IdUnidad', 'Unidad', 'IdCliente', 'RazonSocial'],
        colModel: [
                                    { name: 'act', index: 'act', align: 'center', width: 25, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                                    {name: 'IdDetalleRemito', index: 'IdDetalleRemito', align: 'left', width: 100, editable: false, hidden: true },

                                    { name: 'IdArticulo', index: 'IdArticulo', align: 'left', width: 50, hidden: true, editable: false, hidden: true },
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
        
        
        
//        caption: '<b>Remitos pendientes de facturar</b>',




        
        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////
        height: '100%',
        altRows: false,
        emptyrecords: 'No hay registros para mostrar', // ,





        gridComplete: function () {
            var ids = jQuery("#ListaDrag2").jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                be = "<input class='btn btn-mini'   style='height:22px;width:20px;' type='button' value='<<' onclick=\"copiarListaDrag2('" + cl + "');\"  />";
                jQuery("#ListaDrag2").jqGrid('setRowData', ids[i], { act: be });
                //                    jQuery("#Lista").jqGrid('editRow', ids[i], false);
                //calculateTotal();
            }
        }

    })
    //////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////

    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
    //jQuery("#ListaDrag2").jqGrid('gridResize', { minWidth: 350, maxWidth: 1500, minHeight: 80, maxHeight: 500 });
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

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Ordenes de compra pendientes');
    $('a#a_panel_este_tab2').text('Remitos pendientes');
    // $('a#a_panel_este_tab3').text('Solicitudes de cotizacion');

    ConectarGrillas1();

    $('#a_panel_este_tab1').click(function () {
        ConectarGrillas1();
    });

    $('#a_panel_este_tab2').click(function () {
        ConectarGrillas2();
    });

    //    $('#a_panel_este_tab3').click(function () {
    //        ConectarGrillas3();
    //    });



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


    $("#grabar2").click(function () {
        //  http://stackoverflow.com/questions/10744694/submitting-jqgrid-row-data-from-view-to-controller-what-method
        //  http://stackoverflow.com/questions/6798671/how-to-submit-local-jqgrid-data-and-form-input-elements?answertab=votes#tab-top


        var griddata = $("#Lista").jqGrid('getGridParam', 'data');


        //////////////////////////////////////////////////////////////////////////////////////////////
        var cabecera = $("#formid").serializeObject(); // .serializeArray(); // serializeArray 

        // como no le encontre la vuelta a automatizar la serializacion de inputs disableados, los pongo manualmente
        // como no le encontre la vuelta a automatizar la serializacion de inputs disableados, los pongo manualmente
        // como no le encontre la vuelta a automatizar la serializacion de inputs disableados, los pongo manualmente
        cabecera.NumeroFactura = $("#NumeroFactura").val();
        cabecera.IdCodigoIVA = $("#IdCodigoIva").val();

        

        //        http://stackoverflow.com/questions/5199835/mvc-3-jquery-validation-globalizing-of-number-decimal-field
        //        cabecera.ImporteTotal = Globalize.parseFloat($("#ImporteTotal").val());
        //        cabecera.ImporteIva1 = Globalize.parseFloat( $("#ImporteIva1").val() );
        cabecera.ImporteTotal = $("#ImporteTotal").val().replace(".", ",");
        cabecera.ImporteIva1 = $("#ImporteIva1").val().replace(".", ",");

        cabecera.ImporteBonificacion = $("#ImporteBonificacionTotal").val().replace(".", ",");
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //Ok, I know this already has a highly upvoted answer, but another similar question was asked recently, and I was directed 
        // to this question as well. I'd like to offer my solution as well, because it offers an advantage over the accepted solution: 
        //You can include disabled form elements (which is sometimes important, depending on how your UI functions)
        //        var inputs = $("#formid :input");
        //        var cabecera = {};
        //        $.map(inputs, function (n, i) {
        //            cabecera[n.name] = $(n).val();
        //        });
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////



        //  var aaa = $.toJSON(formdata);

        var fullData = jQuery("#Lista").jqGrid('getRowData');

        //        var gd = $('#ListaLugaresEntrega').jqGrid('getRowData'); // use preferred interface
        //        for (var i = 0; i < gd.length; ++i) {
        //            for (var f in gd[i]) res.push({ name: '_detail[' + i + '].' + f, value: gd[i][f] });
        //        }

        var grid1 = $("#Lista");
        var colModel = grid1.jqGrid('getGridParam', 'colModel');

        var items = [];
        cabecera.DetalleFacturas = [];  // el array no existe en el objeto cabecera, lo anexo a lo bestia (ojo que, en verdad, sí hay uno, porque lo creé con HiddenFor)
        var dataIds = $('#Lista').jqGrid('getDataIDs');
        for (var i = 0; i < dataIds.length; i++) {
            try {
                $('#Lista').jqGrid('saveRow', dataIds[i], false, 'clientArray');
                var data = $('#Lista').jqGrid('getRowData', dataIds[i]);

                data1 = '{"IdFactura":"' + $("#IdFactura").val() + '",'
                for (var j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') {
                        valor = data[cm.name];
                        // if (cm.name === 'Cantidad') valor = valor.replace(".", ",")
                        data1 = data1 + '"' + cm.name + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);

                // items.push(data2);               
                cabecera.DetalleFacturas.push(data2);
            }
            catch (ex) {
                $('#Lista').jqGrid('restoreRow', dataIds[i]);
                alert("No se pudo grabar el comprobante. Es probable que hayas incluido en el detalle columnas que no existen. " + ex);
                return;
            }
        }




        // cabecera.DetalleFacturas.push(items);
        // $(items).appendTo(cabecera);



        //        var allData = {
        //            localGridData:   griddata,       // grid.jqGrid('Lista','data'),
        //            formData: formdata
        //        };

        var dataToSend = JSON.stringify(cabecera); // JSON.stringify(griddata);   JSON.parse() ;   $.toJSON();


        $('html, body').css('cursor', 'wait'); //http://stackoverflow.com/questions/2685748/how-do-i-change-the-cursor-during-a-jquery-synchronous-browser-blocking-post
        $.ajax({
            type: 'POST',
            // contentType: 'application/json; charset=utf-8',
            contentType: 'application/json; charset=utf-8', // http://stackoverflow.com/a/2281875/1054200
            url: ROOT + 'Factura/BatchUpdate',   // 'Factura/UpdateAwesomeGridData',
            dataType: 'json',
            // data:JSON.stringify( {formulario: colData , grilla: dataToSend })
            data: dataToSend,
            //  data: { "formulario": formdata ,"grilla": dataToSend }, // $.toJSON(griddata),
            success: function (result) {
                if (result) {
                    //alert('hola.');
                    grid1.trigger('reloadGrid');

                    $('html, body').css('cursor', 'auto');

                    //window.location.replace(ROOT + "Cliente/index");
                    window.location = (ROOT + "Factura/index");

                } else {
                    // window.location.replace(ROOT + "Cliente/index");


                    alert('No se pudo grabar el comprobante.');
                    $('.loading').html('');

                    $('html, body').css('cursor', 'auto');
                    $('#grabar2').attr("disabled", false).val("Guardar");
                }


            },

            beforeSend: function () {
                //$('.loading').html('some predefined loading img html');
                $('#grabar2').attr("disabled", true).val("Espere...");

            },

            error: function (xhr, textStatus, exceptionThrown) {
                var errorData = $.parseJSON(xhr.responseText);
                var errorMessages = [];
                //this ugly loop is because List<> is serialized to an object instead of an array
                for (var key in errorData) {
                    errorMessages.push(errorData[key]);
                }
                $('#result').html(errorMessages.join("<br />"));
                $('html, body').css('cursor', 'auto');
                $('#grabar2').attr("disabled", false).val("Guardar");
                alert(errorMessages.join("<br />"));


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

