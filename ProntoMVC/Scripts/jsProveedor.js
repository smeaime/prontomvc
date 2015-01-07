$(document).ready(function () {

    var GRILLA = 'Contactos';
    grid2 = $("#Lista" + GRILLA);

    $("#Lista" + GRILLA).jqGrid({
        url: ROOT + 'Proveedor/Det' + GRILLA + '/', postData: { 'IdPresupuesto': function () { return $("#IdProveedor").val(); } },
        editurl: ROOT + 'Proveedor/EditGridData' + GRILLA + '/',

        datatype: 'json',
        mtype: 'GET',

        colNames: ['act', 'IdDetalleProveedor', 'Contacto', 'Puesto', 'Telefono', 'Email'],
        colModel: [
                        { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                        { name: 'IdDetalleProveedor', index: 'IdDetalleProveedor', label: 'TB', width: 40, align: 'left', hidden: true },
                        { name: 'Contacto', index: 'Contacto', label: 'TB', width: 0, align: 'left',
                            unformat: unformatNumber, editable: true, edittype: 'text',
                            editoptions: { maxlength: 20, editrules: { required: true} }
                        },
                        { name: 'Puesto', index: 'Puesto', label: 'TB', width: 0, align: 'left',
                            unformat: unformatNumber, editable: true, edittype: 'text',
                            editoptions: { maxlength: 20, editrules: { required: true} }
                        },
                        { name: 'Telefono', index: 'Telefono', label: 'TB', width: 0, align: 'left',
                            unformat: unformatNumber, editable: true, edittype: 'text',
                            editoptions: { maxlength: 20, editrules: { required: true} }
                        },
                        { name: 'Email', index: 'Email', label: 'TB', width: 0, align: 'left',
                            unformat: unformatNumber, editable: true, edittype: 'text',
                            editoptions: { maxlength: 20, editrules: { required: true} }
                        }

                  ],
        pager: jQuery('#Pager' + GRILLA),
        rowNum: 10,
        rowList: [5, 10, 20, 50],
        sortname: 'Id',
        sortorder: "desc",
        viewrecords: true,
        imgpath: '/scripts/themes/coffee/images',
        caption: '',
        autowidth: true,

        width: 'auto',
        height: 'auto',
        loadonce: true


    });

    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////


    $("#addData" + GRILLA).click(function () {

        jQuery("#Lista" + GRILLA).jqGrid('editGridRow', "new",
                {
                    addCaption: "Agregar item de solicitud",
                    bSubmit: "Aceptar",
                    bCancel: "Cancelar", width: 800,
                    reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
                    recreateForm: true,
                    beforeShowForm: function (form) {
                        var dlgDiv = $("#editmod" + grid2[0].id);
                        dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                        dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                        $('#tr_IdDetalleProveedor', form).hide();
                        $('#tr_IdArticulo', form).hide();
                        $('#tr_IdUnidad', form).hide();
                    },
                    beforeInitData: function () {
                        inEdit = false;
                    },
                    onInitializeForm: function (form) {
                        $('#IdDetalleProveedor', form).val(0);
                        $('#NumeroItem', form).val(jQuery("#Lista" + GRILLA).jqGrid('getGridParam', 'records') + 1);
                        $('#FechaEntrega', form).val($("#FechaIngreso").val());
                    },
                    afterShowForm: function (formid) {
                        $('#Cantidad').focus();
                    },
                    afterComplete: function (response, postdata) {
                        // calculateTotal();
                    }
                })
    });



    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////


    $("#edtData" + GRILLA).click(function () {
        var gr = jQuery("#Lista" + GRILLA).jqGrid('getGridParam', 'selrow');
        if (gr != null) jQuery("#Lista" + GRILLA).jqGrid('editGridRow', gr, { editCaption: "Modificacion item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true,
            closeAfterEdit: true, recreateForm: true, Top: 0,
            beforeShowForm: function (form) {
                var dlgDiv = $("#editmod" + grid2[0].id);
                var parentDiv = dlgDiv.parent(); // div#gbox_list
                var dlgWidth = dlgDiv.width();
                var parentWidth = parentDiv.width();
                var dlgHeight = dlgDiv.height();
                var parentHeight = parentDiv.height();
                dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
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
        });
        else alert("Debe seleccionar un item!");
    });



    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////

    $("#delData" + GRILLA).click(function () {
        var gr = jQuery("#Lista" + GRILLA).jqGrid('getGridParam', 'selrow');
        if (gr != null) {
            jQuery("#Lista" + GRILLA).jqGrid('delGridRow', gr, { caption: "Borrar", msg: "Elimina el registro seleccionado?", bSubmit: "Borrar", bCancel: "Cancelar", width: 300, closeOnEscape: true, reloadAfterSubmit: true,
                afterComplete: function (response, postdata) {
                    calculateTotal();
                }
            });
        }
        else alert("Debe seleccionar un item!");
    });






    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////

});
















/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////




$(document).ready(function () {

    var NOMBRE = 'LugaresEntrega';
    var lastSelectedId;
    var inEdit
    var headerRow, rowHight, resizeSpanHeight;
    grid = $("#Lista" + NOMBRE)

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



    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////

    $("#Lista" + NOMBRE).jqGrid({
        url: ROOT + 'Proveedor/DetLugaresEntrega/', postData: { 'IdPresupuesto': function () { return $("#IdProveedor").val(); } },
        editurl: ROOT + 'Proveedor/EditGridData/',



        datatype: 'json',
        mtype: 'GET',

        colNames: ['act', 'IdDetalleProveedorLugarEntrega', 'DireccionEntrega', 'IdLocalidadEntrega', 'Localidad', 'IdProvinciaEntrega', 'Provincia'],
        colModel: [

                        { name: 'act', index: 'act', align: 'left', width: 60, hidden: true, sortable: false, editable: false },
                        { name: 'IdDetalleProveedorLugarEntrega', index: 'IdDetalleProveedorLugarEntrega', label: 'TB', width: 40, align: 'left', hidden: true },
                        { name: 'DireccionEntrega', index: 'DireccionEntrega', label: 'TB', width: 0, align: 'left',
                            width: 0, unformat: unformatNumber, editable: true, edittype: 'text',
                            editoptions: { maxlength: 20, editrules: { required: true} }
                        },
                        { name: 'IdLocalidadEntrega', index: 'IdLocalidadEntrega', label: 'TB', align: 'left', width: 85,
                            editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: true }
                        },
                        { name: 'Localidad', index: 'Localidad', align: 'left', width: 400, editable: true, edittype: 'text',
                            editoptions: {
                                dataInit: function (elem) {
                                    $(elem).autocomplete({ source: ROOT + 'Proveedor/GetLocalidadesAutocomplete/',
                                        // si el archivo est� en un .js, no va a reconocer el tag @ de razor
                                        minLength: 0,
                                        select: function (event, ui) {
                                            $("#IdLocalidadEntrega").val(ui.item.id);
                                            $("#Localidad").val(ui.item.title);
                                            $("#IdProvinciaEntrega").val(ui.item.idprovincia);
                                        }
                                    })
//                                    .data("ui-autocomplete")._renderItem = function (ul, item) {
//                                        return $("<li></li>")
//                                            .data("ui-autocomplete-item", item)
//                                            .append("<a><span style='display:inline-block;width:500px;font-size:12px'><b>" + item.title + " [" + item.codigo + "]</b></span></a>")
//                                            .appendTo(ul);
//                                    };
                                }
                            },
                            editrules: { required: true }
                        },
                        { name: 'IdProvinciaEntrega', index: 'IdProvinciaEntrega', label: 'TB', align: 'left', width: 85, editable: true, hidden: true, editoptions: { disabled: 'disabled' }, editrules: { edithidden: false, required: true} },
                        { name: 'Provincia', index: 'Provincia', align: 'center', width: 0, editable: true, edittype: 'select', editrules: { required: true },
                            editoptions: { dataUrl: ROOT + 'Proveedor/Provincias/',
                                dataEvents: [{ type: 'change', fn: function (e) { $('#IdProvinciaEntrega').val(this.value); } }]
                            }
                        }
                  ],
        pager: jQuery('#Pager' + NOMBRE),
        rowNum: 10,
        rowList: [5, 10, 20, 50],
        sortname: 'Id',
        sortorder: "desc",
        viewrecords: true,
        imgpath: '/scripts/themes/coffee/images',
        caption: '',
        autowidth: true,

        width: 'auto',
        height: 'auto',
        loadonce: true


    });


    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////


    $("#addData" + NOMBRE).click(function () {
        jQuery("#Lista" + NOMBRE).jqGrid('editGridRow', "new",
                {
                    addCaption: "Agregar item de solicitud",
                    bSubmit: "Aceptar",
                    bCancel: "Cancelar", width: 800,
                    reloadAfterSubmit: false, closeOnEscape: true, closeAfterAdd: true,
                    recreateForm: true,
                    beforeShowForm: function (form) {
                        var dlgDiv = $("#editmod" + grid[0].id);
                        dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                        dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
                        $('#tr_IdDetalleProveedorLugarEntrega', form).hide();
                        $('#tr_IdArticulo', form).hide();
                        $('#tr_IdUnidad', form).hide();
                    },
                    beforeInitData: function () {
                        inEdit = false;
                    },
                    onInitializeForm: function (form) {
                        $('#IdDetalleProveedorLugarEntrega', form).val(0);
                        $('#NumeroItem', form).val(jQuery("#Lista" + NOMBRE).jqGrid('getGridParam', 'records') + 1);
                        $('#FechaEntrega', form).val($("#FechaIngreso").val());
                    },
                    afterShowForm: function (formid) {
                        $('#Cantidad').focus();
                    },
                    afterComplete: function (response, postdata) {
                        calculateTotal();
                    }
                })
    });



    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////


    $("#edtData" + NOMBRE).click(function () {
        var gr = jQuery("#Lista" + NOMBRE).jqGrid('getGridParam', 'selrow');
        if (gr != null) jQuery("#Lista" + NOMBRE).jqGrid('editGridRow', gr, { editCaption: "Modificacion item de solicitud", bSubmit: "Aceptar", bCancel: "Cancelar", width: 800, reloadAfterSubmit: false, closeOnEscape: true,
            closeAfterEdit: true, recreateForm: true, Top: 0,
            beforeShowForm: function (form) {
                var dlgDiv = $("#editmod" + grid[0].id);
                var parentDiv = dlgDiv.parent(); // div#gbox_list
                var dlgWidth = dlgDiv.width();
                var parentWidth = parentDiv.width();
                var dlgHeight = dlgDiv.height();
                var parentHeight = parentDiv.height();
                dlgDiv[0].style.top = 0 //Math.round((parentHeight-dlgHeight)/2) + "px";
                dlgDiv[0].style.left = 0 //Math.round((parentWidth-dlgWidth)/2) + "px";
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
        });
        else alert("Debe seleccionar un item!");
    });



    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////

    $("#delData" + NOMBRE).click(function () {
        var gr = jQuery("#Lista" + NOMBRE).jqGrid('getGridParam', 'selrow');
        if (gr != null) {
            jQuery("#Lista" + NOMBRE).jqGrid('delGridRow', gr, { caption: "Borrar", msg: "Elimina el registro seleccionado?", bSubmit: "Borrar", bCancel: "Cancelar", width: 300, closeOnEscape: true, reloadAfterSubmit: true,
                afterComplete: function (response, postdata) {
                    calculateTotal();
                }
            });
        }
        else alert("Debe seleccionar un item!");
    });






    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////



});




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






/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function () {


    //   http://stackoverflow.com/questions/10744694/submitting-jqgrid-row-data-from-view-to-controller-what-method
    var NOMBRE = 'LugaresEntrega';
    var GRILLA = 'Contactos';
    grid2 = $("#Lista" + GRILLA);


    $('#grabar').click(function () {
        var grid1 = $("#Lista" + NOMBRE)
        var cm, data1, data2, valor;

        /////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        // �no me convendr�a editar sobre renglones asociados con el modelo? Pones esos renglones como hidden, y 
        // con la jqGrid los vas editando. Despues, el post lo haces con un ActionLink,
        // sin necesidad de este mapeo
        // -Pero suponete que quiero agregar un renglon... A qu� campo hidden hago referencia, si el servidor
        // no lo cre�?
        //
        // http://stackoverflow.com/questions/5048055/asp-net-mvc-array-of-hidden-fields
        // http://stackoverflow.com/questions/9915612/how-can-i-add-rows-to-a-collection-list-in-my-model
        // http://blog.stevensanderson.com/2010/01/28/editing-a-variable-length-list-aspnet-mvc-2-style/   <<<<----------- leer!!!!!!!
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////////////////////////
        var cabecera = {
            "IdProveedor": ""
            , "RazonSocial": ""
            , "Direccion": ""
            , "IdLocalidad": ""
            , "CodigoPostal": ""
            , "IdProvincia": ""
            , "IdPais": ""
            , "Telefono": ""
            , "Fax": ""
            , "Email": ""
            , "Cuit": ""
            , "IdCodigoIva": ""
            , "FechaAlta": ""
            , "Contacto": ""
            , "EnviarEmail": ""
            , "DireccionEntrega": ""
            , "IdLocalidadEntrega": ""
            , "IdProvinciaEntrega": ""
            , "CodigoProveedor": ""
            , "IdCuenta": "", "Saldo": "", "SaldoDocumentos": "", "Vendedor1": "", "CreditoMaximo": "", "IGCondicion": "", "IdCondicionVenta": ""
            , "IdMoneda": "", "IBNumeroInscripcion": "", "IBCondicion": "", "TipoProveedor": "", "Codigo": "", "IdListaPrecios": "", "IdIBCondicionPorDefecto": ""
            , "Confirmado": "", "CodigoPresto": "", "Observaciones": "", "Importaciones_NumeroInscripcion": "", "Importaciones_DenominacionInscripcion": "", "IdCuentaMonedaExt": ""
            , "Cobrador": "", "IdIBCondicionPorDefecto2": "", "IdIBCondicionPorDefecto3": "", "IdEstado": "", "NombreFantasia": "", "EsAgenteRetencionIVA": "", "BaseMinimaParaPercepcionIVA": ""
            , "PorcentajePercepcionIVA": "", "IdUsuarioIngreso": "", "FechaIngreso": "", "IdUsuarioModifico": "", "FechaModifico": "", "PorcentajeIBDirecto": "", "FechaInicioVigenciaIBDirecto": ""
            , "FechaFinVigenciaIBDirecto": "", "GrupoIIBB": "", "IdBancoDebito": "", "CBU": "", "PorcentajeIBDirectoCapital": "", "FechaInicioVigenciaIBDirectoCapital": "", "FechaFinVigenciaIBDirectoCapital": ""
            , "GrupoIIBBCapital": "", "IdBancoGestionador": "", "ExpresionRegularNoAgruparFacturasConEstosVendedores": ""
            , "ExigeDatosCompletosEnCartaDePorteQueLoUse": "", "DireccionDeCorreos": ""
            , "DetalleProveedores": []
            , "DetalleProveedoresLugaresEntregas": []
        };


        var colModel = grid1.jqGrid('getGridParam', 'colModel');
        var colModel2 = grid2.jqGrid('getGridParam', 'colModel');


        // var cabecera=""; // no est� andando el serializeObject para los items ocultos
        // var cabecera = $("#formid").serializeObject();
        var prueba = $.map($("#container :input"), function (n, i) { /* n.name and $(n).val() */ });



        cabecera.IdProveedor = $("#IdProveedor").val();

        cabecera.RazonSocial = $("#RazonSocial").val();
        cabecera.Direccion = $("#Direccion").val();
        cabecera.IdLocalidad = $("#IdLocalidad").val();
        cabecera.CodigoPostal = $("#CodigoPostal").val();
        cabecera.IdProvincia = $("#IdProvincia").val();
        cabecera.IdPais = $("#IdPais").val();
        cabecera.Telefono = $("#Telefono").val();

        cabecera.Fax = $("#Fax").val();
        cabecera.Email = $("#Email").val();
        cabecera.Cuit = $("#Cuit").val();
        cabecera.IdCodigoIva = $("#IdCodigoIva").val();
        cabecera.FechaAlta = $("#FechaAlta").val();
        cabecera.Contacto = $("#Contacto").val();

        cabecera.EnviarEmail = $("#EnviarEmail").val();
        cabecera.DireccionEntrega = $("#DireccionEntrega").val();
        cabecera.IdLocalidadEntrega = $("#IdLocalidadEntrega").val();
        cabecera.IdProvinciaEntrega = $("#IdProvinciaEntrega").val();
        cabecera.CodigoProveedor = $("#CodigoProveedor").val();
        cabecera.IdCuenta = $("#IdCuenta").val();


        cabecera.Saldo = $("#Saldo").val();
        cabecera.SaldoDocumentos = $("#SaldoDocumentos").val();
        cabecera.Vendedor1 = $("#Vendedor1").val();
        cabecera.CreditoMaximo = $("#CreditoMaximo").val();
        cabecera.IGCondicion = $("#IGCondicion").val();
        cabecera.IdCondicionVenta = $("#IdCondicionVenta").val();
        cabecera.IdMoneda = $("#IdMoneda").val();

        cabecera.IBNumeroInscripcion = $("#IBNumeroInscripcion").val();
        cabecera.IBCondicion = $('input[name=IBCondicion]:checked').val();
        cabecera.TipoProveedor = $('input[name=TipoProveedor]:checked').val();
        cabecera.Codigo = $("#Codigo").val();
        cabecera.IdListaPrecios = $("#IdListaPrecios").val();
        cabecera.IdIBCondicionPorDefecto = $("#IdIBCondicionPorDefecto").val();
        cabecera.Confirmado = $("#Confirmado").val();

        cabecera.CodigoPresto = $("#CodigoPresto").val();
        cabecera.Observaciones = $("#Observaciones").val();
        cabecera.Importaciones_NumeroInscripcion = $("#Importaciones_NumeroInscripcion").val();
        cabecera.Importaciones_DenominacionInscripcion = $("#Importaciones_DenominacionInscripcion").val();
        cabecera.IdCuentaMonedaExt = $("#IdCuentaMonedaExt").val();
        cabecera.Cobrador = $("#Cobrador").val();
        cabecera.Auxiliar = $("#Auxiliar").val();

        cabecera.IdIBCondicionPorDefecto2 = $("#IdIBCondicionPorDefecto2").val();
        cabecera.IdIBCondicionPorDefecto3 = $("#IdIBCondicionPorDefecto3").val();
        cabecera.IdEstado = $("#IdEstado").val();
        cabecera.NombreFantasia = $("#NombreFantasia").val();
        cabecera.EsAgenteRetencionIVA = $("#EsAgenteRetencionIVA").val();
        cabecera.BaseMinimaParaPercepcionIVA = $("#BaseMinimaParaPercepcionIVA").val();
        cabecera.PorcentajePercepcionIVA = $("#PorcentajePercepcionIVA").val();


        cabecera.IdUsuarioIngreso = $("#IdUsuarioIngreso").val();
        cabecera.FechaIngreso = $("#FechaIngreso").val();
        cabecera.IdUsuarioModifico = $("#IdUsuarioModifico").val();
        cabecera.FechaModifico = $("#FechaModifico").val();
        cabecera.PorcentajeIBDirecto = $("#PorcentajeIBDirecto").val();
        cabecera.FechaInicioVigenciaIBDirecto = $("#FechaInicioVigenciaIBDirecto").val();
        cabecera.FechaFinVigenciaIBDirecto = $("#FechaFinVigenciaIBDirecto").val();
        cabecera.GrupoIIBB = $("#GrupoIIBB").val();
        cabecera.IdBancoDebito = $("#IdBancoDebito").val();
        cabecera.CBU = $("#CBU").val();
        cabecera.PorcentajeIBDirectoCapital = $("#PorcentajeIBDirectoCapital").val();

        cabecera.FechaInicioVigenciaIBDirectoCapital = $("#FechaInicioVigenciaIBDirectoCapital").val();
        cabecera.FechaFinVigenciaIBDirectoCapital = $("#FechaFinVigenciaIBDirectoCapital").val();
        cabecera.GrupoIIBBCapital = $("#GrupoIIBBCapital").val();
        cabecera.IdBancoGestionador = $("#IdBancoGestionador").val();
        cabecera.ExpresionRegularNoAgruparFacturasConEstosVendedores = $("#ExpresionRegularNoAgruparFacturasConEstosVendedores").val();
        cabecera.ExigeDatosCompletosEnCartaDePorteQueLoUse = $("#ExigeDatosCompletosEnCartaDePorteQueLoUse").val();
        cabecera.DireccionDeCorreos = $("#DireccionDeCorreos").val();


        var name = "DetalleProveedores";
        cabecera[name] = [];
        var name2 = "DetalleProveedoresLugaresEntregas";
        cabecera[name2] = [];

        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        var dataIds = grid1.jqGrid('getDataIDs');
        for (var i = 0; i < dataIds.length; i++) {
            try {
                grid1.jqGrid('saveRow', dataIds[i], false, 'clientArray');
                var data = grid1.jqGrid('getRowData', dataIds[i]);

                data1 = '{"IdProveedor":"' + $("#IdProveedor").val() + '",'
                for (var j = 0; j < colModel.length; j++) {
                    cm = colModel[j]
                    if (cm.label === 'TB') { //este label tiene que estar declarado en las columnas del modelo:  { label:'TB' }
                        valor = data[cm.name];
                        if (cm.name === 'Cantidad') valor = valor.replace(".", ",")
                        data1 = data1 + '"' + cm.name + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetalleProveedoresLugaresEntregas.push(data2);
            }
            catch (ex) {
                grid1.jqGrid('restoreRow', dataIds[i]);
                alert("No se pudo grabar el comprobante. " + ex);
                return;
            }
        }

        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        data1 = "";
        var dataIds = grid2.jqGrid('getDataIDs');
        for (var i = 0; i < dataIds.length; i++) {
            try {
                grid2.jqGrid('saveRow', dataIds[i], false, 'clientArray');
                var data = grid2.jqGrid('getRowData', dataIds[i]);

                data1 = '{"IdProveedor":"' + $("#IdProveedor").val() + '",'
                for (var j = 0; j < colModel2.length; j++) {
                    cm = colModel2[j]
                    if (cm.label === 'TB') {
                        valor = data[cm.name];
                        if (cm.name === 'Cantidad') valor = valor.replace(".", ",")
                        data1 = data1 + '"' + cm.name + '":"' + valor + '",';
                    }
                }
                data1 = data1.substring(0, data1.length - 1) + '}';
                data1 = data1.replace(/(\r\n|\n|\r)/gm, "");
                data2 = JSON.parse(data1);
                cabecera.DetalleProveedores.push(data2);
            }
            catch (ex) {
                grid1.jqGrid('restoreRow', dataIds[i]);
                alert("No se pudo grabar el comprobante. " + ex);
                return;
            }
        }

         

        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////

        var dataToSend = JSON.stringify(cabecera); // $.toJSON(cabecera);  // var dataToSend = $("#formid").serialize();


        $.ajax({
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            url: '/Pronto2/Proveedor/BatchUpdate',
            dataType: 'json',
            data: dataToSend,
            success: function (result) {
                if (result) {
                    //alert('hola.');
                    grid1.trigger('reloadGrid');

                    //window.location.replace(ROOT + "Proveedor/index");
                    window.location = (ROOT + "Proveedor/index");

                } else {
                    // window.location.replace(ROOT + "Proveedor/index");
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
                alert(errorMessages.join("<br />"));

            }
        });
    });


    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////


    $("#grabar2").click(function () {
        //                        http: //stackoverflow.com/questions/10744694/submitting-jqgrid-row-data-from-view-to-controller-what-method

        var griddata = $("#ListaLugaresEntrega").jqGrid('getGridParam', 'data');
        var dataToSend = JSON.stringify(griddata); // JSON.stringify(griddata);   JSON.parse() ;   $.toJSON();
        var aaa = $.toJSON(dataToSend);

        var fullData = jQuery("#ListaLugaresEntrega").jqGrid('getRowData');

        //        var gd = $('#ListaLugaresEntrega').jqGrid('getRowData'); // use preferred interface
        //        for (var i = 0; i < gd.length; ++i) {
        //            for (var f in gd[i]) res.push({ name: '_detail[' + i + '].' + f, value: gd[i][f] });
        //        }




        $.ajax({
            type: 'POST',
            // contentType: 'application/json; charset=utf-8',
            url: '/Pronto2/Proveedor/UpdateAwesomeGridData?dataToSend=' + dataToSend,
            dataType: 'json',
            // data: { "": dataToSend }, // $.toJSON(griddata),
            success: function (result) {
                if (result) {
                    $('#Lista').trigger('reloadGrid');
                    window.location.replace(ROOT + "Presupuesto/index");
                } else {
                    alert('No se pudo grabar el comprobante.');
                }
            }
        });

    });

    /////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////
});