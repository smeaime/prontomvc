CREATE  Procedure [dbo].[Polizas_TX_Todas]

@Tipo varchar(10) = Null,
@Estado varchar(1) = Null,
@IdProveedor int = Null,
@Detallado varchar(1) = Null,
@Pendientes varchar(1) = Null,
@IdPoliza int = Null,
@TodosLosPeriodos varchar(1) = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null,
@IdBienAsegurado int = Null,
@Numero varchar(30) = Null,
@Certificado varchar(30) = Null,
@OrdenPermanente varchar(20) = Null,
@Patente varchar(20) = Null

AS 

SET NOCOUNT ON

SET @Tipo=IsNull(@Tipo,'*')
SET @Estado=IsNull(@Estado,'A')
SET @IdProveedor=IsNull(@IdProveedor,-1)
SET @Detallado=IsNull(@Detallado,'R')
SET @Pendientes=IsNull(@Pendientes,'T')
SET @IdPoliza=IsNull(@IdPoliza,-1)
SET @TodosLosPeriodos=IsNull(@TodosLosPeriodos,'*')
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)
SET @IdBienAsegurado=IsNull(@IdBienAsegurado,-1)
SET @Numero=IsNull(@Numero,'')
SET @Certificado=IsNull(@Certificado,'')
SET @OrdenPermanente=IsNull(@OrdenPermanente,'')
SET @Patente=IsNull(@Patente,'')

DECLARE @vector_X varchar(30), @vector_T varchar(30), @IdPoliza1 int, @TipoFacturacion int, @FechaVencimientoPrimerCuota datetime, @CantidadCuotas int, @NumeroCuota int, @FechaCuota datetime, 
	@IdComprobanteProveedor int, @IdOrdenPago int

SET @vector_X='0111111111111111111111111133'

CREATE TABLE #Auxiliar1 
			(
			 IdPoliza INTEGER,
			 TipoFacturacion INTEGER,
			 FechaVencimientoPrimerCuota DATETIME,
			 CantidadCuotas INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPoliza) ON [PRIMARY]

CREATE TABLE #Auxiliar2 
			(
			 IdPoliza INTEGER,
			 NumeroCuota INTEGER,
			 FechaCuota DATETIME,
			 IdComprobanteProveedor INTEGER,
			 IdOrdenPago INTEGER,
			 Codigo VARCHAR(30)
			)

IF @Detallado='R' --or @Detallado='I'
   BEGIN
	IF @Tipo='OBRAS'
		SET @vector_T='0599219999195552155555555500'
	ELSE
		SET @vector_T='0599219999915552155555555500'

	INSERT INTO #Auxiliar2
	 SELECT IdPoliza, Null, Null, Null, Null, Null
	 FROM Polizas
	 WHERE (@Tipo='*' or Tipo=@Tipo) and 
		(@Estado='*' or (@Estado='A' and FechaFinalizacionCobertura>=Getdate()) or (@Estado='I' and FechaFinalizacionCobertura<Getdate())) and 
		(@IdProveedor=-1 or IdProveedor=@IdProveedor) and 
		(@IdPoliza=-1 or IdPoliza=@IdPoliza) and 
		(@TodosLosPeriodos='*' or (Polizas.FechaVencimientoPrimerCuota between @FechaDesde and @FechaHasta)) and 
		(@Numero='' or Polizas.Numero=@Numero) and 
		(@Certificado='' or Polizas.Certificado=@Certificado) 
   END
ELSE
   BEGIN
	IF @Tipo='OBRAS'
		SET @vector_T='05992114F0195552155555555500'
	ELSE
		SET @vector_T='05992114F0915552155555555500'

	INSERT INTO #Auxiliar1
	 SELECT Polizas.IdPoliza, IsNull(Polizas.TipoFacturacion,1), Polizas.FechaVencimientoPrimerCuota, IsNull(Polizas.CantidadCuotas,1)
	 FROM Polizas
	 WHERE (@Tipo='*' or Polizas.Tipo=@Tipo) and 
		(@Estado='*' or (@Estado='A' and Polizas.FechaFinalizacionCobertura>=Getdate()) or (@Estado='I' and Polizas.FechaFinalizacionCobertura<Getdate())) and 
		(@IdProveedor=-1 or Polizas.IdProveedor=@IdProveedor) and 
		(@IdPoliza=-1 or Polizas.IdPoliza=@IdPoliza) and 
		(@TodosLosPeriodos='*' or (Polizas.FechaVencimientoPrimerCuota between @FechaDesde and @FechaHasta)) and 
		(@Numero='' or Polizas.Numero=@Numero) and 
		(@Certificado='' or Polizas.Certificado=@Certificado) 
	
	/*  CURSOR  */
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY  FOR SELECT IdPoliza, TipoFacturacion, FechaVencimientoPrimerCuota, CantidadCuotas FROM #Auxiliar1 ORDER BY IdPoliza
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdPoliza1, @TipoFacturacion, @FechaVencimientoPrimerCuota, @CantidadCuotas
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		SET @NumeroCuota=0
		WHILE @NumeroCuota < @CantidadCuotas
		   BEGIN
			SET @NumeroCuota=@NumeroCuota+1
			SET @FechaCuota=
				CASE WHEN @TipoFacturacion=1 THEN DateAdd(m,@NumeroCuota-1,@FechaVencimientoPrimerCuota)
					WHEN @TipoFacturacion=2 THEN DateAdd(q,@NumeroCuota-1,@FechaVencimientoPrimerCuota)
					WHEN @TipoFacturacion=3 THEN DateAdd(m,(@NumeroCuota-1)*6,@FechaVencimientoPrimerCuota)
					WHEN @TipoFacturacion=4 THEN DateAdd(y,@NumeroCuota-1,@FechaVencimientoPrimerCuota)
					ELSE @FechaVencimientoPrimerCuota
				END
			SET @IdComprobanteProveedor=IsNull((Select Top 1 IdComprobanteProveedor From ComprobantesProveedores Where IdPoliza=@IdPoliza1 and NumeroCuotaPoliza=@NumeroCuota),0)
			IF @IdComprobanteProveedor>0 
				SET @IdOrdenPago=IsNull((Select Top 1 dop.IdOrdenPago From DetalleOrdenesPago dop
							 Left Outer Join OrdenesPago op On op.IdOrdenPago=dop.IdOrdenPago
							 Left Outer Join CuentasCorrientesAcreedores Cta On Cta.IdCtaCte=dop.IdImputacion
							 Left Outer Join ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Cta.IdComprobante and cp.IdTipoComprobante=Cta.IdTipoComp
							 Where IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and cp.IdComprobanteProveedor=@IdComprobanteProveedor),0)
			ELSE
				SET @IdOrdenPago=0

			INSERT INTO #Auxiliar2
			 SELECT @IdPoliza1, @NumeroCuota, @FechaCuota, @IdComprobanteProveedor, @IdOrdenPago, Null
		   END
		FETCH NEXT FROM Cur INTO @IdPoliza1, @TipoFacturacion, @FechaVencimientoPrimerCuota, @CantidadCuotas
	   END
	CLOSE Cur
	DEALLOCATE Cur
   END

UPDATE #Auxiliar2
SET Codigo=Case When @Tipo='OBRAS' or @Tipo='*' Then (Select Top 1 o.NumeroObra COLLATE SQL_Latin1_General_CP1_CI_AS From DetallePolizas dp Left Outer Join Obras o On o.IdObra=dp.IdBienAsegurado Where dp.IdPoliza=#Auxiliar2.IdPoliza)
		When @Tipo='EQUIPOS' Then (Select Top 1 a.Codigo COLLATE SQL_Latin1_General_CP1_CI_AS From DetallePolizas dp Left Outer Join Articulos a On a.IdArticulo=dp.IdBienAsegurado Where dp.IdPoliza=#Auxiliar2.IdPoliza)
		Else Null
	   End

SET NOCOUNT OFF

IF @Detallado='I'
   BEGIN
	SET @vector_X='0111111111111111111133'
	SET @vector_T='041124444444044F440400'
	SELECT 
	 #Auxiliar2.IdPoliza,
	 Obras.NumeroObra as [Obra],
	 Polizas.Numero as [Nro.Poliza],
	 Polizas.NumeroEndoso as [Nro.Endoso],
	 Proveedores.RazonSocial as [Aseguradora],
	 Polizas.FechaVigencia as [Fecha vigencia],
	 Polizas.FechaFinalizacionCobertura as [Fecha finalizacion cobertura],
	 Polizas.ImporteAsegurado as [Importe asegurado],
	 Polizas.ImporteAsegurado / IsNull(Polizas.CantidadCuotas,1) as [Imp.cuota],
	 Polizas.ImportePrima as [Valor prima],
	 Polizas.ImportePremio as [Valor premio],
	 Case When Polizas.TipoFacturacion=1 Then 'Mensual' When Polizas.TipoFacturacion=2 Then 'Trimestral' When Polizas.TipoFacturacion=3 Then 'Semestral' When Polizas.TipoFacturacion=4 Then 'Anual' End as [Tipo facturacion],
	 Polizas.Certificado as [Certificado],
	 #Auxiliar2.NumeroCuota [Cuota],
	 #Auxiliar2.FechaCuota as [Fecha cuota],
	 tc.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Nro.Factura],
	 cp.FechaComprobante as [Fecha factura],
	 cp.TotalComprobante as [Imp.Factura],
	 Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago) as [Orden de pago],
	 op.FechaOrdenPago as [Fecha OP],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Polizas ON Polizas.IdPoliza = #Auxiliar2.IdPoliza
	LEFT OUTER JOIN DetallePolizas ON DetallePolizas.IdPoliza = Polizas.IdPoliza
	LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Polizas.IdProveedor
	LEFT OUTER JOIN TiposPoliza ON TiposPoliza.IdTipoPoliza = Polizas.IdTipoPoliza
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.IdComprobanteProveedor
	LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
	LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Polizas.IdMoneda
	LEFT OUTER JOIN Obras ON Obras.IdObra = DetallePolizas.IdBienAsegurado
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0)) and 
		(@IdBienAsegurado=-1 or DetallePolizas.IdBienAsegurado=@IdBienAsegurado)  
	ORDER BY Polizas.FechaVigencia, Polizas.Numero, #Auxiliar2.NumeroCuota
   END

IF @Detallado='E'
   BEGIN
	SET @vector_X='011111111111111133'
	SET @vector_T='0411244444F4404200'
	SELECT 
	 #Auxiliar2.IdPoliza,
	 Articulos.Codigo as [Orden permanente],
	 Polizas.Numero as [Nro.Poliza],
	 Polizas.NumeroEndoso as [Nro.Endoso],
	 Proveedores.RazonSocial as [Aseguradora],
	 Polizas.FechaVigencia as [Fecha vigencia],
	 Polizas.FechaFinalizacionCobertura as [Fecha finalizacion cobertura],
	 #Auxiliar2.NumeroCuota [Cuota],
	 Polizas.ImporteAsegurado / IsNull(Polizas.CantidadCuotas,1) as [Imp.cuota],
	 #Auxiliar2.FechaCuota as [Fecha cuota],
	 tc.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Nro.Factura],
	 cp.FechaComprobante as [Fecha factura],
	 cp.TotalComprobante as [Imp.Factura],
	 Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago) as [Orden de pago],
	 op.FechaOrdenPago as [Fecha OP],
	 Obras.NumeroObra as [Obra],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Polizas ON Polizas.IdPoliza = #Auxiliar2.IdPoliza
	LEFT OUTER JOIN DetallePolizas ON DetallePolizas.IdPoliza = Polizas.IdPoliza
	LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Polizas.IdProveedor
	LEFT OUTER JOIN TiposPoliza ON TiposPoliza.IdTipoPoliza = Polizas.IdTipoPoliza
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.IdComprobanteProveedor
	LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
	LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Polizas.IdMoneda
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = DetallePolizas.IdBienAsegurado
	LEFT OUTER JOIN Obras ON Obras.IdObra = DetallePolizas.IdObraActual
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0)) and 
		(@OrdenPermanente='' or Articulos.Codigo=@OrdenPermanente) and 
		(@Patente='' or Articulos.NumeroPatente=@Patente)
	ORDER BY Polizas.FechaVigencia, Polizas.Numero, #Auxiliar2.NumeroCuota
   END

IF @Detallado='R' or @Detallado='D'
   BEGIN
	SELECT 
	 #Auxiliar2.IdPoliza,
	 Polizas.Tipo as [Tipo],
	 Polizas.IdPoliza as [IdAux1],
	 #Auxiliar2.NumeroCuota [IdAux2],
	 Proveedores.RazonSocial as [Aseguradora],
	 Polizas.Numero as [Numero],
	 #Auxiliar2.NumeroCuota [Cuota],
	 #Auxiliar2.FechaCuota as [Fecha cuota],
	 tc.DescripcionAb+' '+cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
	 Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago) as [Orden de pago],
	 #Auxiliar2.Codigo as [Obra],
	 #Auxiliar2.Codigo as [O.P.],
	 Polizas.FechaVigencia as [Fecha vigencia],
	 Polizas.FechaFinalizacionCobertura as [Fecha finalizacion cobertura],
	 Polizas.FechaVencimientoPrimerCuota as [Fecha vto. 1qr. cuota],
	 Polizas.NumeroEndoso as [Endoso],
	 Polizas.CantidadCuotas as [Cuotas],
	 Polizas.ImporteAsegurado as [Importe asegurado],
	 Polizas.ImportePrima as [Importe prima],
	 Polizas.ImportePremio as [Importe premio],
	 Monedas.Abreviatura as [Mon.],
	 Polizas.MotivoContratacion as [Motivo contratacion],
	 Polizas.Observaciones as [Observaciones],
	 Case When Polizas.TipoFacturacion=1 Then 'Mensual' When Polizas.TipoFacturacion=2 Then 'Trimestral' When Polizas.TipoFacturacion=3 Then 'Semestral' When Polizas.TipoFacturacion=4 Then 'Anual' End as [Tipo facturacion],
	 Polizas.Certificado as [Certificado],
	 TiposPoliza.Descripcion as [Tipo de poliza],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Polizas ON Polizas.IdPoliza = #Auxiliar2.IdPoliza
	LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Polizas.IdProveedor
	LEFT OUTER JOIN TiposPoliza ON TiposPoliza.IdTipoPoliza = Polizas.IdTipoPoliza
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.IdComprobanteProveedor
	LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
	LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = Polizas.IdMoneda
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0))
	ORDER BY Polizas.FechaVigencia, Polizas.Numero, #Auxiliar2.NumeroCuota
   END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
