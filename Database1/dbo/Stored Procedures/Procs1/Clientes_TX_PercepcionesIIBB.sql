CREATE PROCEDURE [dbo].[Clientes_TX_PercepcionesIIBB]

@Desde datetime,
@Hasta datetime,
@CodigoActividad int = Null, 
@RegistrosResumidos varchar(3) = Null

AS

SET NOCOUNT ON

SET @RegistrosResumidos=IsNull(@RegistrosResumidos,'')

DECLARE @CodigoActividadIIBB int, @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
		@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @A_Id int, @A_NumeroOrden int, @A_NumeroOrden1 int, @proc_name varchar(1000), 
		@Si2 varchar(3), @Formato int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @CodigoActividadIIBB=IsNull((Select Top 1 CodigoActividadIIBB From Empresa Where IdEmpresa=1),0)
SET @CodigoActividad=IsNull(@CodigoActividad,@CodigoActividadIIBB)
SET @Si2='SI2'
SET @Formato=1

CREATE TABLE #Auxiliar1 (IdNotaDebito INTEGER, ImportePercepcion NUMERIC(18,2))
INSERT INTO #Auxiliar1 
 SELECT NotasDebito.IdNotaDebito, 
	IsNull((Select Sum(IsNull(DetND.Importe,0)) 
			From DetalleNotasDebito DetND
			Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto
			Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito and Conceptos.IdCuenta in (Select P.IdCuentaPercepcionIBrutos From Provincias P Where IsNull(P.IdCuentaPercepcionIBrutos,0)<>0)),0)
 FROM NotasDebito 
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @Hasta) and IsNull(NotasDebito.Anulada,'NO')<>'SI'

CREATE TABLE #Auxiliar2 (IdNotaCredito INTEGER, ImportePercepcion NUMERIC(18,2))
INSERT INTO #Auxiliar2 
 SELECT NotasCredito.IdNotaCredito, 
	IsNull((Select Sum(IsNull(DetND.Importe,0)) 
			From DetalleNotasCredito DetND
			Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto
			Where DetND.IdNotaCredito=NotasCredito.IdNotaCredito and Conceptos.IdCuenta in (Select P.IdCuentaPercepcionIBrutos From Provincias P Where IsNull(P.IdCuentaPercepcionIBrutos,0)<>0)),0)
 FROM NotasCredito 
 WHERE (NotasCredito.FechaNotaCredito between @Desde and @Hasta) and IsNull(NotasCredito.Anulada,'NO')<>'SI'

CREATE TABLE #Auxiliar 
			(
			 A_Id INTEGER IDENTITY (1, 1),
			 A_Cliente VARCHAR(100),
			 A_CuitCliente VARCHAR(13),
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(1),
			 A_LetraComprobante VARCHAR(1),
			 A_PuntoVenta INTEGER,
			 A_Numero INTEGER,
			 A_BaseImponible NUMERIC(18,0),
			 A_ImportePercepcion NUMERIC(18,0),
			 A_NumeroCertificadoPercepcionIIBB INTEGER,
			 A_Alicuota NUMERIC(6,0),
			 A_TipoRegistro INTEGER,
			 A_IdProvinciaImpuesto INTEGER,
			 A_ProvinciaImpuesto VARCHAR(50),
			 A_CuitEmpresa VARCHAR(13),
			 A_IBNumeroInscripcion VARCHAR(20),
			 A_Registro VARCHAR(300),
			 A_Registro1 VARCHAR(300),
			 A_ImporteIVA NUMERIC(18,0),
			 A_ImporteTotal NUMERIC(18,0),
			 A_IBCondicion INTEGER,
			 A_IdCodigoIva INTEGER,
			 A_CodigoIBCondicion INTEGER,
			 A_CodigoComprobante VARCHAR(2),
			 A_CodigoActividad INTEGER,
			 A_NumeroOrden INTEGER,
			 A_CodigoNorma INTEGER,
			 A_Jurisdiccion VARCHAR(3)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar ON #Auxiliar (A_Id) ON [PRIMARY]

CREATE TABLE #Auxiliar10 
			(
			 A_IdDetalleOrdenPagoImpuestos INTEGER,
			 A_Origen INTEGER,
			 A_Proveedor VARCHAR(50),
			 A_DireccionProveedor VARCHAR(50),
			 A_LocalidadProveedor VARCHAR(50),
			 A_ProvinciaProveedor VARCHAR(50),
			 A_CuitProveedor VARCHAR(13),
			 A_Fecha DATETIME,
			 A_Numero INTEGER,
			 A_CodigoCondicion INTEGER,
			 A_ImporteTotal NUMERIC(18,0),
			 A_BaseCalculo NUMERIC(18,0),
			 A_Alicuota NUMERIC(6,0),
			 A_ImporteRetencion NUMERIC(18,0),
			 A_NumeroCertificado INTEGER,
			 A_NumeroComprobanteImputado NUMERIC(8,0),
			 A_IdProvinciaImpuesto INTEGER,
			 A_ProvinciaImpuesto VARCHAR(50),
			 A_TipoRegistro INTEGER,
			 A_IdIBCondicion INTEGER,
			 A_IBCondicion VARCHAR(50),
			 A_CuitEmpresa VARCHAR(13),
			 A_IBNumeroInscripcion VARCHAR(20),
			 A_CodigoIBCondicion INTEGER,
			 A_LetraComprobanteImputado VARCHAR(1),
			 A_JurisdiccionProveedor VARCHAR(3),
			 A_NumeroOrden INTEGER,
			 A_Registro VARCHAR(300),
			 A_Registro1 VARCHAR(300),
			 A_IdCodigoIva INTEGER,
			 A_ImporteIVA NUMERIC(18,0),
			 A_SucursalComprobanteImputado INTEGER,
			 A_CodigoComprobante VARCHAR(2),
			 A_FechaComprobante DATETIME,
			 A_ImporteComprobante NUMERIC(18,0),
			 A_CodigoNorma INTEGER,
			 A_CodigoActividad INTEGER,
			 A_CodigoArticuloInciso VARCHAR(3),
			 A_OtrosConceptos NUMERIC(18,0),
			 A_CodigoCategoriaIIBBAlternativo VARCHAR(1)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (A_IdDetalleOrdenPagoImpuestos) ON [PRIMARY]

INSERT INTO #Auxiliar 
 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  Facturas.FechaFactura,
  'F',
  Facturas.TipoABC,
  Facturas.PuntoVenta,
  Facturas.NumeroFactura,
  (Facturas.ImporteTotal - Facturas.ImporteIva1 - Facturas.ImporteIva2 - Facturas.RetencionIBrutos1 - Facturas.RetencionIBrutos2 - Facturas.RetencionIBrutos3) * Facturas.CotizacionMoneda * 100,
  Facturas.RetencionIBrutos1 * Facturas.CotizacionMoneda * 100,
  IsNull(Facturas.NumeroCertificadoPercepcionIIBB,0),
  Facturas.PorcentajeIBrutos1 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  Facturas.ImporteIva1 * 100,
  Facturas.ImporteTotal * 100,
  Clientes.IBCondicion,
  Facturas.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM Facturas 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Facturas.IdIBCondicion
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Facturas.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 WHERE (Facturas.FechaFactura between @Desde and @Hasta) and 
		(Facturas.Anulada is null or Facturas.Anulada<>'SI') and 
		(Facturas.RetencionIBrutos1 is not null and Facturas.RetencionIBrutos1>0)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  Facturas.FechaFactura,
  'F',
  Facturas.TipoABC,
  Facturas.PuntoVenta,
  Facturas.NumeroFactura,
  (Facturas.ImporteTotal - Facturas.ImporteIva1 - Facturas.ImporteIva2 - Facturas.RetencionIBrutos1 - Facturas.RetencionIBrutos2 - Facturas.RetencionIBrutos3) * Facturas.CotizacionMoneda * 100,
  Facturas.RetencionIBrutos2 * Facturas.CotizacionMoneda * 100,  IsNull(Facturas.NumeroCertificadoPercepcionIIBB,0),
  Facturas.PorcentajeIBrutos2 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  Facturas.ImporteIva1 * 100,
  Facturas.ImporteTotal * 100,
  Clientes.IBCondicion,
  Facturas.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM Facturas 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Facturas.IdIBCondicion2
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Facturas.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 WHERE (Facturas.FechaFactura between @Desde and @Hasta) and 
		(Facturas.Anulada is null or Facturas.Anulada<>'SI') and 
		(Facturas.RetencionIBrutos2 is not null and Facturas.RetencionIBrutos2>0) and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  Facturas.FechaFactura,
  'F',
  Facturas.TipoABC,
  Facturas.PuntoVenta,
  Facturas.NumeroFactura,
  (Facturas.ImporteTotal - Facturas.ImporteIva1 - Facturas.ImporteIva2 - Facturas.RetencionIBrutos1 - Facturas.RetencionIBrutos2 - Facturas.RetencionIBrutos3) * Facturas.CotizacionMoneda * 100,
  Facturas.RetencionIBrutos3 * Facturas.CotizacionMoneda * 100,
  IsNull(Facturas.NumeroCertificadoPercepcionIIBB,0),
  Facturas.PorcentajeIBrutos3 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  Facturas.ImporteIva1 * 100,
  Facturas.ImporteTotal * 100,
  Clientes.IBCondicion,
  Facturas.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM Facturas 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Facturas.IdIBCondicion3
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Facturas.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 WHERE (Facturas.FechaFactura between @Desde and @Hasta) and 
		(Facturas.Anulada is null or Facturas.Anulada<>'SI') and 
		(Facturas.RetencionIBrutos3 is not null and Facturas.RetencionIBrutos3>0) and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  Devoluciones.FechaDevolucion,
  'C',
  Devoluciones.TipoABC,
  Devoluciones.PuntoVenta,
  Devoluciones.NumeroDevolucion,
  (Devoluciones.ImporteTotal - Devoluciones.ImporteIva1 - Devoluciones.ImporteIva2 - Devoluciones.RetencionIBrutos1 - Devoluciones.RetencionIBrutos2 - Devoluciones.RetencionIBrutos3) * Devoluciones.CotizacionMoneda * 100,
  Devoluciones.RetencionIBrutos1 * Devoluciones.CotizacionMoneda * 100,
  0,
  Devoluciones.PorcentajeIBrutos1 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  Devoluciones.ImporteIva1 * 100,
  Devoluciones.ImporteTotal * 100,
  Clientes.IBCondicion,
  Devoluciones.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM Devoluciones 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Devoluciones.IdIBCondicion
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Devoluciones.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteDevoluciones
 WHERE (Devoluciones.FechaDevolucion between @Desde and @Hasta) and 
		(Devoluciones.Anulada is null or Devoluciones.Anulada<>'SI') and 
		(Devoluciones.RetencionIBrutos1 is not null and Devoluciones.RetencionIBrutos1>0) and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasDebito.FechaNotaDebito,
  'D',
  NotasDebito.TipoABC,
  NotasDebito.PuntoVenta,
  NotasDebito.NumeroNotaDebito,
  (Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito) * NotasDebito.CotizacionMoneda * 100,
  (IsNull(NotasDebito.RetencionIBrutos1,0)+IsNull(#Auxiliar1.ImportePercepcion,0)) * NotasDebito.CotizacionMoneda * 100,
  NotasDebito.NumeroCertificadoPercepcionIIBB,
  NotasDebito.PorcentajeIBrutos1 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  NotasDebito.ImporteIva1 * 100,
  NotasDebito.ImporteTotal * 100,
  Clientes.IBCondicion,
  NotasDebito.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM NotasDebito 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasDebito.IdCliente
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=IsNull(NotasDebito.IdIBCondicion,Clientes.IdIBCondicionPorDefecto)
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdNotaDebito=NotasDebito.IdNotaDebito
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @Hasta) and IsNull(NotasDebito.Anulada,'NO')<>'SI' and 
		(IsNull(NotasDebito.RetencionIBrutos1,0)<>0 or IsNull(#Auxiliar1.ImportePercepcion,0)<>0) and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasDebito.FechaNotaDebito,
  'D',
  NotasDebito.TipoABC,
  NotasDebito.PuntoVenta,
  NotasDebito.NumeroNotaDebito,
  (Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito) * NotasDebito.CotizacionMoneda * 100,
  NotasDebito.RetencionIBrutos2 * NotasDebito.CotizacionMoneda * 100,
  NotasDebito.NumeroCertificadoPercepcionIIBB,
  NotasDebito.PorcentajeIBrutos2 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  NotasDebito.ImporteIva1 * 100,
  NotasDebito.ImporteTotal * 100,
  Clientes.IBCondicion,
  NotasDebito.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM NotasDebito 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=NotasDebito.IdIBCondicion2
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasDebito.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @Hasta) and 
		IsNull(NotasDebito.Anulada,'NO')<>'SI' and IsNull(NotasDebito.RetencionIBrutos2,0)<>0 and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasDebito.FechaNotaDebito,
  'D',
  NotasDebito.TipoABC,
  NotasDebito.PuntoVenta,
  NotasDebito.NumeroNotaDebito,
  (Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=NotasDebito.IdNotaDebito) * NotasDebito.CotizacionMoneda * 100,
  NotasDebito.RetencionIBrutos3 * NotasDebito.CotizacionMoneda * 100,
  NotasDebito.NumeroCertificadoPercepcionIIBB,
  NotasDebito.PorcentajeIBrutos3 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  NotasDebito.ImporteIva1 * 100,
  NotasDebito.ImporteTotal * 100,
  Clientes.IBCondicion,
  NotasDebito.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM NotasDebito 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=NotasDebito.IdIBCondicion3
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasDebito.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @Hasta) and 
		IsNull(NotasDebito.Anulada,'NO')<>'SI' and IsNull(NotasDebito.RetencionIBrutos3,0)<>0 and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasCredito.FechaNotaCredito,
  'C',
  NotasCredito.TipoABC,
  NotasCredito.PuntoVenta,
  NotasCredito.NumeroNotaCredito,
  (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=NotasCredito.IdNotaCredito) * NotasCredito.CotizacionMoneda * 100,
  (IsNull(NotasCredito.RetencionIBrutos1,0)+IsNull(#Auxiliar2.ImportePercepcion,0)) * NotasCredito.CotizacionMoneda * 100,
  0,
  NotasCredito.PorcentajeIBrutos1 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  NotasCredito.ImporteIva1 * 100,
  NotasCredito.ImporteTotal * 100,
  Clientes.IBCondicion,
  NotasCredito.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM NotasCredito 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasCredito.IdCliente
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=IsNull(NotasCredito.IdIBCondicion,Clientes.IdIBCondicionPorDefecto)
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdNotaCredito=NotasCredito.IdNotaCredito
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 WHERE (NotasCredito.FechaNotaCredito between @Desde and @Hasta) and IsNull(NotasCredito.Anulada,'NO')<>'SI' and 
		(IsNull(NotasCredito.RetencionIBrutos1,0)<>0 or IsNull(#Auxiliar2.ImportePercepcion,0)<>0) and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasCredito.FechaNotaCredito,
  'C',
  NotasCredito.TipoABC,
  NotasCredito.PuntoVenta,
  NotasCredito.NumeroNotaCredito,
  (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=NotasCredito.IdNotaCredito) * NotasCredito.CotizacionMoneda * 100,
  NotasCredito.RetencionIBrutos2 * NotasCredito.CotizacionMoneda * 100,
  0,
  NotasCredito.PorcentajeIBrutos2 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  NotasCredito.ImporteIva1 * 100,
  NotasCredito.ImporteTotal * 100,
  Clientes.IBCondicion,
  NotasCredito.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM NotasCredito 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=NotasCredito.IdIBCondicion2
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasCredito.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 WHERE (NotasCredito.FechaNotaCredito between @Desde and @Hasta) and 
		IsNull(NotasCredito.Anulada,'NO')<>'SI' and IsNull(NotasCredito.RetencionIBrutos2,0)<>0 and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UNION ALL

 SELECT 
  IsNull(Clientes.RazonSocial,''),
  Clientes.Cuit,
  NotasCredito.FechaNotaCredito,
  'C',
  NotasCredito.TipoABC,
  NotasCredito.PuntoVenta,
  NotasCredito.NumeroNotaCredito,
  (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=NotasCredito.IdNotaCredito) * NotasCredito.CotizacionMoneda * 100,
  NotasCredito.RetencionIBrutos3 * NotasCredito.CotizacionMoneda * 100,
  0,
  NotasCredito.PorcentajeIBrutos3 * 100,
  Provincias.TipoRegistroPercepcion,
  IBCondiciones.IdProvincia,
  Provincias.Nombre,
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  Clientes.IBNumeroInscripcion,
  '',
  '',
  NotasCredito.ImporteIva1 * 100,
  NotasCredito.ImporteTotal * 100,
  Clientes.IBCondicion,
  NotasCredito.IdCodigoIva,
  IBCondiciones.Codigo,
  IsNull(tc.CodigoDgi,'00'),
  IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB),
  0,
  IsNull(IBCondiciones.CodigoNormaRetencion,8),
  Substring(IsNull(Provincias.InformacionAuxiliar,''),1,3)
 FROM NotasCredito 
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=NotasCredito.IdIBCondicion3
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=NotasCredito.IdCliente
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 WHERE (NotasCredito.FechaNotaCredito between @Desde and @Hasta) and 
		IsNull(NotasCredito.Anulada,'NO')<>'SI' and IsNull(NotasCredito.RetencionIBrutos3,0)<>0 and 
		(@CodigoActividad=-1 or IsNull(IBCondiciones.CodigoActividad,@CodigoActividadIIBB)=@CodigoActividad)

UPDATE #Auxiliar
SET A_LetraComprobante = 'A'
WHERE A_LetraComprobante IS NULL

UPDATE #Auxiliar
SET A_CuitCliente = '27-00000000-6'
WHERE A_CuitCliente IS NULL OR LEN(RTRIM(A_CuitCliente))=0

UPDATE #Auxiliar
SET A_PuntoVenta = 1
WHERE A_PuntoVenta IS NULL

UPDATE #Auxiliar
SET A_BaseImponible = 0
WHERE A_BaseImponible IS NULL

UPDATE #Auxiliar
SET A_ImportePercepcion = 0
WHERE A_ImportePercepcion IS NULL

UPDATE #Auxiliar
SET A_NumeroCertificadoPercepcionIIBB = 0
WHERE A_NumeroCertificadoPercepcionIIBB IS NULL

UPDATE #Auxiliar
SET A_Alicuota = 0
WHERE A_Alicuota IS NULL

UPDATE #Auxiliar
SET A_TipoRegistro = 0
WHERE A_TipoRegistro IS NULL

UPDATE #Auxiliar
SET A_IBNumeroInscripcion = ''
WHERE A_IBNumeroInscripcion IS NULL

/* Registro para Buenos Aires */
UPDATE #Auxiliar
SET A_Registro = 
	#Auxiliar.A_CuitCliente+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	#Auxiliar.A_TipoComprobante+
	#Auxiliar.A_LetraComprobante+
	Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_PuntoVenta)))+Convert(varchar,#Auxiliar.A_PuntoVenta)+
	Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+
	Case When A_BaseImponible>=0
			Then Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),1,9)+','+
					Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),10,2)+
					Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,8)+','+
					Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),9,2)
			Else '-'+Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_BaseImponible))))+Convert(varchar,abs(#Auxiliar.A_BaseImponible)),1,8)+','+
					Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_BaseImponible))))+Convert(varchar,abs(#Auxiliar.A_BaseImponible)),9,2)+
					'-'+Substring(Substring('000000000',1,9-len(Convert(varchar,abs(#Auxiliar.A_ImportePercepcion))))+Convert(varchar,abs(#Auxiliar.A_ImportePercepcion)),1,7)+','+
					Substring(Substring('000000000',1,9-len(Convert(varchar,abs(#Auxiliar.A_ImportePercepcion))))+Convert(varchar,abs(#Auxiliar.A_ImportePercepcion)),8,2)
	End
WHERE A_TipoRegistro=1

UPDATE #Auxiliar
SET A_Registro1 = 
	#Auxiliar.A_CuitCliente+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	#Auxiliar.A_TipoComprobante+
	#Auxiliar.A_LetraComprobante+
	Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_PuntoVenta)))+Convert(varchar,#Auxiliar.A_PuntoVenta)+
	Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+
	Case When A_BaseImponible>=0
	Then Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),1,9)+','+
				Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),10,2)+
			Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,8)+','+
				Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),9,2)
	Else '-'+Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_BaseImponible))))+Convert(varchar,abs(#Auxiliar.A_BaseImponible)),1,8)+','+
				Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_BaseImponible))))+Convert(varchar,abs(#Auxiliar.A_BaseImponible)),9,2)+
		'-'+Substring(Substring('000000000',1,9-len(Convert(varchar,abs(#Auxiliar.A_ImportePercepcion))))+Convert(varchar,abs(#Auxiliar.A_ImportePercepcion)),1,7)+','+
				Substring(Substring('000000000',1,9-len(Convert(varchar,abs(#Auxiliar.A_ImportePercepcion))))+Convert(varchar,abs(#Auxiliar.A_ImportePercepcion)),8,2)
	End+
	'A'
WHERE A_TipoRegistro=1

/* Registro para Corrientes */
UPDATE #Auxiliar
SET A_Registro = 
	#Auxiliar.A_CuitEmpresa+
	'00'+
	Convert(varchar,Year(#Auxiliar.A_Fecha))+Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+
	Substring( #Auxiliar.A_CuitCliente,1,2)+Substring( #Auxiliar.A_CuitCliente,4,8)+Substring( #Auxiliar.A_CuitCliente,13,1)+
	'00'+
	'00'+Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	Convert(varchar,Year(#Auxiliar.A_Fecha))+'00'+
	Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_NumeroCertificadoPercepcionIIBB)))+Convert(varchar,#Auxiliar.A_NumeroCertificadoPercepcionIIBB)+
	Case When A_BaseImponible>=0
			Then Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),1,9)+','+
					Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),10,2)
			Else '-'+Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_BaseImponible))))+Convert(varchar,abs(#Auxiliar.A_BaseImponible)),1,8)+','+
					Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_BaseImponible))))+Convert(varchar,abs(#Auxiliar.A_BaseImponible)),9,2)
	End+
	Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),1,2)+','+
	Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),3,2)+
	Case When A_BaseImponible>=0
			Then Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,9)+','+
					Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),10,2)
			Else '-'+Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_ImportePercepcion))))+Convert(varchar,abs(#Auxiliar.A_ImportePercepcion)),1,8)+','+
					Substring(Substring('0000000000',1,10-len(Convert(varchar,abs(#Auxiliar.A_ImportePercepcion))))+Convert(varchar,abs(#Auxiliar.A_ImportePercepcion)),9,2)
	End+
	'0'+
	'S'
WHERE A_TipoRegistro=2

/* Registro para Chaco */
UPDATE #Auxiliar
SET A_Registro = ''
WHERE A_TipoRegistro=3

/* Registro para Rio Negro */
UPDATE #Auxiliar
SET A_Registro = 
	#Auxiliar.A_CuitEmpresa+';'+
	'107003562'+';'+
	Convert(varchar,Year(#Auxiliar.A_Fecha))+';'+
	Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+';'+
	'00'+';'+
	Substring( #Auxiliar.A_CuitCliente,1,2)+Substring( #Auxiliar.A_CuitCliente,4,8)+Substring( #Auxiliar.A_CuitCliente,13,1)+';'+
	LTrim(#Auxiliar.A_Cliente)+';'+
	Replace(LTrim(#Auxiliar.A_IBNumeroInscripcion),'-','')+';'+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+';'+
	Convert(varchar,#Auxiliar.A_BaseImponible)+';'+
	Convert(varchar,#Auxiliar.A_Alicuota)+';'+
	Convert(varchar,#Auxiliar.A_ImportePercepcion)+';'+
	#Auxiliar.A_LetraComprobante+
		Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_PuntoVenta)))+Convert(varchar,#Auxiliar.A_PuntoVenta)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)
WHERE A_TipoRegistro=4

/* Registro para Capital Federal */
UPDATE #Auxiliar
SET A_Registro =
	'2'+
	'014'+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	Case When #Auxiliar.A_TipoComprobante='F' Then '01' When #Auxiliar.A_TipoComprobante='D' Then '02' Else '09' End+
	#Auxiliar.A_LetraComprobante+
	'0000'+Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_PuntoVenta)))+Convert(varchar,#Auxiliar.A_PuntoVenta)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImporteTotal)))+Convert(varchar,#Auxiliar.A_ImporteTotal),1,9)+','+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImporteTotal)))+Convert(varchar,#Auxiliar.A_ImporteTotal),10,2)+
		Substring(Convert(varchar,#Auxiliar.A_NumeroCertificadoPercepcionIIBB)+'                ',1,16)+
	'3'+
	Substring( #Auxiliar.A_CuitCliente,1,2)+Substring( #Auxiliar.A_CuitCliente,4,8)+Substring( #Auxiliar.A_CuitCliente,13,1)+
	Case When #Auxiliar.A_IBCondicion=1 or #Auxiliar.A_IBCondicion=4 Then '4' When #Auxiliar.A_IBCondicion=2 Then '2' Else '1' End+
	'0'+Substring('0000000000',1,10-len(Rtrim(LTrim(Substring(Replace(#Auxiliar.A_IBNumeroInscripcion,'-',''),1,10)))))+
		Rtrim(LTrim(Substring(Replace(#Auxiliar.A_IBNumeroInscripcion,'-',''),1,10)))+
	Case When #Auxiliar.A_IdCodigoIva=1 Then '1'
			When #Auxiliar.A_IdCodigoIva=2 Then '2'
			When #Auxiliar.A_IdCodigoIva=3 or #Auxiliar.A_IdCodigoIva=8 or #Auxiliar.A_IdCodigoIva=9 Then '3'
			When #Auxiliar.A_IdCodigoIva=4 or #Auxiliar.A_IdCodigoIva=6 or #Auxiliar.A_IdCodigoIva=7 or #Auxiliar.A_IdCodigoIva=10 Then '4'
			Else '0'
	End+
	Substring(#Auxiliar.A_Cliente+'                              ',1,30)+
	'0000000000000,00'+
	'000000'+Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImporteIVA)))+Convert(varchar,#Auxiliar.A_ImporteIVA),1,7)+','+
		Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImporteIVA)))+Convert(varchar,#Auxiliar.A_ImporteIVA),8,2)+
	'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),1,9)+','+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),10,2)+
	Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),1,2)+','+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),3,2)+
	'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,9)+','+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),10,2)+
	'0000'+Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,9)+','+
		Substring(Substring('00000000000',1,11-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),10,2)
WHERE A_TipoRegistro=7

/* Registro para Cordoba */
UPDATE #Auxiliar
SET A_Registro = 
	#Auxiliar.A_CuitEmpresa+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	'3'+
	Substring('000000000',1,9-len(Rtrim(LTrim(Substring(Replace(#Auxiliar.A_IBNumeroInscripcion,'-',''),1,9)))))+
		Rtrim(LTrim(Substring(Replace(#Auxiliar.A_IBNumeroInscripcion,'-',''),1,9)))+
	Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar.A_NumeroCertificadoPercepcionIIBB)))+Convert(varchar,#Auxiliar.A_NumeroCertificadoPercepcionIIBB)+
	Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion)
WHERE A_TipoRegistro=8

/* Registro para Santa Fe */
UPDATE #Auxiliar
SET A_Registro = 
	'2'+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	'021'+
	Case When #Auxiliar.A_TipoComprobante='F' Then '01' When #Auxiliar.A_TipoComprobante='D' Then '02' Else '09' End+
	#Auxiliar.A_LetraComprobante+
		Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_PuntoVenta)))+Convert(varchar,#Auxiliar.A_PuntoVenta)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+
		'    '+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImporteTotal)))+Convert(varchar,#Auxiliar.A_ImporteTotal),1,7)+','+
		Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImporteTotal)))+Convert(varchar,#Auxiliar.A_ImporteTotal),8,2)+
	'3'+
	Substring(#Auxiliar.A_CuitCliente,1,2)+Substring(#Auxiliar.A_CuitCliente,4,8)+Substring(#Auxiliar.A_CuitCliente,13,1)+
	Case When #Auxiliar.A_CodigoIBCondicion=1 or #Auxiliar.A_CodigoIBCondicion=4 Then '3' Else '1' End+
	Substring('0000000000',1,10-len(Rtrim(LTrim(Substring(Replace(#Auxiliar.A_IBNumeroInscripcion,'-',''),1,10)))))+
		Rtrim(LTrim(Substring(Replace(#Auxiliar.A_IBNumeroInscripcion,'-',''),1,10)))+
	Case When #Auxiliar.A_IdCodigoIva=1 Then '1'
			When #Auxiliar.A_IdCodigoIva=2 Then '2'
			When #Auxiliar.A_IdCodigoIva=3 or #Auxiliar.A_IdCodigoIva=8 or #Auxiliar.A_IdCodigoIva=9 Then '3'
			When #Auxiliar.A_IdCodigoIva=4 or #Auxiliar.A_IdCodigoIva=6 or #Auxiliar.A_IdCodigoIva=7 or #Auxiliar.A_IdCodigoIva=10 Then '4'
			Else '0'
	End+
	'0'+
	'0'+
	'000000000,00'+
	Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImporteIVA)))+Convert(varchar,#Auxiliar.A_ImporteIVA),1,7)+','+
		Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImporteIVA)))+Convert(varchar,#Auxiliar.A_ImporteIVA),8,2)+
	Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),1,7)+','+
		Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),8,2)+
	Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),1,2)+','+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),3,2)+
	Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,7)+','+
		Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),8,2)+
	'000000000,00'+
	Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,7)+','+
		Substring(Substring('000000000',1,9-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),8,2)+
	Substring('000',1,3-len(Convert(varchar,#Auxiliar.A_CodigoIBCondicion)))+Convert(varchar,#Auxiliar.A_CodigoIBCondicion)
WHERE A_TipoRegistro=9

/* Registro para Rio negro (Diseño 2) */
UPDATE #Auxiliar
SET A_Registro = 
	Substring('00',1,2-len(Convert(varchar,#Auxiliar.A_CodigoActividad)))+Convert(varchar,#Auxiliar.A_CodigoActividad)+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+
	A_CodigoComprobante+
	#Auxiliar.A_LetraComprobante+
		Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_PuntoVenta)))+Convert(varchar,#Auxiliar.A_PuntoVenta)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+
	Substring(#Auxiliar.A_CuitCliente,1,2)+Substring(#Auxiliar.A_CuitCliente,4,8)+Substring(#Auxiliar.A_CuitCliente,13,1)+
	Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),1,12)+','+
		Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),13,2)+
	Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),1,2)+','+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),3,2)+
	Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,12)+','+
		Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),13,2)
WHERE A_TipoRegistro=11

/* Registro para La Rioja */
SET @A_NumeroOrden1=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT A_Id FROM #Auxiliar WHERE A_TipoRegistro=12 ORDER BY A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_IBCondicion, A_Fecha, A_Cliente, A_Numero
OPEN Cur
FETCH NEXT FROM Cur INTO @A_Id
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @A_NumeroOrden1=@A_NumeroOrden1+1
	UPDATE #Auxiliar
	SET A_NumeroOrden = @A_NumeroOrden1 
	WHERE A_Id=@A_Id
	FETCH NEXT FROM Cur INTO @A_Id
  END
CLOSE Cur
DEALLOCATE Cur

UPDATE #Auxiliar
SET A_Registro = 
	Substring('00000',1,5-len(Convert(varchar,#Auxiliar.A_NumeroOrden)))+Convert(varchar,#Auxiliar.A_NumeroOrden)+','+
	'1'+','+
	'1'+','+
	Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar.A_Numero)))+Convert(varchar,#Auxiliar.A_Numero)+','+
	Substring(#Auxiliar.A_CuitCliente,1,2)+Substring(#Auxiliar.A_CuitCliente,4,8)+Substring(#Auxiliar.A_CuitCliente,13,1)+','+
	Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
		Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
		Convert(varchar,Year(#Auxiliar.A_Fecha))+','+
	Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),1,9)+'.'+
		Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar.A_BaseImponible)))+Convert(varchar,#Auxiliar.A_BaseImponible),11,2)+','+
	Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),1,3)+'.'+
		Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar.A_Alicuota)))+Convert(varchar,#Auxiliar.A_Alicuota),4,2)+','+
	Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),1,9)+'.'+
		Substring(Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar.A_ImportePercepcion)))+Convert(varchar,#Auxiliar.A_ImportePercepcion),11,2)+','+
	Substring('000',1,3-len(Convert(varchar,#Auxiliar.A_CodigoNorma)))+Convert(varchar,#Auxiliar.A_CodigoNorma)+','+
	Substring(LTrim(#Auxiliar.A_Jurisdiccion)+'   ',1,3)
WHERE A_TipoRegistro=12

--Arciba, el SI2 es para que no haga un bucle infinito
IF @RegistrosResumidos<>'SI2'
  BEGIN
	SET @proc_name='Proveedores_TX_RetencionesIIBB'
	INSERT INTO #Auxiliar10 
		EXECUTE @proc_name @Desde, @Hasta, @Formato, @CodigoActividad, @Si2

	DECLARE @A_IdDetalleOrdenPagoImpuestos int, @A_Origen int, @A_Proveedor varchar(50), @A_DireccionProveedor varchar(50), @A_LocalidadProveedor varchar(50), 
			@A_ProvinciaProveedor varchar(50), @A_CuitProveedor varchar(13), @A_Fecha datetime, @A_Numero int, @A_CodigoCondicion int, @A_ImporteTotal numeric(18,0), 
			@A_BaseCalculo numeric(18,0), @A_Alicuota numeric(6,0), @A_ImporteRetencion numeric(18,0), @A_NumeroCertificado int, @A_NumeroComprobanteImputado numeric(8,0), 
			@A_IdProvinciaImpuesto int, @A_ProvinciaImpuesto varchar(50), @A_TipoRegistro int, @A_IdIBCondicion int, @A_IBCondicion varchar(50), @A_CuitEmpresa varchar(13), 
			@A_IBNumeroInscripcion varchar(20), @A_CodigoIBCondicion int, @A_LetraComprobanteImputado varchar(1), @A_JurisdiccionProveedor varchar(3), 
			@A_Registro varchar(300), @A_Registro1 varchar(300), @A_IdCodigoIva int, @A_ImporteIVA numeric(18,0), @A_SucursalComprobanteImputado int, 
			@A_CodigoComprobante varchar(2), @A_FechaComprobante datetime, @A_ImporteComprobante numeric(18,0), @A_CodigoNorma int, @A_CodigoActividad int, 
			@A_CodigoArticuloInciso varchar(3), @A_OtrosConceptos numeric(18,0), @A_CodigoCategoriaIIBBAlternativo varchar(1)

	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
			SELECT A_IdDetalleOrdenPagoImpuestos, A_Origen, A_Proveedor, A_DireccionProveedor, A_LocalidadProveedor, A_ProvinciaProveedor, A_CuitProveedor, 
					A_Fecha, A_Numero, A_CodigoCondicion, A_ImporteTotal, A_BaseCalculo, A_Alicuota, A_ImporteRetencion, A_NumeroCertificado, A_NumeroComprobanteImputado,
					A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_TipoRegistro, A_IdIBCondicion, A_IBCondicion, A_CuitEmpresa, A_IBNumeroInscripcion, A_CodigoIBCondicion,
					A_LetraComprobanteImputado, A_JurisdiccionProveedor, A_NumeroOrden, A_Registro, A_Registro1, A_IdCodigoIva, A_ImporteIVA, A_SucursalComprobanteImputado,
					A_CodigoComprobante, A_FechaComprobante, A_ImporteComprobante, A_CodigoNorma, A_CodigoActividad, A_CodigoArticuloInciso, A_OtrosConceptos,
					A_CodigoCategoriaIIBBAlternativo
			FROM #Auxiliar10
			WHERE A_TipoRegistro=7
			ORDER BY A_IdDetalleOrdenPagoImpuestos

	OPEN Cur
	FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_Proveedor, @A_DireccionProveedor, @A_LocalidadProveedor, @A_ProvinciaProveedor, @A_CuitProveedor, 
							 @A_Fecha, @A_Numero, @A_CodigoCondicion, @A_ImporteTotal, @A_BaseCalculo, @A_Alicuota, @A_ImporteRetencion, @A_NumeroCertificado, 
							 @A_NumeroComprobanteImputado, @A_IdProvinciaImpuesto, @A_ProvinciaImpuesto, @A_TipoRegistro, @A_IdIBCondicion, @A_IBCondicion, @A_CuitEmpresa, 
							 @A_IBNumeroInscripcion, @A_CodigoIBCondicion, @A_LetraComprobanteImputado, @A_JurisdiccionProveedor, @A_NumeroOrden, @A_Registro, @A_Registro1, 
							 @A_IdCodigoIva, @A_ImporteIVA, @A_SucursalComprobanteImputado, @A_CodigoComprobante, @A_FechaComprobante, @A_ImporteComprobante, @A_CodigoNorma, 
							 @A_CodigoActividad, @A_CodigoArticuloInciso, @A_OtrosConceptos, @A_CodigoCategoriaIIBBAlternativo
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		INSERT INTO #Auxiliar
		(A_Cliente, A_CuitCliente, A_Fecha, A_TipoComprobante, A_LetraComprobante, A_PuntoVenta, A_Numero, A_BaseImponible, A_ImportePercepcion, 
		 A_NumeroCertificadoPercepcionIIBB, A_Alicuota, A_TipoRegistro, A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_CuitEmpresa, A_IBNumeroInscripcion,
		 A_Registro, A_Registro1, A_ImporteIVA, A_ImporteTotal, A_IBCondicion, A_IdCodigoIva, A_CodigoIBCondicion, A_CodigoComprobante, A_CodigoActividad,
		 A_NumeroOrden, A_CodigoNorma, A_Jurisdiccion)
		VALUES
		(@A_Proveedor, @A_CuitProveedor, @A_Fecha, 'F', @A_LetraComprobanteImputado, 0, @A_Numero, @A_BaseCalculo, @A_ImporteRetencion, @A_NumeroCertificado, 
		 @A_Alicuota, 0, @A_IdProvinciaImpuesto, @A_ProvinciaImpuesto, @A_CuitEmpresa, @A_IBNumeroInscripcion, @A_Registro, @A_Registro1, @A_ImporteIVA, 
		 @A_ImporteComprobante, @A_IBCondicion, @A_IdCodigoIva, 0, @A_CodigoComprobante, @A_CodigoActividad, @A_NumeroOrden, @A_CodigoNorma, @A_JurisdiccionProveedor)

		FETCH NEXT FROM Cur INTO @A_IdDetalleOrdenPagoImpuestos, @A_Origen, @A_Proveedor, @A_DireccionProveedor, @A_LocalidadProveedor, @A_ProvinciaProveedor, @A_CuitProveedor, 
								 @A_Fecha, @A_Numero, @A_CodigoCondicion, @A_ImporteTotal, @A_BaseCalculo, @A_Alicuota, @A_ImporteRetencion, @A_NumeroCertificado, 
								 @A_NumeroComprobanteImputado, @A_IdProvinciaImpuesto, @A_ProvinciaImpuesto, @A_TipoRegistro, @A_IdIBCondicion, @A_IBCondicion, @A_CuitEmpresa, 
								 @A_IBNumeroInscripcion, @A_CodigoIBCondicion, @A_LetraComprobanteImputado, @A_JurisdiccionProveedor, @A_NumeroOrden, @A_Registro, @A_Registro1, 
								 @A_IdCodigoIva, @A_ImporteIVA, @A_SucursalComprobanteImputado, @A_CodigoComprobante, @A_FechaComprobante, @A_ImporteComprobante, @A_CodigoNorma, 
								 @A_CodigoActividad, @A_CodigoArticuloInciso, @A_OtrosConceptos, @A_CodigoCategoriaIIBBAlternativo
	  END
	CLOSE Cur
	DEALLOCATE Cur
  END
  
SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0001111111111111111111133'
SET @vector_T='0005555555555555555555500'

IF @RegistrosResumidos=''
  BEGIN
	SELECT 
	 0 as [IdAux],
	 1 as [K_Tipo],
	 A_IdProvinciaImpuesto as [K_IdProvinciaImpuesto],
	 A_Cliente as [Entidad],
	 A_CuitCliente as [Cuit cliente],
	 A_Fecha as [Fecha Cmp.],
	 A_TipoComprobante as [Tipo Cmp.],
	 A_LetraComprobante as [Letra Cmp.],
	 A_PuntoVenta as [Punto venta],
	 A_Numero as [Numero Cmp.],
	 A_BaseImponible/100 as [Base Imp.],
	 A_ImportePercepcion/100 as [Importe perc.],
	 A_NumeroCertificadoPercepcionIIBB as [Numero certificado],
	 A_Alicuota/100 as [Alicuota],
	 A_ProvinciaImpuesto as [IIBB Provincia],
	 A_CuitEmpresa as [CUIT Empresa],
	 A_TipoRegistro as [Tipo registro],
	 A_Registro as [Registro],
	 A_ImporteIVA as [Importe IVA],
	 A_ImporteTotal as [Importe total],
	 A_IBCondicion as [Cond.IIBB],
	 A_IdCodigoIva as [Cond.IVA],
	 A_Registro1 as [Registro Web],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 

	UNION ALL

	SELECT 
	 0 as [IdAux],
	 2 as [K_Tipo],
	 A_IdProvinciaImpuesto as [K_IdProvinciaImpuesto],
	 'TOTAL PROVINCIA' as [Entidad],
	 Null as [Cuit cliente],
	 Null as [Fecha Cmp.],
	 Null as [Tipo Cmp.],
	 Null as [Letra Cmp.],
	 Null as [Punto venta],
	 Null as [Numero Cmp.],
	 Null as [Base Imp.],
	 SUM(A_ImportePercepcion/100) as [Importe perc.],
	 Null as [Numero certificado],
	 Null as [Alicuota],
	 Null as [IIBB Provincia],
	 Null as [CUIT Empresa],
	 Null as [Tipo registro],
	 Null as [Registro],
	 Null as [Importe IVA],
	 Null as [Importe total],
	 Null as [Cond.IIBB],
	 Null as [Cond.IVA],
	 Null as [Registro Web],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	GROUP BY A_IdProvinciaImpuesto

	UNION ALL

	SELECT 
	 0 as [IdAux],
	 3 as [K_Tipo],
	 A_IdProvinciaImpuesto as [K_IdProvinciaImpuesto],
	 Null as [Entidad],
	 Null as [Cuit cliente],
	 Null as [Fecha Cmp.],
	 Null as [Tipo Cmp.],
	 Null as [Letra Cmp.],
	 Null as [Punto venta],
	 Null as [Numero Cmp.],
	 Null as [Base Imp.],
	 Null as [Importe perc.],
	 Null as [Numero certificado],
	 Null as [Alicuota],
	 Null as [IIBB Provincia],
	 Null as [CUIT Empresa],
	 Null as [Tipo registro],
	 Null as [Registro],
	 Null as [Importe IVA],
	 Null as [Importe total],
	 Null as [Cond.IIBB],
	 Null as [Cond.IVA],
	 Null as [Registro Web],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 
	GROUP BY A_IdProvinciaImpuesto

	UNION ALL

	SELECT 
	 0 as [IdAux],
	 4 as [K_Tipo],
	 999999 as [K_IdProvinciaImpuesto],
	 'TOTAL GENERAL' as [Entidad],
	 Null as [Cuit cliente],
	 Null as [Fecha Cmp.],
	 Null as [Tipo Cmp.],
	 Null as [Letra Cmp.],
	 Null as [Punto venta],
	 Null as [Numero Cmp.],
	 Null as [Base Imp.],
	 SUM(A_ImportePercepcion/100) as [Importe perc.],
	 Null as [Numero certificado],
	 Null as [Alicuota],
	 Null as [IIBB Provincia],
	 Null as [CUIT Empresa],
	 Null as [Tipo registro],
	 Null as [Registro],
	 Null as [Importe IVA],
	 Null as [Importe total],
	 Null as [Cond.IIBB],
	 Null as [Cond.IVA],
	 Null as [Registro Web],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar 

	ORDER By [K_IdProvinciaImpuesto], [K_Tipo], A_ProvinciaImpuesto, A_Fecha, A_Cliente, A_Numero
  END
ELSE
	SELECT *
	FROM #Auxiliar 
	ORDER By A_IdProvinciaImpuesto, A_ProvinciaImpuesto, A_Fecha, A_Cliente, A_Numero

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar10
