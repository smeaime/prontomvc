//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// LAYOUT
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const bCARGAR_MENU = true;
const bCARGAR_ARBOL = true;

const bEstadoNodos = true; // esto es el carga del estado abierto/cerrado de cada nodo (no su contenido)
const bCargaParcial = true;  // esto es la carga (parcial/total) del CONTENIDO del arbolito  -parece que la carga TOTAL tarda por el render de una grilla grande, NO porque tarde en traer los datos.
// http: //stackoverflow.com/questions/9192276/send-expanded-treegrid-nodes-in-cookie/9202378#9202378
 // no me anda... pinta que Oleg en su persistencia, ya tiene todos los nodos cargados, o sea 
//  que no vuelve a llamar al servidor cuando se aprieta un nodo


function RefrescarArbol() {
    $("#addtree2").trigger("reloadGrid");
}



$(function () {



    var eslaprimeravez = true;


    var $grid = $('#addtree')


    // creo que la posta está por acá
    // http: //stackoverflow.com/questions/9242601/how-to-remove-flashing-on-persisting-remotely-populated-jqgrid-tree-node/9244023#9244023

    var idsOfExpandedRows = []

    if (bEstadoNodos) {

        var
            saveObjectInLocalStorage = function (storageItemName, object) {
                if (typeof window.localStorage !== 'undefined') {
                    window.localStorage.setItem(storageItemName, JSON.stringify(object));
                }
            },
            removeObjectFromLocalStorage = function (storageItemName) {
                if (typeof window.localStorage !== 'undefined') {
                    window.localStorage.removeItem(storageItemName);
                }
            },
            getObjectFromLocalStorage = function (storageItemName) {
                if (typeof window.localStorage !== 'undefined') {
                    return JSON.parse(window.localStorage.getItem(storageItemName));
                }
            },
            myColumnStateName = function (g) {
                if (g[0] == undefined) return undefined;
                // return window.location.pathname + '#' + g[0].id; // para devolver uno por pagina
                return '#' + g[0].id;

            },
            updateIdsOfExpandedRows = function (id, isExpanded) {
                var index = $.inArray(id, idsOfExpandedRows);
                if (!isExpanded && index >= 0) {
                    idsOfExpandedRows.splice(index, 1); // remove id from the list
                } else if (index < 0) {
                    idsOfExpandedRows.push(id);
                }
                saveObjectInLocalStorage(myColumnStateName($grid), idsOfExpandedRows);
            },
            orgExpandRow = $.fn.jqGrid.expandRow,
            orgCollapseRow = $.fn.jqGrid.collapseRow;

        if ($grid[0] != undefined) {
            idsOfExpandedRows = getObjectFromLocalStorage(myColumnStateName($grid)) || [];
        }

    }





    /////////////////////////////////////////////


    if (bCARGAR_ARBOL) // no cargar ningun arbol. -si, porque lo que pone lento todo es la carga de la jqgrid con semejante localstorage
    {

        if (bCargaParcial) {

            // arbol normal, q carga los nodos a medida q se los usa

            jQuery("#addtree").jqGrid({

                //columns names
                colNames: ['', '', ''],
                //columns model
                colModel: [
                    { name: 'Name', index: 'Name', align: 'left', width: 400 },
                    { name: 'Id', index: 'Id', width: 1, hidden: true, key: true },
                    { name: 'Role', index: 'Role', width: 1, hidden: true },
                ],

                // el treeReader define las columnas que vienen despues del colmodel para manejo del arbol. por default se agregan 4 columnas
                //    treeReader: {
                //        level_field: "level",
                //        parent_id_field: "parent", // then why does your table use "parent_id"?
                //        leaf_field: "isLeaf",
                //        expanded_field: "expanded",
                //        loaded: "loaded",
                //        icon_field: "icon"
                //    },


                postData: {
                    idsOfExpandedRows: function () {
                        // the code can by dynamic, read contain of some elements 
                        // on the page use "if"s and so on and return the value which 
                        // should be posted to the server
                        return idsOfExpandedRows;
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


                onSelectRow: function (id, status, e) {
                    guardarTopPositionDelArbol();
                },

                beforeProcessing: function (data) {
                    //guardarTopPositionDelArbol();
                    if (bEstadoNodos) {
                        var rows = data.rows, i, l = rows.length, row, index;
                        for (i = 0; i < l; i++) {
                            row = rows[i].cell;
                            // cambié los indices en los tres renglones!
                            index = $.inArray(row[1], idsOfExpandedRows);
                            row[6] = index >= 0; // set expanded column
                            row[7] = index >= 0;  //true;       // set loaded column
                        }

                    }

                },



                loadComplete: function (data) {
                    refrescarFondo_addtree();

                    if (eslaprimeravez) {
                        cargarTopPositionDelArbol();
                        eslaprimeravez = false;
                    }

                    var gridId = $("#addtree").attr('id');
                    //var gridParentWidth = $('#gbox_' + gridId).parent().width();
                    //$('#' + gridId).setGridWidth(gridParentWidth);

                },


                //    onSelectRow: function (id) {
                //        var data = $("#addtree").jqGrid('getRowData', id);
                //        if (data['Role'] != "") {
                //            window.location = $($.parseHTML(data['Role'])).attr('href');
                //        }
                //    },

                url: ROOT + "Home/TreeGrid",

                treedatatype: 'json',
                datatype: 'json',
                // ajaxGridOptions: { contentType: "application/json" },
                mtype: "POST",

                viewrecords: true,
                treeGridModel: 'adjacency',

                treeIcons: {
                    leaf: 'ui-icon-blank'  // http://stackoverflow.com/questions/22248944/jqgrid-treegrid-remove-icon-from-leaf-nodes
                    //leaf: 'ui-icon-document-b' 
                },


                ///////////////////////////////
                width: 'auto', // 'auto',
                autowidth: false,
                shrinkToFit: true,
                //////////////////////////////


                ExpandColClick: true,

                sortname: 'Name',
                sortorder: 'asc',

                col: false,
                gridview: true,
                height: 'auto',
                pager: "", //, "paddtree", //"paddtree", // "#paddtree",
                treeGrid: true,
                rowNum: 10000,

                caption: ""
            });

            //jQuery("#addtree").jqGrid('navGrid', "#paddtree");
            // $grid.jqGrid('navGrid', '#addtree', { edit: false, add: false, del: false, search: false });
            jQuery("#addtree").jqGrid('bindKeys');
            // jQuery("#addtree").setCell(row, col, val, { background: '#ff0000' });
            jQuery("#addtree").filterToolbar({ stringResult: true, searchOnEnter: true, defaultSearch: 'cn', enableClear: false }); // si queres sacar el enableClear, definilo en las searchoptions de la columna específica http://www.trirand.com/blog/?page_id=393/help/clearing-the-clear-icon-in-a-filtertoolbar/





        }

        else {
            // pruebas para árbol usando cookie
            // con cookies no va. probar usando localstorage http://www.w3schools.com/html/html5_webstorage.asp

            //if ($.cookie("arbol") == null) {
            //    RecargarCookieArbol();
            //}

            if (localStorage.arbol == null) {
                RecargarCookieArbol();
            }

            function RecargarCookieArbol() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: ROOT + "Home/TreeGrid_ParaGrillaNoTreeviewEnLocalStorage",
                    dataType: "json",
                    success: function (data) {
                        var lala = JSON.stringify(data);
                        // $.cookie("arbol", lala, { path: '/' });
                        localStorage.arbol = lala;
                        RefrescarArbol();

                    }
                });
            }


            if (localStorage.arbol != null) {
                $("#addtree2").jqGrid({
                    //data: JSON.parse(localStorage.arbol).rows,//$.cookie("arbol"),
                    datatype: "jsonstring", // "local",  //http://stackoverflow.com/questions/6831306/load-local-json-data-in-jqgrid-without-addjsonrows
                    datastr: JSON.parse(localStorage.arbol).rows,

                    colModel: [
                        //{ name: "id", width: 1 },
                        { name: "descr", width: 180, searchoptions: { sopt: ['cn', 'eq'] } },
                        //{ name: "Name2", width: 1, hidden: true },
                        //{ name: "Name3", width: 1, hidden: true },
                        //{ name: "Name4", width: 1, hidden: true },
                        //{ name: "Name5", width: 1, hidden: true },
                    ],

                    //ignoreCase: true,

                    //loadComplete: function (data) {
                    //    refrescarFondo_addtree();

                    //    if (eslaprimeravez) {
                    //        cargarTopPositionDelArbol();
                    //        eslaprimeravez = false;
                    //    }

                    //    var gridId = $("#addtree2").attr('id');
                    //    var gridParentWidth = $('#gbox_' + gridId).parent().width();
                    //    $('#' + gridId).setGridWidth(gridParentWidth);

                    //},

                    //// pager: "#addtree2Pager",
                    //rowNum: 500,
                    ////rowList: [1, 2, 10],
                    //viewrecords: true,

                    ////autoencode: true,
                    ////gridview: true,
                    ignoreCase: true,

                    ////treeGrid: true,

                    height: "auto",


                    gridview: true,
                    rowNum: 10000,
                    ////sortname: 'id',

                    treeGrid: true,
                    treeGridModel: 'adjacency',
                    treedatatype: "local",
                    ExpandColumn: 'descr',


                    loadui: 'disable', // es la unica manera q encontré de sacar el cartelote "loading" q no se iba
                    jsonReader: {
                        repeatitems: false,
                        root: function (obj) { return obj; },
                        page: function () { return 1; },
                        total: function () { return 1; },
                        records: function (obj) { return obj.length; }
                    }




                });

                jQuery("#addtree2").filterToolbar({
                    stringResult: true, searchOnEnter: true,
                    defaultSearch: 'cn',
                    enableClear: false
                });

            }
        }


    }








    if (bEstadoNodos) {




        $grid.jqGrid('navButtonAdd', '#paddtree', {
            caption: "",
            buttonicon: "ui-icon-closethick",
            title: "Clear saved grid's settings",
            onClickButton: function () {
                removeObjectFromLocalStorage(myColumnStateName($(this)));
                window.location.reload();
            }
        });
        $.jgrid.extend({
            expandRow: function (rc) {
                //alert('before expandNode: rowid="' + rc._id_ + '", name="' + rc.name + '"');
                updateIdsOfExpandedRows(rc._id_, true);
                return orgExpandRow.call(this, rc);
            },
            collapseRow: function (rc) {
                //alert('before collapseNode: rowid="' + rc._id_ + '", name="' + rc.name + '"');
                updateIdsOfExpandedRows(rc._id_, false);
                return orgCollapseRow.call(this, rc);
            }
        });
    }







    ///////////////////////////////////////////
    /////////////////////////////////////
    /////////////////////////////////////
<<<<<<< HEAD
    // scroll 
    //$(".ui-jqgrid").css("overflow-x", "hidden");
    //$(".ui-jqgrid-bdiv").css("overflow-x", "hidden");
=======
    // scroll  // al sacarselo a la grilla del arbol, estoy jodiendo al del resto de las grillas
    //$(".ui-jqgrid").css("overflow-x", "hidden");
    //$(".ui-jqgrid-bdiv").css("overflow-x", "hidden");




>>>>>>> 26eea8d15817db532eb626919a3399990a2e4457
    /////////////////////////////////////
    /////////////////////////////////////
    /////////////////////////////////////
    // transparente
    //$("#addtree > .ui-jqgrid tr.jqgrow").css(" background-color", "yellow !important;");
    $("#addtree > .ui-widget-content").css("background", "transparent");
    $("#gbox_addtree").css("background", "transparent");
    $("#gbox_addtree").css("border", "0");
    /////////////////////////////////////
    /////////////////////////////////////
    // http://stackoverflow.com/questions/1195374/jqgrid-change-theme
    //     $('#myGrid .ui-widget').addClass('jqgrid-widget');
    $('#addtree .ui-widget-content').addClass('jqgrid-widget-content');



    function refrescarFondo_addtree() {

        $('#addtree .ui-widget-content').addClass('jqgrid-widget-content');
        $('#addtree2 .ui-widget-content').addClass('jqgrid-widget-content');

    }



    ///////////////////
    // para borrar el encabezado
    var gview = $("#addtree").parents("div.ui-jqgrid-view");
    gview.children("div.ui-jqgrid-hdiv").hide();



////////////////











    RefrescarArbol();  //creo que cuando es "local", hay que forzar la carga, no hay autoload http://www.trirand.com/jqgridwiki/doku.php?id=wiki%3aretrieving_data#array_data
})













/* Remove jquery-ui styles from jqgrid */
function estiloArbol() {
    $('#addtree .ui-widget-content').addClass('jqgrid-widget-content');

    $("#addtree").find(".jqgfirstrow").hide(); //borra el renglon fantasma de la pantalla, parece un bug de la jqgrid http://www.trirand.com/blog/?page_id=393/help/updatecolumns-deprecated-in-3-8-is-there-a-replacement-to-fix-header-widthing-issue-1
}

/* Remove jquery-ui styles from jqgrid */
function removeJqgridUiStyles() {
    $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
    $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
    $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
    $(".ui-jqgrid-pager").removeClass("ui-state-default");
}

///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////





function armarMenu() {

    if (!bCARGAR_MENU) return;

    // https: //github.com/twitter/bootstrap/issues/160
    //                http: //stackoverflow.com/questions/9758587/twitter-bootstrap-multilevel-dropdown-menu
    // http: //wiki.pixelpress.com.au/2012/07/23/bootstrap-3rd-level-navbar-dropdowns/
    $.post(ROOT + "Home/Menu", null, function (data) {
        var menu_html = '';

        // menu_html += '   <li class="pull-left">  &nbsp  </li>'; // para agregar un margen a la izquierda

        var longitud = 0





        if (!data) return;


        for (var i = 0; i < data.length; i++) {



            if (longitud > 0) {
                if (longitud - data[i].IdItem.split("-").length == 1) { menu_html += '</ul></li>' }
                if (longitud - data[i].IdItem.split("-").length == 2) { menu_html += '</ul></li></ul></li>' }
                if (longitud - data[i].IdItem.split("-").length == 3) { menu_html += '</ul></li></ul></li></ul></li>' }
                // if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
                if (longitud - data[i].IdItem.split("-").length >= 4) { menu_html += '</ul></li></ul></li></ul></li>' }


                if (data[i - 1].EsPadre == "SI" && (longitud == data[i].IdItem.split("-").length)) { menu_html += '</ul></li>' }
            }



            //if (longitud > 0) {
            //    if (longitud - data[i].IdItem.length == 3) { menu_html += '</ul></li>' }
            //    if (longitud - data[i].IdItem.length == 6) { menu_html += '</ul></li></ul></li>' }
            //    if (longitud - data[i].IdItem.length == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
            //    if (longitud - data[i].IdItem.length == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
            //}





            //if (data[i].EsPadre == "SI" && longitud - data[i].IdItem.length < 12) {

            //    if (data[i].Link.length > 0) {
            //        menu_html += '<li><span class="folder" id="' + data[i].Clave + '"><strong>' + data[i].Link + '</strong></span><ul>'
            //    }
            //    else {
            //        menu_html += '<li><span class="folder" id="' + data[i].Clave + '">' + data[i].Descripcion + '</span><ul>'
            //    }

            //}
            //else {
            //    if (data[i].Link.length > 0) {
            //        menu_html += '<li><span class="leaf country" id="' + data[i].Clave + '">' + data[i].Link + '</span>' + '</li>'
            //    }
            //    else {
            //        menu_html += '<li><span class="leaf country" id="' + data[i].Clave + '">' + data[i].Descripcion + '</span></li>'
            //    }
            //}



            if (data[i].EsPadre == "SI") {
                if (data[i].ParentId == "") {
                    menu_html += '<li class="dropdown pull-left " name="MenusesPronto" ><a href="#" data-toggle="dropdown" class="dropdown-toggle  pull-left ">' + data[i].Descripcion
                    // + ' <b class="caret"></b>'
                    + '</a><ul class="dropdown-menu" id="444' + i + '">'
                }
                else {
                    menu_html += '<li class="dropdown-submenu " name="MenusesPronto"><a href="#">' + data[i].Descripcion + '</a><ul class="dropdown-menu" id="444' + i + '">'
                }
            }
            else {
                try {
                    if (data[i].Link.length > 0) {
                        menu_html += '<li>' + data[i].Link + '</li>'
                    }
                    else {
                        menu_html += '<li><a href="#">' + data[i].Descripcion + '</a></li>'
                    }
                } catch (e) {
                    menu_html += '<li><a href="#">' + data[i].Descripcion + '</a></li>'

                }


            }



            //longitud = data[i].IdItem.length;
            longitud = data[i].IdItem.split("-").length;
        }



        //if (longitud > 0) {
        //    if (longitud - 2 == 3) { menu_html += '</ul></li>' }
        //    if (longitud - 2 == 6) { menu_html += '</ul></li></ul></li>' }
        //    if (longitud - 2 == 9) { menu_html += '</ul></li></ul></li></ul></li>' }
        //    if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
        //}

        if (longitud > 0) {
            if (longitud == 1) { menu_html += '</ul></li>' }
            if (longitud == 2) { menu_html += '</ul></li></ul></li>' }
            if (longitud == 3) { menu_html += '</ul></li></ul></li></ul></li>' }
            //                    if (longitud - 2 == 12) { menu_html += '</ul></li></ul></li></ul></li></ul></li>' }
            if (longitud >= 4) { menu_html += '</ul></li></ul></li></ul></li>' }
        }














        menu_html += ''
        //                    $("#navigation2").empty().append(menu_html);
        //$("#navigation2").append(menu_html);
        //$("#navigation3").empty().append(menu_html);
        $("#navigation3").empty().replaceWith(menu_html);














        estiloArbol();


    });
}

