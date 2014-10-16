/// <reference path="typings\jquery\jquery.d.ts" />

// http://blogs.msdn.com/b/typescript/archive/2013/01/24/interfaces-walkthrough.aspx
// Ensuring Class Instance Shape
var Person = (function () {
    function Person() {
    }
    Person.prototype.CalcularTodos = function () {
    };

    Person.prototype.CalcularItem = function () {
    };

    Person.prototype.SerializaForm = function () {
    };
    return Person;
})();
;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var getColumnSrcIndexByName = function (grid, columnName) {
    var cm = grid.jqGrid('getGridParam', 'colModel'), i = 0, index = 0, l = cm.length, cmName;
    while (i < l) {
        cmName = cm[i].name;
        i++;
        if (cmName === columnName) {
            return index;
        } else if (cmName !== 'rn' && cmName !== 'cb' && cmName !== 'subgrid') {
            index++;
        }
    }
    return -1;
};

// total del item -ok, pero para recalcular en el popup form del jqgrid, no en la celledit
function CalcularItem() {
    var pbglobal = parseFloat($("#Totales").find("#PorcentajeBonificacion").val().replace(",", ".") || 0);

    //var pbglobal = 0; //  parseFloat($("#PorcentajeBonificacion").val().replace(",", "."));
    var pb = parseFloat($("#PorcentajeBonificacion").val() || 0);
    if (isNaN(pb)) {
        pb = 0;
    }
    var pr = parseFloat($("#Importe").val());
    var cn = 1;
    var pi = parseFloat($("#IVAComprasPorcentaje1").val());
    var st = Math.round(pr * cn * 10000) / 10000;

    ///////////////////////////////////////////////////////
    //bonif item
    var ib = Math.round(st * pb / 100 * 10000) / 10000;
    st = st - ib;

    // bonif global
    var bg = Math.round(st * pbglobal / 100 * 10000) / 10000;
    st = st - bg;

    ////////////////////////////////////////////////////
    var ii = Math.round(st * pi / 100 * 10000) / 10000;
    var it = Math.round((st + ii) * 10000) / 10000;

    $("#ImporteBonificacion").val(ib.toFixed(4));
    $("#ImporteIva").val(ii.toFixed(4));
    $("#ImporteIva1").val(ii.toFixed(4));
    $("#ImporteTotalItem").val(it.toFixed(4));
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//# sourceMappingURL=FondoFijo.js.map
