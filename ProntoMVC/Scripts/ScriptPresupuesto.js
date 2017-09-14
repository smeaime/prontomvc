
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// http://stackoverflow.com/questions/7169227/javascript-best-practices-for-asp-net-mvc-developers
// http://stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript el truco interesante de var DED = (function() {
// http://stackoverflow.com/questions/251814/jquery-and-organized-code?lq=1   una risa

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

"use strict";







function agregarBotonDeCopiaEnLasGrillasAuxiliares()
{
    var ids = jQuery("#ListaDrag").jqGrid('getDataIDs');
    for (var i = 0; i < ids.length; i++) 
    {
        var cl = ids[i];
        var be = "<input style='height:22px;width:;' type='button' value=' << ' onclick=\"copiarArticulo('" + cl + "');\"  />";
        jQuery("#ListaDrag").jqGrid('setRowData', ids[i], { Edit: be });

        //https://stackoverflow.com/questions/13961180/invoking-a-doubleclick-event
        //copiarArticulo(id);

    }   


    var ids = jQuery("#ListaDrag2").jqGrid('getDataIDs');
    for (var i = 0; i < ids.length; i++) 
    {
        var cl = ids[i];
        var be = "<input style='height:22px;width:;' type='button' value=' << ' onclick=\"copiarRM('" + cl + "');\"  />";
        jQuery("#ListaDrag2").jqGrid('setRowData', ids[i], { act: be });

        //https://stackoverflow.com/questions/13961180/invoking-a-doubleclick-event
        //copiarArticulo(id);

    }   


    var ids = jQuery("#ListaDrag3").jqGrid('getDataIDs');
    for (var i = 0; i < ids.length; i++) 
    {
        var cl = ids[i];
        var be = "<input style='height:22px;width:;' type='button' value=' << ' onclick=\"CopiarPresupuesto('" + cl + "');\"  />";
        jQuery("#ListaDrag3").jqGrid('setRowData', ids[i], { act: be });

        //https://stackoverflow.com/questions/13961180/invoking-a-doubleclick-event
        //copiarArticulo(id);

    }   


}

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        // total generales y del pie de la grilla
        function calculateTotal() {
            var totalCantidad = $('#Lista').jqGrid('getCol', 'Cantidad', false, 'sum')

            var pr, cn, st, ib, ib_, ib_t, pi, ii, st1, ib1, ib2, ii1, st2, pb, st3, tp, tg;
            st1 = 0;
            ib1 = 0;
            ib2 = 0;
            ii1 = 0;
            pb = parseFloat($("#Bonificacion").val().replace(",", "."));
            if (isNaN(pb)) { pb = 0; }
            var dataIds = $('#Lista').jqGrid('getDataIDs');
            for (var i = 0; i < dataIds.length; i++) {
                var data = $('#Lista').jqGrid('getRowData', dataIds[i]);
                pr = parseFloat(data['Precio'].replace(",", "."));
                if (isNaN(pr)) { pr = 0; }
                cn = parseFloat(data['Cantidad'].replace(",", "."));
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
                ib_t = ib1 + ib_;
                ////////////////////////////////////////////////////
                ////////////////////////////////////////////////////
                pi = parseFloat(data['PorcentajeIva'].replace(",", "."));
                ii = Math.round((st - ib - ib_) * pi / 100 * 10000) / 10000;
                ii1 = ii1 + ii
                tp = st - ib_t + ii;
                // por qué aplica el global sobre los items? está bien?
                // y si está bien, no debe usarse a sí mismo (como en la linea ib = parseFloat(data['ImporteBonificacion']. etc)
                // porque si no, se va aplicando a sí mismo cada vez que editas el item
                data['ImporteBonificacion'] = ib_t.toFixed(4);
                data['ImporteIva'] = ii.toFixed(4);
                data['ImporteTotalItem'] = tp.toFixed(4);
                $('#Lista').jqGrid('setRowData', dataIds[i], data);
            }
            st2 = Math.round((st1 - ib1) * 10000) / 10000;
            st3 = Math.round((st2 - ib2) * 10000) / 10000;
            tg = Math.round((st3 + ii1) * 10000) / 10000;

            $("#Subtotal1").val(st1.toFixed(4));
            $("#TotalBonificacionItems").val(ib1.toFixed(4));
            $("#TotalBonificacionGlobal").val(ib2.toFixed(4));
            $("#Subtotal2").val(st3.toFixed(4));
            $("#TotalIva").val(ii1.toFixed(4));
            $("#Total").val(tg.toFixed(4));

            $('#Lista').jqGrid('footerData', 'set', {
                NumeroObra: 'TOTALES', Cantidad: totalCantidad.toFixed(2),
                ImporteBonificacion: ib1.toFixed(4),
                ImporteIva: ii1.toFixed(4),
                ImporteTotalItem: tg.toFixed(4)
            });
        };


        function pickdates(id) {
            jQuery("#" + id + "_sdate", "#Lista").datepicker({ dateFormat: "yy-mm-dd" });
        }




        // total del item
        function CalcularImportes() {
            var pbglobal = parseFloat($("#Bonificacion").val().replace(",", "."));
            var pb = parseFloat($("#PorcentajeBonificacion").val());
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
            bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
            st = st - bg;
            ////////////////////////////////////////////////////



            var ii = Math.round(st * pi / 100 * 10000) / 10000;
            var it = Math.round((st + ii) * 10000) / 10000;



            $("#ImporteBonificacion").val(ib.toFixed(4));
            $("#ImporteIva").val(ii.toFixed(4));
            $("#ImporteTotalItem").val(it.toFixed(4));
        }



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











        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        function copiarRM(id) {

            $("#loading").show();

            try {
                jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);
            } catch (e) {
                LogJavaScript("Error en Script copiarArticulo   ", e);
            }

            //sacarDeEditMode();



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

                //IdRequerimiento = getdata['IdRequerimiento'];
                IdRequerimiento = getdata['NumeroRequerimiento'];

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
                            tmpdata['IdDetallePresupuesto'] = 0;

                            tmpdata['OrigenDescripcion'] = data[i].OrigenDescripcion;
                            tmpdata['Cantidad'] = data[i].Cantidad;
                            tmpdata['Observaciones'] = data[i].Observaciones;
                            tmpdata['NumeroItem'] = prox;

                            var now = new Date();
                            var currentDate = strpad00(now.getDate()) + "/" + strpad00(now.getMonth() + 1) + "/" + now.getFullYear();
                            tmpdata['FechaEntrega'] = currentDate;



                            tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                            tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                            tmpdata['NumeroItemRM'] = data[i].NumeroItem;
                            tmpdata['Cantidad'] = data[i].Cantidad;
                            tmpdata['NumeroObra'] = data[i].NumeroObra;
                            //tmpdata['FechaNecesidad'] = displayDate;
                            tmpdata['Precio'] = 0;
                            tmpdata['PorcentajeBonificacion'] = 0;
                            tmpdata['ImporteBonificacion'] = 0;
                            tmpdata['ImporteIva'] = 0;
                            tmpdata['ImporteTotalItem'] = 0;



                            prox++;
                            getdata = tmpdata;
                            var idazar = Math.ceil(Math.random() * 1000000);





                            tmpdata['PorcentajeIva'] = data[i].PorcentajeIva;
                            tmpdata['NumeroItem'] = ProximoNumeroItem();   // jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;


                            QuitarRenglonDragDrop(idazar, getdata)




                        }
                        RefrescarOrigenDescripcion();

                        AgregarRenglonesEnBlanco({ "IdDetallePresupuesto": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });


                        //                    rows = $("#Lista").getGridParam("reccount");
                        //                    if (rows >= 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

                    }
                });
            } catch (e) { }


            $("#loading").hide();

        }



        function copiarArticulo(id) {


            $("#loading").show();

            try {
                jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);
            } catch (e) {
                LogJavaScript("Error en Script copiarArticulo   ", e);
            }

            //sacarDeEditMode();

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
                tmpdata['IdDetallePresupuesto'] = 0;
                tmpdata['NumeroItem'] = prox++;


                // tmpdata['PorcentajeIva'] = getdata['Iva'].replace(",", ".");
                tmpdata['Cantidad'] = 1;
                tmpdata['FechaEntrega'] = $("#FechaIngreso").val();


                getdata = tmpdata;
            } catch (e) { }

            var idazar = Math.ceil(Math.random() * 1000000);
            // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)




            QuitarRenglonDragDrop(idazar, getdata)
            //////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////




            //resetAltRows.call(this);
            $("#gbox_grid2").css("border", "1px solid #aaaaaa");
            //RefrescarOrigenDescripcion();

            AgregarRenglonesEnBlanco({ "IdDetallePresupuesto": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

            //        rows = $("#Lista").getGridParam("reccount");
            //        if (rows >= 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);

            $("#loading").hide();

        }



        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        function CopiarPresupuesto(acceptId) {



            try {
                jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);
            } catch (e) {
                LogJavaScript("Error en Script copiarArticulo   ", e);
            }

            //sacarDeEditMode();

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
                $("#Proveedor").val(getdata['Proveedor']);



                $("#Numero").val(getdata['Numero']);
                $("#SubNumero").val("");
                BuscarOrden(getdata['Numero']);


                //me traigo los datos de detalle
                var IdPresupuesto = getdata['IdPresupuesto']; //deber�a usar getdata['IdRequerimiento'];, pero estan desfasadas las columnas


                $.ajax({
                    type: "GET",
                    contentType: "application/json; charset=utf-8",
                    url: ROOT + 'Presupuesto/DetPresupuestosSinFormato/',
                    data: { IdPresupuesto: IdPresupuesto },
                    dataType: "Json",
                    beforeSend: function () {
                        $("#loading").show();
                    },
                    complete: function () {
                        $("#loading").hide();
                    },

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
                            var idazar = Math.ceil(Math.random() * 1000000);

                            QuitarRenglonDragDrop(idazar, getdata)

                            //    $("#Lista").jqGrid('addRowData', grid, getdata);
                        }


                        //                rows = $("#Lista").getGridParam("reccount");
                        //                if (rows > 5) $("#Lista").jqGrid('setGridHeight', rows * 40, true);
                        
AgregarRenglonesEnBlanco({ "IdDetallePresupuesto": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });




                        //Validar();
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
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


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
                    var getdata = ui.draggable.parent().parent().jqGrid('getRowData', acceptId);
                    var j = 0, tmpdata = {}, dropname;
                    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');

                    var IdArticulo = getdata['IdArticulo'];
                    copiarArticulo(IdArticulo);
                    $("#gbox_grid2").css("border", "1px solid #aaaaaa");
                    return;



                    try {
                        tmpdata['IdArticulo'] = getdata['IdArticulo'];
                        tmpdata['Codigo'] = getdata['Codigo'];
                        tmpdata['Descripcion'] = getdata['Descripcion'];
                        tmpdata['IdUnidad'] = getdata['IdUnidad'];
                        tmpdata['Unidad'] = getdata['Unidad'];
                        tmpdata['PorcentajeIva'] = getdata['Iva'].replace(",", ".");
                        tmpdata['IdDetallePresupuesto'] = 0;
                        tmpdata['Cantidad'] = 1;
                        tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                        tmpdata['FechaEntrega'] = $("#FechaIngreso").val();
                        getdata = tmpdata;
                    } catch (e) { }
                    var grid;
                    grid = Math.ceil(Math.random() * 1000000);
                    // SE CAMBIO EN EL COMPONENTE grid.jqueryui.js LA LINEA 435 (SE COMENTO LA INSTRUCCION addRowData)
                    $("#" + this.id).jqGrid('addRowData', grid, getdata);
                    //resetAltRows.call(this);
                    $("#gbox_grid2").css("border", "1px solid #aaaaaa");
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

                        IdRequerimiento = getdata['NumeroRequerimiento'];

                        copiarRM(IdRequerimiento);

                        /*
                        $.ajax({
                            type: "GET",
                            contentType: "application/json; charset=utf-8",
                            url: ROOT + 'Requerimiento/DetRequerimientosSinFormato/',
                            data: { IdRequerimiento: IdRequerimiento },
                            dataType: "Json",
                            success: function (data) {
                                var longitud = data.length;
                                for (var i = 0; i < data.length; i++) {
                                    if (!FechaEntrega) FechaEntrega = "";
                                    var date = new Date(parseInt(data[i].FechaEntrega.substr(6)));
                                    var displayDate = $.datepicker.formatDate("mm/dd/yy", date);
                                    tmpdata['IdArticulo'] = data[i].IdArticulo;
                                    tmpdata['Codigo'] = data[i].Codigo;
                                    tmpdata['Descripcion'] = data[i].Descripcion;
                                    tmpdata['IdUnidad'] = data[i].IdUnidad;
                                    tmpdata['Unidad'] = data[i].Unidad;
                                    tmpdata['IdDetallePresupuesto'] = 0;
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
                        */

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
                    var j = 0, tmpdata = {}, dropname, IdPresupuesto;
                    var dropmodel = $("#" + this.id).jqGrid('getGridParam', 'colModel');
                    var grid;


                    CopiarPresupuesto(acceptId)

                    /*
                    try {
                        $("#Numero").val(getdata['Numero']);
                        $("#SubNumero").val("");
                        IdPresupuesto = getdata['IdPresupuesto'];
                        BuscarOrden(getdata['Numero']);
                        $.ajax({
                            type: "GET",
                            contentType: "application/json; charset=utf-8",
                            url: ROOT + 'Presupuesto/DetPresupuestosSinFormato/',
                            data: { IdPresupuesto: IdPresupuesto },
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
                                    tmpdata['IdDetallePresupuesto'] = 0;
                                    tmpdata['IdDetalleRequerimiento'] = data[i].IdDetalleRequerimiento;
                                    tmpdata['NumeroRequerimiento'] = data[i].NumeroRequerimiento;
                                    tmpdata['NumeroItemRM'] = data[i].NumeroItemRM;
                                    tmpdata['Cantidad'] = data[i].Cantidad;
                                    tmpdata['Observaciones'] = data[i].Observaciones;
                                    tmpdata['NumeroObra'] = data[i].NumeroObra;
                                    tmpdata['FechaEntrega'] = displayDate;
                                    tmpdata['NumeroItem'] = jQuery("#Lista").jqGrid('getGridParam', 'records') + 1;
                                    getdata = tmpdata;
                                    idazar = Math.ceil(Math.random() * 1000000);

                                    //    $("#Lista").jqGrid('addRowData', idazar, getdata);


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
                            }
                        });
                    } catch (e) { }
                    */



                    $("#gbox_grid2").css("border", "1px solid #aaaaaa");


                }
            });
        }




        function proveedorSeleccionado(event, ui) {
            //			var producto = ui.item.value;
            //			var cantidad = $("#txtCantidad").val();
            //			// vamos a validar la cantidad con un procedimiento muy simple
            //			cantidad = parseInt(cantidad, 10); // convierte este valor en un entero base 10 (un numero cualquiera)
            //			if (isNaN(cantidad)) cantidad = 0;
            //			var precio = producto.precio;
            //			var importe = precio * cantidad;
            $("#IdProveedor").val(ui.item.id);

            // no quiero que jquery maneje el texto del control porque no puede manejar objetos, asi que escribimos los datos nosotros y cancelamos el evento
            $("#Proveedor").val(ui.item.value);
            $("#IdCondicionCompra").val(ui.item.IdCondicionCompra);
            $("#Contacto").val(ui.item.Contacto);
            event.preventDefault();
        }

        function BuscarOrden(Numero) {
            $.ajax({
                type: "GET",
                contentType: "application/json; charset=utf-8",
                url: ROOT + 'Presupuesto/BuscarOrden/',
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


///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////


$(function () {












            var lastSelectedId;
            var inEdit
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

            $("#Proveedor").autocomplete({
                source:  ROOT + 'Proveedor/GetProveedoresAutocomplete2', // '@Url.Action("GetProveedoresAutocomplete2", "Proveedor")',
                minLength: 1,
                select: proveedorSeleccionado,
                messages: { noResults: "", results: function () { } }
            });



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

            $("#FechaIngreso").datepicker({
                changeMonth: true,
                changeYear: true
            });

            //Para que haga wrap en las celdas
            $('.ui-jqgrid .ui-jqgrid-htable th div').css('white-space', 'normal');
            //$.jgrid.formatter.integer.thousandsSeparator=',';








            $('#Lista').jqGrid({
                url: ROOT + 'Presupuesto/DetPresupuestos/',
                postData: { 'IdPresupuesto': function () { return $("#IdPresupuesto").val(); } },
                datatype: 'json',
                mtype: 'POST',
                colNames: ['Acciones', 'IdDetallePresupuesto', 'IdArticulo', 'IdUnidad', 'Item', 'Obra', 'Cant.', 'Un.', 'Codigo', 'Material', 'Precio', '% Bon.', 'Imp.Bon.', '% Iva',
                    'Imp.Iva', 'Imp.Total', 'Entrega', 'Observ', 'Nro.RM', 'ItemRM', 'Adj1', "IdDetalleRequerimiento"],
                colModel: [
                            { name: 'act', formoptions: { rowpos: 1, colpos: 1 }, index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                            { name: 'IdDetallePresupuesto', formoptions: { rowpos: 2, colpos: 1 }, index: 'IdDetallePresupuesto', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: true } },
                            { name: 'IdArticulo', formoptions: { rowpos: 3, colpos: 1 }, index: 'IdArticulo', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: true, required: true } },
                            { name: 'IdUnidad', formoptions: { rowpos: 4, colpos: 1 }, index: 'IdUnidad', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editrules: { edithidden: true, required: true } },
                            { name: 'NumeroItem', formoptions: { rowpos: 5, colpos: 1 }, formoptions: { rowpos: 1, colpos: 1 }, index: 'NumeroItem', label: 'TB', align: 'right', width: 40, editable: true, edittype: 'text', editrules: { required: true } },
                            { name: 'NumeroObra', formoptions: { rowpos: 6, colpos: 1 }, index: 'NumeroObra', label: 'TB', align: 'center', width: 80, sortable: false, editable: false },
                            {
                                name: 'Cantidad', formoptions: { rowpos: 7, colpos: 1 }, index: 'Cantidad', label: 'TB', align: 'right', width: 100, editable: true, edittype: 'text',
                                editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { CalcularImportes(); } }] }, editrules: { required: true }
                            },
                            {
                                name: 'Unidad', formoptions: { rowpos: 7, colpos: 2 }, index: 'Unidad', align: 'center', width: 60,
                                editable: true, edittype: 'select', editrules: { required: true },
                                editoptions: {
                                    dataUrl: ROOT + 'Articulo/Unidades', // '@Url.Action("Unidades", "Articulo")',
                                    dataEvents: [{ type: 'change', fn: function (e) { $('#IdUnidad').val(this.value); } }]
                                }
                            },
                            {
                                name: 'Codigo', formoptions: { rowpos: 8, colpos: 1 }, index: 'Codigo', align: 'left', width: 85, editable: true, edittype: 'text',
                                editoptions: {
                                    dataInit: function (elem) {
                                        $(elem).autocomplete({
                                            source:  ROOT + 'Articulo/GetCodigosArticulosAutocomplete2', //  '@Url.Action("GetCodigosArticulosAutocomplete2", "Articulo")', minLength: 3,
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
                                editrules: { required: true }
                            },
                            {
                                name: 'Descripcion', formoptions: { rowpos: 8, colpos: 2 }, index: 'Descripcion', align: 'left', width: 500, editable: true, edittype: 'text',
                                editoptions: {
                                    dataInit: function (elem) {
                                        $(elem).autocomplete({
                                            source:  ROOT + 'Articulo/GetArticulosAutocomplete2', // '@Url.Action("GetArticulosAutocomplete2", "Articulo")', minLength: 0,
                                            select: function (event, ui) {
                                                $("#IdArticulo").val(ui.item.id);
                                                $("#Codigo").val(ui.item.codigo);
                                                $("#PorcentajeIva").val(ui.item.iva);
                                                $("#IdUnidad").val(ui.item.IdUnidad);
                                                $("#Unidad").attr("value", ui.item.IdUnidad);
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
                                name: 'Precio', formoptions: { rowpos: 9, colpos: 1 }, index: 'Precio', label: 'TB', align: 'right', width: 100, editable: true, edittype: 'text',
                                editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { CalcularImportes(); } }] }, editrules: { required: true }
                            },
                            {
                                name: 'PorcentajeBonificacion', formoptions: { rowpos: 10, colpos: 1 }, index: 'PorcentajeBonificacion', label: 'TB', align: 'right', width: 100, editable: true, edittype: 'text',
                                editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { CalcularImportes(); } }] }
                            },
                            { name: 'ImporteBonificacion', formoptions: { rowpos: 11, colpos: 1 }, index: 'ImporteBonificacion', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled' } },
                            {
                                name: 'PorcentajeIva', formoptions: { rowpos: 12, colpos: 1 }, index: 'PorcentajeIva', label: 'TB',
                                align: 'right', width: 100, editable: true, editoptions: { maxlength: 20, dataEvents: [{ type: 'change', fn: function (e) { CalcularImportes(); } }] }
                            },
                            { name: 'ImporteIva', formoptions: { rowpos: 13, colpos: 1 }, index: 'ImporteIva', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled' } },
                            { name: 'ImporteTotalItem', formoptions: { rowpos: 14, colpos: 1 }, index: 'ImporteTotalItem', label: 'TB', align: 'right', width: 100, editable: true, editoptions: { disabled: 'disabled' } },
                            {
                                name: 'FechaEntrega', formoptions: { rowpos: 15, colpos: 1 }, index: 'FechaEntrega', label: 'TB', width: 200, align: 'center',
                                sorttype: 'date', editable: true,
                                formatoptions: { newformat: 'dd/mm/yy' }, datefmt: 'dd/mm/yy', editoptions: { size: 10, maxlengh: 10, dataInit: initDateEdit },
                                editrules: { required: true }
                            },
                            {
                                name: 'Observaciones', formoptions: { rowpos: 16, colpos: 1 }, index: 'Observaciones', label: 'TB', align: 'left', width: 600, editable: true, edittype: 'textarea',
                                editoptions: { rows: '2', cols: '40' }
                            }, //editoptions: { dataInit: function (elem) { $(elem).val(inEdit ? "Modificado" : "Nuevo"); }
                            { name: 'NumeroRequerimiento', formoptions: { rowpos: 17, colpos: 1 }, index: 'NumeroRequerimiento', label: 'TB', align: 'right', width: 50, sortable: false, editable: false },
                            { name: 'NumeroItemRM', index: 'NumeroItemRM', label: 'TB', align: 'right', width: 100, sortable: false, editable: false },
                            {
                                name: 'ArchivoAdjunto1', index: 'ArchivoAdjunto1', label: 'TB', align: 'left', width: 100, editable: true, edittype: 'file',
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

                            { name: 'IdDetalleRequerimiento', index: 'IdDetalleRequerimiento', label: 'TB', hidden: true },


                ],




                beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
                    lastRowIndex = iRow;
                    lastColIndex = iCol;
                },
                onSelectRow: function (id) {

                    if (id && id !== lastSelectedId) {
                        if (typeof lastSelectedId !== "undefined") {
                            jQuery("#Lista").jqGrid('restoreRow', lastSelectedId);
                        }
                        lastSelectedId = id;
                    }

                },
                ondblClickRow: function (id) {
                    sacarDeEditMode();
                    dobleclic = true;
                    EditarItem(id); //$("#edtData").click();
                },




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
},

loadComplete:  function () {

                        AgregarRenglonesEnBlanco({ "IdDetallePresupuesto": "0", "IdArticulo": "0", "Cantidad": "0", "Descripcion": "" });

                },
                afterSaveCell: function (rowid, name, val, iRow, iCol) {
                    //No anda calculateTotal();
                },
                //pager: $('#ListaPager'),
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
                height: 150, //'auto',
                altRows: false,
                footerrow: true,
                userDataOnFooter: true
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
            , editurl: ROOT + 'Presupuesto/EditGridData/' // pinta que esta es la papa: editurl con la url, y cellsubmit en clientarray
                ///////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////
            });
            jQuery("#Lista").jqGrid('navGrid', '#ListaPager', { refresh: true, add: false, edit: false, del: false }, {}, {}, {}, { sopt: ["cn"], width: 700, closeOnEscape: true, closeAfterSearch: true });













    
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
            url: ROOT + 'Presupuesto/BatchUpdate', //            url: '@Url.Action("BatchUpdate", "Presupuesto")',
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
            editoptions: { dataUrl:  ROOT + 'Articulo/Unidades', //  '@Url.Action("Unidades")' 
}, editrules: { required: true }
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
            agregarBotonDeCopiaEnLasGrillasAuxiliares();
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
                    { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
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
        loadComplete: function () {
            agregarBotonDeCopiaEnLasGrillasAuxiliares();
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
                    { name: 'act', index: 'act', align: 'center', width: 80, sortable: false, editable: false, search: false, hidden: false }, //, formatter: 'showlink', formatoptions: { baseLinkUrl: '@Url.Action("Edit")'} },
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

        loadComplete: function () {
            agregarBotonDeCopiaEnLasGrillasAuxiliares();
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









//})


    //    $(document).ready(function () {





            function PopupCentrar() {
                //return ;
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







            $("#addData").click(function () {
                jQuery("#Lista").jqGrid('editGridRow', "new", {
                    addCaption: "Agregar item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
                    recreateForm: true,
                    beforeShowForm: function (form) {

                        PopupCentrar();

                        //                    var dlgDiv = $("#editmod" + grid[0].id);
                        //                    dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                        //                    dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                        $('#tr_IdDetallePresupuesto', form).hide();
                        $('#tr_IdArticulo', form).hide();
                        $('#tr_IdUnidad', form).hide();
                    },
                    beforeInitData: function () {
                        inEdit = false;
                    },
                    onInitializeForm: function (form) {
                        $('#IdDetallePresupuesto', form).val(0);
                        $('#NumeroItem', form).val(jQuery("#Lista").jqGrid('getGridParam', 'records') + 1);
                        $('#FechaEntrega', form).val($("#FechaIngreso").val());
                    },
                    afterShowForm: function (formid) {
                        $('#Cantidad').focus();
                    },
                    afterComplete: function (response, postdata) {
                        calculateTotal();
                    }
                });
            });




    $("#edtData").click(function () {
        //sacarDeEditMode();
        var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');

        EditarItem(gr)
    });




function EditarItem(gr) {

                if (gr != null) jQuery("#Lista").jqGrid('editGridRow', gr, {
                    editCaption: "Modificacion item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true,
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
                        $('#tr_IdDetallePresupuesto', form).hide();
                        $('#tr_IdArticulo', form).hide();
                        $('#tr_IdUnidad', form).hide();


                    },
                    beforeInitData: function () {
                        inEdit = true;
                    },
                    afterComplete: function (response, postdata) {
                        calculateTotal();
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






            $("#delData").click(function () {
                var gr = jQuery("#Lista").jqGrid('getGridParam', 'selrow');
                if (gr != null) {
                    jQuery("#Lista").jqGrid('delGridRow', gr, {
                        caption: "Borrar", msg: "Elimina el registro seleccionado?", bSubmit: "Borrar", bCancel: "Cancelar", width: 300, closeOnEscape: true, reloadAfterSubmit: true,
                        afterComplete: function (response, postdata) {
                            calculateTotal();
                        }
                    });
                }
                else alert("Debe seleccionar un item!");
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








        });









