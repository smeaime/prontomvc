/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// http://stackoverflow.com/questions/7169227/javascript-best-practices-for-asp-net-mvc-developers
// http://stackoverflow.com/questions/247209/current-commonly-accepted-best-practices-around-code-organization-in-javascript el truco interesante de var DED = (function() {
// http://stackoverflow.com/questions/251814/jquery-and-organized-code?lq=1   una risa

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


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




    $.post(ROOT + "Acceso/ArbolConNiveles", { IdUsuario: $("#IdEmpleado").val() }, function (data) {

// la cuestion es: si no lo ves (el superadmin te puso nivel mínimo) , tampoco lo debés poder administrar (aunque seas administrador)


        var menu_html = '<ul id="Tablas64646" class="treeviewMod treeviewMod-famfamfam filetree treeview-famfamfam"  style="margin: 30px !important;" >';
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
                strNivelinp += '<div name="slider" id="'

                if (data[i].Orden <= 1) {
                    // el nodo no existe en la base, es nuevo. Uso el nombre del nodo, en lugar del id
                    strNivelinp += data[i].Clave.replace('"', " "); 

                }
                else {
                    strNivelinp += data[i].Orden;
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






            $(function () {
                $('[name^="slider"]').slider({
                    value: $(this).val(),
                    min: 1,
                    max: 9,
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



            var prueba = $.map(
                        $('[name^="slider"]'), // $("#Tablas64646 :input"),
                        function (n, i) {
                            var valor = parseInt( $(n).attr('value'));
                            $(n).slider('value', valor);
                        }
                    );





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

    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////



    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////
    // GRABADO: llamando a BatchUpdate
    /////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////


    $("#grabar2").click(function () {
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
                            var a = { IdEmpleadoAcceso: parseInt($(n).attr("id")),  // $(n).attr("name"),
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



