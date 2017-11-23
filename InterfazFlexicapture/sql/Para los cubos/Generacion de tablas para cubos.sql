/*

Generar DW_DimFecha.sql

*/

SET DATEFIRST 1

Truncate Table DW_DimFecha

Declare @Dia int, @ClaveFecha int, @Fecha datetime, @NombreDiaSemana varchar(10), @NumeroDiaSemana tinyint, @NumeroDiaMes tinyint, @NumeroDiaAño smallint, 
	@NumeroSemanaAño tinyint, @NombreMes varchar(10), @NumeroMes tinyint, @NumeroTrimestre tinyint, @NumeroAño smallint, @NumeroSemestre tinyint

Set @Dia=0
While @Dia<>7671
   Begin
	Set @Fecha=DateAdd(day,@Dia,Convert(datetime,'1/1/2000',103))
	Set @ClaveFecha=Convert(int,
				 Convert(varchar,Year(@Fecha))+
				 Substring('00',1,2-len(Convert(varchar,Month(@Fecha))))+Convert(varchar,Month(@Fecha))+
				 Substring('00',1,2-len(Convert(varchar,Day(@Fecha))))+Convert(varchar,Day(@Fecha))
				)
	Set @NumeroDiaSemana=DatePart(dw,@Fecha)
	Set @NombreDiaSemana=Case When @NumeroDiaSemana=1 Then 'Lunes' When @NumeroDiaSemana=2 Then 'Martes' When @NumeroDiaSemana=3 Then 'Miercoles' When @NumeroDiaSemana=4 Then 'Jueves'
				When @NumeroDiaSemana=5 Then 'Viernes' When @NumeroDiaSemana=6 Then 'Sabado' When @NumeroDiaSemana=7 Then 'Domingo' Else '' End
	Set @NumeroDiaMes=Day(@Fecha)
	Set @NumeroMes=Month(@Fecha)
	Set @NumeroAño=Year(@Fecha)
	Set @NombreMes=Case When Month(@Fecha)=1 Then 'Enero' When Month(@Fecha)=2 Then 'Febrero' When Month(@Fecha)=3 Then 'Marzo' When Month(@Fecha)=4 Then 'Abril'
				When Month(@Fecha)=5 Then 'Mayo' When Month(@Fecha)=6 Then 'Junio' When Month(@Fecha)=7 Then 'Julio' When Month(@Fecha)=8 Then 'Agosto'
				When Month(@Fecha)=9 Then 'Setiembre' When Month(@Fecha)=10 Then 'Octubre' When Month(@Fecha)=11 Then 'Noviembre' When Month(@Fecha)=12 Then 'Diciembre' Else '' End
	Set @NumeroDiaAño=DatePart(dy,@Fecha)
	Set @NumeroSemanaAño=DatePart(wk,@Fecha)
	Set @NumeroTrimestre=DatePart(qq,@Fecha)
	Set @NumeroSemestre=Case When @NumeroMes<=6 Then 1 Else 2 End

	Insert Into DW_DimFecha
	(ClaveFecha, Fecha, NombreDiaSemana, NumeroDiaSemana, NumeroDiaMes, NumeroDiaAño, NumeroSemanaAño, NombreMes, NumeroMes, NumeroTrimestre, NumeroAño, NumeroSemestre)
	Values
	(@ClaveFecha, @Fecha, @NombreDiaSemana, @NumeroDiaSemana, @NumeroDiaMes, @NumeroDiaAño, @NumeroSemanaAño, @NombreMes, @NumeroMes, @NumeroTrimestre, @NumeroAño, @NumeroSemestre)

	Set @Dia=@Dia+1
   End

Select * From DW_DimFecha Order By ClaveFecha



/*

Procesar dimensiones y fact tables.sql

*/

TRUNCATE TABLE DW_DimProveedores
TRUNCATE TABLE DW_DimLocalidades
TRUNCATE TABLE DW_DimProvincias
TRUNCATE TABLE DW_DimPaises
TRUNCATE TABLE DW_DimDescripcionIva
TRUNCATE TABLE DW_DimArticulos
TRUNCATE TABLE DW_DimRubros
TRUNCATE TABLE DW_DimSubrubros
TRUNCATE TABLE DW_DimPresupuestoObras
TRUNCATE TABLE DW_DimClientes
TRUNCATE TABLE DW_DimVendedores
TRUNCATE TABLE DW_DimObras
TRUNCATE TABLE DW_DimComprobantes
TRUNCATE TABLE DW_DimColores
TRUNCATE TABLE DW_DimDepositos
TRUNCATE TABLE DW_DimUbicaciones
TRUNCATE TABLE DW_DimUnidades
TRUNCATE TABLE DW_DimUnidadesOperativas
TRUNCATE TABLE DW_DimRubrosContables
TRUNCATE TABLE DW_DimTiposMovimiento
TRUNCATE TABLE DW_DimMonedas

TRUNCATE TABLE DW_FactPedidos
TRUNCATE TABLE DW_FactPresupuestoObras
TRUNCATE TABLE DW_FactPresupuestoObrasReal
TRUNCATE TABLE DW_FactVentas
TRUNCATE TABLE DW_FactStock
TRUNCATE TABLE DW_FactIngresosEgresosPorObra
TRUNCATE TABLE DW_FactProyeccionEgresos
TRUNCATE TABLE DW_FactCuadroGastosDetallado
TRUNCATE TABLE DW_FactPresupuestoFinanciero
TRUNCATE TABLE DW_FactPosicionFinanciera
TRUNCATE TABLE DW_FactBalance

EXEC _TempCondicionesCompra_Generar

/*=====================================*/
/* INICIALIZAR VARIABLES               */
/*=====================================*/
DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int, 
		@ModeloContableSinApertura varchar(2), @Formato varchar(10), @proc_name varchar(100), @nada varchar(10), @Desde datetime, @Hasta datetime, @AuxI1 int, @AuxI2 int, @IncluirCierre varchar(2), @Si varchar(2)

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @ModeloContableSinApertura=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ModeloContableSinApertura'),'NO')
SET @Formato='SinFormato'
SET @nada=''
SET @Desde=Convert(datetime,'1/1/2000',103)
SET @Hasta=GetDate()
SET @AuxI1=-1
SET @AuxI2=0
SET @Si='SI'


/*=====================================*/
/* PROCESAR DIMENSIONES                */
/*=====================================*/
INSERT INTO DW_DimProveedores
 SELECT 0, Null, ' Sin proveedor', Null, Null, Null, Null, Null, Null, Null, Null, Null
 UNION ALL
 SELECT IdProveedor, CodigoEmpresa, RazonSocial, Direccion, IdLocalidad, CodigoPostal, IdProvincia, IdPais, Telefono1, Email, Cuit, IdCodigoIva
 FROM Proveedores

INSERT INTO DW_DimLocalidades
 SELECT 0, ' Sin localidad'
 UNION ALL
 SELECT IdLocalidad, Nombre
 FROM Localidades

INSERT INTO DW_DimProvincias
 SELECT 0, ' Sin provincia'
 UNION ALL
 SELECT IdProvincia, Nombre
 FROM Provincias

INSERT INTO DW_DimPaises
 SELECT 0, ' Sin pais'
 UNION ALL
 SELECT IdPais, Descripcion
 FROM Paises

INSERT INTO DW_DimDescripcionIva
 SELECT 0, ' Sin condicion'
 UNION ALL
 SELECT IdCodigoIva, Descripcion
 FROM DescripcionIva

INSERT INTO DW_DimArticulos
 SELECT 0, Null, 0, 0, ' Sin articulo', 0
 UNION ALL
 SELECT IdArticulo, Codigo, IdRubro, IdSubrubro, Descripcion, CostoReposicion
 FROM Articulos
 UNION ALL
 SELECT IdConcepto*-1, Null, 0, 0, Descripcion, 0
 FROM Conceptos
UPDATE DW_DimArticulos
SET IdRubro=0
WHERE Not Exists(Select Top 1 a.IdRubro From Rubros a Where a.IdRubro=DW_DimArticulos.IdRubro)
UPDATE DW_DimArticulos
SET IdSubrubro=0
WHERE Not Exists(Select Top 1 a.IdSubrubro From Subrubros a Where a.IdSubrubro=DW_DimArticulos.IdSubrubro)

INSERT INTO DW_DimRubros
 SELECT 0, ' Sin rubro'
 UNION ALL
 SELECT IdRubro, Descripcion
 FROM Rubros

INSERT INTO DW_DimSubrubros
 SELECT 0, ' Sin subrubro'
 UNION ALL
 SELECT IdSubrubro, Descripcion
 FROM Subrubros

INSERT INTO DW_DimPresupuestoObras
 EXEC PresupuestoObrasNodos_TX_ParaArbol
 
INSERT INTO DW_DimClientes
 SELECT 0, Null, ' Sin cliente', Null, Null, Null, Null, Null, Null, Null, Null, Null
 UNION ALL
 SELECT IdCliente, CodigoCliente, RazonSocial, Direccion, IdLocalidad, CodigoPostal, IdProvincia, IdPais, Telefono, Email, Cuit, IdCodigoIva
 FROM Clientes

INSERT INTO DW_DimVendedores
 SELECT 0, ' Sin vendedor'
 UNION ALL
 SELECT IdVendedor, Nombre
 FROM Vendedores

INSERT INTO DW_DimObras
 SELECT 0, Null, ' Sin obra', 0
 UNION ALL
 SELECT IdObra, NumeroObra, Descripcion, IdUnidadOperativa
 FROM Obras
UPDATE DW_DimObras
SET IdUnidadOperativa=0
WHERE Not Exists(Select Top 1 a.IdUnidadOperativa From UnidadesOperativas a Where a.IdUnidadOperativa=DW_DimObras.IdUnidadOperativa)

INSERT INTO DW_DimColores
 SELECT 0, ' Sin color'
 UNION ALL
 SELECT IdColor, Descripcion
 FROM Colores

INSERT INTO DW_DimDepositos
 SELECT 0, ' Sin deposito'
 UNION ALL
 SELECT IdDeposito, Descripcion
 FROM Depositos

INSERT INTO DW_DimUbicaciones
 SELECT 0, ' Sin ubicacion', 0
 UNION ALL
 SELECT IdUbicacion, IsNull(', '+Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+IsNull(' - Est.:'+Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
		IsNull(' - Mod.:'+Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+IsNull(' - Gab.:'+Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,''), IdDeposito
 FROM Ubicaciones
UPDATE DW_DimUbicaciones
SET IdDeposito=0
WHERE Not Exists(Select Top 1 a.IdDeposito From Depositos a Where a.IdDeposito=DW_DimUbicaciones.IdDeposito)

INSERT INTO DW_DimUnidades
 SELECT 0, ' Sin unidad'
 UNION ALL
 SELECT IdUnidad, Abreviatura
 FROM Unidades

INSERT INTO DW_DimRubrosContables
 SELECT 0, ' Sin rubro contable'
 UNION ALL
 SELECT -1, 'Ventas'
 UNION ALL
 SELECT IdRubroContable, Descripcion
 FROM RubrosContables

INSERT INTO DW_DimUnidadesOperativas
 SELECT 0, ' Sin unidad'
 UNION ALL
 SELECT IdUnidadOperativa, Descripcion
 FROM UnidadesOperativas

INSERT INTO DW_DimTiposMovimiento
 SELECT 0, ' Sin tipo movimiento'
 UNION ALL
 SELECT 1, 'Ingresos'
 UNION ALL
 SELECT 2, 'Egresos (Gastos)'
 UNION ALL
 SELECT 3, 'Egresos (Bienes/Servicios)'

INSERT INTO DW_DimMonedas
 SELECT 0, ' Sin moneda'
 UNION ALL
 SELECT IdMoneda, Nombre
 FROM Monedas

/*=====================================*/
/* PROCESO DE COMPROBANTES             */
/*=====================================*/
INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1000000000000000'), 'S/D', Null, Null, 0, 0, 0, 0, 0, 20000101, 0, 0, 0, 0, 0

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'001'+Substring('000000000000',1,12-Len(Convert(varchar,Facturas.IdFactura)))+Convert(varchar,Facturas.IdFactura)), 
		tc.DescripcionAb+' '+Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura), --+' '+Convert(varchar(10),Facturas.FechaFactura,103), 
		Null, Null, 0, 0, 0, IsNull(Facturas.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(Facturas.FechaFactura))+
			Substring('00',1,2-len(Convert(varchar,Month(Facturas.FechaFactura))))+Convert(varchar,Month(Facturas.FechaFactura))+
			Substring('00',1,2-len(Convert(varchar,Day(Facturas.FechaFactura))))+Convert(varchar,Day(Facturas.FechaFactura))),
		Facturas.IdCliente, 0, Facturas.IdVendedor, 1, Facturas.IdFactura
 FROM Facturas
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=1
 WHERE IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'001'+Substring('000000000000',1,12-Len(Convert(varchar,df.IdDetalleFactura)))+Convert(varchar,df.IdDetalleFactura)), 
		tc.DescripcionAb+' '+Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura), --+' '+Convert(varchar(10),Facturas.FechaFactura,103), 
		Null, Null, df.IdArticulo, df.IdUnidad, 0, 
		IsNull((Select Top 1 OrdenesCompra.IdObra From DetalleFacturasOrdenesCompra dfoc 
					Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
					Left Outer Join OrdenesCompra On doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
					Where dfoc.IdDetalleFactura=df.IdDetalleFactura),Facturas.IdObra), 0, 
		Convert(int,Convert(varchar,Year(Facturas.FechaFactura))+
			Substring('00',1,2-len(Convert(varchar,Month(Facturas.FechaFactura))))+Convert(varchar,Month(Facturas.FechaFactura))+
			Substring('00',1,2-len(Convert(varchar,Day(Facturas.FechaFactura))))+Convert(varchar,Day(Facturas.FechaFactura))),
		Facturas.IdCliente, 0, Facturas.IdVendedor, 1, df.IdFactura
 FROM DetalleFacturas df
 LEFT OUTER JOIN Facturas ON df.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=1
 WHERE IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'005'+Substring('000000000000',1,12-Len(Convert(varchar,Devoluciones.IdDevolucion)))+Convert(varchar,Devoluciones.IdDevolucion)), 
		tc.DescripcionAb+' '+Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion), --+' '+Convert(varchar,Devoluciones.FechaDevolucion,103), 
		Null, Null, 0, 0, 0, IsNull(Devoluciones.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(Devoluciones.FechaDevolucion))+
			Substring('00',1,2-len(Convert(varchar,Month(Devoluciones.FechaDevolucion))))+Convert(varchar,Month(Devoluciones.FechaDevolucion))+
			Substring('00',1,2-len(Convert(varchar,Day(Devoluciones.FechaDevolucion))))+Convert(varchar,Day(Devoluciones.FechaDevolucion))),
		Devoluciones.IdCliente, 0, Devoluciones.IdVendedor, 5, Devoluciones.IdDevolucion
 FROM Devoluciones
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=5
 WHERE IsNull(Devoluciones.Anulada,'')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'005'+Substring('000000000000',1,12-Len(Convert(varchar,dv.IdDetalleDevolucion)))+Convert(varchar,dv.IdDetalleDevolucion)), 
		tc.DescripcionAb+' '+Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion), --+' '+Convert(varchar,Devoluciones.FechaDevolucion,103), 
		dv.Partida, dv.NumeroCaja, dv.IdArticulo, dv.IdUnidad, dv.IdUbicacion, IsNull(dv.IdObra,Devoluciones.IdObra), 0, 
		Convert(int,Convert(varchar,Year(Devoluciones.FechaDevolucion))+
			Substring('00',1,2-len(Convert(varchar,Month(Devoluciones.FechaDevolucion))))+Convert(varchar,Month(Devoluciones.FechaDevolucion))+
			Substring('00',1,2-len(Convert(varchar,Day(Devoluciones.FechaDevolucion))))+Convert(varchar,Day(Devoluciones.FechaDevolucion))),
		Devoluciones.IdCliente, 0, Devoluciones.IdVendedor, 5, dv.IdDevolucion
 FROM DetalleDevoluciones dv
 LEFT OUTER JOIN Devoluciones ON dv.IdDevolucion = Devoluciones.IdDevolucion
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=5
 WHERE IsNull(Devoluciones.Anulada,'')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'003'+Substring('000000000000',1,12-Len(Convert(varchar,NotasDebito.IdNotaDebito)))+Convert(varchar,NotasDebito.IdNotaDebito)),
		tc.DescripcionAb+' '+NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito), --+' '+Convert(varchar,NotasDebito.FechaNotaDebito,103), 
		Null, Null, 0, 0, 0, IsNull(NotasDebito.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(NotasDebito.FechaNotaDebito))+
			Substring('00',1,2-len(Convert(varchar,Month(NotasDebito.FechaNotaDebito))))+Convert(varchar,Month(NotasDebito.FechaNotaDebito))+
			Substring('00',1,2-len(Convert(varchar,Day(NotasDebito.FechaNotaDebito))))+Convert(varchar,Day(NotasDebito.FechaNotaDebito))),
		NotasDebito.IdCliente, 0, NotasDebito.IdVendedor, 3, NotasDebito.IdNotaDebito
 FROM NotasDebito
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=3
 WHERE IsNull(NotasDebito.Anulada,'NO')<>'SI' --and IsNull(NotasDebito.CtaCte,'SI')='SI' and IsNull(NotasDebito.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'003'+Substring('000000000000',1,12-Len(Convert(varchar,dnb.IdDetalleNotaDebito)))+Convert(varchar,dnb.IdDetalleNotaDebito)),
		tc.DescripcionAb+' '+NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito), --+' '+Convert(varchar,NotasDebito.FechaNotaDebito,103), 
		Null, Null, dnb.IdConcepto*-1, 0, 0, NotasDebito.IdObra, 0, 
		Convert(int,Convert(varchar,Year(NotasDebito.FechaNotaDebito))+
			Substring('00',1,2-len(Convert(varchar,Month(NotasDebito.FechaNotaDebito))))+Convert(varchar,Month(NotasDebito.FechaNotaDebito))+
			Substring('00',1,2-len(Convert(varchar,Day(NotasDebito.FechaNotaDebito))))+Convert(varchar,Day(NotasDebito.FechaNotaDebito))),
		NotasDebito.IdCliente, 0, NotasDebito.IdVendedor, 3, dnb.IdNotaDebito
 FROM DetalleNotasDebito dnb
 LEFT OUTER JOIN NotasDebito ON dnb.IdNotaDebito = NotasDebito.IdNotaDebito
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=3
 WHERE IsNull(NotasDebito.Anulada,'NO')<>'SI' --and IsNull(NotasDebito.CtaCte,'SI')='SI' and IsNull(NotasDebito.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'004'+Substring('000000000000',1,12-Len(Convert(varchar,NotasCredito.IdNotaCredito)))+Convert(varchar,NotasCredito.IdNotaCredito)), 
		tc.DescripcionAb+' '+NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito), --+' '+Convert(varchar,NotasCredito.FechaNotaCredito,103), 
		Null, Null, 0, 0, 0, IsNull(NotasCredito.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(NotasCredito.FechaNotaCredito))+
			Substring('00',1,2-len(Convert(varchar,Month(NotasCredito.FechaNotaCredito))))+Convert(varchar,Month(NotasCredito.FechaNotaCredito))+
			Substring('00',1,2-len(Convert(varchar,Day(NotasCredito.FechaNotaCredito))))+Convert(varchar,Day(NotasCredito.FechaNotaCredito))),
		NotasCredito.IdCliente, 0, NotasCredito.IdVendedor, 4, NotasCredito.IdNotaCredito
 FROM NotasCredito
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=4
 WHERE IsNull(NotasCredito.Anulada,'NO')<>'SI' --and IsNull(NotasCredito.CtaCte,'SI')='SI' and IsNull(NotasCredito.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'004'+Substring('000000000000',1,12-Len(Convert(varchar,dnc.IdDetalleNotaCredito)))+Convert(varchar,dnc.IdDetalleNotaCredito)), 
		tc.DescripcionAb+' '+NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito), --+' '+Convert(varchar,NotasCredito.FechaNotaCredito,103), 
		Null, Null, dnc.IdConcepto*-1, 0, 0, NotasCredito.IdObra, 0, 
		Convert(int,Convert(varchar,Year(NotasCredito.FechaNotaCredito))+
			Substring('00',1,2-len(Convert(varchar,Month(NotasCredito.FechaNotaCredito))))+Convert(varchar,Month(NotasCredito.FechaNotaCredito))+
			Substring('00',1,2-len(Convert(varchar,Day(NotasCredito.FechaNotaCredito))))+Convert(varchar,Day(NotasCredito.FechaNotaCredito))),
		NotasCredito.IdCliente, 0, NotasCredito.IdVendedor, 4, dnc.IdNotaCredito
 FROM DetalleNotasCredito dnc
 LEFT OUTER JOIN NotasCredito ON dnc.IdNotaCredito = NotasCredito.IdNotaCredito
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=4
 WHERE IsNull(NotasCredito.Anulada,'NO')<>'SI' --and IsNull(NotasCredito.CtaCte,'SI')='SI' and IsNull(NotasCredito.NoIncluirEnCubos,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'038'+Substring('000000000000',1,12-Len(Convert(varchar,Asientos.IdAsiento)))+Convert(varchar,Asientos.IdAsiento)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento), --+' '+Convert(varchar,Asientos.FechaAsiento,103), 
		Null, Null, 0, 0, 0, 0, 0, 
		  Convert(int,Convert(varchar,Year(Asientos.FechaAsiento))+
			Substring('00',1,2-len(Convert(varchar,Month(Asientos.FechaAsiento))))+Convert(varchar,Month(Asientos.FechaAsiento))+
			Substring('00',1,2-len(Convert(varchar,Day(Asientos.FechaAsiento))))+Convert(varchar,Day(Asientos.FechaAsiento))),
		0, 0, 0, 38, Asientos.IdAsiento
 FROM Asientos
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=38

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'038'+Substring('000000000000',1,12-Len(Convert(varchar,DetAsi.IdDetalleAsiento)))+Convert(varchar,DetAsi.IdDetalleAsiento)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento), --+' '+Convert(varchar,Asientos.FechaAsiento,103), 
		Null, Null, 0, 0, 0, IsNull(DetAsi.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(Asientos.FechaAsiento))+
			Substring('00',1,2-len(Convert(varchar,Month(Asientos.FechaAsiento))))+Convert(varchar,Month(Asientos.FechaAsiento))+
			Substring('00',1,2-len(Convert(varchar,Day(Asientos.FechaAsiento))))+Convert(varchar,Day(Asientos.FechaAsiento))),
		0, 0, 0, 38, DetAsi.IdAsiento
 FROM DetalleAsientos DetAsi 
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=38

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'106'+Substring('000000000000',1,12-Len(Convert(varchar,AjustesStock.IdAjusteStock)))+Convert(varchar,AjustesStock.IdAjusteStock)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,AjustesStock.NumeroAjusteStock)))+Convert(varchar,AjustesStock.NumeroAjusteStock), --+' '+Convert(varchar,AjustesStock.FechaAjuste,103), 
		Null, Null, 0, 0, 0, 0, 0, 
		Convert(int,Convert(varchar,Year(AjustesStock.FechaAjuste))+
			Substring('00',1,2-len(Convert(varchar,Month(AjustesStock.FechaAjuste))))+Convert(varchar,Month(AjustesStock.FechaAjuste))+
			Substring('00',1,2-len(Convert(varchar,Day(AjustesStock.FechaAjuste))))+Convert(varchar,Day(AjustesStock.FechaAjuste))),
		0, 0, 0, 106, AjustesStock.IdAjusteStock
 FROM AjustesStock
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=106

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'106'+Substring('000000000000',1,12-Len(Convert(varchar,das.IdDetalleAjusteStock)))+Convert(varchar,das.IdDetalleAjusteStock)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,AjustesStock.NumeroAjusteStock)))+Convert(varchar,AjustesStock.NumeroAjusteStock), --+' '+Convert(varchar,AjustesStock.FechaAjuste,103), 
		das.Partida, das.NumeroCaja, das.IdArticulo, das.IdUnidad, das.IdUbicacion, IsNull(das.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(AjustesStock.FechaAjuste))+
			Substring('00',1,2-len(Convert(varchar,Month(AjustesStock.FechaAjuste))))+Convert(varchar,Month(AjustesStock.FechaAjuste))+
			Substring('00',1,2-len(Convert(varchar,Day(AjustesStock.FechaAjuste))))+Convert(varchar,Day(AjustesStock.FechaAjuste))),
		0, 0, 0, 106, das.IdAjusteStock
 FROM DetalleAjustesStock das
 LEFT OUTER JOIN AjustesStock ON das.IdAjusteStock = AjustesStock.IdAjusteStock
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=106

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'050'+Substring('000000000000',1,12-Len(Convert(varchar,SalidasMateriales.IdSalidaMateriales)))+Convert(varchar,SalidasMateriales.IdSalidaMateriales)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales), --+' '+Convert(varchar,SalidasMateriales.FechaSalidaMateriales,103), 
		Null, Null, 0, 0, 0, 0, 0, 
		Convert(int,Convert(varchar,Year(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))),
		0, IsNull(SalidasMateriales.IdProveedor,0), 0, 50, SalidasMateriales.IdSalidaMateriales
 FROM SalidasMateriales
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=50
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'050'+Substring('000000000000',1,12-Len(Convert(varchar,dsm.IdDetalleSalidaMateriales)))+Convert(varchar,dsm.IdDetalleSalidaMateriales)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales), --+' '+Convert(varchar,SalidasMateriales.FechaSalidaMateriales,103), 
		dsm.Partida, dsm.NumeroCaja, dsm.IdArticulo, dsm.IdUnidad, dsm.IdUbicacion, IsNull(dsm.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))),
		0, IsNull(SalidasMateriales.IdProveedor,0), 0, 50, dsm.IdSalidaMateriales
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=50
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'050'+Substring('000000',1,6-Len(Convert(varchar,DetalleConjuntos.IdDetalleConjunto)))+Convert(varchar,DetalleConjuntos.IdDetalleConjunto)+
			Substring('000000',1,6-Len(Convert(varchar,dsm.IdDetalleSalidaMateriales)))+Convert(varchar,dsm.IdDetalleSalidaMateriales)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales), --+' '+Convert(varchar,SalidasMateriales.FechaSalidaMateriales,103), 
		dsm.Partida, dsm.NumeroCaja, DetalleConjuntos.IdArticulo, dsm.IdUnidad, dsm.IdUbicacion, IsNull(dsm.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))),
		0, IsNull(SalidasMateriales.IdProveedor,0), 0, 50, dsm.IdSalidaMateriales
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Conjuntos ON dsm.IdArticulo = Conjuntos.IdArticulo
 LEFT OUTER JOIN DetalleConjuntos ON Conjuntos.IdConjunto = DetalleConjuntos.IdConjunto
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=50
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')='SI'  

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'060'+Substring('000000000000',1,12-Len(Convert(varchar,Recepciones.IdRecepcion)))+Convert(varchar,Recepciones.IdRecepcion)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+IsNull('/'+Convert(varchar,Recepciones.SubNumero),''), --+' '+Convert(varchar,Recepciones.FechaRecepcion,103), 
		Null, Null, 0, 0, 0, 0, 0, 
		Convert(int,Convert(varchar,Year(Recepciones.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Month(Recepciones.FechaRecepcion))))+Convert(varchar,Month(Recepciones.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Day(Recepciones.FechaRecepcion))))+Convert(varchar,Day(Recepciones.FechaRecepcion))),
		0, IsNull(Recepciones.IdProveedor,0), 0, 60, Recepciones.IdRecepcion
 FROM Recepciones
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=60
 WHERE IsNull(Recepciones.Anulada,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'060'+Substring('000000000000',1,12-Len(Convert(varchar,dr.IdDetalleRecepcion)))+Convert(varchar,dr.IdDetalleRecepcion)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+IsNull('/'+Convert(varchar,Recepciones.SubNumero),''), --+' '+Convert(varchar,Recepciones.FechaRecepcion,103), 
		dr.Partida, dr.NumeroCaja, dr.IdArticulo, dr.IdUnidad, dr.IdUbicacion, IsNull(dr.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(Recepciones.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Month(Recepciones.FechaRecepcion))))+Convert(varchar,Month(Recepciones.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Day(Recepciones.FechaRecepcion))))+Convert(varchar,Day(Recepciones.FechaRecepcion))),
		0, IsNull(Recepciones.IdProveedor,0), 0, 60, dr.IdRecepcion
 FROM DetalleRecepciones dr
 LEFT OUTER JOIN Recepciones ON dr.IdRecepcion = Recepciones.IdRecepcion
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=60
 WHERE IsNull(Recepciones.Anulada,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'108'+Substring('000000000000',1,12-Len(Convert(varchar,OtrosIngresosAlmacen.IdOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.IdOtroIngresoAlmacen)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen), --+' '+Convert(varchar,OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,103), 
		Null, Null, 0, 0, 0, 0, 0, 
		Convert(int,Convert(varchar,Year(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
			Substring('00',1,2-len(Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
			Substring('00',1,2-len(Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))),
		0, 0, 0, 108, OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 FROM OtrosIngresosAlmacen
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=108
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'108'+Substring('000000000000',1,12-Len(Convert(varchar,doia.IdDetalleOtroIngresoAlmacen)))+Convert(varchar,doia.IdDetalleOtroIngresoAlmacen)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen), --+' '+Convert(varchar,OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,103), 
		doia.Partida, Null, doia.IdArticulo, doia.IdUnidad, doia.IdUbicacion, IsNull(doia.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
			Substring('00',1,2-len(Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
			Substring('00',1,2-len(Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))),
		0, 0, 0, 108, doia.IdOtroIngresoAlmacen
 FROM DetalleOtrosIngresosAlmacen doia
 LEFT OUTER JOIN OtrosIngresosAlmacen ON doia.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=108
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'041'+Substring('000000000000',1,12-Len(Convert(varchar,Remitos.IdRemito)))+Convert(varchar,Remitos.IdRemito)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,Remitos.PuntoVenta)))+Convert(varchar,Remitos.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito), --+' '+Convert(varchar,Remitos.FechaRemito,103), 
		Null, Null, 0, 0, 0, 0, 0, 
		Convert(int,Convert(varchar,Year(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Month(Remitos.FechaRemito))))+Convert(varchar,Month(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Day(Remitos.FechaRemito))))+Convert(varchar,Day(Remitos.FechaRemito))),
		IsNull(Remitos.IdCliente,0), IsNull(Remitos.IdProveedor,0), 0, 41, Remitos.IdRemito
 FROM Remitos
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=41
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'041'+Substring('000000000000',1,12-Len(Convert(varchar,dr.IdDetalleRemito)))+Convert(varchar,dr.IdDetalleRemito)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,Remitos.PuntoVenta)))+Convert(varchar,Remitos.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito), --+' '+Convert(varchar,Remitos.FechaRemito,103), 
		dr.Partida, dr.NumeroCaja, dr.IdArticulo, dr.IdUnidad, dr.IdUbicacion, IsNull(dr.IdObra,0), IsNull(dr.IdColor,0), 
		Convert(int,Convert(varchar,Year(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Month(Remitos.FechaRemito))))+Convert(varchar,Month(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Day(Remitos.FechaRemito))))+Convert(varchar,Day(Remitos.FechaRemito))),
		IsNull(Remitos.IdCliente,0), IsNull(Remitos.IdProveedor,0), 0, 41, dr.IdRemito
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=41
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+'041'+Substring('000000',1,6-Len(Convert(varchar,DetalleConjuntos.IdDetalleConjunto)))+Convert(varchar,DetalleConjuntos.IdDetalleConjunto)+
			Substring('000000',1,6-Len(Convert(varchar,dr.IdDetalleRemito)))+Convert(varchar,dr.IdDetalleRemito)), 
		tc.DescripcionAb+' '+Substring('0000',1,4-Len(Convert(varchar,Remitos.PuntoVenta)))+Convert(varchar,Remitos.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito), --+' '+Convert(varchar,Remitos.FechaRemito,103)), 
		dr.Partida, dr.NumeroCaja, DetalleConjuntos.IdArticulo, dr.IdUnidad, dr.IdUbicacion, IsNull(dr.IdObra,0), IsNull(dr.IdColor,0), 
		Convert(int,Convert(varchar,Year(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Month(Remitos.FechaRemito))))+Convert(varchar,Month(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Day(Remitos.FechaRemito))))+Convert(varchar,Day(Remitos.FechaRemito))),
		IsNull(Remitos.IdCliente,0), IsNull(Remitos.IdProveedor,0), 0, 41, dr.IdRemito
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Conjuntos ON dr.IdArticulo = Conjuntos.IdArticulo
 LEFT OUTER JOIN DetalleConjuntos ON Conjuntos.IdConjunto = DetalleConjuntos.IdConjunto
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=41
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI' and IsNull(dr.DescargaPorKit,'NO')='SI'  

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+Substring('000',1,3-Len(Convert(varchar,cp.IdTipoComprobante)))+Convert(varchar,cp.IdTipoComprobante)+
			Substring('000000000000',1,12-Len(Convert(varchar,cp.IdComprobanteProveedor)))+Convert(varchar,cp.IdComprobanteProveedor)), 
		tc.DescripcionAb+' '+cp.Letra+'-'+
			Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
		Null, Null, 0, 0, 0, IsNull(IsNull(cp.IdObra,0),0), 0, 
		Convert(int,Convert(varchar,Year(cp.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Month(cp.FechaRecepcion))))+Convert(varchar,Month(cp.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Day(cp.FechaRecepcion))))+Convert(varchar,Day(cp.FechaRecepcion))),
		0, IsNull(IsNull(cp.IdProveedor,cp.IdProveedorEventual),0), 0, cp.IdTipoComprobante, cp.IdComprobanteProveedor
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 --WHERE IsNull(cp.Confirmado,'')<>'NO' 

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'2'+Substring('000',1,3-Len(Convert(varchar,IsNull(cp.IdTipoComprobante,0))))+Convert(varchar,IsNull(cp.IdTipoComprobante,0))+
			Substring('000000000000',1,12-Len(Convert(varchar,dcp.IdDetalleComprobanteProveedor)))+Convert(varchar,dcp.IdDetalleComprobanteProveedor)), 
		IsNull(tc.DescripcionAb,'S/D')+' '+IsNull(cp.Letra,' ')+'-'+
			Substring('0000',1,4-Len(Convert(varchar,IsNull(cp.NumeroComprobante1,0))))+Convert(varchar,IsNull(cp.NumeroComprobante1,0))+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,IsNull(cp.NumeroComprobante2,0))))+Convert(varchar,IsNull(cp.NumeroComprobante2,0)),
		Null, Null, IsNull(dcp.IdArticulo,0), 0, 0, IsNull(IsNull(dcp.IdObra,Cuentas.IdObra),0), 0, 
		Convert(int,Convert(varchar,Year(cp.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Month(cp.FechaRecepcion))))+Convert(varchar,Month(cp.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Day(cp.FechaRecepcion))))+Convert(varchar,Day(cp.FechaRecepcion))),
		0, IsNull(IsNull(cp.IdProveedor,cp.IdProveedorEventual),0), 0, cp.IdTipoComprobante, dcp.IdComprobanteProveedor
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=dcp.IdCuenta
 --WHERE IsNull(cp.Confirmado,'')<>'NO' 

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'017'+Substring('000000000000',1,12-Len(Convert(varchar,OrdenesPago.IdOrdenPago)))+Convert(varchar,OrdenesPago.IdOrdenPago)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago), 
		Null, Null, 0, 0, 0, IsNull(OrdenesPago.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(OrdenesPago.FechaOrdenPago))+
			Substring('00',1,2-len(Convert(varchar,Month(OrdenesPago.FechaOrdenPago))))+Convert(varchar,Month(OrdenesPago.FechaOrdenPago))+
			Substring('00',1,2-len(Convert(varchar,Day(OrdenesPago.FechaOrdenPago))))+Convert(varchar,Day(OrdenesPago.FechaOrdenPago))),
		0, IsNull(OrdenesPago.IdProveedor,0), 0, 17, OrdenesPago.IdOrdenPago
 FROM OrdenesPago
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=17
 WHERE IsNull(OrdenesPago.Anulada,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+Substring('000',1,3-Len(Convert(varchar,Valores.IdTipoComprobante)))+Convert(varchar,Valores.IdTipoComprobante)+
			Substring('000000000000',1,12-Len(Convert(varchar,Valores.IdValor)))+Convert(varchar,Valores.IdValor)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,Valores.NumeroComprobante)))+Convert(varchar,Valores.NumeroComprobante), 
		Null, Null, 0, 0, 0, IsNull(Valores.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(Valores.FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(Valores.FechaComprobante))))+Convert(varchar,Month(Valores.FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Day(Valores.FechaComprobante))))+Convert(varchar,Day(Valores.FechaComprobante))),
		0, 0, 0, Valores.IdTipoComprobante, Valores.IdValor
 FROM Valores
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=Valores.IdTipoComprobante
 WHERE Valores.Estado='G' and IsNull(Valores.Anulado,'NO')<>'SI' 

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'002'+Substring('000000000000',1,12-Len(Convert(varchar,Recibos.IdRecibo)))+Convert(varchar,Recibos.IdRecibo)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo), 
		Null, Null, 0, 0, 0, IsNull(Recibos.IdObra,0), 0, 
		Convert(int,Convert(varchar,Year(Recibos.FechaRecibo))+
			Substring('00',1,2-len(Convert(varchar,Month(Recibos.FechaRecibo))))+Convert(varchar,Month(Recibos.FechaRecibo))+
			Substring('00',1,2-len(Convert(varchar,Day(Recibos.FechaRecibo))))+Convert(varchar,Day(Recibos.FechaRecibo))),
		IsNull(Recibos.IdCliente,0), 0, 0, 2, Recibos.IdRecibo
 FROM Recibos
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=2
 WHERE IsNull(Recibos.Anulado,'NO')<>'SI'

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'039'+Substring('000000000000',1,12-Len(Convert(varchar,PlazosFijos.IdPlazoFijo)))+Convert(varchar,PlazosFijos.IdPlazoFijo)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,PlazosFijos.NumeroCertificado1)))+Convert(varchar,PlazosFijos.NumeroCertificado1), 
		Null, Null, 0, 0, 0, 0, 0, 
		Convert(int,Convert(varchar,Year(PlazosFijos.FechaInicioPlazoFijo))+
			Substring('00',1,2-len(Convert(varchar,Month(PlazosFijos.FechaInicioPlazoFijo))))+Convert(varchar,Month(PlazosFijos.FechaInicioPlazoFijo))+
			Substring('00',1,2-len(Convert(varchar,Day(PlazosFijos.FechaInicioPlazoFijo))))+Convert(varchar,Day(PlazosFijos.FechaInicioPlazoFijo))),
		0, 0, 0, 39, PlazosFijos.IdPlazoFijo
 FROM PlazosFijos
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=39

INSERT INTO DW_DimComprobantes
 SELECT Convert(numeric(16,0),'1'+'014'+Substring('000000000000',1,12-Len(Convert(varchar,DepositosBancarios.IdDepositoBancario)))+Convert(varchar,DepositosBancarios.IdDepositoBancario)), 
		tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+Convert(varchar,DepositosBancarios.NumeroDeposito), 
		Null, Null, 0, 0, 0, 0, 0, 
		Convert(int,Convert(varchar,Year(DepositosBancarios.FechaDeposito))+
			Substring('00',1,2-len(Convert(varchar,Month(DepositosBancarios.FechaDeposito))))+Convert(varchar,Month(DepositosBancarios.FechaDeposito))+
			Substring('00',1,2-len(Convert(varchar,Day(DepositosBancarios.FechaDeposito))))+Convert(varchar,Day(DepositosBancarios.FechaDeposito))),
		0, 0, 0, 14, DepositosBancarios.IdDepositoBancario
 FROM DepositosBancarios
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=14
 


/*=====================================*/
/* PROCESO DE PEDIDOS                  */
/*=====================================*/
INSERT INTO DW_FactPedidos
 SELECT 
  dp.IdDetallePedido, 
  Substring('0000',1,4-Len(Convert(varchar,IsNull(p.PuntoVenta,0))))+Convert(varchar,IsNull(p.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,p.NumeroPedido)))+Convert(varchar,p.NumeroPedido)+IsNull(' / '+Convert(varchar,p.SubNumero),''),
  p.IdProveedor, 
  Convert(int,Convert(varchar,Year(FechaPedido))+
	Substring('00',1,2-len(Convert(varchar,Month(FechaPedido))))+Convert(varchar,Month(FechaPedido))+
	Substring('00',1,2-len(Convert(varchar,Day(FechaPedido))))+Convert(varchar,Day(FechaPedido))),
  p.IdComprador, 
  Monedas.Abreviatura, 
  dp.NumeroItem, 
  dp.IdArticulo, 
  dp.Cantidad, 
  Unidades.Abreviatura, 
  (dp.Precio * (100-IsNull(dp.PorcentajeBonificacion,0))/100) * (100-IsNull(p.PorcentajeBonificacion,0))/100, 
  r.IdObra, 
  dp.IdDetalleRequerimiento
 FROM DetallePedidos dp
 LEFT OUTER JOIN Pedidos p ON p.IdPedido=dp.IdPedido
 LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = dp.IdUnidad
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda = p.IdMoneda
 LEFT OUTER JOIN DetalleRequerimientos dr ON dr.IdDetalleRequerimiento = dp.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos r ON r.IdRequerimiento = dr.IdRequerimiento
 WHERE IsNull(dp.Cumplido,'NO')<>'AN'


/*=====================================*/
/* PROCESO DE PRESUPUESTO DE OBRA      */
/*=====================================*/
INSERT INTO DW_FactPresupuestoObras
 SELECT pond.IdPresupuestoObrasNodo, pond.CodigoPresupuesto, pond.Importe, pond.Cantidad, pond.CantidadBase, pond.Rendimiento, pond.Incidencia, pond.Costo
 FROM PresupuestoObrasNodosDatos pond 
 LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo=pond.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Obras ON Obras.IdObra = PresupuestoObrasNodos.IdObra
 WHERE IsNull(Obras.ActivarPresupuestoObra,'NO')='SI'
 

/*=====================================*/
/* PROCESO DE PRESUPUESTO DE OBRA REAL */
/*=====================================*/
CREATE TABLE #Auxiliar1 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 Cantidad NUMERIC(18, 2),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT Det.IdPresupuestoObrasNodo, Year(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), 
		Month(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), Det.Cantidad, Det.Importe*cp.CotizacionMoneda
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor

INSERT INTO #Auxiliar1 
 SELECT dsmpo.IdPresupuestoObrasNodo, Year(SalidasMateriales.FechaSalidaMateriales), Month(SalidasMateriales.FechaSalidaMateriales), dsmpo.Cantidad, Det.CostoUnitario*dsmpo.Cantidad
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMateriales=dsmpo.IdDetalleSalidaMateriales
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(Det.DescargaPorKit,'')<>'SI'

INSERT INTO #Auxiliar1 
 SELECT dsmpo.IdPresupuestoObrasNodo, Year(SalidasMateriales.FechaSalidaMateriales), Month(SalidasMateriales.FechaSalidaMateriales), dsmpo.Cantidad, Articulos.CostoReposicion*dsmpo.Cantidad
 FROM DetalleSalidasMaterialesKits Det 
 LEFT OUTER JOIN DetalleSalidasMateriales ON Det.IdDetalleSalidaMateriales=DetalleSalidasMateriales.IdDetalleSalidaMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMaterialesKit=dsmpo.IdDetalleSalidaMaterialesKit
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo

INSERT INTO #Auxiliar1 
 SELECT Det.IdPresupuestoObrasNodo, Year(dsd.FechaCertificadoHasta), Month(dsd.FechaCertificadoHasta), IsNull(Det.CantidadAvance,0), IsNull(Det.ImporteTotal,0)
 FROM SubcontratosPxQ Det 
 LEFT OUTER JOIN Subcontratos ON Subcontratos.IdSubcontrato=Det.IdSubcontrato
 LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.NumeroSubcontrato=Subcontratos.NumeroSubcontrato
 LEFT OUTER JOIN DetalleSubcontratosDatos dsd ON dsd.IdSubcontratoDatos=SubcontratosDatos.IdSubcontratoDatos and dsd.NumeroCertificado=Det.NumeroCertificado
 WHERE dsd.FechaCertificadoHasta is not null 

INSERT INTO #Auxiliar1 
 SELECT ponc.IdPresupuestoObrasNodo, Year(ponc.Fecha), Month(ponc.Fecha), ponc.Cantidad, ponc.Importe
 FROM PresupuestoObrasNodosConsumos ponc 

INSERT INTO #Auxiliar1 
 SELECT PartesProduccion.IdPresupuestoObrasNodoMateriales, Year(PartesProduccion.FechaParteProduccion), Month(PartesProduccion.FechaParteProduccion), PartesProduccion.Cantidad, PartesProduccion.Cantidad*PartesProduccion.Importe
 FROM PartesProduccion 
 
CREATE TABLE #Auxiliar2 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 Cantidad NUMERIC(18, 2),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdPresupuestoObrasNodo, #Auxiliar1.Año, #Auxiliar1.Mes, Sum(IsNull(#Auxiliar1.Cantidad,0)), Sum(IsNull(#Auxiliar1.Importe,0))
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdPresupuestoObrasNodo, #Auxiliar1.Año, #Auxiliar1.Mes

CREATE TABLE #Auxiliar3 
			(
			 IdPresupuestoObrasNodo INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 Porcentaje NUMERIC(18, 2),
			 CantidadTeorica NUMERIC(18, 2),
			 ImporteTeorico NUMERIC(18, 2),
			 CantidadReal NUMERIC(18, 2),
			 ImporteReal NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT PxQ.IdPresupuestoObrasNodo, PxQ.Año, PxQ.Mes, PxQ.Cantidad, PxQ.CantidadTeorica, PxQ.Importe, 
 		Case When IsNull((Select Count(*) From PresupuestoObrasNodos pon Where pon.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo or Patindex('%/'+Convert(varchar,PxQ.IdPresupuestoObrasNodo)+'/%', pon.Lineage)>0),0)<=1 Then 0 Else PxQ.CantidadAvance End, 0
 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and #Auxiliar2.Año=PxQ.Año and #Auxiliar2.Mes=PxQ.Mes
 WHERE PxQ.CodigoPresupuesto=0

INSERT INTO #Auxiliar3 
 SELECT #Auxiliar2.IdPresupuestoObrasNodo, #Auxiliar2.Año, #Auxiliar2.Mes, 0, 0, 0, 
 		Case When IsNull((Select Count(*) From PresupuestoObrasNodos pon Where pon.IdPresupuestoObrasNodo=#Auxiliar2.IdPresupuestoObrasNodo or Patindex('%/'+Convert(varchar,#Auxiliar2.IdPresupuestoObrasNodo)+'/%', pon.Lineage)>0),0)<=1 Then #Auxiliar2.Cantidad Else 0 End, #Auxiliar2.Importe
 FROM #Auxiliar2 

DELETE #Auxiliar3
WHERE not Exists(Select Top 1 pon.IdPresupuestoObrasNodo From PresupuestoObrasNodos pon Where pon.IdPresupuestoObrasNodo=#Auxiliar3.IdPresupuestoObrasNodo) or 
	(Porcentaje=0 and CantidadTeorica=0 and ImporteTeorico=0 and CantidadReal=0 and ImporteReal=0)

INSERT INTO DW_FactPresupuestoObrasReal
 SELECT IdPresupuestoObrasNodo, 0, Convert(int,Convert(varchar,Año)+Substring('00',1,2-len(Convert(varchar,Mes)))+Convert(varchar,Mes)+'01'), 
		Sum(IsNull(Porcentaje,0)), Sum(IsNull(CantidadTeorica,0)), Sum(IsNull(ImporteTeorico,0)), Sum(IsNull(CantidadReal,0)), Sum(IsNull(ImporteReal,0))
 FROM #Auxiliar3
 GROUP BY IdPresupuestoObrasNodo, Año, Mes
 
 DROP TABLE #Auxiliar1
 DROP TABLE #Auxiliar2
 DROP TABLE #Auxiliar3
 
 
/*=====================================*/
/* PROCESO DE VENTAS                   */
/*=====================================*/

SET @proc_name='CuboDeVentasDetalladas'
INSERT INTO DW_FactVentas 
	EXECUTE @proc_name @Desde, @Hasta, @AuxI2,  @nada, @Formato

--INSERT INTO DW_FactVentas
-- SELECT 
--  Facturas.IdCliente,
--  Convert(int,Convert(varchar,Year(Facturas.FechaFactura))+
--	Substring('00',1,2-len(Convert(varchar,Month(Facturas.FechaFactura))))+Convert(varchar,Month(Facturas.FechaFactura))+
--	Substring('00',1,2-len(Convert(varchar,Day(Facturas.FechaFactura))))+Convert(varchar,Day(Facturas.FechaFactura))),
--  IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva),
--  Facturas.IdVendedor,
--  OrdenesCompra.IdObra,
--  Case When Facturas.TipoABC='B' and IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8 
--		Then Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
--		Else Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * Facturas.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
--  End,
--  Convert(numeric(16,0),'2'+'001'+Substring('000000000000',1,12-Len(Convert(varchar,df.IdDetalleFactura)))+Convert(varchar,df.IdDetalleFactura))
-- FROM DetalleFacturasOrdenesCompra dfoc
-- LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
-- LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
-- LEFT OUTER JOIN DetalleFacturas df ON df.IdDetalleFactura = dfoc.IdDetalleFactura
-- LEFT OUTER JOIN Facturas ON dfoc.IdFactura = Facturas.IdFactura
-- LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
-- LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=dfoc.IdFactura
-- WHERE IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI'

--INSERT INTO DW_FactVentas
-- SELECT 
--  Facturas.IdCliente,
--  Convert(int,Convert(varchar,Year(Facturas.FechaFactura))+
--	Substring('00',1,2-len(Convert(varchar,Month(Facturas.FechaFactura))))+Convert(varchar,Month(Facturas.FechaFactura))+
--	Substring('00',1,2-len(Convert(varchar,Day(Facturas.FechaFactura))))+Convert(varchar,Day(Facturas.FechaFactura))),
--  IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva),
--  Facturas.IdVendedor,
--  Facturas.IdObra,
--  Case When Facturas.TipoABC='B' and IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8 
--		Then Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
--		Else Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * Facturas.CotizacionMoneda * IsNull(dfp.Porcentaje,100) / 100 ,2)
--  End,
--  Convert(numeric(16,0),'2'+'001'+Substring('000000000000',1,12-Len(Convert(varchar,df.IdDetalleFactura)))+Convert(varchar,df.IdDetalleFactura))
-- FROM DetalleFacturas df
-- LEFT OUTER JOIN Facturas ON df.IdFactura = Facturas.IdFactura
-- LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
-- LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=df.IdFactura
-- WHERE IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI' and 
--	not exists(Select Top 1 dfoc.IdDetalleFactura From DetalleFacturasOrdenesCompra dfoc Where dfoc.IdDetalleFactura=df.IdDetalleFactura)

--INSERT INTO DW_FactVentas
-- SELECT 
--  Devoluciones.IdCliente,
--  Convert(int,Convert(varchar,Year(Devoluciones.FechaDevolucion))+
--	Substring('00',1,2-len(Convert(varchar,Month(Devoluciones.FechaDevolucion))))+Convert(varchar,Month(Devoluciones.FechaDevolucion))+
--	Substring('00',1,2-len(Convert(varchar,Day(Devoluciones.FechaDevolucion))))+Convert(varchar,Day(Devoluciones.FechaDevolucion))),
--  IsNull(Devoluciones.IdCodigoIva,Clientes.IdCodigoIva),
--  Devoluciones.IdVendedor,
--  IsNull(dv.IdObra,Devoluciones.IdObra),
--  Case When Devoluciones.TipoABC='B' and IsNull(Devoluciones.IdCodigoIva,Clientes.IdCodigoIva)<>8  
--		Then ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) / (1+(Devoluciones.PorcentajeIva1/100)) * Devoluciones.CotizacionMoneda
--		Else ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * Devoluciones.CotizacionMoneda
--  End * -1,
--  Convert(numeric(16,0),'2'+'005'+Substring('000000000000',1,12-Len(Convert(varchar,dv.IdDetalleDevolucion)))+Convert(varchar,dv.IdDetalleDevolucion))
-- FROM DetalleDevoluciones dv
-- LEFT OUTER JOIN Devoluciones ON dv.IdDevolucion = Devoluciones.IdDevolucion
-- LEFT OUTER JOIN Clientes ON Devoluciones.IdCliente = Clientes.IdCliente
-- LEFT OUTER JOIN Articulos ON dv.IdArticulo = Articulos.IdArticulo
-- WHERE IsNull(Devoluciones.Anulada,'')<>'SI'

--INSERT INTO DW_FactVentas
-- SELECT 
--  NotasDebito.IdCliente,
--  Convert(int,Convert(varchar,Year(NotasDebito.FechaNotaDebito))+
--	Substring('00',1,2-len(Convert(varchar,Month(NotasDebito.FechaNotaDebito))))+Convert(varchar,Month(NotasDebito.FechaNotaDebito))+
--	Substring('00',1,2-len(Convert(varchar,Day(NotasDebito.FechaNotaDebito))))+Convert(varchar,Day(NotasDebito.FechaNotaDebito))),
--  IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva),
--  NotasDebito.IdVendedor,
--  NotasDebito.IdObra,
--  Case When NotasDebito.TipoABC='B' AND IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva)<>8  
--		Then Round(Case When dnb.Gravado='SI' Then IsNull(dnb.Importe,0) / (1+(NotasDebito.PorcentajeIva1/100)) Else IsNull(dnb.Importe,0) End * IsNull(NotasDebito.CotizacionMoneda,1) * IsNull(dndp.Porcentaje,100) / 100 ,2)
--		Else Round(IsNull(dnb.Importe,0) * IsNull(NotasDebito.CotizacionMoneda,1) * IsNull(dndp.Porcentaje,100) / 100 ,2)
--  End,
--  Convert(numeric(16,0),'2'+'003'+Substring('000000000000',1,12-Len(Convert(varchar,dnb.IdDetalleNotaDebito)))+Convert(varchar,dnb.IdDetalleNotaDebito))
-- FROM DetalleNotasDebito dnb
-- LEFT OUTER JOIN NotasDebito ON dnb.IdNotaDebito = NotasDebito.IdNotaDebito
-- LEFT OUTER JOIN Clientes ON NotasDebito.IdCliente = Clientes.IdCliente
-- LEFT OUTER JOIN DetalleNotasDebitoProvincias dndp ON dndp.IdNotaDebito=NotasDebito.IdNotaDebito
-- WHERE IsNull(NotasDebito.Anulada,'NO')<>'SI' and IsNull(NotasDebito.CtaCte,'SI')='SI' and IsNull(NotasDebito.NoIncluirEnCubos,'NO')<>'SI'

--INSERT INTO DW_FactVentas
-- SELECT 
--  NotasCredito.IdCliente,
--  Convert(int,Convert(varchar,Year(NotasCredito.FechaNotaCredito))+
--	Substring('00',1,2-len(Convert(varchar,Month(NotasCredito.FechaNotaCredito))))+Convert(varchar,Month(NotasCredito.FechaNotaCredito))+
--	Substring('00',1,2-len(Convert(varchar,Day(NotasCredito.FechaNotaCredito))))+Convert(varchar,Day(NotasCredito.FechaNotaCredito))),
--  IsNull(NotasCredito.IdCodigoIva,Clientes.IdCodigoIva),
--  NotasCredito.IdVendedor,
--  NotasCredito.IdObra,
--  Case When NotasCredito.TipoABC='B' AND IsNull(NotasCredito.IdCodigoIva,Clientes.IdCodigoIva)<>8  
--		Then Round(Case When dnc.Gravado='SI' Then IsNull(dnc.Importe,0) / (1+(NotasCredito.PorcentajeIva1/100)) Else IsNull(dnc.Importe,0) End * IsNull(NotasCredito.CotizacionMoneda,1) * IsNull(dncp.Porcentaje,100) / 100 ,2)
--		Else Round(IsNull(dnc.Importe,0) * IsNull(NotasCredito.CotizacionMoneda,1) * IsNull(dncp.Porcentaje,100) / 100 ,2)
--  End * -1,
--  Convert(numeric(16,0),'2'+'004'+Substring('000000000000',1,12-Len(Convert(varchar,dnc.IdDetalleNotaCredito)))+Convert(varchar,dnc.IdDetalleNotaCredito))
-- FROM DetalleNotasCredito dnc
-- LEFT OUTER JOIN NotasCredito ON dnc.IdNotaCredito = NotasCredito.IdNotaCredito
-- LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
-- LEFT OUTER JOIN Conceptos ON dnc.IdConcepto = Conceptos.IdConcepto
-- LEFT OUTER JOIN DetalleNotasCreditoProvincias dncp ON dncp.IdNotaCredito=NotasCredito.IdNotaCredito
-- WHERE IsNull(NotasCredito.Anulada,'NO')<>'SI' and IsNull(NotasCredito.CtaCte,'SI')='SI' and IsNull(NotasCredito.NoIncluirEnCubos,'NO')<>'SI'

--INSERT INTO DW_FactVentas
-- SELECT 
--  Null,
--  Convert(int,Convert(varchar,Year(Asientos.FechaAsiento))+
--	Substring('00',1,2-len(Convert(varchar,Month(Asientos.FechaAsiento))))+Convert(varchar,Month(Asientos.FechaAsiento))+
--	Substring('00',1,2-len(Convert(varchar,Day(Asientos.FechaAsiento))))+Convert(varchar,Day(Asientos.FechaAsiento))),
--  Null,
--  Null,
--  DetAsi.IdObra,
--  Case When DetAsi.Debe is not null and DetAsi.Haber is null Then DetAsi.Debe * -1
--		When DetAsi.Debe is null and DetAsi.Haber is not null Then DetAsi.Haber
--		When DetAsi.Debe is not null and DetAsi.Haber is not null Then (DetAsi.Debe - DetAsi.Haber) * -1
--		Else 0
--  End,
--  Convert(numeric(16,0),'2'+'038'+Substring('000000000000',1,12-Len(Convert(varchar,DetAsi.IdDetalleAsiento)))+Convert(varchar,DetAsi.IdDetalleAsiento))
-- FROM DetalleAsientos DetAsi 
-- LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
-- LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
-- WHERE Cuentas.Codigo between 4000 and 4999

DELETE DW_FactVentas
WHERE Fecha is null

UPDATE DW_FactVentas
SET IdObra=0
WHERE Not Exists(Select Top 1 a.IdObra From DW_DimObras a Where a.IdObra=DW_FactVentas.IdObra)

UPDATE DW_FactVentas
SET IdVendedor=0
WHERE Not Exists(Select Top 1 a.IdVendedor From DW_DimVendedores a Where a.IdVendedor=DW_FactVentas.IdVendedor)

DELETE DW_FactVentas
WHERE Not Exists(Select Top 1 DW_DimComprobantes.ClaveComprobante From DW_DimComprobantes Where DW_DimComprobantes.ClaveComprobante=DW_FactVentas.ClaveComprobante)


/*=====================================*/
/* PROCESO DE STOCKS                   */
/*=====================================*/

CREATE TABLE #Auxiliar4 (
						 IdArticulo INTEGER, 
						 IdUnidad INTEGER, 
						 IdUbicacion INTEGER, 
						 IdObra INTEGER, 
						 IdColor INTEGER, 
						 Cantidad NUMERIC(18, 2),
						 Fecha INTEGER, 
						 ClaveComprobante NUMERIC(16, 0)
						)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdArticulo) ON [PRIMARY]
INSERT INTO #Auxiliar4
 SELECT das.IdArticulo, das.IdUnidad, das.IdUbicacion, das.IdObra, Null, das.CantidadUnidades, 
		Convert(int,Convert(varchar,Year(AjustesStock.FechaAjuste))+
			Substring('00',1,2-len(Convert(varchar,Month(AjustesStock.FechaAjuste))))+Convert(varchar,Month(AjustesStock.FechaAjuste))+
			Substring('00',1,2-len(Convert(varchar,Day(AjustesStock.FechaAjuste))))+Convert(varchar,Day(AjustesStock.FechaAjuste))),
		Convert(numeric(16,0),'2'+'106'+Substring('000000000000',1,12-Len(Convert(varchar,das.IdDetalleAjusteStock)))+Convert(varchar,das.IdDetalleAjusteStock))
 FROM DetalleAjustesStock das
 LEFT OUTER JOIN AjustesStock ON das.IdAjusteStock = AjustesStock.IdAjusteStock

INSERT INTO #Auxiliar4
 SELECT dsm.IdArticulo, dsm.IdUnidad, dsm.IdUbicacion, dsm.IdObra, Null, dsm.Cantidad * -1,
		Convert(int,Convert(varchar,Year(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))),
		Convert(numeric(16,0),'2'+'050'+Substring('000000000000',1,12-Len(Convert(varchar,dsm.IdDetalleSalidaMateriales)))+Convert(varchar,dsm.IdDetalleSalidaMateriales))
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')<>'SI'  

INSERT INTO #Auxiliar4
 SELECT dsm.IdArticulo, dsm.IdUnidad, dsm.IdUbicacion, dsm.IdObra, Null, dsm.Cantidad * IsNull(DetalleConjuntos.Cantidad,1) * -1, 
		Convert(int,Convert(varchar,Year(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Month(SalidasMateriales.FechaSalidaMateriales))+
			Substring('00',1,2-len(Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))))+Convert(varchar,Day(SalidasMateriales.FechaSalidaMateriales))),
		Convert(numeric(16,0),'2'+'050'+Substring('000000',1,6-Len(Convert(varchar,DetalleConjuntos.IdDetalleConjunto)))+Convert(varchar,DetalleConjuntos.IdDetalleConjunto)+
			Substring('000000',1,6-Len(Convert(varchar,dsm.IdDetalleSalidaMateriales)))+Convert(varchar,dsm.IdDetalleSalidaMateriales))
 FROM DetalleSalidasMateriales dsm 
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Conjuntos ON dsm.IdArticulo = Conjuntos.IdArticulo
 LEFT OUTER JOIN DetalleConjuntos ON Conjuntos.IdConjunto = DetalleConjuntos.IdConjunto
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(dsm.DescargaPorKit,'NO')='SI'  

INSERT INTO #Auxiliar4
 SELECT dr.IdArticulo, dr.IdUnidad, dr.IdUbicacion, dr.IdObra, Null, dr.Cantidad, 
		Convert(int,Convert(varchar,Year(Recepciones.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Month(Recepciones.FechaRecepcion))))+Convert(varchar,Month(Recepciones.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Day(Recepciones.FechaRecepcion))))+Convert(varchar,Day(Recepciones.FechaRecepcion))),
		Convert(numeric(16,0),'2'+'060'+Substring('000000000000',1,12-Len(Convert(varchar,dr.IdDetalleRecepcion)))+Convert(varchar,dr.IdDetalleRecepcion))
 FROM DetalleRecepciones dr
 LEFT OUTER JOIN Recepciones ON dr.IdRecepcion = Recepciones.IdRecepcion
 WHERE IsNull(Recepciones.Anulada,'NO')<>'SI'

INSERT INTO #Auxiliar4
 SELECT doia.IdArticulo, doia.IdUnidad, doia.IdUbicacion, doia.IdObra, Null, doia.Cantidad, 
		Convert(int,Convert(varchar,Year(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
			Substring('00',1,2-len(Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Month(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))+
			Substring('00',1,2-len(Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))))+Convert(varchar,Day(OtrosIngresosAlmacen.FechaOtroIngresoAlmacen))),
		Convert(numeric(16,0),'2'+'108'+Substring('000000000000',1,12-Len(Convert(varchar,doia.IdDetalleOtroIngresoAlmacen)))+Convert(varchar,doia.IdDetalleOtroIngresoAlmacen))
 FROM DetalleOtrosIngresosAlmacen doia
 LEFT OUTER JOIN OtrosIngresosAlmacen ON doia.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI'

INSERT INTO #Auxiliar4
 SELECT dr.IdArticulo, dr.IdUnidad, dr.IdUbicacion, dr.IdObra, dr.IdColor, dr.Cantidad * -1,
		Convert(int,Convert(varchar,Year(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Month(Remitos.FechaRemito))))+Convert(varchar,Month(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Day(Remitos.FechaRemito))))+Convert(varchar,Day(Remitos.FechaRemito))),
		Convert(numeric(16,0),'2'+'041'+Substring('000000000000',1,12-Len(Convert(varchar,dr.IdDetalleRemito)))+Convert(varchar,dr.IdDetalleRemito))
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI' and IsNull(dr.DescargaPorKit,'NO')<>'SI'  

INSERT INTO #Auxiliar4
 SELECT dr.IdArticulo, dr.IdUnidad, dr.IdUbicacion, dr.IdObra, dr.IdColor, dr.Cantidad * IsNull(DetalleConjuntos.Cantidad,1) * -1, 
		Convert(int,Convert(varchar,Year(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Month(Remitos.FechaRemito))))+Convert(varchar,Month(Remitos.FechaRemito))+
			Substring('00',1,2-len(Convert(varchar,Day(Remitos.FechaRemito))))+Convert(varchar,Day(Remitos.FechaRemito))),
		Convert(numeric(16,0),'2'+'041'+Substring('000000',1,6-Len(Convert(varchar,DetalleConjuntos.IdDetalleConjunto)))+Convert(varchar,DetalleConjuntos.IdDetalleConjunto)+
			Substring('000000',1,6-Len(Convert(varchar,dr.IdDetalleRemito)))+Convert(varchar,dr.IdDetalleRemito))
 FROM DetalleRemitos dr 
 LEFT OUTER JOIN Remitos ON dr.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Conjuntos ON dr.IdArticulo = Conjuntos.IdArticulo
 LEFT OUTER JOIN DetalleConjuntos ON Conjuntos.IdConjunto = DetalleConjuntos.IdConjunto
 WHERE IsNull(Remitos.Anulado,'NO')<>'SI' and IsNull(dr.DescargaPorKit,'NO')='SI'  

INSERT INTO #Auxiliar4
 SELECT dd.IdArticulo, dd.IdUnidad, dd.IdUbicacion, dd.IdObra, Null, dd.Cantidad,
		Convert(int,Convert(varchar,Year(Devoluciones.FechaDevolucion))+
			Substring('00',1,2-len(Convert(varchar,Month(Devoluciones.FechaDevolucion))))+Convert(varchar,Month(Devoluciones.FechaDevolucion))+
			Substring('00',1,2-len(Convert(varchar,Day(Devoluciones.FechaDevolucion))))+Convert(varchar,Day(Devoluciones.FechaDevolucion))),
		Convert(numeric(16,0),'2'+'005'+Substring('000000000000',1,12-Len(Convert(varchar,dd.IdDetalleDevolucion)))+Convert(varchar,dd.IdDetalleDevolucion))
 FROM DetalleDevoluciones dd 
 LEFT OUTER JOIN Devoluciones ON dd.IdDevolucion = Devoluciones.IdDevolucion
 WHERE IsNull(Devoluciones.Anulada,'NO')<>'SI'

UPDATE #Auxiliar4
SET IdObra=0
WHERE Not Exists(Select Top 1 a.IdObra From DW_DimObras a Where a.IdObra=#Auxiliar4.IdObra)

UPDATE #Auxiliar4
SET IdUbicacion=0
WHERE Not Exists(Select Top 1 a.IdUbicacion From DW_DimUbicaciones a Where a.IdUbicacion=#Auxiliar4.IdUbicacion)

CREATE TABLE #Auxiliar5 (IdArticulo INTEGER, Cantidad NUMERIC(18, 2))
CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdArticulo) ON [PRIMARY]
INSERT INTO #Auxiliar5 
 SELECT IdArticulo, Sum(IsNull(Cantidad,0))
 FROM #Auxiliar4
 GROUP BY IdArticulo

INSERT INTO DW_FactStock
 SELECT a.IdArticulo, a.IdUnidad, a.IdUbicacion, a.IdObra, a.IdColor, a.Cantidad, a.Fecha, a.ClaveComprobante
 FROM #Auxiliar4 a 
 LEFT OUTER JOIN #Auxiliar5 b ON b.IdArticulo=a.IdArticulo
 WHERE a.Fecha is not null and IsNull(b.Cantidad,0)<>0

DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5


/*==========================================*/
/* PROCESO DE INGRESOS - EGRESOS POR OBRA   */
/*==========================================*/

SET @proc_name='CuboIngresoEgresosPorObra1'
INSERT INTO DW_FactIngresosEgresosPorObra 
	EXECUTE @proc_name @Desde, @Hasta, @AuxI1, @AuxI2, @nada, @nada, @Formato

UPDATE DW_FactIngresosEgresosPorObra
SET Fecha=20000101
WHERE Fecha is null

UPDATE DW_FactIngresosEgresosPorObra
SET IdObra=0
WHERE IdObra is null

UPDATE DW_FactIngresosEgresosPorObra
SET IdRubroContable=0
WHERE IdRubroContable is null

DELETE DW_FactIngresosEgresosPorObra
WHERE Not Exists(Select Top 1 DW_DimComprobantes.ClaveComprobante From DW_DimComprobantes Where DW_DimComprobantes.ClaveComprobante=DW_FactIngresosEgresosPorObra.ClaveComprobante)

DELETE DW_FactIngresosEgresosPorObra
WHERE Not Exists(Select Top 1 DW_DimRubrosContables.IdRubroContable From DW_DimRubrosContables Where DW_DimRubrosContables.IdRubroContable=DW_FactIngresosEgresosPorObra.IdRubroContable)

--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 1, IsNull(OrdenesCompra.IdObra,Facturas.IdObra), -1, 
--		Convert(int,Convert(varchar,Year(Facturas.FechaFactura))+
--			Substring('00',1,2-len(Convert(varchar,Month(Facturas.FechaFactura))))+Convert(varchar,Month(Facturas.FechaFactura))+
--			Substring('00',1,2-len(Convert(varchar,Day(Facturas.FechaFactura))))+Convert(varchar,Day(Facturas.FechaFactura))),
--		Convert(numeric(16,0),'2'+'001'+Substring('000000000000',1,12-Len(Convert(varchar,df.IdDetalleFactura)))+Convert(varchar,df.IdDetalleFactura)),
--		Case When Facturas.TipoABC='B' and IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8 
--				Then Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda,2)
--				Else Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * Facturas.CotizacionMoneda,2)
--		End
-- FROM DetalleFacturasOrdenesCompra dfoc
-- LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
-- LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
-- LEFT OUTER JOIN DetalleFacturas df ON df.IdDetalleFactura = dfoc.IdDetalleFactura
-- LEFT OUTER JOIN Facturas ON dfoc.IdFactura = Facturas.IdFactura
-- LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
-- WHERE IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI'
 
--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 1, IsNull(Facturas.IdObra,0), -1, 
--		Convert(int,Convert(varchar,Year(Facturas.FechaFactura))+
--			Substring('00',1,2-len(Convert(varchar,Month(Facturas.FechaFactura))))+Convert(varchar,Month(Facturas.FechaFactura))+
--			Substring('00',1,2-len(Convert(varchar,Day(Facturas.FechaFactura))))+Convert(varchar,Day(Facturas.FechaFactura))),
--		Convert(numeric(16,0),'2'+'001'+Substring('000000000000',1,12-Len(Convert(varchar,df.IdDetalleFactura)))+Convert(varchar,df.IdDetalleFactura)),
--		Case When Facturas.TipoABC='B' and IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva)<>8 
--				Then Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) / (1+(Facturas.PorcentajeIva1/100)) * Facturas.CotizacionMoneda,2)
--				Else Round(((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * Facturas.CotizacionMoneda,2)
--		End
-- FROM DetalleFacturas df
-- LEFT OUTER JOIN Facturas ON df.IdFactura = Facturas.IdFactura
-- LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
-- LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=df.IdFactura
-- WHERE IsNull(Facturas.Anulada,'NO')<>'SI' and IsNull(Facturas.NoIncluirEnCubos,'NO')<>'SI' and 
--	not exists(Select Top 1 dfoc.IdDetalleFactura From DetalleFacturasOrdenesCompra dfoc Where dfoc.IdDetalleFactura=df.IdDetalleFactura)
 
--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 1, IsNull(dv.IdObra,Devoluciones.IdObra), -1, 
--		Convert(int,Convert(varchar,Year(Devoluciones.FechaDevolucion))+
--			Substring('00',1,2-len(Convert(varchar,Month(Devoluciones.FechaDevolucion))))+Convert(varchar,Month(Devoluciones.FechaDevolucion))+
--			Substring('00',1,2-len(Convert(varchar,Day(Devoluciones.FechaDevolucion))))+Convert(varchar,Day(Devoluciones.FechaDevolucion))),
--		Convert(numeric(16,0),'2'+'005'+Substring('000000000000',1,12-Len(Convert(varchar,dv.IdDetalleDevolucion)))+Convert(varchar,dv.IdDetalleDevolucion)),
--		Case When Devoluciones.TipoABC='B' and IsNull(Devoluciones.IdCodigoIva,Clientes.IdCodigoIva)<>8  
--				Then ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) / (1+(Devoluciones.PorcentajeIva1/100)) * Devoluciones.CotizacionMoneda
--				Else ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * Devoluciones.CotizacionMoneda
--		End * -1
-- FROM DetalleDevoluciones dv
-- LEFT OUTER JOIN Devoluciones ON dv.IdDevolucion = Devoluciones.IdDevolucion
-- LEFT OUTER JOIN Clientes ON Devoluciones.IdCliente = Clientes.IdCliente
-- WHERE IsNull(Devoluciones.Anulada,'')<>'SI'

--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 1, IsNull(NotasDebito.IdObra,0), -1, 
--		Convert(int,Convert(varchar,Year(NotasDebito.FechaNotaDebito))+
--			Substring('00',1,2-len(Convert(varchar,Month(NotasDebito.FechaNotaDebito))))+Convert(varchar,Month(NotasDebito.FechaNotaDebito))+
--			Substring('00',1,2-len(Convert(varchar,Day(NotasDebito.FechaNotaDebito))))+Convert(varchar,Day(NotasDebito.FechaNotaDebito))),
--		Convert(numeric(16,0),'2'+'003'+Substring('000000000000',1,12-Len(Convert(varchar,dnb.IdDetalleNotaDebito)))+Convert(varchar,dnb.IdDetalleNotaDebito)),
--		Case When NotasDebito.TipoABC='B' AND IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva)<>8  
--				Then Round(Case When dnb.Gravado='SI' Then IsNull(dnb.Importe,0) / (1+(NotasDebito.PorcentajeIva1/100)) Else IsNull(dnb.Importe,0) End  * IsNull(NotasDebito.CotizacionMoneda,1),2)
--				Else Round(IsNull(dnb.Importe,0) * IsNull(NotasDebito.CotizacionMoneda,1),2)
--		End
-- FROM DetalleNotasDebito dnb
-- LEFT OUTER JOIN NotasDebito ON dnb.IdNotaDebito = NotasDebito.IdNotaDebito
-- LEFT OUTER JOIN Clientes ON NotasDebito.IdCliente = Clientes.IdCliente
-- WHERE IsNull(NotasDebito.Anulada,'NO')<>'SI' and IsNull(NotasDebito.CtaCte,'SI')='SI' and IsNull(NotasDebito.NoIncluirEnCubos,'NO')<>'SI'

--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 1, IsNull(NotasCredito.IdObra,0), -1, 
--		Convert(int,Convert(varchar,Year(NotasCredito.FechaNotaCredito))+
--			Substring('00',1,2-len(Convert(varchar,Month(NotasCredito.FechaNotaCredito))))+Convert(varchar,Month(NotasCredito.FechaNotaCredito))+
--			Substring('00',1,2-len(Convert(varchar,Day(NotasCredito.FechaNotaCredito))))+Convert(varchar,Day(NotasCredito.FechaNotaCredito))),
--		Convert(numeric(16,0),'2'+'004'+Substring('000000000000',1,12-Len(Convert(varchar,dnc.IdDetalleNotaCredito)))+Convert(varchar,dnc.IdDetalleNotaCredito)),
--		Case When NotasCredito.TipoABC='B' AND IsNull(NotasCredito.IdCodigoIva,Clientes.IdCodigoIva)<>8  
--				Then Round(Case When dnc.Gravado='SI' Then IsNull(dnc.Importe,0) / (1+(NotasCredito.PorcentajeIva1/100)) Else IsNull(dnc.Importe,0) End * IsNull(NotasCredito.CotizacionMoneda,1),2)
--				Else Round(IsNull(dnc.Importe,0) * IsNull(NotasCredito.CotizacionMoneda,1),2)
--		End * -1
-- FROM DetalleNotasCredito dnc
-- LEFT OUTER JOIN NotasCredito ON dnc.IdNotaCredito = NotasCredito.IdNotaCredito
-- LEFT OUTER JOIN Clientes ON NotasCredito.IdCliente = Clientes.IdCliente
-- WHERE IsNull(NotasCredito.Anulada,'NO')<>'SI' and IsNull(NotasCredito.CtaCte,'SI')='SI' and IsNull(NotasCredito.NoIncluirEnCubos,'NO')<>'SI'

--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 1, IsNull(DetAsi.IdObra,0), -1, 
--		Convert(int,Convert(varchar,Year(Asientos.FechaAsiento))+
--			Substring('00',1,2-len(Convert(varchar,Month(Asientos.FechaAsiento))))+Convert(varchar,Month(Asientos.FechaAsiento))+
--			Substring('00',1,2-len(Convert(varchar,Day(Asientos.FechaAsiento))))+Convert(varchar,Day(Asientos.FechaAsiento))),
--		Convert(numeric(16,0),'2'+'038'+Substring('000000000000',1,12-Len(Convert(varchar,DetAsi.IdDetalleAsiento)))+Convert(varchar,DetAsi.IdDetalleAsiento)),
--		Case When DetAsi.Debe is not null and DetAsi.Haber is null Then DetAsi.Debe * -1
--				When DetAsi.Debe is null and DetAsi.Haber is not null Then DetAsi.Haber
--				When DetAsi.Debe is not null and DetAsi.Haber is not null Then (DetAsi.Debe - DetAsi.Haber) * -1
--				Else 0
--		End
-- FROM DetalleAsientos DetAsi 
-- LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
-- LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
-- WHERE Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'CIE' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'APE'

--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 2, IsNull(IsNull(dcp.IdObra,Cuentas.IdObra),0), CuentasGastos.IdRubroContable, 
--		Convert(int,Convert(varchar,Year(cp.FechaRecepcion))+
--			Substring('00',1,2-len(Convert(varchar,Month(cp.FechaRecepcion))))+Convert(varchar,Month(cp.FechaRecepcion))+
--			Substring('00',1,2-len(Convert(varchar,Day(cp.FechaRecepcion))))+Convert(varchar,Day(cp.FechaRecepcion))),
--		Convert(numeric(16,0),'2'+Substring('000',1,3-Len(Convert(varchar,cp.IdTipoComprobante)))+Convert(varchar,cp.IdTipoComprobante)+
--			Substring('000000000000',1,12-Len(Convert(varchar,dcp.IdDetalleComprobanteProveedor)))+Convert(varchar,dcp.IdDetalleComprobanteProveedor)), 
--		Case When cp.Letra='A' or cp.Letra='M' 
--				Then dcp.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
--				Else (dcp.Importe - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje1,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje2,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje3,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje4,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje5,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje6,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje7,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje8,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje9,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje10,0)/100))))) * 
--					cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
--		End
-- FROM DetalleComprobantesProveedores dcp 
-- LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor
-- LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
-- LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=dcp.IdCuenta
-- LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
-- WHERE IsNull(cp.Confirmado,'')<>'NO' and 
--		((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
--		 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=dcp.IdCuenta))) 

--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 2, IsNull(Cuentas.IdObra,IsNull(Facturas.IdObra,IsNull(Devoluciones.IdObra,IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0)))))))), IsNull(IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable),0), 
--		Convert(int,Convert(varchar,Year(Subdiarios.FechaComprobante))+
--			Substring('00',1,2-len(Convert(varchar,Month(Subdiarios.FechaComprobante))))+Convert(varchar,Month(Subdiarios.FechaComprobante))+
--			Substring('00',1,2-len(Convert(varchar,Day(Subdiarios.FechaComprobante))))+Convert(varchar,Day(Subdiarios.FechaComprobante))),
--		Convert(numeric(16,0),'1'+Substring('000',1,3-Len(Convert(varchar,Subdiarios.IdTipoComprobante)))+Convert(varchar,Subdiarios.IdTipoComprobante)+
--			Substring('000000000000',1,12-Len(Convert(varchar,Subdiarios.IdComprobante)))+Convert(varchar,Subdiarios.IdComprobante)), 
--		Case When Subdiarios.Debe is not null and Subdiarios.Haber is null Then Subdiarios.Debe * -1
--				When Subdiarios.Debe is null and Subdiarios.Haber is not null Then Subdiarios.Haber
--				When Subdiarios.Debe is not null and Subdiarios.Haber is not null Then (Subdiarios.Debe - Subdiarios.Haber) * -1
--				Else 0
--		End
-- FROM Subdiarios 
-- LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
-- LEFT OUTER JOIN TiposComprobante tc ON Subdiarios.IdTipoComprobante=tc.IdTipoComprobante
-- LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and 
--						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--						IsNull(tc.Agrupacion1,' ')='PROVEEDORES'
-- LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
-- LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
-- LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
-- LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
-- LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
-- LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
-- LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante and IsNull(tc.Agrupacion1,'')='GASTOSBANCOS'
-- LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(Cuentas.IdObra,IsNull(Facturas.IdObra,IsNull(Devoluciones.IdObra,IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0))))))))
-- LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
-- WHERE cp.IdComprobanteProveedor is null and IsNull(tc.Agrupacion1,'')<>'VENTAS' and 
--		((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
--		 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta))) 
	
--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 2, IsNull(IsNull(da.IdObra,Cuentas.IdObra),0), IsNull(CuentasGastos.IdRubroContable,0), 
--		Convert(int,Convert(varchar,Year(Asientos.FechaAsiento))+
--			Substring('00',1,2-len(Convert(varchar,Month(Asientos.FechaAsiento))))+Convert(varchar,Month(Asientos.FechaAsiento))+
--			Substring('00',1,2-len(Convert(varchar,Day(Asientos.FechaAsiento))))+Convert(varchar,Day(Asientos.FechaAsiento))),
--		Convert(numeric(16,0),'2'+'038'+Substring('000000000000',1,12-Len(Convert(varchar,da.IdDetalleAsiento)))+Convert(varchar,da.IdDetalleAsiento)),
--		Case When da.Debe is not null and da.Haber is null Then da.Debe * -1
--				When da.Debe is null and da.Haber is not null Then da.Haber
--				When da.Debe is not null and da.Haber is not null Then (da.Debe - da.Haber) * -1
--				Else 0
--		End
-- FROM DetalleAsientos da 
-- LEFT OUTER JOIN Asientos ON da.IdAsiento=Asientos.IdAsiento
-- LEFT OUTER JOIN Cuentas ON da.IdCuenta=Cuentas.IdCuenta
-- LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
-- WHERE Substring(IsNull(Asientos.Tipo,''),1,3)<>'CIE' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'APE' and 
--		((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
--		 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=da.IdCuenta)))
	
--INSERT INTO DW_FactIngresosEgresosPorObra
-- SELECT 3, IsNull(IsNull(dcp.IdObra,Cuentas.IdObra),0), CuentasGastos.IdRubroContable, 
--		Convert(int,Convert(varchar,Year(cp.FechaRecepcion))+
--			Substring('00',1,2-len(Convert(varchar,Month(cp.FechaRecepcion))))+Convert(varchar,Month(cp.FechaRecepcion))+
--			Substring('00',1,2-len(Convert(varchar,Day(cp.FechaRecepcion))))+Convert(varchar,Day(cp.FechaRecepcion))),
--		Convert(numeric(16,0),'2'+Substring('000',1,3-Len(Convert(varchar,cp.IdTipoComprobante)))+Convert(varchar,cp.IdTipoComprobante)+
--			Substring('000000000000',1,12-Len(Convert(varchar,dcp.IdDetalleComprobanteProveedor)))+Convert(varchar,dcp.IdDetalleComprobanteProveedor)), 
--		Case When cp.Letra='A' or cp.Letra='M' 
--				Then dcp.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
--				Else (dcp.Importe - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje1,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje2,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje3,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje4,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje5,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje6,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje7,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje8,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje9,0)/100)))) - 
--					(dcp.Importe-(dcp.Importe/(1+(IsNull(dcp.IVAComprasPorcentaje10,0)/100))))) * 
--					cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
--		End
-- FROM DetalleComprobantesProveedores dcp 
-- LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor
-- LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
-- LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=dcp.IdCuenta
-- LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
-- WHERE IsNull(cp.Confirmado,'')<>'NO' and 
--		(dcp.IdObra is not null and Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
--		 Not Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=dcp.IdCuenta)) 

--DELETE DW_FactIngresosEgresosPorObra
--WHERE Fecha is null

--UPDATE DW_FactIngresosEgresosPorObra
--SET IdObra=0
--WHERE Not Exists(Select Top 1 a.IdObra From DW_DimObras a Where a.IdObra=DW_FactIngresosEgresosPorObra.IdObra)


/*==========================================*/
/* PROCESO DE PROYECCION DE EGRESOS         */
/*==========================================*/

SET @proc_name='CtasCtesA_ProyeccionEgresosParaCubo1'
INSERT INTO DW_FactProyeccionEgresos 
	EXECUTE @proc_name @Desde, @nada, @Formato

UPDATE DW_FactProyeccionEgresos
SET Fecha=20000101
WHERE Fecha is null

DELETE DW_FactProyeccionEgresos
WHERE Not Exists(Select Top 1 DW_DimComprobantes.ClaveComprobante From DW_DimComprobantes Where DW_DimComprobantes.ClaveComprobante=DW_FactProyeccionEgresos.ClaveComprobante)

--DECLARE @IdCtaCte1 int, @IdCtaCte2 int, @IdImputacion1 int, @IdImputacion2 int, @IdImputacionAnt int, @IdProveedor1 int, @IdProveedor2 int, @IdProveedorAnt int, 
--		@SaldoCuota1 numeric(18,2), @SaldoCuota2 numeric(18,2), @ImporteCuota1 numeric(18,2), @ImporteCuota2 numeric(18,2), @A_Fecha datetime, @SaldoAAplicar numeric(18,2), 
--		@SaldoAplicado numeric(18,2), @Diferencia numeric(18,2), @IdAux int

--/*   CALCULAR SALDOS DE CUENTA CORRIENTE A LA FECHA INDICADA CON APERTURA POR CONDICIONES DE COMPRA   */
--CREATE TABLE #Auxiliar10 
--			(
--			 A_IdCtaCte INTEGER,
--			 A_IdProveedor INTEGER,
--			 A_Fecha DATETIME,
--			 A_IdImputacion INTEGER,
--			 A_Coeficiente INTEGER,
--			 A_ImporteCuota NUMERIC(18, 2),
--			 A_SaldoCuota NUMERIC(18, 2),
--			 A_Dias INTEGER,
--			 A_IdAux INTEGER,
--			 A_IdTipoComprobante INTEGER,
--			 A_IdComprobante INTEGER,
--			 A_ClaveComprobante NUMERIC(16,0)
--			)
--CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (A_IdImputacion, A_Fecha) ON [PRIMARY]
--CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar10 (A_IdCtaCte) ON [PRIMARY]
--INSERT INTO #Auxiliar10 
-- SELECT 
--  CtaCte.IdCtaCte,
--  CtaCte.IdProveedor,
--  Case When IsNull(Tmp.Dias,0)=0 and IsNull(Tmp.Porcentaje,100)=100
--		Then IsNull(IsNull(CtaCte.FechaVencimiento,cp.FechaComprobante),CtaCte.Fecha)
--		Else DateAdd(day,IsNull(Tmp.Dias,0),IsNull(cp.FechaComprobante,CtaCte.FechaVencimiento))
--  End,
--  IsNull(CtaCte.IdImputacion,0),
--  1,
--  CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100,
--  CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100,
--  0,
--  IsNull(Tmp.IdAux,0),
--  Case When CtaCte.IdTipoComp=16 Then 17 Else CtaCte.IdTipoComp End,
--  Abs(CtaCte.IdComprobante),
--  Convert(numeric(16,0),'1'+Substring('000',1,3-Len(Convert(varchar,Case When CtaCte.IdTipoComp=16 Then 17 Else CtaCte.IdTipoComp End)))+Convert(varchar,Case When CtaCte.IdTipoComp=16 Then 17 Else CtaCte.IdTipoComp End)+
--	Substring('000000000000',1,12-Len(Convert(varchar,Abs(CtaCte.IdComprobante))))+Convert(varchar,Abs(CtaCte.IdComprobante))) 
-- FROM CuentasCorrientesAcreedores CtaCte
-- LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
-- LEFT OUTER JOIN ComprobantesProveedores cp ON CtaCte.IdComprobante=cp.IdComprobanteProveedor and CtaCte.IdTipoComp=cp.IdTipoComprobante
-- LEFT OUTER JOIN _TempCondicionesCompra Tmp ON cp.IdCondicionCompra=Tmp.IdCondicionCompra 
-- WHERE TiposComprobante.Coeficiente=1 

--UPDATE #Auxiliar10
--SET A_Dias=DATEDIFF(day,A_Fecha,GETDATE())

--CREATE TABLE #Auxiliar11 
--			(
--			 A_IdCtaCte INTEGER,
--			 A_TotalImporteCuota NUMERIC(18, 2),
--			 A_TotalComprobante NUMERIC(18, 2),
--			 A_Diferencia NUMERIC(18, 2)
--			)
--CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (A_IdCtaCte) ON [PRIMARY]
--INSERT INTO #Auxiliar11 
-- SELECT A_IdCtaCte, Sum(A_ImporteCuota), 0, 0
-- FROM #Auxiliar10
-- GROUP BY A_IdCtaCte

--UPDATE #Auxiliar11
--SET A_TotalComprobante=(Select Top 1 CtaCte.ImporteTotal From CuentasCorrientesAcreedores CtaCte Where CtaCte.IdCtaCte=#Auxiliar11.A_IdCtaCte)
--UPDATE #Auxiliar11
--SET A_Diferencia=A_TotalComprobante-A_TotalImporteCuota

--DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdCtaCte, A_ImporteCuota, A_IdAux FROM #Auxiliar10 ORDER BY A_IdCtaCte 
--OPEN CtaCte1
--FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @ImporteCuota1, @IdAux
--WHILE @@FETCH_STATUS = 0
--  BEGIN
--	SET @Diferencia=IsNull((Select Top 1 A_Diferencia From #Auxiliar11 Where A_IdCtaCte=@IdCtaCte1),0)
--	IF @Diferencia<>0
--	  BEGIN
--		UPDATE #Auxiliar10
--		SET A_ImporteCuota=A_ImporteCuota+@Diferencia, A_SaldoCuota=A_SaldoCuota+@Diferencia
--		WHERE A_IdAux=@IdAux and A_IdCtaCte=@IdCtaCte1

--		UPDATE #Auxiliar11
--		SET A_Diferencia = 0
--		WHERE A_IdCtaCte=@IdCtaCte1
--	  END
--	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @ImporteCuota1, @IdAux
--  END
--CLOSE CtaCte1
--DEALLOCATE CtaCte1

--CREATE TABLE #Auxiliar20 
--			(
--			 A_IdCtaCte INTEGER,
--			 A_IdProveedor INTEGER,
--			 A_Fecha DATETIME,
--			 A_IdImputacion INTEGER,
--			 A_Coeficiente INTEGER,
--			 A_ImporteCuota NUMERIC(15, 2),
--			 A_SaldoCuota NUMERIC(15, 2),
--			 A_Dias INTEGER
--			)
--CREATE NONCLUSTERED INDEX IX__Auxiliar20 ON #Auxiliar20 (A_IdImputacion, A_Fecha) ON [PRIMARY]
--INSERT INTO #Auxiliar20 
-- SELECT 
--  CtaCte.IdCtaCte,
--  CtaCte.IdProveedor,
--  CtaCte.Fecha,
--  IsNull(CtaCte.IdImputacion,0),
--  -1,
--  CtaCte.ImporteTotal,
--  CtaCte.ImporteTotal,
--  0
-- FROM CuentasCorrientesAcreedores CtaCte
-- LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
-- WHERE TiposComprobante.Coeficiente=-1 

--/*  CURSORES  */
--DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY 
--	FOR	SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_ImporteCuota, A_SaldoCuota
--		FROM #Auxiliar20
--		WHERE A_SaldoCuota<>0 and A_IdImputacion<>0
--		ORDER BY A_IdImputacion, A_Fecha 
--OPEN CtaCte1
--FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1
--WHILE @@FETCH_STATUS = 0
--  BEGIN
--	SET @SaldoAAplicar=@SaldoCuota1
--	SET @IdImputacionAnt=@IdImputacion1
--	SET @IdProveedorAnt=@IdProveedor1

--	DECLARE CtaCte2 CURSOR LOCAL FORWARD_ONLY 
--		FOR	SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_ImporteCuota, A_SaldoCuota
--			FROM #Auxiliar10
--			WHERE A_SaldoCuota<>0 and A_IdImputacion=@IdImputacionAnt and A_IdProveedor=@IdProveedorAnt
--			ORDER BY A_IdImputacion, A_Fecha 
--	OPEN CtaCte2
--	FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteCuota2, @SaldoCuota2
--	WHILE @@FETCH_STATUS = 0 and not @SaldoAAplicar=0
--	  BEGIN
--		IF @SaldoAAplicar>=@SaldoCuota2
--		  BEGIN
--			SET @SaldoAAplicar=@SaldoAAplicar-@SaldoCuota2
--			SET @SaldoAplicado=0
--		  END
--		ELSE
--		  BEGIN
--			SET @SaldoAplicado=@SaldoCuota2-@SaldoAAplicar
--			SET @SaldoAAplicar=0
--		  END

--		UPDATE #Auxiliar10
--		SET A_SaldoCuota = @SaldoAplicado
--		WHERE CURRENT OF CtaCte2

--		FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteCuota2, @SaldoCuota2
--	  END
--	CLOSE CtaCte2
--	DEALLOCATE CtaCte2

--	UPDATE #Auxiliar20
--	SET A_SaldoCuota = @SaldoAAplicar
--	WHERE CURRENT OF CtaCte1

--	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1
--   END
--CLOSE CtaCte1
--DEALLOCATE CtaCte1

--INSERT INTO DW_FactProyeccionEgresos 
-- SELECT 
--  A_IdProveedor, 
--  Convert(int,Convert(varchar,Year(A_Fecha))+
--	Substring('00',1,2-len(Convert(varchar,Month(A_Fecha))))+Convert(varchar,Month(A_Fecha))+
--	Substring('00',1,2-len(Convert(varchar,Day(A_Fecha))))+Convert(varchar,Day(A_Fecha))),
--  A_SaldoCuota * A_Coeficiente,
--  A_ClaveComprobante
-- FROM #Auxiliar10
-- WHERE A_SaldoCuota<>0 

--DROP TABLE #Auxiliar10
--DROP TABLE #Auxiliar11
--DROP TABLE #Auxiliar20


/*==========================================*/
/* PROCESO DE CUADRO DE GASTOS DETALLADO    */
/*==========================================*/

SET @IncluirCierre='NO'

SET @proc_name='Cuentas_CuadroGastosPorObraDetallado'
INSERT INTO DW_FactCuadroGastosDetallado 
	EXECUTE @proc_name @Desde, @Hasta, @nada, @IncluirCierre, @AuxI1, @Formato

DELETE DW_FactCuadroGastosDetallado
WHERE Not Exists(Select Top 1 DW_DimComprobantes.ClaveComprobante From DW_DimComprobantes Where DW_DimComprobantes.ClaveComprobante=DW_FactCuadroGastosDetallado.ClaveComprobante)

--	 COLLATE Modern_Spanish_CI_AS
--CREATE TABLE #Auxiliar21 
--			(
--			 IdComprobanteProveedor INTEGER,
--			 Importe NUMERIC(18,2)
--			)
--INSERT INTO #Auxiliar21 
-- SELECT 
--  Subdiarios.IdComprobante,
--  Sum(
--	  Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null and 
--					Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--					Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--					Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--					Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--					Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--					Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--					IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
--			Then Subdiarios.Debe
--		When Subdiarios.Debe is null and Subdiarios.Haber is not null and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
--			Then Subdiarios.Haber * -1
--		When Subdiarios.Debe is not null and Subdiarios.Haber is not null and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--				Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--				IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
--			Then Subdiarios.Debe - Subdiarios.Haber
--		 Else 0
--	  End
--	  )
-- FROM Subdiarios 
-- LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
-- LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
-- WHERE ((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
--		 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta)))
-- GROUP BY Subdiarios.IdComprobante


--CREATE TABLE #Auxiliar22 
--			(
--			 IdComprobanteProveedor INTEGER,
--			 IdProvinciaDestino INTEGER,
--			 PorcentajeProvinciaDestino NUMERIC(12,5),
--			 PorcentajeGeneral NUMERIC(12,5)
--			)
--CREATE NONCLUSTERED INDEX IX__Auxiliar22 ON #Auxiliar22 (IdComprobanteProveedor) ON [PRIMARY]
--INSERT INTO #Auxiliar22 
-- SELECT 
--  dcp.IdComprobanteProveedor,
--  Case When cp.IdProveedor is not null
--		Then Case When dcp.IdProvinciaDestino1 is null or dcp.IdProvinciaDestino1=0 Then Proveedores.IdProvincia Else dcp.IdProvinciaDestino1 End
--		Else Case When dcp.IdProvinciaDestino1 is null or dcp.IdProvinciaDestino1=0 Then (Select Top 1 P.IdProvincia From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual) Else dcp.IdProvinciaDestino1 End
--  End,
--  dcp.PorcentajeProvinciaDestino1,
--  Case When IsNull(#Auxiliar21.Importe,0)<>0 
--		Then IsNull(dcp.PorcentajeProvinciaDestino1,100) * ((dcp.Importe*cp.CotizacionMoneda) / Case When IsNull(cp.TotalIvaNoDiscriminado,0)<>0 Then 1+(IsNull(dcp.IvaComprasPorcentaje1,0)/100) Else 1 End / Abs(#Auxiliar21.Importe))
--		Else 100 
--  End
-- FROM DetalleComprobantesProveedores dcp
-- LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
-- LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor  
-- LEFT OUTER JOIN #Auxiliar21 ON #Auxiliar21.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
-- LEFT OUTER JOIN Cuentas ON dcp.IdCuenta=Cuentas.IdCuenta
-- WHERE ((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
--		 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=dcp.IdCuenta))) and 
--		(IsNull(dcp.PorcentajeProvinciaDestino1,0)<>0 or (dcp.PorcentajeProvinciaDestino1 is null and dcp.PorcentajeProvinciaDestino2 is null))

-- UNION ALL

-- SELECT 
--  dcp.IdComprobanteProveedor,
--  Case When cp.IdProveedor is not null
--		Then Case When dcp.IdProvinciaDestino2 is null or dcp.IdProvinciaDestino2=0 Then Proveedores.IdProvincia Else dcp.IdProvinciaDestino2 End
--		Else Case When dcp.IdProvinciaDestino2 is null or dcp.IdProvinciaDestino2=0 Then (Select Top 1 P.IdProvincia From Proveedores P Where P.IdProveedor=cp.IdProveedorEventual) Else dcp.IdProvinciaDestino2 End
--  End,
--  dcp.PorcentajeProvinciaDestino2,
--  Case When IsNull(#Auxiliar21.Importe,0)<>0 
--		Then IsNull(dcp.PorcentajeProvinciaDestino2,100) * ((dcp.Importe*cp.CotizacionMoneda) / Case When IsNull(cp.TotalIvaNoDiscriminado,0)<>0 Then 1+(IsNull(dcp.IvaComprasPorcentaje1,0)/100) Else 1 End / #Auxiliar21.Importe)
--		Else 100 
--  End
-- FROM DetalleComprobantesProveedores dcp
-- LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
-- LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor  
-- LEFT OUTER JOIN #Auxiliar21 ON #Auxiliar21.IdComprobanteProveedor=dcp.IdComprobanteProveedor  
-- LEFT OUTER JOIN Cuentas ON dcp.IdCuenta=Cuentas.IdCuenta
-- WHERE ((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
--		 (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 
--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=dcp.IdCuenta))) and 
--		IsNull(dcp.PorcentajeProvinciaDestino2,0)<>0


--CREATE TABLE #Auxiliar23 
--			(
--			 IdComprobanteProveedor INTEGER,
--			 PorcentajeGeneral NUMERIC(12,5)
--			)
--CREATE NONCLUSTERED INDEX IX__Auxiliar23 ON #Auxiliar23 (IdComprobanteProveedor) ON [PRIMARY]
--INSERT INTO #Auxiliar23 
-- SELECT #Auxiliar22.IdComprobanteProveedor, SUM(#Auxiliar22.PorcentajeGeneral)
-- FROM #Auxiliar22
-- GROUP BY #Auxiliar22.IdComprobanteProveedor

--/*  CURSOR  */
--DECLARE @IdComprobanteProveedor int, @Corte int, @DiferenciaA100 numeric(12,5)
--SET @Corte=0
--DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdComprobanteProveedor FROM #Auxiliar22 ORDER BY IdComprobanteProveedor
--OPEN Cur
--FETCH NEXT FROM Cur INTO @IdComprobanteProveedor
--WHILE @@FETCH_STATUS = 0
--  BEGIN
--	IF @Corte<>@IdComprobanteProveedor
--	  BEGIN
--		SET @Corte=@IdComprobanteProveedor
--		SET @DiferenciaA100=100-IsNull((Select Top 1 #Auxiliar23.PorcentajeGeneral From #Auxiliar23 Where #Auxiliar23.IdComprobanteProveedor=@Corte),0)

--		UPDATE #Auxiliar22
--		SET PorcentajeGeneral = PorcentajeGeneral+@DiferenciaA100
--		WHERE CURRENT OF Cur
--	  END
--	FETCH NEXT FROM Cur INTO @IdComprobanteProveedor
--  END
--CLOSE Cur
--DEALLOCATE Cur

--INSERT INTO DW_FactCuadroGastosDetallado 
-- SELECT 
--  Case When Cuentas.IdObra is not null Then Cuentas.IdObra
--		When cp.IdComprobanteProveedor is not null Then IsNull((Select Top 1 dcp.IdObra From DetalleComprobantesProveedores dcp Where dcp.IdDetalleComprobanteProveedor=Subdiarios.IdDetalleComprobante),0)
--		Else IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0)))))
--  End,
--  IsNull(RubrosContables.IdRubroContable,IsNull((Select Top 1 cg.IdRubroContable From Cuentas C Left Outer Join CuentasGastos cg On cg.IdCuentaGasto=C.IdCuentaGasto Where cg.IdCuentaMadre=Subdiarios.IdCuenta),0)),
--  Convert(int,Convert(varchar,Year(Subdiarios.FechaComprobante))+
--	Substring('00',1,2-len(Convert(varchar,Month(Subdiarios.FechaComprobante))))+Convert(varchar,Month(Subdiarios.FechaComprobante))+
--	Substring('00',1,2-len(Convert(varchar,Day(Subdiarios.FechaComprobante))))+Convert(varchar,Day(Subdiarios.FechaComprobante))),
--  Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then IsNull(dfp.IdProvinciaDestino,0)
--		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones Then IsNull(Devoluciones.IdProvinciaDestino,0)
--		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then IsNull(dndp.IdProvinciaDestino,0)
--		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then IsNull(dncp.IdProvinciaDestino,0)
--		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago Then IsNull(OrdenesPago.IdProvinciaDestino,0)
--		When Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo Then IsNull(Recibos.IdProvinciaDestino,0)
--		Else Case When IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES' Then IsNull(#Auxiliar22.IdProvinciaDestino,0)
--					When IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS' Then IsNull(CuentasBancarias.IdProvincia,0)
--					Else 0
--			 End
--  End,
--  Convert(numeric(16,0),'1'+Substring('000',1,3-Len(Convert(varchar,Subdiarios.IdTipoComprobante)))+Convert(varchar,Subdiarios.IdTipoComprobante)+
--	Substring('000000000000',1,12-Len(Convert(varchar,Subdiarios.IdComprobante)))+Convert(varchar,Subdiarios.IdComprobante)), 
--  Case When Subdiarios.Debe is not null and Subdiarios.Haber is null 
--		Then Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Subdiarios.Debe * IsNull(dfp.Porcentaje,100) / 100 
--					When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Subdiarios.Debe * IsNull(dndp.Porcentaje,100) / 100
--					When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Subdiarios.Debe * IsNull(dncp.Porcentaje,100) / 100
--					When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--							IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
--					 Then Subdiarios.Debe * IsNull(#Auxiliar22.PorcentajeGeneral,100) / 100 
--					 Else Subdiarios.Debe
--			 End
--		When Subdiarios.Debe is null and Subdiarios.Haber is not null 
--		Then Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then Subdiarios.Haber * -1 * IsNull(dfp.Porcentaje,100) / 100
--					When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then Subdiarios.Haber * -1 * IsNull(dndp.Porcentaje,100) / 100
--					When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then Subdiarios.Haber * -1 * IsNull(dncp.Porcentaje,100) / 100 
--					When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--							IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
--					 Then Subdiarios.Haber * -1 * IsNull(#Auxiliar22.PorcentajeGeneral,100) / 100 
--					 Else Subdiarios.Haber * -1
--			End
--		When Subdiarios.Debe is not null and Subdiarios.Haber is not null 
--		Then Case When Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dfp.Porcentaje,100) / 100
--					When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dndp.Porcentaje,100) / 100 
--					When Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(dncp.Porcentaje,100) / 100
--					When Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--							Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--							IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
--					Then (Subdiarios.Debe - Subdiarios.Haber) * IsNull(#Auxiliar22.PorcentajeGeneral,100) / 100
--					Else (Subdiarios.Debe - Subdiarios.Haber)
--			 End
--		Else 0
--  End
-- FROM Subdiarios 
-- LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
-- LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
-- LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
-- LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable)
-- LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
-- LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
-- LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and 
--												Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--												Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--												Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--												Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--												Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--												Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--												IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
-- LEFT OUTER JOIN #Auxiliar22 ON #Auxiliar22.IdComprobanteProveedor=Subdiarios.IdComprobante and 
--								Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
--								Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
--								Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
--								Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
--								Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
--								Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
--								IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
-- LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
-- LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
-- LEFT OUTER JOIN DetalleFacturasProvincias dfp ON dfp.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
-- LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
-- LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
-- LEFT OUTER JOIN DetalleNotasDebitoProvincias dndp ON dndp.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
-- LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
-- LEFT OUTER JOIN DetalleNotasCreditoProvincias dncp ON dncp.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
-- LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
-- LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
-- LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
-- LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=Valores.IdCuentaBancaria
-- WHERE 
--		( (Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 

--		  (@ModeloContableSinApertura='SI' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='5') or 

--		  (((Cuentas.IdObra Is Null and NotasDebito.IdObra Is Not Null and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito) or 
--			(Cuentas.IdObra Is Null and NotasCredito.IdObra Is Not Null and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito)) and 
--		   Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta)) or 

--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
--		  Exists(Select Top 1 cg.IdCuentaMadre From CuentasGastos cg Where cg.IdCuentaMadre=Subdiarios.IdCuenta)) ) and 

--		(cp.IdComprobanteProveedor is null or (cp.IdComprobanteProveedor is not null and IsNull(cp.TomarEnCuboDeGastos,'SI')='SI'))

--INSERT INTO DW_FactCuadroGastosDetallado 
-- SELECT 
--  IsNull(Cuentas.IdObra,0),
--  IsNull(IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable),0),
--  Convert(int,Convert(varchar,Year(Asientos.FechaAsiento))+
--	Substring('00',1,2-len(Convert(varchar,Month(Asientos.FechaAsiento))))+Convert(varchar,Month(Asientos.FechaAsiento))+
--	Substring('00',1,2-len(Convert(varchar,Day(Asientos.FechaAsiento))))+Convert(varchar,Day(Asientos.FechaAsiento))),
--  IsNull(DetAsi.IdProvinciaDestino,0),
--  Convert(numeric(16,0),'2'+'038'+Substring('000000000000',1,12-Len(Convert(varchar,DetAsi.IdDetalleAsiento)))+Convert(varchar,DetAsi.IdDetalleAsiento)),
--  IsNull(DetAsi.Debe,0) - ISNull(DetAsi.Haber,0)
-- FROM DetalleAsientos DetAsi 
-- LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
-- LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
-- LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(DetAsi.IdObra,Cuentas.IdObra)
-- LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
-- LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable)
-- LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
-- LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=DetAsi.IdProvinciaDestino
-- WHERE 
--		((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
--		 IsNull(CuentasGastos.IdRubroContable,IsNull(Cuentas.IdRubroContable,0))>0 or 
--		 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 	
--		  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetAsi.IdCuenta))) and 
--		(@IncluirCierre='SI' or (@IncluirCierre='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE')))

--DROP TABLE #Auxiliar21
--DROP TABLE #Auxiliar22
--DROP TABLE #Auxiliar23


/*=====================================*/
/* PROCESO DE PRESUPUESTO FINANCIERO   */
/*=====================================*/

SET @proc_name='CuboPresupuestoFinanciero'
INSERT INTO DW_FactPresupuestoFinanciero 
	EXECUTE @proc_name @nada, @Formato

UPDATE DW_FactPresupuestoFinanciero
SET Fecha=20000101
WHERE Fecha is null

UPDATE DW_FactPresupuestoFinanciero
SET IdObra=0
WHERE IdObra is null

UPDATE DW_FactPresupuestoFinanciero
SET IdRubroContable=0
WHERE IdRubroContable is null

DELETE DW_FactPresupuestoFinanciero
WHERE Not Exists(Select Top 1 DW_DimComprobantes.ClaveComprobante From DW_DimComprobantes Where DW_DimComprobantes.ClaveComprobante=DW_FactPresupuestoFinanciero.ClaveComprobante)

DELETE DW_FactPresupuestoFinanciero
WHERE Not Exists(Select Top 1 DW_DimRubrosContables.IdRubroContable From DW_DimRubrosContables Where DW_DimRubrosContables.IdRubroContable=DW_FactPresupuestoFinanciero.IdRubroContable)


/*===================================*/
/* PROCESO DE POSICION FINANCIERA   */
/*===================================*/

SET @proc_name='CuboPosicionFinanciera'
INSERT INTO DW_FactPosicionFinanciera 
	EXECUTE @proc_name @Hasta, @nada, @Formato

UPDATE DW_FactPosicionFinanciera
SET Fecha=20000101
WHERE Fecha is null


/*==============================*/
/* PROCESO DE BALANCE CONTABLE  */
/*==============================*/

SET @proc_name='Cuentas_TX_BalanceConAperturaParaCubo'
INSERT INTO DW_FactBalance 
	EXECUTE @proc_name @nada, @nada, @Desde, @Hasta, @AuxI1, @Desde, @nada, @Si, @Si, @Si, @Formato

UPDATE DW_FactBalance
SET ClaveComprobante=Convert(numeric(16,0),'1000000000000000')
WHERE Not Exists(Select Top 1 DW_DimComprobantes.ClaveComprobante From DW_DimComprobantes Where DW_DimComprobantes.ClaveComprobante=DW_FactBalance.ClaveComprobante)
