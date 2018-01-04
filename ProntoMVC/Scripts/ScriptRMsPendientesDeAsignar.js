
"use strict";



var ListaReq;
var ListaReq1 = "";

function CargarDetalle (){

                    $("#Lista").jqGrid().setGridParam({
                        url: ROOT + 'ValeSalida/DetValesSalidaSinFormatoSegunListaDeItemsDeRequerimientos',
                        postData: { //idDetalleRequerimientos' : ListaReq },
                                    'idDetalleRequerimientosString' : ListaReq1 },
                        datatype: 'json',
                        traditional: true, //problemas al usar arrays en los parametros
                        ajaxDelOptions: {traditional: true},
                        mtype: 'POST' 
                    }).trigger("reloadGrid");
        
}


$(document).ready(function () {



       $("#Vale").click(function () {    //$('#Vale').on('click', function () {
        $("#frmVale").dialog({
            autoOpen: true,
            position: { my: "center", at: "100", of: window },
            height: 750,
            width: 900,
            resizable: true,
            //title: 'Vale',
            modal: true,
            open: function () {
                $("#frmVale").html("");

                var $grid = $("#ListaReq"), i, n;
                ListaReq = $grid.jqGrid("getGridParam", "selarrrow");
                if ((ListaReq == null) || (ListaReq.length == 0)) {
                    ListaReq = [rowIdContextMenu];
                    if ((ListaReq == null) || (ListaReq.length == 0)) {
                        alert("No hay rms elegidas " + rowIdContextMenu);
                        return;
                    }
                }

                ListaReq1 = ""
                for (i = 0, n = ListaReq.length; i < n; i++) {
                    ListaReq1 = ListaReq1 + ListaReq[i] + ",";
                }
                if (ListaReq1.length > 0) { ListaReq1 = ListaReq1.substring(1, ListaReq1.length - 1); }






                $.get(
                        ROOT + 'Requerimiento/PartialPage1',
                         { idDetalleRequerimientos: ListaReq1 }, function (partialView) {
                    try {
                        $("#frmVale").html(partialView);
                    }
                    catch (err) {
                    }
                    inicializar();

                    RefrescaAnchoJqgrids();
                    deshabilitarPanelesDerecho();





                }).then(function () {
                    //alert("hola")
                  CargarDetalle();
                });
            },
            buttons: {
                //"Add User": function () {
                //    //addUserInfo();
                //    $(this).dialog("close");
                //},
                //"Cancelar": function () {
                //    $(this).dialog("close");
                //}
            }
        });
        return false;
    });



});