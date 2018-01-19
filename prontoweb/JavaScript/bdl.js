
var qs = (function (a) {
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i) {
        var p = a[i].split('=', 2);
        if (p.length == 1)
            b[p[0]] = "";
        else
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
})(window.location.search.substr(1).split('&'));




var ie5 = (document.getElementById && document.all);
var ns6 = (document.getElementById && !document.all);
var custWindowOpen = false;
var ListWindowOpen = false;
var xMouse = 0;
var yMouse = 0;
var deltaX = 5;
var deltaY = 10;

function ListenMouse() {
    document.onmousemove = getMouseMove;
}

function OpenListItems() {
    if (ListWindowOpen)
        CloseListItems();
    var el = document.getElementById("ListItems");
    if (ie5) {
        xMouse += 5;
    }
    else if (ns6) {
        xMouse = (xMouse + 5) + "px";
    }
    VisibilityChange(el, true, false);
    custWindowOpen = true;
}

function CloseListItems() {
    var el = document.getElementById("ListItems");
    VisibilityChange(el, false);
    ListWindowOpen = false;
}
function VisibilityChange(el, show, preserveCoord) {
    var visible;
    var display;
    if (show) {
        visible = "visible";
        display = "block";
        if (!preserveCoord) {
            el.style.left = xMouse;
            el.style.top = yMouse;
        }
    }
    else {
        visible = "hidden";
        display = "none";
    }
    if (ie5) {
        el.style.filter = "blendTrans(Duration=1.2)";
        el.filters[0].Apply();
        el.style.visibility = visible;
        el.style.display = display;
        el.filters[0].Play();
    } else {
        el.style.visibility = visible;
        el.style.display = display;
    }
}

function getMouseMove(e) {
    var posX;
    var posY;
    if (window.innerHeight) {
        posX = window.pageXOffset;
        posY = window.pageYOffset;
    }
    else if (document.documentElement && document.documentElement.scrollTop) {
        posX = document.documentElement.scrollLeft;
        posY = document.documentElement.scrollTop;
    }
    else if (document.body) {
        posX = document.body.scrollLeft;
        posY = document.body.scrollTop;
    }

    if (ie5) {
        xMouse = posX + event.clientX;
        yMouse = posY + event.clientY + deltaY;
    }
    else if (ns6) {
        xMouse = posX + e.clientX;
        yMouse = posY + e.clientY + deltaY + "px";
    }
}

function setIdArticulo(ddl) {
    var idArticulo = ddl[ddl.selectedIndex].value;
    document.getElementById("ctl00_ContentPlaceHolder1_HFIdArticulo").value = idArticulo;
    document.getElementById("ctl00_ContentPlaceHolder1_DVRequerimientoItem_TBIdArticulo").value = idArticulo;
}

function SetArticulo(element) {
    var textBox = document.getElementById("ctl00_ContentPlaceHolder1_DVRequerimientoItem_TBIdArticulo");
    if (element.selectedIndex != "0")
        textBox.value = element.selectedIndex;
    else
        textBox.value = " ";
}

function ValidateSelection(source, arguments) {
    var ddlArticulo = document.getElementById("ctl00_ContentPlaceHolder1_DVRequerimientoItem_DDLArticulo");
    if (ddlArticulo != null) {
        var iValue = new Number(ddlArticulo[ddlArticulo.selectedIndex].value);
        arguments.IsValid = (iValue > 0);
    }
    else {
        arguments.IsValid = false;
    }
}
function EmisionReq(id, format) {
    window.open("Emision.aspx?idReq=" + id + "&format=" + format, "requerimiento");
}


function validaB() {
    var cod = document.getElementById("ctl00_ContentPlaceHolder1_DVRequerimientoItem_TBIdArticulo").value;
    var description = document.getElementById("ctl00_ContentPlaceHolder1_DVRequerimientoItem_TBArticuloDesc").value;
    var idRubro = document.getElementById("ctl00_ContentPlaceHolder1_DVRequerimientoItem_DDLRubro").value;
    if (cod != "") {
        //return true;
        ExecuteCall("NuevoRequerimiento.aspx?cod=" + cod + "&desc=" + description + "&idRubro=" + idRubro);
    }
    else {
        if (idRubro > 0) {
            ExecuteCall("NuevoRequerimiento.aspx?idart=0&desc=" + description + "&idRubro=" + idRubro);
        }
        else {
            var re = /[^\s]{2,}/;
            if ((description.length > 0) && re.test(description))
            //return true;
                ExecuteCall("NuevoRequerimiento.aspx?idart=0&desc=" + description + "&idRubro=" + idRubro);
            else
                alert("Ingrese al menos 2 letras para buscar por descripción, el rubro o un código de artículo");
        }
    }
    return false;
}



// para mostrar el panel de popup de busqueda de articulos

function ShowBuscaArticulos(id, empresa, pt) {
    ExecuteCall("Pedido.aspx?cmd=ShowBuscaArticulos&id=" + id + "&empresaName=" + empresa, pt);
    //ExecuteCall("DocumentosAFirmar.aspx?cmd=ShowBuscaArticulos&id=" + id + "&empresaName=" + empresa, pt);
}

function closePed() {
    var el = document.getElementById("PedidoData");
    VisibilityChange(el, false, false);
    var pb = document.getElementById('bkgDark');
    pb.style.display = "none";
    pb.style.visibility = "hidden";
}







function getBaseURL() {
    var url = location.href.toLowerCase();;  // entire url including querystring - also: window.location.href;
    var baseURL = url.substring(0, url.indexOf('/', 14)); // qué quiere decir el 14? -desde dónde empieza...

    if (url.indexOf('bdlconsultores') != -1) {
        return "https://prontotesting.williamsentregas.com.ar/ProntoWilliams/";
    }
    else if (url.indexOf('prontotesting') != -1 || url.indexOf('190.12.108.166') != -1) {
        return "https://prontotesting.williamsentregas.com.ar/";
    }

    else if (url.indexOf('prontoclientes') != -1 ) {
        return "https://prontoclientes.williamsentregas.com.ar/";
    }
    else if (url.indexOf('williamsentregas') != -1) {
        return "https://prontoweb.williamsentregas.com.ar/";
    }
    else if (url.indexOf('williamsdebug') != -1) {
        return "http://190.12.108.166/williamsdebug/";
    }
    else if (url.indexOf('190.2.243.5') != -1) {
        return "http://190.2.243.5/pronto/";
    }



    if (baseURL.indexOf('http://localhost') != -1) {
        // Base Url for localhost
        var url = location.href;  // window.location.href;
        var pathname = location.pathname;  // window.location.pathname;
        var index1 = url.indexOf(pathname);
        var index2 = url.indexOf("/", index1 + 1);
        // var baseLocalUrl = url.substr(0, index2); tomo el segundo "/"
        var baseLocalUrl = url.substr(0, index1);

        return baseLocalUrl + "/";
    }
    else {
        // Root Url for domain name
        return baseURL + "/";
            }

}