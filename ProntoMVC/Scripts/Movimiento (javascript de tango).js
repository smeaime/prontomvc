var renderError = 0;
var discriminaIVA = false;
var permiteAgregarRenglones = true;
var inputValue = 0;
var indexValue = 0;
var lockWindowsProccess = 0;
var esCreditoDebito = false;
var movimientoReferenciado = false;
var _puntoVentaElectronico = false;

function NoPermiteAgregarRenglones() {
    ConsoleWriteStart("NoPermiteAgregarRenglones");
    permiteAgregarRenglones = false;
    $("#divRowButtonsAdd").hide();
    $("#divRowButtonsAddImpuesto").hide();
    $(".divConceptoID > div > div").hide();
    $(".divConceptoID > div > input:text").width(284);

    ConsoleWriteDown("NoPermiteAgregarRenglones");
}

function PermitirAgregarRenglones() {
    ConsoleWriteStart("PermitirAgregarRenglones");
    permiteAgregarRenglones = true;
    $("#divRowButtonsAdd").show();
    $("#divRowButtonsAddImpuesto").show();
    ConsoleWriteDown("PermitirAgregarRenglones");
}

function getDetalleRenglon(rowIdName) {
    ConsoleWriteStart("getDetalleRenglon");
	var obj = "";

	var container = $(rowIdName + ' input,textarea').each(function (i, e) {
		var name = $(e).attr("name");
		var finalname = name.split(".")[1];
		var value = $(e).val();
		obj = obj + finalname + "=" + value + "&";
	});
    ConsoleWriteDown("getDetalleRenglon");
	return obj.toString();
}

function DisabledBtnAdd() {
    ConsoleWriteStart("DisabledBtnAdd");
	DisabledControl($('#btnNuevoDetalleMovimiento'));
	DisabledControl($('#btnNuevoImpuesto'));
	ConsoleWriteDown("DisabledBtnAdd");
}

function EnabledBtnAdd() {
    ConsoleWriteStart("EnabledBtnAdd");
	if (permiteAgregarRenglones) {
		EnabledControl($('#btnNuevoDetalleMovimiento'));
		EnabledControl($('#btnNuevoImpuesto'));
    }
    ConsoleWriteDown("EnabledBtnAdd");
}

function inputFocusin(e, index) {
    ConsoleWriteStart("inputFocusin");
	inputValue = $(e).attr('value');
	indexValue = index;
	ConsoleWriteDown("inputFocusin");
}

function inputChange(value, index) {
    ConsoleWriteStart("inputChange");
	if ((inputValue == value) && (indexValue == index)) {
		return false;
	}
	else {
		return true;
    }
    ConsoleWriteDown("inputChange");
}

function getElementsByClassName(searchClass, domNode, tagName) {
    ConsoleWriteStart("getElementsByClassName");
	if (domNode == null) domNode = document;
	if (tagName == null) tagName = '*';
	var el = new Array();
	var tags = domNode.getElementsByTagName(tagName);
	var tcl = " " + searchClass + " ";

	for (i = 0, j = 0; i < tags.length; i++) {
		var test = " " + tags[i].className + " ";
		if (test.indexOf(tcl) != -1) {
			el[j++] = tags[i];
		}
    }
    ConsoleWriteDown("getElementsByClassName");
	return el; 
}

function inicioEnvio() {
    if (esCreditoDebito) {
        ShowProgress();
    }
}

function actualizarRenglon(rowId, e) {
    ConsoleWriteStart("actualizarRenglon");
    $('#DetalleMovimiento_' + rowId + '__DetalleMovimientoImporteBonificado').attr("value", e.detalleMovimientoImporteBonificado);
	$('#DetalleMovimiento_' + rowId + '__DetalleMovimientoCantidad').attr("value", e.detalleMovimientoCantidad);
	$('#DetalleMovimiento_' + rowId + '__DetalleMovimientoImporteTotal').attr("value", e.detalleMovimientoImporteTotal);
	$('#DetalleMovimiento_' + rowId + '__DetalleMovimientoImporteUnitario').attr("value", e.detalleMovimientoImporteUnitario);
	$('#DetalleMovimiento_' + rowId + '__DetalleMovimientoImporteBase').attr("value", e.detalleMovimientoImporteBase);
	$('#DetalleMovimiento_' + rowId + '__DetalleMovimientoImporteSubtotal').attr("value", e.detalleMovimientoImporteSubtotal);
	ConsoleWriteDown("actualizarRenglon");
}

function actualizarTotales(e) {    
    ConsoleWriteStart("actualizarTotales");
	$('#OtrosImpuestos').attr('value', e.movimientoTotalOtrosImpuestos);
	$('#SubTotalImporte').attr('value', e.movimientoSubtotalImporte);
	$('#MovimientoTotalImporte').attr('value', e.movimientoTotalImporte);		
	$("#hTitleTotal").html('Total $ ' + ((e.movimientoTotalImporte != undefined) ? e.movimientoTotalImporte : "0,00"));
	$('#MovimientoTotalOtrosImpuestos').attr('value', e.movimientoTotalOtrosImpuestos);
	$('#MovimientoTotalIva').attr('value', e.movimientoTotalIva);
	$('#MovimientoSubtotalImporte').attr('value', e.movimientoSubtotalImporte);
	$('#TotalDescuento').attr('value', e.movimientoTotalDescuento);
	$('#TotalRecargo').attr('value', e.movimientoTotalRecargo);
	ConsoleWriteDown("actualizarTotales");
}

function ExecuteChangeTipoMovimiento(sUrl) {
    ConsoleWriteStart("ExecuteChangeTipoMovimiento");
	var aVal = $("#TipoMovimientoID").attr('value');
	var aValDD = $("#TipoMovimientoIDdropdown").attr("value");
	$("#TipoMovimientoIDdropdown").attr("value", aVal);
	var model = $("#FormComprobante form").serialize();
	$("#TipoMovimientoIDdropdown").attr("value", aValDD);

	$.ajax({
	    type: "POST",
	    data: model,
	    url: sUrl,
	    success: function (e) {
	        ConsoleWriteBeginSuccess("ExecuteChangeTipoMovimiento");
	        $("#DivDetallesComprobante").empty().append(e.renglones);
	        ShowImportes();
	        $("#DivImpuestosGlobales").html(e.ImpuestoGlobal);
	        $("#Observaciones").attr("value", e.leyenda);
	        ConsoleWriteEndSuccess("ExecuteChangeTipoMovimiento");
	    }
	});
	ConsoleWriteDown("ExecuteChangeTipoMovimiento");
}


//Actualizar todos los importes y totales del movimiento
function ActualizarTotalesMovimiento(urlActualizarTotalesMovimiento) {
    ConsoleWriteStart("ActualizarTotalesMovimiento");
	var parametro = $("#FormComprobante form").serialize();

	$.ajax({
		type: "POST",
		url: urlActualizarTotalesMovimiento,
		data: parametro,
		success: function (e) {
		    ConsoleWriteBeginSuccess("ActualizarTotalesMovimiento");
		    $("#DivDetallesComprobante").empty().append(e.renglones);
			$("#DivImpuestosGlobales").html(e.ImpuestoGlobal);
			ShowImportes();
			actualizarTotales(e);
			actualizarDetalleOtrosImpuestos(e);
			EnablePanelButtons();
			ConsoleWriteEndSuccess("ActualizarTotalesMovimiento");
		},
		error: function (e) {
			EnablePanelButtons();
		}
    });
    ConsoleWriteDown("ActualizarTotalesMovimiento");
}

//Calculo total, solo totales.
function CalcularTotal(urlCalculoTotal) {
    ConsoleWriteStart("CalcularTotal");
	var parametro = $("#FormComprobante form").serialize();
	$.ajax({
		type: "POST",
		url: urlCalculoTotal,
		data: parametro,
		success: function (e) {
		    ConsoleWriteBeginSuccess("CalcularTotal");
			ShowImportes();
			actualizarTotales(e);
			actualizarDetalleOtrosImpuestos(e);
			EnablePanelButtons();
			ConsoleWriteEndSuccess("CalcularTotal");
		},
		error: function (e) {
			EnablePanelButtons();
		}
    });
    ConsoleWriteDown("CalcularTotal");
}

function ActualizarDetalleImpuestoRenglon(rowid, e) {
    ConsoleWriteStart("ActualizarDetalleImpuestoRenglon");
    $("#detimpuesto_" + rowid).html(e.detalleMovimientoDetalleImpuestoView);
    ConsoleWriteDown("ActualizarDetalleImpuestoRenglon");
}

//DetalleMovimiento
function CalculoTotalRenglon(rowId, calculoTotalUrl) {
    ConsoleWriteStart("CalculoTotalRenglon");
	$('#DetalleMovimiento_' + rowId + '__Actualizando').attr('value', 'True');
	var parametro = $("#FormComprobante form").serialize();

	if ($('#DetalleMovimiento_' + rowId + '__DetalleMovimientoCantidad').attr('value') != 0) {
	    $.ajax({
	        type: "POST",
	        url: calculoTotalUrl,
	        data: parametro,
	        success: function (e) {
	            ConsoleWriteBeginSuccess("CalculoTotalRenglon");
	            $('#DetalleMovimiento_' + rowId + '__Actualizando').attr('value', 'False');
	            actualizarRenglon(rowId, e);
	            actualizarTotales(e);
	            actualizarDetalleOtrosImpuestos(e);
	            actualizarImpuestoGlobales(e);
	            ShowImportes();
	            EnablePanelButtons();
	            ActualizarDetalleImpuestoRenglon(rowId, e);
	            ConsoleWriteEndSuccess("CalculoTotalRenglon");
	        },
	        error: function (e) {
	            $('#DetalleMovimiento_' + rowId + '__Actualizando').attr('value', 'False');
	        }
	    });
    }
    ConsoleWriteDown("CalculoTotalRenglon");
}

function GetDataDetalle(rowId, urlGetDetalleMovimientoData) {
    if (!movimientoReferenciado) {
        ConsoleWriteStart("GetDataDetalle");
        DisablePanelButtons();
        $('#DetalleMovimiento_' + rowId + '__ClienteID').attr('value', $('#ClienteID').val());
        $('#DetalleMovimiento_' + rowId + '__TipoMovimientoID').attr('value', $('#TipoMovimientoID').val());

        $('#DetalleMovimiento_' + rowId + '__Actualizando').attr('value', 'True');
        var parametro = $("#FormComprobante form").serialize();

        $.ajax({
            type: "POST",
            data: parametro,
            url: urlGetDetalleMovimientoData,
            success: function (e) {
                ConsoleWriteBeginSuccess("GetDataDetalle");
                $('#DetalleMovimiento_' + rowId + '__ConceptoID').attr("value", e.conceptoId);
                $('#DetalleMovimiento_' + rowId + '__LegalUnidadMedidaID').attr("value", e.legalUnidadMedidaID);
                $('#DetalleMovimiento_' + rowId + '__DetalleMovimientoDescripcion').attr("value", e.conceptoDescripcion);
                $('#ldDetalleMovimiento_' + rowId + '__ConceptoID').attr("value", e.conceptoDescripcion);
                $('#DetalleMovimiento_' + rowId + '__DetalleMovimientoDescripcionAux').attr("value", e.conceptoDescripcion);
                $('#DetalleMovimiento_' + rowId + '__DescripcionAmpliada').attr("value", e.conceptoDescripcionAmpliada);
                $('#DetalleMovimiento_' + rowId + '__DetalleMovimientoCodigo').attr("value", e.conceptoCodigo);

                if ($('#DetalleMovimiento_' + rowId + '__DetalleMovimientoCantidad').attr('value') != 0) {
                    $('#DetalleMovimiento_' + rowId + '__Actualizando').attr('value', 'False');
                    actualizarRenglon(rowId, e);
                    actualizarTotales(e);
                    actualizarDetalleOtrosImpuestos(e);
                    actualizarImpuestoGlobales(e);
                    ShowImportes();
                    EnablePanelButtons();
                    ActualizarDetalleImpuestoRenglon(rowId, e);
                }

                ConsoleWriteEndSuccess("GetDataDetalle");
            }
        });
        ConsoleWriteDown("GetDataDetalle");
    }
}

//DetalleImpuestoTotal
function calcularRenglonImpuestoGlobal(rowId, urlCalculoTotalMovimientoPorRenglonDeImpuesto) {
    ConsoleWriteStart("calcularRenglonImpuestoGlobal");
	$('#TotalImpuesto_' + rowId + '__Actualizando').attr('value', 'True');
	var parametro = $("#FormComprobante form").serialize();

	$.ajax({
	    type: "POST",
	    url: urlCalculoTotalMovimientoPorRenglonDeImpuesto,
	    data: parametro,
	    success: function (e) {
	        ConsoleWriteBeginSuccess("calcularRenglonImpuestoGlobal");
	        var objJson = e.listaImpuestos;

	        for (var i = 0; i < objJson.length; i++) {
	            $('#TotalImpuesto_' + objJson[i].id + '__TotalImpuestoImporte').attr("value", objJson[i].importe);
	            $('#TotalImpuesto_' + objJson[i].id + '__TotalImpuestoBaseImponible').attr("value", objJson[i].baseImponible);
	        }

	        $('#TotalImpuesto_' + rowId + '__Actualizando').attr('value', 'False');
	        $('#TotalImpuesto_' + rowId + '__TotalImpuestoImporte').attr("value", e.TotalImpuestoImporte);
	        $('#TotalImpuesto_' + rowId + '__TotalImpuestoBaseImponible').attr("value", e.Baseimponible);
	        ShowImportes();
	        actualizarTotales(e);
	        actualizarDetalleOtrosImpuestos(e);
	        EnablePanelButtons();
	        ConsoleWriteEndSuccess("calcularRenglonImpuestoGlobal");
	    },
	    error: function (e) {
	        $('#TotalImpuesto_' + rowId + '__Actualizando').attr('value', 'False');
	        EnablePanelButtons();
	    }
	});
    ConsoleWriteDown("calcularRenglonImpuestoGlobal");
}

function GetDataImpuesto(rowid, urlGetImpuestoData, urlCalculoTotalMovimientoPorRenglonDeImpuesto) {
    ConsoleWriteStart("GetDataImpuesto");
	DisablePanelButtons();

	$("#TotalImpuesto_" + rowid + "__Actualizando").attr("value", "True");    

	var parametro = $("#FormComprobante form").serialize();

	$.ajax({
		type: "POST",
		data: parametro,
		url: urlGetImpuestoData,
		success: function (e) {
		    ConsoleWriteBeginSuccess("GetDataImpuesto");
			$("#TotalImpuesto_" + rowid + "__Actualizando").attr("value", "False");
			$("#TotalImpuesto_" + rowid + "__Id").attr("value", e.Id);
			$("#TotalImpuesto_" + rowid + "__Impuesto_Id").attr("value", e.Impuesto_Id);
			$("#TotalImpuesto_" + rowid + "__ImpuestoID").attr("value", e.ImpuestoId);
			$("#TotalImpuesto_" + rowid + "__Impuesto_TipoImpuestoID").attr("value", e.ImpuestoTipoImpuestoId);
			$("#TotalImpuesto_" + rowid + "__Impuesto_TipoImpuesto_Id").attr("value", e.ImpuestoTipoImpuesto_Id);
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoBaseImponible").attr("value", e.Impuesto_BaseCalculo);
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoAlicuota").attr("value", e.Impuesto_Alicuota);
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoImporte").attr("value", e.Impuesto_ImporteCalculo);
			calcularRenglonImpuestoGlobal(rowid, urlCalculoTotalMovimientoPorRenglonDeImpuesto);
			DisableControlsImporteFijo(rowid, e.Impuesto_TipoBaseCalculo);
			ConsoleWriteEndSuccess("GetDataImpuesto");
		}
	});
    ConsoleWriteDown("GetDataImpuesto");
}

function DisableControlsImporteFijo(rowid, Impuesto_TipoBaseCalculo) {
    ConsoleWriteStart("DisableControlsImporteFijo");
	$("#TotalImpuesto_" + rowid + "__TotalImpuestoBaseImponible").attr("readonly", "");
	$("#TotalImpuesto_" + rowid + "__TotalImpuestoAlicuota").attr("readonly", "");
	$("#TotalImpuesto_" + rowid + "__TotalImpuestoImporte").attr("readonly", "readonly");

	switch (Impuesto_TipoBaseCalculo) {
		case 0: //automatico
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoBaseImponible").attr("readonly", "readonly");
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoAlicuota").attr("disabledreadonly", "");
			break;
		case 1: //manual
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoBaseImponible").attr("readonly", "");
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoAlicuota").attr("readonly", "");
			break;
		case 2: //importeFijo
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoBaseImponible").attr("readonly", "readonly");
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoAlicuota").attr("readonly", "readonly");
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoImporte").attr("readonly", "");
			break;
		default:
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoBaseImponible").attr("readonly", "");
			$("#TotalImpuesto_" + rowid + "__TotalImpuestoAlicuota").attr("readonly", "");
			break;
    }
    ConsoleWriteDown("DisableControlsImporteFijo");
}

function actualizarDetalleOtrosImpuestos(e) {
    ConsoleWriteStart("actualizarDetalleOtrosImpuestos");
    $("#DivTotalOtrosImpuestos").html(e.otrosImpuestosView);
    setTimeout(function () {
        if (permiteAgregarRenglones) {
            PermitirAgregarRenglones();
        }
        else {
            NoPermiteAgregarRenglones();
        }
    }, 100);

    ConsoleWriteDown("actualizarDetalleOtrosImpuestos");
}
function actualizarImpuestoGlobales(e) {
    ConsoleWriteStart("actualizarImpuestoGlobales");
    $("#DivImpuestosGlobales").html(e.impuestoGlobalesView);
    ConsoleWriteDown("actualizarImpuestoGlobales");
}

function updateDatosMovimiento(updateurl) {
    ConsoleWriteStart("updateDatosMovimiento");
	var parametro = $("#FormDatosMovimiento form").serialize();
	$.ajax({
	    type: 'POST',
	    url: updateurl,
	    data: parametro,
	    cache: false,
	    success: function (data) {
	        ConsoleWriteBeginSuccess("updateDatosMovimiento");
	        actualizarDatosCliente(data);
	        actualizarDatosDomicilio(data);
	        ConsoleWriteEndSuccess("updateDatosMovimiento");
	    }
	});
    ConsoleWriteDown("updateDatosMovimiento");
}

function updateDatosDomicilio(updateurl) {
    ConsoleWriteStart("updateDatosDomicilio");
	var parametro = $("#FormDatosMovimientoDomicilio form").serialize();
	$.ajax({
		type: 'POST',
		url: updateurl,
		data: parametro,
		cache: false,
		success: function (data) {
		    ConsoleWriteBeginSuccess("updateDatosDomicilio");
			actualizarDatosDomicilio(data);
			ConsoleWriteEndSuccess("updateDatosDomicilio");
		}
    });
    ConsoleWriteDown("updateDatosDomicilio");
}

function addBillItem(addurl) {
    ConsoleWriteStart("addBillItem");
	DisabledBtnAdd();
	var parametro = $("#FormComprobante form").serialize();
	$.ajax({
	    type: 'POST',
        async: false,
		url: addurl,
		data: parametro,
		cache: false,
		success: function (html) {
		    ConsoleWriteBeginSuccess("addBillItem");
			$("#editorRows").append(html);
			ShowImportes();
			aplicarClases();
			EnabledBtnAdd();
			resizeWindowsIE7();
			ConsoleWriteEndSuccess("addBillItem");
		}
    });
    ConsoleWriteDown("addBillItem");	
}

function addImpuestoItem(addurl) {
    ConsoleWriteStart("addImpuestoItem");
	DisabledBtnAdd();    
	var parametro = $("#FormComprobante form").serialize();
	$.ajax({
		type: 'POST',
		url: addurl,
		data: parametro,
		cache: false,
		success: function (html) {
		    ConsoleWriteBeginSuccess("addImpuestoItem");
			$("#editorRowsImpuesto").append(html);
			ShowImportes();
			aplicarClases();
			EnabledBtnAdd();
			resizeWindowsIE7();
			ConsoleWriteEndSuccess("addImpuestoItem");
		}
    });
    ConsoleWriteDown("addImpuestoItem");
}

function actualizarDatosComprobante(data) {
    ConsoleWriteStart("actualizarDatosComprobante");
	if (data != null) {
	    $("#ldClienteID").attr("value", data.razonSocial);
	    $("#hTitleCliente").html(data.razonSocial);
		
		if (renderError == 0) {
		    actualizarDatosDomicilio(data);
		    $("#DatosMovimiento_DatosMovimientoCodigoCliente").attr("value", data.codigo);
			$("#DatosMovimiento_DatosMovimientoRazonSocial").attr("value", data.razonSocial);
			$("#DatosMovimiento_DatosMovimientoTipoDocumentoID").attr("value", data.tipoDoc);
			$("#DatosMovimiento_DatosMovimientoNumeroDocumento").attr("value", data.numDoc);
			$("#DatosMovimiento_PerfilImpositivoID").attr("value", data.perfilImpositivoID);
			$("#DatosMovimiento_DatosMovimientoLegalTipoResponsableCodigo").attr("value", data.legalTipoResponsableCodigo);
			$("#DatosMovimiento_DatosMovimientoCorreoElectronicoCliente").attr("value", data.mail);

			$("#PublicarComprobanteEnPortal").removeClass("ComprobantePublicar");
			if (data.clientePublicaEnPortal === "1") {
			    $("#PublicarComprobanteEnPortal").addClass("ComprobantePublicar");
			}

			discriminaIVA = data.discriminaIVA;
			ActualizarRenglones(data.id);

			if (parseFloat($('#MovimientoTotalImporte').attr('value').replace(',', '.')) > 0) {    			    
				CalcularTotal($('#CalculoTotalComprobante').attr('value'));
			}            
		}
	} 
	
	renderError = 0;
	ConsoleWriteDown("actualizarDatosComprobante");
}

function ActualizarRenglones(clienteId) {
    ConsoleWriteStart("ActualizarRenglones");
	var surl = $('#ActualizarRenglones').attr('value');
	var parametro = $("#FormComprobante form").serialize();

	$.ajax({
	    async: !esCreditoDebito,
		type: 'POST',
		url: surl,
		data: parametro,
		cache: false,
		success: function (data) {
		    ConsoleWriteBeginSuccess("ActualizarRenglones");
			$("#DivDetallesComprobante").empty().append(data.renglones);
			$('#MovimientoDiscriminaIVA').attr('value', data.movimientoDiscriminaIVA);
			ShowImportes();

			$("#NumeradorID").attr('value', data.talonarioid);	        
			$("#MovimientoLetra").attr('value', data.talonarioLetra);
			$("#NumeradorIDdropdown option[value='" + data.talonarioid + "']").attr('selected', 'selected');

			//getProximoNumeroComprobante('/ERP/Movimientos/ActualizarTotalesMovimiento');
			actualizarNumeroTalonario(data.dataTalonario.Data);
			$('#MovimientoDiscriminaIVA').attr('value', data.dataTalonario.Data.movimientoDiscriminaIVA);
			$("#MovimientoLetra").attr('value', data.dataTalonario.Data.letra);
			$("#DivDetallesComprobante").empty().append(data.dataTalonario.Data.renglones);
			$("#DivImpuestosGlobales").html(data.dataTalonario.Data.ImpuestoGlobal);
			$('#licenseInfo').html(data.dataTalonario.Data.licenseEntityInfo);
			actualizarTotales(data.dataTalonario.Data);
			actualizarDetalleOtrosImpuestos(data.dataTalonario.Data);
			ShowImportes();
			EnablePanelButtons();
			ConsoleWriteEndSuccess("ActualizarRenglones");
		}
    });
    ConsoleWriteDown("ActualizarRenglones");
}

function ShowImportes() {
    ConsoleWriteStart("ShowImportes");
	var discrimina = ($('#MovimientoDiscriminaIVA').attr('value').toUpperCase() == 'TRUE');
	if (discrimina) {
		if (discriminaIVA) {
			$('.impBaseRenglon').show();
			$('.impUnitarioRenglon').hide();
			$('.impSubTotal').show();
			$('.impTotal').hide();
		}
		else {
			$('.impBaseRenglon').hide();
			$('.impUnitarioRenglon').show();
			$('.impSubTotal').hide();
			$('.impTotal').show();
		}
	}
	else {
		$('.impBaseRenglon').hide();
		$('.impUnitarioRenglon').show();
		$('.impSubTotal').hide();
		$('.impTotal').show();
	}
    ConsoleWriteDown("ShowImportes");
}

function actualizarDatosCliente(data) {
    ConsoleWriteStart("actualizarDatosCliente");
    $("#DatosMovimiento_DatosMovimientoCodigoCliente").attr("value", data.codigo);
	$("#DatosMovimiento_DatosMovimientoRazonSocial").attr("value", data.razonSocial);
	$("#DatosMovimiento_DatosMovimientoTipoDocumentoID").attr("value", data.tipoDocumentoId);
	$("#DatosMovimiento_DatosMovimientoNumeroDocumento").attr("value", data.numeroDocumento);
	$("#DatosMovimiento_DatosMovimientoCorreoElectronicoCliente").attr("value", data.mail);

	ConsoleWriteDown("actualizarDatosCliente");
}

function actualizarDatosDomicilio(data) {
    ConsoleWriteStart("actualizarDatosDomicilio");
	$("#DatosMovimiento_DatosMovimientoCalle").attr("value", data.calle);
	$("#DatosMovimiento_DatosMovimientoNumero").attr("value", data.numero);
	$("#DatosMovimiento_DatosMovimientoEdificio").attr("value", data.edificio);
	$("#DatosMovimiento_DatosMovimientoPiso").attr("value", data.piso);
	$("#DatosMovimiento_DatosMovimientoDepartamento").attr("value", data.departamento);
	$("#DatosMovimiento_DatosMovimientoLocalidad").attr("value", data.localidad);
	$("#DatosMovimiento_DatosMovimientoCodigoPostal").attr("value", data.cp);
	$("#DatosMovimiento_DatosMovimientoProvinciaID").attr("value", data.provinciaid);
	ConsoleWriteDown("actualizarDatosDomicilio");
}

function ClearDatosCliente() {
    ConsoleWriteStart("ClearDatosCliente");
    $("#DatosMovimiento_DatosMovimientoCodigoCliente").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoRazonSocial").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoTipoDocumentoID").attr("value", "0");
    $("#DatosMovimiento_DatosMovimientoNumeroDocumento").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoCalle").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoNumero").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoEdificio").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoPiso").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoDepartamento").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoLocalidad").attr("value", "");
    $("#DatosMovimiento_DatosMovimientoCodigoPostal").attr("value", "");
    ConsoleWriteDown("ClearDatosCliente");
}

function onChangeLegalConcepto(tipo) {
    ConsoleWriteStart("onChangeLegalConcepto");
	$("#MovimientoDesdeFecha").attr('readonly', 'readonly');
	$("#MovimientoHastaFecha").attr('readonly', 'readonly');
	$("#MovimientoDesdeFecha").datepicker("disable");
	$("#MovimientoHastaFecha").datepicker("disable");

	if ((tipo == 2) || (tipo == 3)) {
		$("#MovimientoDesdeFecha").attr("readonly", "");
		$("#MovimientoHastaFecha").attr("readonly", "");
		$("#MovimientoDesdeFecha").datepicker("enable");
		$("#MovimientoHastaFecha").datepicker("enable");
	}
	if ((tipo == 1) || (tipo == 2)) {
		//$("#editorRows").empty();
		$("#editorRowsImpuesto").empty();
		$("#DivTotalOtrosImpuestos").empty();
		$('#OtrosImpuestos').attr('value', "0,00");
		$('#SubTotalImporte').attr('value', "0,00");
		$('#MovimientoTotalImporte').attr('value', "0,00");
		$("#hTitleTotal").html('Total $ ' + "0,00");
		$('#MovimientoTotalOtrosImpuestos').attr('value', "0,00");
		$('#MovimientoTotalIva').attr('value', "0,00");
		$('#MovimientoSubtotalImporte').attr('value', "0,00");
		$('#TotalDescuento').attr('value', "0,00");
		$('#TotalRecargo').attr('value', "0,00"); 
		$(".classAddDetalleRenglon").click();
	}
    ConsoleWriteDown("onChangeLegalConcepto");
}

function onchangeDomicilio(valor) {
    ConsoleWriteStart("onchangeDomicilio");
	$.ajax({
		type: "GET",
		url: "/ERP/Movimientos/ResolverDomicilio/" + valor,
		success: function (e) {
		    ConsoleWriteBeginSuccess("onchangeDomicilio");
			actualizarDatosDomicilio(e);
			ConsoleWriteEndSuccess("onchangeDomicilio");
		}
    });
    ConsoleWriteDown("onchangeDomicilio");
}


function loadMovimientoData(urlLoadData, movimientoId) {
    ConsoleWriteStart("loadMovimientoData");
    movimientoReferenciado = true;
    $.ajax({
        async: !esCreditoDebito,
        beforeSend: inicioEnvio,
		type: "GET",
		url: urlLoadData + "/" + movimientoId,
		success: function (e) {
		    ConsoleWriteBeginSuccess("loadMovimientoData");
			refreshData(e);
			actualizarNumeroTalonario(e);
			ConsoleWriteEndSuccess("loadMovimientoData");
		}
    });
    ConsoleWriteDown("loadMovimientoData");
}

function loadMovimientoDataForDebit(urlLoadData, movimientoId) {
    ConsoleWriteStart("loadMovimientoDataForDebit");
	$.ajax({
		type: "GET",
		url: urlLoadData + "/" + movimientoId,
		success: function (e) {
		    ConsoleWriteBeginSuccess("loadMovimientoDataForDebit");
			refreshDebitData(e);
			ConsoleWriteEndSuccess("loadMovimientoDataForDebit");
		}
    });
    ConsoleWriteDown("loadMovimientoDataForDebit");
}

function disabledControls() {
    ConsoleWriteStart("disabledControls");
    disabledHeadeControls();
    ConsoleWriteDown("disabledControls");
}

function enableControls() {
    ConsoleWriteStart("enableControls");
    enableHeaderControls();
    ConsoleWriteDown("enableControls");
}

function disabledHeadeControls() {
    ConsoleWriteStart("disabledHeadeControls");
	$("#LegalConceptoIDdropdown").attr("disabled", "disabled");
	$("#MovimientoDesdeFecha").attr("readonly", "readonly");
	$("#MovimientoDesdeFecha").datepicker("disable");
	$("#MovimientoDesdeFecha").attr("disabled", "");
	$("#MovimientoHastaFecha").attr("readonly", "readonly");
	$("#MovimientoHastaFecha").datepicker("disable");
	$("#MovimientoHastaFecha").attr("disabled", "");
	//$("#MovimientoFechaVencimiento").attr("readonly", "readonly");
	//$("#DivEncabezadoComprobanteEdicionDatos").css("display", "none");
	$("#FormaPagoIDdropdown").attr("disabled", "disabled");
	$("#TipoMovimientoIDdropdown").attr("disabled", "disabled");
	ConsoleWriteDown("disabledHeadeControls");
}

function enableHeaderControls() {
    ConsoleWriteStart("enableHeaderControls");
	$("#LegalConceptoIDdropdown").attr("disabled", "");
	$("#MovimientoDesdeFecha").attr("readonly", "");
	$("#MovimientoDesdeFecha").datepicker("enable");
	$("#MovimientoHastaFecha").attr("readonly", "");
	$("#MovimientoHastaFecha").datepicker("enable");
	//$("#MovimientoFechaVencimiento").attr("disabled", "");
	//$("#DivEncabezadoComprobanteEdicionDatos").css("display", "block");
	$("#FormaPagoIDdropdown").attr("disabled", "");
	$("#TipoMovimientoIDdropdown").attr("disabled", "");
	ConsoleWriteDown("enableHeaderControls");
}

function refreshDebitData(data) {
    ConsoleWriteStart("refreshDebitData");
	$("#NumeradorIDdropdown option").each(function () {
		if ($(this).text() == data.numeradordescripcion) {
			$("#NumeradorID").attr("value", data.numeradorid);
			$(this).attr("selected", "selected");
		}
		else {
			$(this).attr("selected", "");
		}
	});
	$("#LegalConceptoID").attr("value", data.legalconceptoid);
	$("#LegalConceptoIDdropdown option").each(function () {
		if ($(this).text() == data.legalconceptodescripcion) {
			$(this).attr("selected", "selected");
		}
		else {
			$(this).attr("selected", "");
		}
	});
	$("#MovimientoDesdeFecha").attr("value", data.fechadesde);
	$("#MovimientoHastaFecha").attr("value", data.fechahasta);
	$("#FormaPagoID").attr("value", data.FormaPagoID);
	ConsoleWriteDown("refreshDebitData");
}

function refreshData(data) {
    ConsoleWriteStart("refreshData");
	$("#NumeradorID").attr("value", data.numeradorid);
	$("#MovimientoReferenciadoNumeradorId").attr("value", data.numeradorid);    

	$("#NumeradorIDdropdown option").each(function () {
		if ($(this).text() == data.numeradordescripcion) {
			$(this).attr("selected", "selected");
		}
		else {
			$(this).attr("selected", "");
		}
	});
	$("#MovimientoLetra").attr("value", data.numeradorLetra);

	$("#LegalConceptoID").attr("value", data.legalconceptoid);
	$("#LegalConceptoIDdropdown option").each(function () {
		if ($(this).text() == data.legalconceptodescripcion) {
			$(this).attr("selected", "selected");
		}
		else {
			$(this).attr("selected", "");
		}
	});
	$("#MovimientoDesdeFecha").attr("value", data.fechadesde);
	$("#MovimientoHastaFecha").attr("value", data.fechahasta);
	$("#FormaPagoID").attr("value", data.FormaPagoID);
	$('#MovimientoTotalImporte').attr('value', data.totalImporte);
	$("#hTitleTotal").html('Total $ ' + data.totalImporte);	
	$('#MovimientoTotalOtrosImpuestos').attr('value', data.OtrosImp);
	$('#MovimientoTotalIva').attr('value', data.TotalIva);
	$('#MovimientoSubtotalImporte').attr('value', data.Subtotal);
	ConsoleWriteDown("refreshData");
}

function loadMovimientoDetailsDataBlank(urlLoadData) {
    ConsoleWriteStart("loadMovimientoDetailsDataBlank");
    
    //$("[id^='tdDelete_'] > div > a > img").click();

    $("#DivDetallesComprobante").empty();
    $("#countRowBill").val("-1");
    movimientoReferenciado = false;

	var parametro = $("#FormComprobante form").serialize();
	$.ajax({
	    async: !esCreditoDebito,
	    type: "POST",
	    url: urlLoadData,
	    data: parametro,
	    success: function (data) {
	        ConsoleWriteBeginSuccess("loadMovimientoDetailsDataBlank");
	        $('#MovimientoTotalImporte').attr('value', '0,00');
	        $("#hTitleTotal").html('Total $ ' + '0,00');
	        $('#MovimientoTotalOtrosImpuestos').attr('value', '0,00');
	        $('#MovimientoTotalIva').attr('value', '0,00');
	        $('#MovimientoSubtotalImporte').attr('value', '0,00');
	        ActualizarDataComprobante(data);
	        ConsoleWriteEndSuccess("loadMovimientoDetailsDataBlank");
	    }
	});
    ConsoleWriteDown("loadMovimientoDetailsDataBlank");
}

function loadMovimientoDetailsData(urlLoadData, movimientoId) {
    ConsoleWriteStart("loadMovimientoDetailsData");
    $.ajax({
        async: !esCreditoDebito,
		type: "GET",
		url: urlLoadData + "/" + movimientoId,
		success: function (data) {
		    ConsoleWriteBeginSuccess("loadMovimientoDetailsData");
		    ActualizarDataComprobante(data);
		    ConsoleWriteEndSuccess("loadMovimientoDetailsData");
		}
    });
    ConsoleWriteDown("loadMovimientoDetailsData");
}

function ActualizarDataComprobante(data) {
    ConsoleWriteStart("ActualizarDataComprobante");
    $("#DivDetallesComprobante").empty().append(data.html);
	$("#DivImpuestosGlobales").html(data.htmlImpuestos);
	$('#ReadOnly').attr('value', data.readOnly);
	/*if (data.readOnly) {
		$('.inputCalcularRenglon').attr('readonly', 'readonly');
	}
	else {
		$('.inputCalcularRenglon').removeAttribute('readonly', '0');
	}*/
	actualizarDetalleOtrosImpuestos(data);
	actualizarImpuestoGlobales(data);

	ShowImportes();
	ConsoleWriteDown("ActualizarDataComprobante");
}

function editarDatosCliente() {
    ConsoleWriteStart("editarDatosCliente");
	var razonsocial = $("#DatosMovimiento_DatosMovimientoRazonSocial").attr("value");
	var tipodocumentoid = $("#DatosMovimiento_DatosMovimientoTipoDocumentoID").attr("value");
	var numerodocumento = $("#DatosMovimiento_DatosMovimientoNumeroDocumento").attr("value");
	var letra = $("#MovimientoLetra").attr("value");
	var calle = $("#DatosMovimiento_DatosMovimientoCalle").attr("value");
	var numero = $("#DatosMovimiento_DatosMovimientoNumero").attr("value");
	var edificio = $("#DatosMovimiento_DatosMovimientoEdificio").attr("value")
	var piso = $("#DatosMovimiento_DatosMovimientoPiso").attr("value")
	var departamento = $("#DatosMovimiento_DatosMovimientoDepartamento").attr("value")
	var localidad = $("#DatosMovimiento_DatosMovimientoLocalidad").attr("value");
	var codigopostal = $("#DatosMovimiento_DatosMovimientoCodigoPostal").attr("value");
	var paisid = $("#DatosMovimiento_DatosMovimientoPaisID").attr("value");
	var provinciaid = $("#DatosMovimiento_DatosMovimientoProvinciaID").attr("value");
	var mail = $("#DatosMovimiento_DatosMovimientoCorreoElectronicoCliente").attr("value");
	callpupdatecustomerdatamovimientos(razonsocial, tipodocumentoid, numerodocumento, letra,
                    calle, numero, edificio, piso, departamento, localidad, codigopostal, paisid, provinciaid, mail);
	ConsoleWriteDown("editarDatosCliente");
}

function editarDatosClienteFullScreen() {
    ConsoleWriteStart("editarDatosClienteFullScreen");
    var razonsocial = $("#DatosMovimiento_DatosMovimientoRazonSocial").attr("value");
    var tipodocumentoid = $("#DatosMovimiento_DatosMovimientoTipoDocumentoID").attr("value");
    var numerodocumento = $("#DatosMovimiento_DatosMovimientoNumeroDocumento").attr("value");
    var letra = $("#MovimientoLetra").attr("value");
    var calle = $("#DatosMovimiento_DatosMovimientoCalle").attr("value");
    var numero = $("#DatosMovimiento_DatosMovimientoNumero").attr("value");
    var edificio = $("#DatosMovimiento_DatosMovimientoEdificio").attr("value")
    var piso = $("#DatosMovimiento_DatosMovimientoPiso").attr("value")
    var departamento = $("#DatosMovimiento_DatosMovimientoDepartamento").attr("value")
    var localidad = $("#DatosMovimiento_DatosMovimientoLocalidad").attr("value");
    var codigopostal = $("#DatosMovimiento_DatosMovimientoCodigoPostal").attr("value");
    var paisid = $("#DatosMovimiento_DatosMovimientoPaisID").attr("value");
    var provinciaid = $("#DatosMovimiento_DatosMovimientoProvinciaID").attr("value");
    var mail = $("#DatosMovimiento_DatosMovimientoCorreoElectronicoCliente").attr("value");
    callpupdatecustomerdatafullscreenmovimientos(razonsocial, tipodocumentoid, numerodocumento, letra,
                    calle, numero, edificio, piso, departamento, localidad, codigopostal, paisid, provinciaid, mail);
    ConsoleWriteDown("editarDatosClienteFullScreen");
}

function altaConceptosPoput() {
    ConsoleWriteStart("altaConceptosPoput");
    var legalConceptoId = $("#LegalConceptoID").val();
    callpaltaconceptosmovimientos(legalConceptoId);
    ConsoleWriteDown("altaConceptosPoput");
}

function altaConceptosfullscreenPoput() {
    ConsoleWriteStart("altaConceptosPoput");
    var legalConceptoId = $("#LegalConceptoID").val();
    callpaltaconceptosfullscreenmovimientos(legalConceptoId);
    ConsoleWriteDown("altaConceptosPoput");
}

function editarDatosDomicilio() {
    ConsoleWriteStart("editarDatosDomicilio");
	var calle = $("#DatosMovimiento_DatosMovimientoCalle").attr("value");
	var numero = $("#DatosMovimiento_DatosMovimientoNumero").attr("value");
	var edificio = $("#DatosMovimiento_DatosMovimientoEdificio").attr("value")
	var piso = $("#DatosMovimiento_DatosMovimientoPiso").attr("value")
	var departamento = $("#DatosMovimiento_DatosMovimientoDepartamento").attr("value")
	var localidad = $("#DatosMovimiento_DatosMovimientoLocalidad").attr("value");
	var codigopostal = $("#DatosMovimiento_DatosMovimientoCodigoPostal").attr("value");
	var paisid = $("#DatosMovimiento_DatosMovimientoPaisID").attr("value");
	var provinciaid = $("#DatosMovimiento_DatosMovimientoProvinciaID").attr("value");
	var mail = $("#DatosMovimiento_DatosMovimientoCorreoElectronicoCliente").attr("value");

	callpupdateaddressdatamovimientos(calle, numero, edificio, piso, departamento, localidad, codigopostal, paisid, provinciaid, mail);
	ConsoleWriteDown("editarDatosDomicilio");
}

function clearControls() {
    ConsoleWriteStart("clearControls");
    enableControls();
    ConsoleWriteDown("clearControls");
}

function getProximoNumeroComprobante(urlActualizarTotalesMovimiento) {
    ConsoleWriteStart("getProximoNumeroComprobante");
	var parametro = $("#FormComprobante form").serialize();
	$.ajax({
	    async: !esCreditoDebito,
	    type: "POST",
	    url: urlActualizarTotalesMovimiento,
	    data: parametro,
	    success: function (e) {
	        ConsoleWriteBeginSuccess("getProximoNumeroComprobante");
	        actualizarNumeroTalonario(e);
	        $('#MovimientoDiscriminaIVA').attr('value', e.movimientoDiscriminaIVA);
	        $("#MovimientoLetra").attr('value', e.letra);
	        $("#DivDetallesComprobante").empty().append(e.renglones);
	        $("#DivImpuestosGlobales").html(e.ImpuestoGlobal);
	        $('#licenseInfo').html(e.licenseEntityInfo);
	        actualizarTotales(e);
	        actualizarDetalleOtrosImpuestos(e);
	        ShowImportes();
	        EnablePanelButtons();
	        HideProgress();

	        if (permiteAgregarRenglones) {
	            PermitirAgregarRenglones();
	        } else {
	            NoPermiteAgregarRenglones();
	        }

	        ConsoleWriteEndSuccess("getProximoNumeroComprobante");
	    }
	});
    ConsoleWriteDown("getProximoNumeroComprobante");
}

function actualizarNumeroTalonario(datos) {
    ConsoleWriteStart("actualizarNumeroTalonario");
	if (datos.numeradorPuntoVentaEsElectronico == undefined) 
	{
		$("#divNumeroElectronico").css("display", "block");
		$("#divNumeroManual").css("display", "none");
	}
	else {
	    $('#MovimientoLetra').attr("value", datos.numeradorLetraNombre);

	    _puntoVentaElectronico = datos.numeradorPuntoVentaEsElectronico;
		if (datos.numeradorPuntoVentaEsElectronico) {
			$("#divNumeroElectronico").css("display", "block");
			$("#divNumeroManual").css("display", "none");
		}
		else {
			$("#divNumeroElectronico").css("display", "none");
			$("#divNumeroManual").css("display", "inline-block");

			$("#PuntoVenta_PuntoVentaCodigo").attr("value", datos.numeradorSucursal);
			$("#MovimientoNumero").attr("value", datos.numeradorProximoNumero);
			if (datos.numeradorPuntoVentaImprime) {
				$("#MovimientoNumero").attr("readonly", true);
			}
			else {
				$("#MovimientoNumero").attr("readonly", "");
			}
		}
	}
	var tipoMov = $("#TipoMovimientoIDdropdown option:selected").text();
	/*$("#TempNumeroFactura").attr("value", tipoMov + " " + datos.numeradorDescripcionMovimiento);*/
	$("#TempNumeroFactura").text(tipoMov + " " + datos.numeradorDescripcionMovimiento);
	ConsoleWriteDown("actualizarNumeroTalonario");
}

//***************************************************
function disableRowsControls() {
    ConsoleWriteStart("disableRowsControls");
	$('.lookupConceptoID').each(
		function (index) {
			$(this).attr("disabled", "disabled");
		});
	$('input[name$="DetalleMovimientoDescripcion"]').each(
		function (index) {
			$(this).attr("readonly", "readonly");
    });
    $('input[name$="DetalleMovimientoDescripcionAux"]').each(
		function (index) {
		    $(this).attr("readonly", "readonly");
	});
	$('input[name$="DetalleMovimientoCantidad"]').each(
		function (index) {
			$(this).attr("readonly", "readonly");
		});
	$('input[name$="DetalleMovimientoImporteUnitario"]').each(
		function (index) {
			$(this).attr("readonly", "readonly");
		});
	$('input[name$="DetalleMovimientoImporteBase"]').each(
		function (index) {
			$(this).attr("readonly", "readonly");
		});
	$('input[name$="DetalleMovimientoPorcentajeBonificado"]').each(
		function (index) {
			$(this).attr("readonly", "readonly");
        });
    $('input[name$="DetalleMovimientoPorcentajeBonificadoAux"]').each(
		function (index) {
		    $(this).attr("readonly", "readonly");
	});
	$('textarea[name$="DescripcionAmpliada"]').each(
		function (index) {
			$(this).attr("readonly", "readonly");
    });
    ConsoleWriteDown("disableRowsControls");
}