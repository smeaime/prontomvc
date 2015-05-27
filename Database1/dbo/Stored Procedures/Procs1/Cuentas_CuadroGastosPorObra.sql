
CREATE Procedure [dbo].[Cuentas_CuadroGastosPorObra]

@FechaDesde datetime,
@FechaHasta datetime,
@Dts varchar(100) 

AS 

SET NOCOUNT ON

Declare @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int,
	@IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int,@IdTipoComprobanteOrdenPago int

Set @IdTipoComprobanteFacturaVenta=(Select Top 1 Parametros.IdTipoComprobanteFacturaVenta
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteDevoluciones=(Select Top 1 Parametros.IdTipoComprobanteDevoluciones
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteNotaDebito=(Select Top 1 Parametros.IdTipoComprobanteNotaDebito
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteNotaCredito=(Select Top 1 Parametros.IdTipoComprobanteNotaCredito
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteRecibo=(Select Top 1 Parametros.IdTipoComprobanteRecibo
					From Parametros Where Parametros.IdParametro=1)
Set @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago
					From Parametros Where Parametros.IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Subdiarios.IdComprobante,
  SUM(
  Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
		IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
		 Then Subdiarios.Debe
	When Subdiarios.Debe is null and Subdiarios.Haber is not null and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
		IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
		 Then Subdiarios.Haber * -1
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
		Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
		IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
		 Then Subdiarios.Debe - Subdiarios.Haber
	 Else 0
  End)
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre 
		 From CuentasGastos
		 Where CuentasGastos.IdCuentaMadre=Subdiarios.IdCuenta)))
 GROUP BY Subdiarios.IdComprobante


CREATE TABLE #Auxiliar2 
			(
			 IdComprobanteProveedor INTEGER,
			 IdProvinciaDestino INTEGER,
			 PorcentajeProvinciaDestino NUMERIC(12,5),
			 PorcentajeGeneral NUMERIC(12,5)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  dcp.IdComprobanteProveedor,
  Case When cp.IdProveedor is not null
	Then IsNull(dcp.IdProvinciaDestino1,Proveedores.IdProvincia)
	Else IsNull(dcp.IdProvinciaDestino1,(Select Top 1 P.IdProvincia
						From Proveedores P 
						Where P.IdProveedor=cp.IdProveedorEventual))
  End,
  dcp.PorcentajeProvinciaDestino1,
  Case When IsNull(#Auxiliar1.Importe,0)<>0 
	Then IsNull(dcp.PorcentajeProvinciaDestino1,100) * (dcp.Importe / #Auxiliar1.Importe)
	Else 100 
  End
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor  
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  Case When cp.IdProveedor is not null
	Then IsNull(dcp.IdProvinciaDestino2,Proveedores.IdProvincia)
	Else IsNull(dcp.IdProvinciaDestino2,(Select Top 1 P.IdProvincia
						From Proveedores P 
						Where P.IdProveedor=cp.IdProveedorEventual))
  End,
  dcp.PorcentajeProvinciaDestino2,
  Case When IsNull(#Auxiliar1.Importe,0)<>0 
	Then IsNull(dcp.PorcentajeProvinciaDestino2,100) * (dcp.Importe / #Auxiliar1.Importe)
	Else 100 
  End
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor  
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	IsNull(dcp.PorcentajeProvinciaDestino2,0)<>0


CREATE TABLE #Auxiliar3 
			(
			 IdComprobanteProveedor INTEGER,
			 PorcentajeGeneral NUMERIC(12,5)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.IdComprobanteProveedor,
  SUM(#Auxiliar2.PorcentajeGeneral)
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdComprobanteProveedor

CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdComprobanteProveedor) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdComprobanteProveedor int, @Corte int, @DiferenciaA100 numeric(12,5)
SET @Corte=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR
		SELECT IdComprobanteProveedor
		FROM #Auxiliar2
		ORDER BY IdComprobanteProveedor
OPEN Cur
FETCH NEXT FROM Cur INTO @IdComprobanteProveedor

WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdComprobanteProveedor
	   BEGIN
		SET @Corte=@IdComprobanteProveedor
		SET @DiferenciaA100=100-ISNULL((Select Top 1 #Auxiliar3.PorcentajeGeneral
						From #Auxiliar3
						Where #Auxiliar3.IdComprobanteProveedor=@Corte),0)
--print convert(varchar,@Corte)+'  '+convert(varchar,@DiferenciaA100)
		UPDATE #Auxiliar2
		SET PorcentajeGeneral = PorcentajeGeneral+@DiferenciaA100
		WHERE CURRENT OF Cur
	   END
	FETCH NEXT FROM Cur INTO @IdComprobanteProveedor
   END
CLOSE Cur
DEALLOCATE Cur


TRUNCATE TABLE _TempCuadroGastosParaCubo

INSERT INTO _TempCuadroGastosParaCubo 
SELECT 
 Cuentas.IdObra,
 Obras.NumeroObra,
 CuentasGastos.IdRubroContable,
 RubrosContables.Descripcion,
 Obras.IdUnidadOperativa,
 UnidadesOperativas.Descripcion,
 Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null 
	 Then 	Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			 Then Subdiarios.Debe * IsNull(dfp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			 Then Subdiarios.Debe * IsNull(dndp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			 Then Subdiarios.Debe * IsNull(dncp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then Subdiarios.Debe * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100
			 Else Subdiarios.Debe
		End
	When Subdiarios.Debe is null and Subdiarios.Haber is not null 
	 Then 	Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			 Then Subdiarios.Haber * -1 * IsNull(dfp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			 Then Subdiarios.Haber * -1 * IsNull(dndp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			 Then Subdiarios.Haber * -1 * IsNull(dncp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then Subdiarios.Haber * -1 * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100
			 Else Subdiarios.Haber * -1
		End
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null 
	 Then 	Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			 Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dfp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			 Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dndp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			 Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dncp.Porcentaje,100) / 100
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100
			 Else (Subdiarios.Debe - Subdiarios.Haber)
		End
	 Else 0
 End,
 Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=dfp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=Devoluciones.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=dndp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=dncp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=OrdenesPago.IdProvinciaDestino)
	 Else 	Case When IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			Then (Select Provincias.Nombre From Provincias 
				Where Provincias.IdProvincia=#Auxiliar2.IdProvinciaDestino)
			Else Null
		End
 End,
 Null,
 Null
FROM Subdiarios 
LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdComprobanteProveedor=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN DetalleNotasDebitoProvincias dndp ON dndp.IdNotaDebito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN DetalleNotasCreditoProvincias dncp ON dncp.IdNotaCredito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null

UNION ALL

SELECT 
 0,
 'Sin Obra',
 0,
 'Sin Rubro',
 0,
 'Sin U.Operativa',
 Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null 
	 Then 	Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			 Then Round(Subdiarios.Debe * IsNull(dfp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			 Then Round(Subdiarios.Debe * IsNull(dndp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			 Then Round(Subdiarios.Debe * IsNull(dncp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then Round(Subdiarios.Debe * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100 ,2)
			 Else Subdiarios.Debe
		End
	When Subdiarios.Debe is null and Subdiarios.Haber is not null 
	 Then 	Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			 Then Round(Subdiarios.Haber * -1 * IsNull(dfp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			 Then Round(Subdiarios.Haber * -1 * IsNull(dndp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			 Then Round(Subdiarios.Haber * -1 * IsNull(dncp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then Round(Subdiarios.Haber * -1 * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100 ,2)
			 Else Subdiarios.Haber * -1
		End
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null 
	 Then 	Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
			 Then Round((Subdiarios.Debe - Subdiarios.Haber) * IsNull(dfp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
			 Then Round((Subdiarios.Debe - Subdiarios.Haber) * IsNull(dndp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
			 Then Round((Subdiarios.Debe - Subdiarios.Haber) * IsNull(dncp.Porcentaje,100) / 100 ,2)
			When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			 Then Round((Subdiarios.Debe - Subdiarios.Haber) * IsNull(#Auxiliar2.PorcentajeGeneral,100) / 100 ,2)
			 Else (Subdiarios.Debe - Subdiarios.Haber)
		End
	 Else 0
 End,
 Case 	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=dfp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=Devoluciones.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=dndp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=dncp.IdProvinciaDestino)
	When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
	 Then (Select Provincias.Nombre From Provincias 
		Where Provincias.IdProvincia=OrdenesPago.IdProvinciaDestino)
	 Else 	Case When IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
			Then (Select Provincias.Nombre From Provincias 
				Where Provincias.IdProvincia=#Auxiliar2.IdProvinciaDestino)
			Else Null
		End
 End,
 Null,
 Null
FROM Subdiarios 
LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdComprobanteProveedor=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN DetalleNotasDebitoProvincias dndp ON dndp.IdNotaDebito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN DetalleNotasCreditoProvincias dncp ON dncp.IdNotaCredito=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and 
				Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	Exists(Select Top 1 CuentasGastos.IdCuentaMadre 
		From CuentasGastos
		Where CuentasGastos.IdCuentaMadre=Subdiarios.IdCuenta)

UNION ALL

SELECT 
 Cuentas.IdObra,
 Obras.NumeroObra,
 CuentasGastos.IdRubroContable,
 RubrosContables.Descripcion,
 Obras.IdUnidadOperativa,
 UnidadesOperativas.Descripcion,
 Case 	When DetAsi.Debe is not null and DetAsi.Haber is null 
	 Then DetAsi.Debe
	When DetAsi.Debe is null and DetAsi.Haber is not null 
	 Then DetAsi.Haber * -1
	When DetAsi.Debe is not null and DetAsi.Haber is not null 
	 Then DetAsi.Debe - DetAsi.Haber
	 Else 0
 End,
 Null,
 Null,
 Null
FROM DetalleAsientos DetAsi 
LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
WHERE (Asientos.FechaAsiento between @FechaDesde and @FechaHasta) and 
	Asientos.IdCuentaSubdiario is null and 
	Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null

UNION ALL

SELECT 
 0,
 'Sin Obra',
 0,
 'Sin Rubro',
 0,
 'Sin U.Operativa',
 Case 	When DetAsi.Debe is not null and DetAsi.Haber is null 
	 Then DetAsi.Debe
	When DetAsi.Debe is null and DetAsi.Haber is not null 
	 Then DetAsi.Haber * -1
	When DetAsi.Debe is not null and DetAsi.Haber is not null 
	 Then DetAsi.Debe - DetAsi.Haber
	 Else 0
 End,
 Null,
 Null,
 Null
FROM DetalleAsientos DetAsi  
LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
WHERE (Asientos.FechaAsiento between @FechaDesde and @FechaHasta) and 
	Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	Exists(Select Top 1 CuentasGastos.IdCuentaMadre 
		From CuentasGastos
		Where CuentasGastos.IdCuentaMadre=DetAsi.IdCuenta)

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3

SET NOCOUNT OFF

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts
