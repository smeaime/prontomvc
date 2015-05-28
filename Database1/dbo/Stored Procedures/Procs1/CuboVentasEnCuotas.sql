CREATE Procedure [dbo].[CuboVentasEnCuotas]

@FechaDesde datetime,
@FechaHasta datetime,
@Dts varchar(200)

AS 

SET NOCOUNT ON

Declare @mIdRubroVentasEnCuotas int
Set @mIdRubroVentasEnCuotas=IsNull((Select Top 1 Parametros.IdRubroVentasEnCuotas
					From Parametros Where Parametros.IdParametro=1),0)

TRUNCATE TABLE _TempCuboVentasEnCuotas
INSERT INTO _TempCuboVentasEnCuotas 
 SELECT
  Articulos.Descripcion,
  IsNull(Articulos.NumeroManzana,''),
  'VENDIDO',
  'Cli.'+Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS+' '+
	'Cuota '+Substring('   ',1,3-Len(Convert(varchar,DetVta.Cuota)))+Convert(varchar,DetVta.Cuota)+'/'+Convert(varchar,vec.CantidadCuotas)+' '+
	'Vto.'+Convert(varchar,DetVta.FechaPrimerVencimiento,103)+' '+
	'DB '+NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)+' - '+
	'Gen.'+Convert(varchar,DetVta.NumeroGeneracion)+' - '+
	'Est.'+IsNull(EstadosVentasEnCuotas.Descripcion COLLATE Modern_Spanish_CI_AS,'')+' '+
	Case When vec.Observaciones is not null 
		Then '- Obs.'+Substring(Convert(varchar,vec.Observaciones),1,50)
		Else ''
	End,
  1,
  vec.ImporteCuota,
  vec.ImporteCuota-IsNull(Cta.Saldo,0),
  Case When IsNull(Cta.FechaVencimiento,DetVta.FechaPrimerVencimiento)<=GetDate()
	Then IsNull(Cta.Saldo,0)
	Else 0
  End,
  Case When DetVta.FechaPrimerVencimiento<=GetDate() Then 1 Else 0 End
 FROM DetalleVentasEnCuotas DetVta
 LEFT OUTER JOIN VentasEnCuotas vec ON vec.IdVentaEnCuotas=DetVta.IdVentaEnCuotas
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=vec.IdCliente
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
 LEFT OUTER JOIN EstadosVentasEnCuotas ON EstadosVentasEnCuotas.IdEstadoVentaEnCuotas=vec.IdEstadoVentaEnCuotas
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito = DetVta.IdNotaDebito
 LEFT OUTER JOIN CuentasCorrientesDeudores Cta ON Cta.IdTipoComp = 3 and Cta.IdComprobante = DetVta.IdNotaDebito

 UNION ALL

 SELECT
  Articulos.Descripcion,
  IsNull(Articulos.NumeroManzana,''),
  'DISPONIBLE',
  '',
  0,
  0,
  0,
  0,
  0
 FROM Articulos
 WHERE Articulos.IdRubro=@mIdRubroVentasEnCuotas and 
	Not Exists(Select Top 1 vec.IdVentaEnCuotas From VentasEnCuotas vec Where vec.IdArticulo=Articulos.IdArticulo)


TRUNCATE TABLE _TempCuboVentasEnCuotas1 
INSERT INTO _TempCuboVentasEnCuotas1 
 SELECT
  Clientes.RazonSocial,
  'Bien '+Articulos.Descripcion+' '+
	'Manz.:'+IsNull(Articulos.NumeroManzana COLLATE Modern_Spanish_CI_AS,'')+' '+
	'Cuota '+Substring('   ',1,3-Len(Convert(varchar,DetVta.Cuota)))+Convert(varchar,DetVta.Cuota)+'/'+Convert(varchar,vec.CantidadCuotas)+' '+
	'Vto.'+Convert(varchar,DetVta.FechaPrimerVencimiento,103)+' '+
	'DB '+NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)+' - '+
	'Gen.'+Convert(varchar,DetVta.NumeroGeneracion)+' - '+
	'Est.'+IsNull(EstadosVentasEnCuotas.Descripcion COLLATE Modern_Spanish_CI_AS,'')+' '+
	Case When vec.Observaciones is not null 
		Then '- Obs.'+Substring(Convert(varchar,vec.Observaciones),1,50)
		Else ''
	End,
  IsNull(Cta.FechaVencimiento,DetVta.FechaPrimerVencimiento),
  IsNull(Cta.ImporteTotal,0)
 FROM DetalleVentasEnCuotas DetVta
 LEFT OUTER JOIN VentasEnCuotas vec ON vec.IdVentaEnCuotas=DetVta.IdVentaEnCuotas
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=vec.IdCliente
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=vec.IdArticulo
 LEFT OUTER JOIN EstadosVentasEnCuotas ON EstadosVentasEnCuotas.IdEstadoVentaEnCuotas=vec.IdEstadoVentaEnCuotas
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito = DetVta.IdNotaDebito
 LEFT OUTER JOIN CuentasCorrientesDeudores Cta ON Cta.IdTipoComp = 3 and Cta.IdComprobante = DetVta.IdNotaDebito
 WHERE IsNull(Cta.FechaVencimiento,DetVta.FechaPrimerVencimiento) between @FechaDesde and @FechaHasta


Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF