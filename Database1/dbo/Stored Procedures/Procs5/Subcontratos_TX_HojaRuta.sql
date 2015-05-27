CREATE Procedure [dbo].[Subcontratos_TX_HojaRuta]

@NumeroSubcontrato int,
@AmpliacionSubcontrato int = Null

AS 

SET NOCOUNT ON

DECLARE @IdProveedor int, @IdCuentaAnticipoAProveedores int, @IdCuentaDevolucionAnticipoAProveedores int, @IdCuentaSubcontratosAcopio int

SET @IdProveedor=IsNull((Select Top 1 IdProveedor From SubcontratosDatos Where NumeroSubcontrato=@NumeroSubcontrato),0)
SET @AmpliacionSubcontrato=IsNull(@AmpliacionSubcontrato,-1)
SET @IdCuentaAnticipoAProveedores=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaAnticipoAProveedores'),0)
SET @IdCuentaDevolucionAnticipoAProveedores=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaDevolucionAnticipoAProveedores'),0)
SET @IdCuentaSubcontratosAcopio=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaSubcontratosAcopio'),0)

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 IdTipoComprobante INTEGER,
			 Proveedor VARCHAR(50),
			 Anticipo NUMERIC(18,2),
			 DevolucionAnticipo NUMERIC(18,2),
			 Certificacion NUMERIC(18,2),
			 Acopio NUMERIC(18,2),
			 Desacopio NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT dcp.IdComprobanteProveedor, cp.IdTipoComprobante, 
	Case When cp.IdProveedor=@IdProveedor Then '' Else IsNull(Proveedores.RazonSocial,'') End,
	Case When dcp.IdCuenta=@IdCuentaAnticipoAProveedores and ((tc.Coeficiente=1 and IsNull(dcp.Importe,0)>0) or (tc.Coeficiente=-1 and IsNull(dcp.Importe,0)<0)) 
			--IsNull(dcp.PorcentajeAnticipo,0)<>0 and IsNull(dcp.Importe,0)>0
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1)
		Else Null
	End,
	Case When dcp.IdCuenta=@IdCuentaDevolucionAnticipoAProveedores and ((tc.Coeficiente=1 and IsNull(dcp.Importe,0)<0) or (tc.Coeficiente=-1 and IsNull(dcp.Importe,0)>0)) 
			--(IsNull(dcp.IdPedidoAnticipo,0)<>0 and IsNull(dcp.Importe,0)<0) or (tc.Coeficiente=-1 and dcp.IdCuenta=@IdCuentaDevolucionAnticipoAProveedores)
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1)
		Else Null
	End,
	Case When (dcp.IdCuenta=@IdCuentaAnticipoAProveedores and ((tc.Coeficiente=1 and IsNull(dcp.Importe,0)>0) or (tc.Coeficiente=-1 and IsNull(dcp.Importe,0)<0))) or 
		(dcp.IdCuenta=@IdCuentaDevolucionAnticipoAProveedores and ((tc.Coeficiente=1 and IsNull(dcp.Importe,0)<0) or (tc.Coeficiente=-1 and IsNull(dcp.Importe,0)>0)))
		Then Null
		Else IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1)
	End,
	Case When dcp.IdCuenta=@IdCuentaSubcontratosAcopio and cp.IdProveedor<>@IdProveedor
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1)
		Else Null
	End,
	Case When dcp.IdCuenta=@IdCuentaSubcontratosAcopio and cp.IdProveedor=@IdProveedor
		Then IsNull(dcp.Importe,0) * IsNull(cp.CotizacionMoneda,1) * IsNull(tc.Coeficiente,1) 
		Else Null
	End
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON IsNull(cp.IdProveedor,cp.IdProveedorEventual)=Proveedores.IdProveedor
 WHERE IsNull(cp.Confirmado,'SI')<>'NO' and IsNull(dcp.NumeroSubcontrato,0)=@NumeroSubcontrato and 
	(@AmpliacionSubcontrato=-1 or 
	 (@AmpliacionSubcontrato=0 and IsNull(dcp.AmpliacionSubcontrato,'')<>'SI') or 
	 (@AmpliacionSubcontrato=1 and IsNull(dcp.AmpliacionSubcontrato,'')='SI'))

CREATE TABLE #Auxiliar2 
			(
			 IdComprobanteProveedor INTEGER,
			 IdTipoComprobante INTEGER,
			 Proveedor VARCHAR(50),
			 Anticipo NUMERIC(18,2),
			 DevolucionAnticipo NUMERIC(18,2),
			 Certificacion NUMERIC(18,2),
			 Acopio NUMERIC(18,2),
			 Desacopio NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT IdComprobanteProveedor, IdTipoComprobante, Proveedor, Sum(IsNull(Anticipo,0)), Sum(IsNull(DevolucionAnticipo,0)), 
	Sum(IsNull(Certificacion,0)), Sum(IsNull(Acopio,0)), Sum(IsNull(Desacopio,0))
 FROM #Auxiliar1
 GROUP BY IdComprobanteProveedor, IdTipoComprobante, Proveedor

-- LISTA DE OP's QUE CANCELAN LOS COMPROBANTES DE PROVEEDORES
CREATE TABLE #Auxiliar3 
			(
			 IdComprobanteProveedor INTEGER,
			 OrdenesPago VARCHAR(100)
			)

CREATE TABLE #Auxiliar4 
			(
			 IdComprobanteProveedor INTEGER,
			 OrdenPago VARCHAR(8)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdComprobanteProveedor) ON [PRIMARY]
INSERT INTO #Auxiliar4 
 SELECT Cta.IdComprobante, Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)
 FROM DetalleOrdenesPago DetOP
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN CuentasCorrientesAcreedores Cta ON Cta.IdCtaCte=DetOP.IdImputacion
 WHERE Exists(Select Top 1 * From #Auxiliar2 Where #Auxiliar2.IdComprobanteProveedor=Cta.IdComprobante and #Auxiliar2.IdTipoComprobante=Cta.IdTipoComp)

INSERT INTO #Auxiliar3 
 SELECT IdComprobanteProveedor, '' FROM #Auxiliar4 GROUP BY IdComprobanteProveedor

/*  CURSOR  */
DECLARE @IdComprobanteProveedor int, @OrdenPago varchar(8), @Corte int, @P varchar(100)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdComprobanteProveedor, OrdenPago FROM #Auxiliar4 ORDER BY IdComprobanteProveedor
OPEN Cur
FETCH NEXT FROM Cur INTO @IdComprobanteProveedor, @OrdenPago
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdComprobanteProveedor
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar3
			SET OrdenesPago = SUBSTRING(@P,1,100)
			WHERE IdComprobanteProveedor=@Corte
		SET @P=''
		SET @Corte=@IdComprobanteProveedor
	   END
	IF NOT @OrdenPago IS NULL
		IF PATINDEX('%'+@OrdenPago+' '+'%', @P)=0
			SET @P=@P+@OrdenPago+' '
	FETCH NEXT FROM Cur INTO @IdComprobanteProveedor, @OrdenPago
   END
   IF @Corte<>0
      BEGIN
	UPDATE #Auxiliar3
	SET OrdenesPago = SUBSTRING(@P,1,100)
	WHERE IdComprobanteProveedor=@Corte
      END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT 
 #Auxiliar2.IdComprobanteProveedor as [Aux0],
 TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 #Auxiliar2.Proveedor as [Proveedor],
 cp.FechaComprobante [Fecha],
 cp.FechaRecepcion [FechaRecepcion],
 #Auxiliar2.Certificacion as [Certificacion],
 #Auxiliar2.DevolucionAnticipo as [DevolucionAnticipo],
 #Auxiliar2.Anticipo as [Anticipo],
 #Auxiliar2.Certificacion+#Auxiliar2.DevolucionAnticipo as [Neto],
 #Auxiliar2.Acopio as [Acopio], 
 #Auxiliar2.Desacopio as [Desacopio],
 #Auxiliar3.OrdenesPago as [OrdenesPago]
FROM #Auxiliar2
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.IdComprobanteProveedor
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar2.IdComprobanteProveedor=#Auxiliar3.IdComprobanteProveedor
ORDER BY [Fecha], [Comprobante]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4