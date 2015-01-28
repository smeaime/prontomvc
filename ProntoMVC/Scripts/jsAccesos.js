/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// http://stackoverflow.com/questions/7169227/javascript-best-practices-for-asp-net-mvc-developers
// http://stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript el truco interesante de var DED = (function() {
// http://stackoverflow.com/questions/251814/jquery-and-organized-code?lq=1   una risa

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

"use strict";




var lastColIndex;
var lastRowIndex;
var lastSelectedId;




function actualizaHijos(o) {
    //var padrenivel = $(n).attr('value');
    var padrenivel = $(o).slider('value');
    //var hijos = $(this).children(":input");


    //var hijos = $(this).closest("ul").children();
    var hijos = $(o).closest("li").children();
    var inputhijos = $(hijos).find("div");



    for (var i = 0; i < inputhijos.length; ++i) {
        try {
            $(inputhijos[i]).slider('value', padrenivel);
        } catch (e) {

        }
    }
}




$(document).ready(function () {

    $("#btnVolver").hide();



    function armarArbolDeAccesos() {

        $.post(ROOT + "Acceso/ArbolConNiveles", { IdUsuario: $("#IdEmpleado").val() }, function (data) {

            // la cuestion es: si no lo ves (el superadmin te puso nivel mínimo) , tampoco lo debés poder administrar (aunque seas administrador)


            var menu_html = '<ul id="Tablas64646" class="treeviewMod treeviewMod-famfamfam filetree treeview-famfamfam"  style="margin: 30px !important;" >';
            var longitud = 0
            for (var i = 0; i < data.length; i++) {



                if (longitud > 0) {
                    if (longitud - data[i].IdItem.split("-").length == 1) { menu_html += '</ul></li>' }
                    if (longitud - data[i].IdItem.split("-").length == 2) { menu_html += '</ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.split("-").length == 3) { menu_html += '</ul></li></ul></li></ul></li>' }
                    // if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                    if (longitud - data[i].IdItem.split("-").length >= 4) { menu_html += '</ul></li></ul></li></ul></li>' }
                }




                var strNivelinp = '';
                //strNivelinp += '<input  class="inputboxes"   id="' + data[i].Orden + '" name="' + data[i].Orden + '"    value="' + data[i].Link + '"  style="visibility:hidden; display: none"  >';
                if (data[i].Orden != -999) {
                    strNivelinp += '<div name="slider" id="'

                    if (data[i].Orden <= 1) {
                        // el nodo no existe en la base, es nuevo. Uso el nombre del nodo, en lugar del id
                        strNivelinp += data[i].Clave.replace('"', " ");

                    }
                    else {
                        //strNivelinp += data[i].Orden;
                        strNivelinp += data[i].Clave.replace('"', " ");
                    }
                    strNivelinp += '"   class="" value="' + (Number(data[i].Link) || 0) + '"  > </div>';
                }

                if (data[i].EsPadre == "SI" && longitud - data[i].IdItem.length < 12) {

                    menu_html += '<li>'
                    menu_html += ' <span class="folder " id="' + data[i].Clave + '" ';

                    if (data[i].Orden == -999) {
                        menu_html += ' style="visibility:hidden" ';
                    }
                    menu_html += '>' + data[i].Descripcion + '</span>';


                    menu_html += strNivelinp;
                    menu_html += ' <ul>';



                }
                else {
                    if (data[i].Link.length > 0) {
                        menu_html += '<li><span class="leaf country "  id="' + data[i].Clave + '">' + data[i].Descripcion + '</span>'
                    }
                    else {
                        menu_html += '<li><span class="leaf country  " id="' + data[i].Clave + '">' + data[i].Descripcion + '</span>'
                    }
                    menu_html += strNivelinp
                    menu_html += ' </li>'
                }








                // http://www.techiesweb.net/asp-net-mvc3-dynamically-added-form-fields-model-binding/

                // longitud = data[i].IdItem.length;
                longitud = data[i].IdItem.split("-").length;
            }

            if (longitud > 0) {
                if (longitud == 1) { menu_html += '</ul></li>' }
                if (longitud == 2) { menu_html += '</ul></li></ul></li>' }
                if (longitud == 3) { menu_html += '</ul></li></ul></li></ul></li>' }
                //                    if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                if (longitud >= 4) { menu_html += '</ul></li></ul></li></ul></li>' }
            }
            menu_html += '</ul>';

            $("#Accord233").empty().append(menu_html);




            ///////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////

            // este post está incluido en el primer post, para que el reemplazo de treeviews se haga con los dos terminados de ejecutar
            $.post(ROOT + "Acceso/MenuConNiveles", { IdUsuario: $("#IdEmpleado").val() }, function (data) {
                var menu_html = '<ul id="TablasMenu" class="treeviewMod treeviewMod-famfamfam filetree treeview-famfamfam"  style="margin: 30px !important;" >';
                var longitud = 0
                for (var i = 0; i < data.length; i++) {
                    if (longitud > 0) {
                        if (longitud - data[i].IdItem.length == 3) { menu_html += '</ul></li>' }
                        if (longitud - data[i].IdItem.length == 6) { menu_html += '</ul></li></ul></li>' }
                        if (longitud - data[i].IdItem.length == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
                        // if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                        if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li>' }
                    }






                    var strNivelinp = '';
                    //strNivelinp += '<input  class="inputboxes"   id="' + data[i].Orden + '" name="' + data[i].Orden + '"    value="' + data[i].Link + '"  style="visibility:hidden; display: none"  >';
                    if (data[i].Orden != -999) {
                        strNivelinp += '<div name="slider" id="' + data[i].Clave + '"   class="" value="' + data[i].Orden + '"  > </div>';
                    }

                    if (data[i].EsPadre == "SI" && longitud - data[i].IdItem.length < 12) {

                        menu_html += '<li>'
                        menu_html += ' <span class="folder " id="' + data[i].Clave + '" ';

                        if (data[i].Orden == -999) {
                            menu_html += ' style="visibility:hidden" ';
                        }
                        menu_html += '>' + data[i].Descripcion + '</span>';


                        menu_html += strNivelinp;
                        menu_html += ' <ul>';



                    }
                    else {
                        if (data[i].Link.length > 0) {
                            menu_html += '<li><span class="leaf country "  id="' + data[i].Clave + '">' + data[i].Descripcion + '</span>'
                        }
                        else {
                            menu_html += '<li><span class="leaf country  " id="' + data[i].Clave + '">' + data[i].Descripcion + '</span>'
                        }
                        menu_html += strNivelinp
                        menu_html += ' </li>'
                    }








                    // http://www.techiesweb.net/asp-net-mvc3-dynamically-added-form-fields-model-binding/

                    longitud = data[i].IdItem.length;
                }

                if (longitud > 0) {
                    if (longitud - 2 == 3) { menu_html += '</ul></li>' }
                    if (longitud - 2 == 6) { menu_html += '</ul></li></ul></li>' }
                    if (longitud - 2 == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
                    //                    if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                    if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li>' }
                }
                menu_html += '</ul>';

                $("#AccordDeMenus").append(menu_html);



                ///////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////





                if (true) {
                    //cómo optimizar la creación de tantos controlcitos??


                    // creo los sliders
                    $(function () {
                        $('[name^="slider"]').slider({

                            // http://stackoverflow.com/questions/3083874/is-there-a-way-to-make-the-jquery-ui-slider-start-with-0-on-top-instead-of-on-bo

                            value: $(this).val(),
                            min: 1,
                            max: 9,

                            //                        value: $(this).val() * -1,
                            //                        min: -9,
                            //                        max: -1,

                            step: 1,
                            //                slide: function (event, ui) {
                            //                    //       $("#amount").val("$" + ui.value);
                            //                    actualizaHijos(this);
                            //                },
                            change: function (event, ui) {
                                //       $("#amount").val("$" + ui.value);
                                actualizaHijos(this);
                            }
                        });
                    });



                    // les asigno el valor
                    var prueba = $.map(
                $('[name^="slider"]'), // $("#Tablas64646 :input"),
                function (n, i) {
                    var valor = parseInt($(n).attr('value'));
                    $(n).slider('value', valor);
                }
                );

                }



                ///////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////



                $("#Tablas64646").treeview({
                    collapsed: true,
                    animated: "medium",
                    control: "#sidetreecontrol",
                    //persist: "location"
                    persist: "cookie"

                });




                $("#TablasMenu").treeview({
                    collapsed: true,
                    animated: "medium",
                    control: "#sidetreecontrol",
                    //persist: "location"
                    persist: "cookie"

                });




            });

        });
    }

    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////



    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    // GRABADO: llamando a BatchUpdate
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////


    $("#grabar244").click(function () {
        $("#grabar2").click();
    })




    function GrabarGrillaLocal() {



        var $this = $('#Lista')
        var ids = $this.jqGrid('getDataIDs'), i, l = ids.length;

        for (i = 0; i < l; i++) {
            try {
                var rowdata = $('#arbolpermisos').jqGrid('saveRow', ids[i]);
            } catch (e) {
                $('#arbolpermisos').jqGrid('restoreRow', ids[i]);
                continue;
            }
        }
    }


    $("#grabar2").click(function () {

        //jQuery('#Lista').jqGrid('saveCell', lastRowIndex, lastColIndex);

        //sacarDeEditMode();
        jQuery('#arbolpermisos').jqGrid('saveCell', lastRowIndex, lastColIndex);



        GrabarGrillaLocal()

        var cabecera = SerializaForm();
        var d = JSON.stringify(cabecera)

        //var count = Object.keys(d).length
        //console.log(count);

        $('html, body').css('cursor', 'wait');
        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: ROOT + 'Acceso/Edit',
            dataType: 'json',
            data: d, // $.toJSON(cabecera),
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
                        //window.location = (ROOT + "Pedido/Edit/" + result.IdPedido);
                        location.reload();

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

    })



    $("#grabar3").click(function () {
        //  http://stackoverflow.com/questions/10744694/submitting-jqgrid-row-data-from-view-to-controller-what-method
        //  http://stackoverflow.com/questions/6798671/how-to-submit-local-jqgrid-data-and-form-input-elements?answertab=votes#tab-top

        $('#grabar2').attr("disabled", true).html("Espere...").val("Espere...");


        var griddata = $("#Lista").jqGrid('getGridParam', 'data');
        var cabecera = $("#formid").serializeObject(); // .serializeArray(); // serializeArray 


        //  var aaa = $.toJSON(formdata);

        var fullData = jQuery("#Lista").jqGrid('getRowData');

        //        var gd = $('#ListaLugaresEntrega').jqGrid('getRowData'); // use preferred interface
        //        for (var i = 0; i < gd.length; ++i) {
        //            for (var f in gd[i]) res.push({ name: '_detail[' + i + '].' + f, value: gd[i][f] });
        //        }

        // var grid1 = $("#Lista");
        //var colModel = grid1.jqGrid('getGridParam', 'colModel');

        var items = [];

        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////


        cabecera.EmpleadosAccesos = [];
        //        var eacc = { Nodo: 'aaaa', Nivel: 3 };
        //        cabecera.EmpleadosAccesos.push(eacc);



        // var dataIds = grilla1.jqGrid('getDataIDs');

        var prueba = $.map(
                        $('[name^="slider"]'), // $("#Tablas64646 :input"),
                        function (n, i) {
                            var a = {
                                IdEmpleadoAcceso: null, //parseInt($(n).attr("id")) ojo con pasar a int un nodo como "80-01", porque te quedará idempleadoacceso=80  ,  // $(n).attr("name"),
                                Nivel: $(n).slider('value'), // $(n).val() ,
                                Nodo: $(n).attr("id")
                            };
                            cabecera.EmpleadosAccesos.push(a);
                        }
                     );



        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////




        var dataToSend = JSON.stringify(cabecera); // JSON.stringify(griddata);   JSON.parse() ;   $.toJSON();







        $("#mensajeLocal").hide()




        $.ajax({
            type: 'POST',
            // contentType: 'application/json; charset=utf-8',
            contentType: 'application/json; charset=utf-8', // http://stackoverflow.com/a/2281875/1054200
            url: ROOT + 'Acceso/Edit',   // 'Factura/UpdateAwesomeGridData',
            dataType: 'json',
            // data:JSON.stringify( {formulario: colData , grilla: dataToSend })
            data: dataToSend,
            //  data: { "formulario": formdata ,"grilla": dataToSend }, // $.toJSON(griddata),
            success: function (result) {
                if (result) {
                    $('#mensajeLocal').show();
                    //$(".alert").alert();
                    $('#grabar2').attr("disabled", false).val("Guardar").html("Guardar");

                    // armarArbol();
                    // armarMenu();

                    location.reload();

                    // grid1.trigger('reloadGrid');

                    //window.location.replace(ROOT + "Cliente/index");
                    //window.location = (ROOT + "Acceso/index");

                } else {
                    // window.location.replace(ROOT + "Cliente/index");
                    alert('No se pudo grabar el comprobante.');
                }

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
                $('#grabar2').attr("disabled", false).val("Guardar").html("Guardar");
                alert(errorMessages.join("<br />"));

            }





        });







    });







    function SerializaForm() {
        var cm, data1, data2, valor;
        var colModel = jQuery("#arbolpermisos").jqGrid('getGridParam', 'colModel');

        var cabecera = $("#formid").serializeObject(); // .serializeArray(); // serializeArray 



        var grilla = jQuery("#arbolpermisos").jqGrid('getRowData')

        cabecera.EmpleadosAccesos = grilla;



        return cabecera;

    }

    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////



    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










    var $grid = $('#arbolpermisos')

    // creo que la posta está por acá
    // http: //stackoverflow.com/questions/9242601/how-to-remove-flashing-on-persisting-remotely-populated-jqgrid-tree-node/9244023#9244023

    var idsOfExpandedRows = []


    $grid.jqGrid({

        //columns names
        colNames: ['descripcion', 'id', 'link', 'nivel (1 max ... 9 min)', 'clave'
            // el controlador me está devolviendo datos en estas columnas que impiden que las agrupe!!!!
            //, 'puede ver', 'editar', 'borrar'
        ],
        //columns model
        colModel: [
                                    { name: 'Descripcion', index: 'Nodo', align: 'left', width: 300 },
                                    { name: 'Id', index: 'Id', width: 1, hidden: true, key: true },
                                    { name: 'link', index: 'link', width: 200, hidden: true },
                                    {
                                        name: 'Nivel', index: 'Nivel', width: 200, hidden: false, editable: true
                                        , align: 'right', edittype: 'select',
                                        editrules: { required: false },
                                        editoptions: {
                                            //defaultValue: '9',
                                            // maxlength: 5,

                                            //value: " 1:1 permiso total ; 2:2 ; 3:3 ; 4:4;  5:5; 6:6 ; 9:9 permiso minimo",
                                            // value: "-1:permiso total; 1:1; 2:2 ; 3:3 ; 4:4;  5:5; 6:6 ; 7:7; 8:8 ; 9:9 ; 10:permiso minimo",
                                            value: "1:1; 2:2 ; 3:3 ; 4:4;  5:5; 6:6 ; 7:7; 8:8 ; 9:9 ",
                                            size: 1,

                                            dataEvents: [{
                                                type: 'change', fn: function (e) {

                                                    //                                                $('#IVAComprasPorcentaje1').val(this.value);
                                                    //                                                CalcularItem();

                                                }
                                            }] // dataevents va ADENTRO de editoptions!!!
                                        }
                                    }


                                    , { name: 'Nodo', index: 'Nodo', align: 'left', width: 240, hidden: false }

// el controlador me está devolviendo datos en estas columnas que impiden que las agrupe!!!!
    //, { name: 'ver', index: 'Aktiasdv', width: 100, edittype: 'checkbox', align: 'center', formatter: "checkbox", editable: true, formatoptions: { disabled: false }, hidden: true }
    //, { name: 'editar', index: 'Aktasdddiv', width: 100, edittype: 'checkbox', align: 'center', formatter: "checkbox", editable: true, formatoptions: { disabled: false }, hidden: true }
    //, { name: 'borrar', index: 'Aktidaav', width: 100, edittype: 'checkbox', align: 'center', formatter: "checkbox", editable: true, formatoptions: { disabled: false } , hidden:true}


        ],

        // el treeReader define las columnas que vienen despues del colmodel para manejo del arbol. por default se agregan 4 columnas
        treeReader: {
            level_field: "level",
            parent_id_field: "parent", // then why does your table use "parent_id"?
            leaf_field: "isLeaf",
            expanded_field: "expanded",
            loaded: "loaded",
            icon_field: "icon"
        },


        postData: {
            idsOfExpandedRows: function () {
                // the code can by dynamic, read contain of some elements 
                // on the page use "if"s and so on and return the value which 
                // should be posted to the server
                return idsOfExpandedRows;
            },

            IdEmpleado: function () {
                // the code can by dynamic, read contain of some elements 
                // on the page use "if"s and so on and return the value which 
                // should be posted to the server
                return $("#IdEmpleado").val();
            }
        },

        ExpandColumn: 'Name',
        //                                            colNames: ["Account", "Acc Num", "Debit", "Credit", "Balance", "Enabled"],
        //                                            colModel: [
        //                                        { name: "name", index: "name", width: 180 },
        //                                        { name: "num", index: "acc_num", width: 80, formatter: "integer", sorttype: "int", align: "center" },
        //                                        { name: "debit", index: "debit", width: 80, formatter: "number", sorttype: "number", align: "right" },
        //                                        { name: "credit", index: "credit", width: 80, formatter: "number", sorttype: "number", align: "right" },
        //                                        { name: "balance", index: "balance", width: 80, formatter: "number", sorttype: "number", align: "right" },
        //                                        { name: "enbl", index: "enbl", width: 60, align: "center", formatter: "checkbox", editoptions: { value: "1:0"} }
        //                                    ],



        //        beforeProcessing: function (data) {
        //            if (bPersisteArbol) {
        //                var rows = data.rows, i, l = rows.length, row, index;
        //                for (i = 0; i < l; i++) {
        //                    row = rows[i].cell;
        //                    // cambié los indices en los tres renglones!
        //                    index = $.inArray(row[1], idsOfExpandedRows);
        //                    row[7] = index >= 0; // set expanded column
        //                    row[8] = true;       // set loaded column
        //                }

        //            }
        //        },

        beforeEditCell: function (rowid, cellname, value, iRow, iCol) {
            lastRowIndex = iRow;
            lastColIndex = iCol;

            // http://stackoverflow.com/questions/8333933/highlight-cell-value-on-doubleclick-for-copy
            //selectText(e.target);
        },


        afterEditCell: function (rowid, cellname, value, iRow, iCol) {

            var $input = $("#" + iRow + "_" + cellname);
            $input.select(); // acá me marca el texto

            //http://jsfiddle.net/ironicmuffin/7dGrp/
            //http://fiddle.jshell.net/qLQRA/show/

            // alert('hola'); 
        },

        ///////////////////////////////
        width: 'auto', // 'auto',
        autowidth: true,
        shrinkToFit: false,
        //////////////////////////////

        url: ROOT + "Home/TreeGridConNiveles_Todos_ParaEdicionEnAccesos",

        treedatatype: 'json',
        datatype: 'json',
        // ajaxGridOptions: { contentType: "application/json" },
        mtype: "POST",

        viewrecords: true,
        treeGridModel: 'adjacency',

        treeIcons: { leaf: 'ui-icon-document-b' },
        ExpandColClick: true,

        sortname: 'Name',
        sortorder: 'asc',


        ///////////////////////////////////////////////////////////////////////////////////////////////
        // http://stackoverflow.com/questions/14662632/jqgrid-celledit-in-json-data-shows-url-not-set-alert

        cellEdit: true,
        cellsubmit: 'clientArray'
        , editurl: ROOT + 'Pedido/EditGridData/', // pinta que esta es la papa: editurl con la url, y cellsubmit en clientarray
        ///////////////////////////////////////////////////////////////////////////////////////////////


        col: false,
        gridview: true,
        height: 500, //'auto',
        pager: "parbolpermisos", // "#parbolpermisos",
        treeGrid: true,
        rowNum: 10000,

        caption: ""
    });
    // $grid.appendPostData({ 'idsOfExpandedRows': idsOfExpandedRows })
    $grid.jqGrid('navGrid', "#parbolpermisos");
    $grid.jqGrid('navGrid', '#arbolpermisos', { edit: false, add: false, del: false, search: false });
    $grid.jqGrid('bindKeys');
    // $("#arbolpermisos").css("background", "transparent");
    // jQuery("#arbolpermisos").setCell(row, col, val, { background: '#ff0000' });









});


//$("#dialog-password").dialog({
//    autoOpen: false,
//    height: 300,
//    width: 300,
//    modal: true,
//    buttons: {
//        'Ok': function () {
//            validatePwd();
//        }
//    },
//    open: function () {
//        var combo = $("#dialog-password").data('Combo')
//        var idusuario = $("#Aux1").val();
//        var usuario = $("#Aux2").val();
//        $("#Aux0").val(combo);
//        $("#usuario").val(usuario);
//        $('#password').focus();
//        if (idusuario == "") {
//            $("#mySelect").val([]);
//        }
//        else {
//            $('#mySelect').val(idusuario);
//        }
//    },
//    close: function () {
//        $('#password').val("");
//        var combo = $("#Aux0").val();
//        $('#' + combo).val("");
//        $("#Aux3").val("");
//    }
//});


//$('#password').keypress(function (e) {
//    if (e.keyCode == 13) {
//        e.preventDefault();
//        validatePwd();
//    }
//});




