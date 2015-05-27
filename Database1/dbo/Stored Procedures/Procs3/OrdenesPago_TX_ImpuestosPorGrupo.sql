CREATE PROCEDURE [dbo].[OrdenesPago_TX_ImpuestosPorGrupo]

@IdOrdenPago int,
@IdProveedor int,
@IdImputaciones varchar(2000)

AS

SET NOCOUNT ON

DECLARE @TopeMensualRG3164RetencionIVA Numeric(18,2), @IdCodigoIva int, @CodigoSituacionRetencionIVA int, @ActividadPrincipalGrupo int, @FechaOP datetime, @ComprobantesMes Numeric(18,2), 
		@PorcentajeRetencionIVA Numeric(6,2), @IdComprobanteProveedor int, @TotalBrutoComprobante Numeric(18,2), @ImporteRetencion Numeric(18,2), @IdOrdenPagoAnterior int, @IdImputacion int

IF @IdProveedor=-1
	SET @IdProveedor=Isnull((Select Top 1 IdProveedor From OrdenesPago Where IdOrdenPago=@IdOrdenPago),-1)

SET @TopeMensualRG3164RetencionIVA=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='TopeMensualRG3164RetencionIVA'),0)

SET @IdCodigoIva=Isnull((Select Top 1 IdCodigoIva From Proveedores Where IdProveedor=@IdProveedor),1)

SET @CodigoSituacionRetencionIVA=Isnull((Select Top 1 CodigoSituacionRetencionIVA From Proveedores Where IdProveedor=@IdProveedor),0)

SET @ActividadPrincipalGrupo=Isnull((Select Top 1 ap.Agrupacion1 From Proveedores 
									 Left Outer Join [Actividades Proveedores] ap On ap.IdActividad=Proveedores.IdActividad
									 Where IdProveedor=@IdProveedor),0)

SET @PorcentajeRetencionIVA=0
IF @IdCodigoIva=1 and @ActividadPrincipalGrupo=1 and (@CodigoSituacionRetencionIVA=2 or @CodigoSituacionRetencionIVA=4)
	SET @PorcentajeRetencionIVA=21
IF @IdCodigoIva=1 and @ActividadPrincipalGrupo=1 and not (@CodigoSituacionRetencionIVA=2 or @CodigoSituacionRetencionIVA=4)
	SET @PorcentajeRetencionIVA=10.5

IF @IdOrdenPago=-1
	SET @FechaOP=GetDate()
ELSE
	SET @FechaOP=Isnull((Select Top 1 FechaOrdenPago From OrdenesPago Where IdOrdenPago=@IdOrdenPago),GetDate())

IF @IdImputaciones='*'
  BEGIN
	SET @IdImputaciones=''
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdImputacion FROM DetalleOrdenesPago WHERE IdOrdenPago=@IdOrdenPago ORDER BY IdDetalleOrdenPago
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdImputacion
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @IdImputaciones=@IdImputaciones + '(' + Convert(varchar,@IdImputacion) + ')'
		FETCH NEXT FROM Cur INTO @IdImputacion
	  END
	CLOSE Cur
	DEALLOCATE Cur
  END

CREATE TABLE #Auxiliar1 
			(
			 Mes INTEGER,
			 Año INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT DISTINCT Month(cca.Fecha), Year(cca.Fecha)
 FROM CuentasCorrientesAcreedores cca
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cca.IdTipoComp
 WHERE cca.IdProveedor=@IdProveedor and cca.Fecha<=@FechaOP and tc.Coeficiente=1 and Patindex('%('+Convert(varchar,cca.IdCtaCte)+')%', @IdImputaciones)<>0

CREATE TABLE #Auxiliar2 
			(
			 IdCtaCte INTEGER,
			 IdComprobanteProveedor INTEGER,
			 Fecha DATETIME,
			 ImporteBruto NUMERIC(18,2),
			 ImporteIva NUMERIC(18,2),
			 TotalComprobante NUMERIC(18,2),
			 ImputacionEnOPActual varchar(2),
			 Comprobante varchar(25)
			)
INSERT INTO #Auxiliar2 
 SELECT cca.IdCtaCte, cp.IdComprobanteProveedor, cca.Fecha, IsNull(cp.TotalBruto,0)*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1), 
		IsNull(cp.TotalIva1,0)*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1), IsNull(cp.TotalComprobante,0)*IsNull(tc.Coeficiente,1)*IsNull(cp.CotizacionMoneda,1), 
		Case When Patindex('%('+Convert(varchar,cca.IdCtaCte)+')%', @IdImputaciones)<>0 Then 'SI' Else '' End,
		tc.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
 FROM CuentasCorrientesAcreedores cca
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cca.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=cca.IdComprobante and cp.IdTipoComprobante=cca.IdTipoComp
 WHERE cca.IdProveedor=@IdProveedor and cca.Fecha<=@FechaOP and cp.IdComprobanteProveedor is not null and 
	Exists(Select Top 1 #Auxiliar1.Mes From #Auxiliar1 Where #Auxiliar1.Mes=Month(cca.Fecha) and #Auxiliar1.Año=Year(cca.Fecha)) and 
	(IsNull(cp.IdOrdenPagoRetencionIva,0)=0 or IsNull(cp.IdOrdenPagoRetencionIva,0)=@IdOrdenPago) and 
	IsNull((Select Sum(IsNull(dop.ImporteRetencionIVA,0)) From DetalleOrdenesPago dop 
			Left Outer Join OrdenesPago On OrdenesPago.IdOrdenPago=dop.IdOrdenPago
			Where dop.IdOrdenPago<>@IdOrdenPago and IsNull(OrdenesPago.Anulada,'')<>'SI' and IsNull(dop.IdImputacion,0)=cca.IdCtaCte),0)=0

CREATE TABLE #Auxiliar3 
			(
			 Mes INTEGER,
			 Año INTEGER,
			 ImporteBruto NUMERIC(18,2)
			)
INSERT INTO #Auxiliar3 
 SELECT Month(Fecha), Year(Fecha), Sum(IsNull(ImporteBruto,0))
 FROM #Auxiliar2
 GROUP BY Month(Fecha), Year(Fecha)

/* ---------------BORRAR-------------- */
--set @TopeMensualRG3164RetencionIVA=5000
/* ----------------------------------- */

SET NOCOUNT OFF

SELECT a2.IdCtaCte, a2.IdComprobanteProveedor, a2.Fecha, a2.ImporteBruto, a2.ImporteIva, a2.TotalComprobante, a2.ImputacionEnOPActual, a2.Comprobante, 
		@PorcentajeRetencionIVA as [PorcentajeRetencionIVA], Round(a2.ImporteBruto*@PorcentajeRetencionIVA/100,2) as [ImporteRetencionIva]
FROM #Auxiliar2 a2
LEFT OUTER JOIN #Auxiliar3 a3 ON a3.Mes=Month(a2.Fecha) and a3.Año=Year(a2.Fecha)
WHERE IsNull(a3.ImporteBruto,0)>@TopeMensualRG3164RetencionIVA and @PorcentajeRetencionIVA>0

--select * from #Auxiliar1
--select * from #Auxiliar2
--select * from #Auxiliar3

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
