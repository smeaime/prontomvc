
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// http://stackoverflow.com/questions/7169227/javascript-best-practices-for-asp-net-mvc-developers
// http://stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript el truco interesante de var DED = (function() {
// http://stackoverflow.com/questions/251814/jquery-and-organized-code?lq=1   una risa

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

"use strict";

///////////////////////////////////////////////////////////////////////////


$(function () {

    
    $('#grabar2').click(function () {

        var cm, data1, data2, valor;
        var colModel = jQuery("#Lista").jqGrid('getGridParam', 'colModel');
        var cabecera = {
            "IdPresupuesto": "", "Numero": "", "SubNumero": "", "FechaIngreso": "", "IdProveedor": "", "Validez": "", "Bonificacion": "", "PorcentajeIva1": "", "IdMoneda": "",
            "ImporteBonificacion": "", "ImporteIva1": "", "ImporteTotal": "", "IdPlazoEntrega": "", "IdCondicionCompra": "", "Garantia": "", "LugarEntrega": "",
            "IdComprador": "", "Aprobo": "", "Referencia": "", "Detalle": "", "Contacto": "", "Observaciones": "", "DetallePresupuestos": []
        };

        var ImporteBonificacion = $("#TotalBonificacionGlobal").val();
        //            ImporteBonificacion = ImporteBonificacion.replace(".", ",");

        cabecera.IdPresupuesto = $("#IdPresupuesto").val();
        cabecera.Numero = $("#Numero").val();
        cabecera.SubNumero = $("#SubNumero").val();
        cabecera.FechaIngreso = $("#FechaIngreso").val();
        cabecera.IdProveedor = $("#IdProveedor").val();
        cabecera.Validez = $("#Validez").val();
        cabecera.Bonificacion = $("#Bonificacion").val().replace(".", ",");
        //            cabecera.PorcentajeIva1 = 21;
        cabecera.IdMoneda = $("#IdMoneda").val();
        cabecera.ImporteBonificacion = ImporteBonificacion;
        cabecera.ImporteIva1 = $("#TotalIva").val();
        cabecera.ImporteTotal = $("#Total").val();
        cabecera.IdPlazoEntrega = $("#IdPlazoEntrega").val();
        cabecera.IdCondicionCompra = $("#IdCondicionCompra").val();
        cabecera.Garantia = $("#Garantia").val();
        cabecera.LugarEntrega = $("#LugarEntrega").val();
        cabecera.IdComprador = $("#IdComprador").val();
        cabecera.Aprobo = $("#Aprobo").val();
        cabecera.Referencia = $("#Referencia").val();
        cabecera.Detalle = $("#Detalle").val();
        cabecera.Contacto = $("#Contacto").val();
        cabecera.Observaciones = $("#Observaciones").val();

        var dataIds = $('#Lista').jqGrid('getDataIDs');
        for (var i = 0; i < dataIds.length; i++) {
            try {
                $('#Lista').jqGrid('saveRow', dataIds[i], false, 'clientArray');
                var data = $('#Lista').jqGrid('getRowData', dataIds[i]);




                var iddeta = data['IdDetallePresupuesto'];
                //alert(iddeta);
                if (!iddeta) continue;


                data1 = '{"IdPresupuesto":"' + $("#IdPresupuesto").val() + '",'
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
                        if (cm.name === 'Observaciones' || cm.name == "ArchivoAdjunto1") {

                            //valor = valor.replace('"', '\\"');
                            valor = escapeRegExp(valor)
                            //valor = ""
                        }

                        data1 = data1 + '"' + cm.name + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetallePresupuestos.push(data2);
            }
            catch (ex) {
                $('#Lista').jqGrid('restoreRow', dataIds[i]);
                alert("No se pudo grabar el comprobante. " + ex);
                return;
            }
        }


        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: '@Url.Action("BatchUpdate", "Presupuesto")',
            dataType: 'json',
            data: JSON.stringify(cabecera), // $.toJSON(cabecera),
            success: function (result) {
                //                    if (result) {
                //                        $('#Lista').trigger('reloadGrid');
                //                        window.location.replace(ROOT + "Presupuesto/index");
                //                    } else {
                //                        alert('No se pudo grabar el comprobante.');
                //                    }

                if (result) {
                    //$('#Lista').trigger('reloadGrid');

                    //$('html, body').css('cursor', 'auto');
                    //window.location = (ROOT + "Presupuesto/index");

                    var dt = new Date();
                    var currentTime = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();

                    $("#textoMensajeAlerta").html("Grabado " + currentTime);
                    $("#mensajeAlerta").show();
                    // $('#Lista').trigger('reloadGrid'); // no tenes el id!!!!!
                    //si graban de nuevo, va a dar un alta!!!!


                    $('html, body').css('cursor', 'auto');
                    $('#grabar2').attr("disabled", false);
                    //$('#grabar2').attr("disabled", false).val("Aceptar y nuevo");

                    //alert('hola.');
                    // grid1.trigger('reloadGrid');

                    //window.location.replace(ROOT + "Cliente/index");

                    window.location = (ROOT + "Presupuesto/Edit/" + result.IdPresupuesto);
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
                var errorData = $.parseJSON(xhr.responseText);
                var errorMessages = [];
                //this ugly loop is because List<> is serialized to an object instead of an array
                for (var key in errorData) {
                    errorMessages.push(errorData[key]);
                }



                $('#result').html(errorMessages.join("<br />"));
                alert(errorMessages.join("\n").replace(/<br\/>/g, '\n'));



                $('html, body').css('cursor', 'auto');
                $('#grabar2').attr("disabled", false).val("Aceptar");
                //alert(errorMessages.join("<br />"));

                $("#textoMensajeAlerta").html(errorMessages.join("<br />"));
                //$('#result').html(errorMessages.join("<br />"));
                //$("#textoMensajeAlerta").html(xhr.responseText);
                //$("#textoMensajeAlerta").html(errorData.Errors.join("<br />"));
                $("#mensajeAlerta").show();
                pageLayout.show('east');

            }




        });
    });







    
    function unformatNumber(cellvalue, options, rowObject) {
        return cellvalue.replace(",", ".");
    }

    function formatNumber(cellvalue, options, rowObject) {
        return cellvalue.replace(".", ",");
    }




    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    $("#ListaDrag").jqGrid({

        url: ROOT + 'Articulo/Articulos_DynamicGridData',
        datatype: 'json',
        mtype: 'POST',
        cellEdit: true,


        colNames: ['', '', 'Codigo', 'Descripcion'

   , 'Rubro'

   , 'Subrubro'
   , 'Nro.inv.', '', '', 'Unidad'


        ],






        colModel: [
        { name: 'Edit', index: 'Edit', width: 50, align: 'left', sortable: false, search: false },
        { name: 'Delete', index: 'Delete', width: 1, align: 'left', sortable: false, search: false, hidden: true },
        {
            name: 'Codigo', index: 'Codigo', width: 130, align: 'left', stype: 'text',
            search: true, searchoptions: {
                clearSearch: true, searchOperators: true
                , sopt: ['cn']
            }
        },
        {
            name: 'Descripcion', index: 'Descripcion', width: 480, align: 'left', stype: 'text',
            editable: false, edittype: 'text', editoptions: { maxlength: 250 }, editrules: { required: true }

            , search: true, searchoptions: {
                clearSearch: true,
                searchOperators: true
                , sopt: ['cn']
                //, sopt: ['eq', 'ne', 'lt', 'le', 'gt', 'ge', 'bw', 'bn', 'ew', 'en', 'cn', 'nc', 'nu', 'nn', 'in', 'ni']
            }
        },
        {
            name: 'Rubro.Descripcion', index: 'Rubro.Descripcion', width: 200, align: 'left', editable: true, edittype: 'select',
            editoptions: { dataUrl: '@Url.Action("Unidades")' }, editrules: { required: true }
            , search: true, searchoptions: {
                //sopt: ['cn']
            }
        },


        { name: 'Subrubro.Descripcion', index: '', width: 200, align: 'left', search: true, stype: 'text' },
        { name: 'NumeroInventario', index: '', width: 50, align: 'left', search: true, stype: 'text' }

        ,
        { name: 'IdArticulo', index: 'IdArticulo', align: 'left', width: 100, editable: false, hidden: true },
        { name: 'IdUnidad', index: 'IdUnidad', align: 'left', width: 100, editable: false, hidden: true },
        { name: 'Unidad', index: 'Unidad', width: 100, align: 'left', search: true, stype: 'text' },


        ],

        ondblClickRow: function (id) {
            copiarArticulo(id);
        },
        loadComplete: function () {
            grid = $("ListaDrag");
        },


        pager: $('#ListaDragPager'),


        rowNum: 15,
        rowList: [10, 20, 50, 100],
        sortname: 'Descripcion',
        sortorder: 'asc',
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
        //, caption: 'MATERIALES'

        , gridview: true
        , multiboxonly: true
        , multipleSearch: true


    })
    jQuery("#ListaDrag").jqGrid('navGrid', '#ListaDragPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
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








    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////









    $("#ListaDrag2").jqGrid({
        url: ROOT + 'Requerimiento/Requerimientos_DynamicGridData',

        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; }, 'IdObra': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: true,
        colNames: ['Acciones', 'IdRequerimiento', 'Numero', 'Fecha', 'Cump.', 'Recep.', 'Entreg.', 'Impresa', 'Detalle', 'Obra', 'Presupuestos', 'Comparativas',
                   'Pedidos', 'Recepciones', 'Salidas', 'Libero', 'Solicito', 'Sector', 'Usuario_anulo', 'Fecha_anulacion', 'Motivo_anulacion', 'Fechas_liberacion',
                   'Observaciones', 'Lugar de entrega', 'IdObra', 'IdSector'],
        colModel: [
                    { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
                    { name: 'IdRequerimiento', index: 'IdRequerimiento', align: 'left', width: 100, editable: false, hidden: true },
                    { name: 'NumeroRequerimiento', index: 'NumeroRequerimiento', align: 'right', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn', 'eq'] } },
                    { name: 'FechaRequerimiento', index: 'FechaRequerimiento', width: 75, align: 'center', sorttype: 'date', editable: false, formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', search: false },
                    { name: 'Cumplido', index: 'Cumplido', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                    { name: 'Recepcionado', index: 'Recepcionado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                    { name: 'Entregado', index: 'Entregado', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                    { name: 'Impresa', index: 'Impresa', align: 'center', width: 50, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
                    { name: 'Detalle', index: 'Detalle', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'NumeroObra', index: 'NumeroObra', align: 'left', width: 85, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'Presupuestos', index: 'Presupuestos', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] }, hidden: true },
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
                    { name: 'IdObra', index: 'IdObra', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } },
                    { name: 'IdSector', index: 'IdSector', align: 'left', width: 200, editable: false, search: true, searchoptions: { sopt: ['cn'] } }
        ],


        ondblClickRow: function (id) {
            copiarRM(id);
        },


        pager: $('#ListaDragPager2'),


        rowNum: 15,
        rowList: [10, 20, 50, 100],
        sortname: 'NumeroRequerimiento',
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
        // , caption: 'REQUERIMIENTOS'

        , gridview: true
        , multiboxonly: true
        , multipleSearch: true


    })
    jQuery("#ListaDrag2").jqGrid('navGrid', '#ListaDragPager2', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
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








    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    $("#ListaDrag3").jqGrid({
        url: ROOT + 'Presupuesto/Presupuestos_DynamicGridData',
        postData: { 'FechaInicial': function () { return ""; }, 'FechaFinal': function () { return ""; } },
        datatype: 'json',
        mtype: 'POST',
        cellEdit: true,
        colNames: ['Acciones', 'IdPresupuesto', 'Numero', 'Orden', 'Fecha', 'Proveedor'

        , 'Validez', 'Bonif.', '% Iva', 'Mon', 'Subtotal', 'Imp.Bon.', 'Imp.Iva', 'Imp.Total',
                   'Plazo_entrega', 'Condicion_compra', 'Garantia', 'Lugar_entrega', 'Comprador', 'Aprobo', 'Referencia', 'Detalle', 'Contacto', 'Observaciones', 'IdProveedor'
        ],
        colModel: [
                    { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: true }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
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
                    { name: 'IdProveedor', index: 'IdProveedor', align: 'left', width: 250, editable: false, search: true, searchoptions: { sopt: ['cn'] } }

        ],





        ondblClickRow: function (id) {
            CopiarPresupuesto(id)
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
        //, caption: 'SOLICITUDES DE COTIZACION'

, gridview: true
, multiboxonly: true
, multipleSearch: true


    })
    jQuery("#ListaDrag3").jqGrid('navGrid', '#ListaDragPager3', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });
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





    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





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

    //DEFINICION DE PANEL ESTE PARA LISTAS DRAG DROP
    $('a#a_panel_este_tab1').text('Artículos');
    $('a#a_panel_este_tab2').text('Requerimientos');
    $('a#a_panel_este_tab3').text('Presupuestos');

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




})