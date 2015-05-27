CREATE Procedure [dbo].[Empleados_GenerarNovedadesPorControlesVariosParaAdministradores]

AS 

SET NOCOUNT ON 

DECLARE @IdEmpleado int, @IdTipoComprobante int, @IdComprobante int, @Tipo varchar(2), @NumeroComprobante varchar(20), @Detalle varchar(200), 
		@FechaArranqueCajaYBancos datetime

SET @FechaArranqueCajaYBancos=IsNull((Select Top 1 FechaArranqueCajaYBancos From Parametros Where IdParametro=1),convert(datetime,'1/1/2000',103))

CREATE TABLE #Auxiliar0 (IdEmpleado INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdEmpleado) ON [PRIMARY]
INSERT INTO #Auxiliar0 
 SELECT IdEmpleado
 FROM Empleados
 WHERE IsNull(Administrador,'')='SI'

CREATE TABLE #Auxiliar1 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Tipo VARCHAR(2),
			 NumeroComprobante VARCHAR(20),
			 Detalle VARCHAR(200)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdTipoComprobante, IdComprobante) ON [PRIMARY]

--Verificar que este en cuenta corriente deudores
INSERT INTO #Auxiliar1 
 SELECT 
  1, 
  Facturas.IdFactura, 
  'FA',
  Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
  'El comprobante FA '+Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' del '+Convert(varchar,Facturas.FechaFactura)+', no esta en cuenta corriente'
 FROM Facturas
 WHERE IsNull(Facturas.Anulada,'')<>'SI' and IsNull(Facturas.Anulada,'')<>'AN' and IsNull(Facturas.OrigenRegistro,'')='' and Facturas.FechaFactura>=@FechaArranqueCajaYBancos and 
		Not Exists(Select Top 1 ccd.IdCtaCte From CuentasCorrientesDeudores ccd Where ccd.IdTipoComp=1 and ccd.IdComprobante=Facturas.IdFactura)

--Verificar que este en subdiarios
INSERT INTO #Auxiliar1 
 SELECT 
  1, 
  Facturas.IdFactura, 
  'FA',
  Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
  'El comprobante FA '+Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' del '+Convert(varchar,Facturas.FechaFactura)+', no esta en subdiarios'
 FROM Facturas
 WHERE IsNull(Facturas.Anulada,'')<>'SI' and IsNull(Facturas.Anulada,'')<>'AN' and IsNull(Facturas.OrigenRegistro,'')='' and Facturas.FechaFactura>=@FechaArranqueCajaYBancos and 
		Facturas.ImporteTotal>0 and Not Exists(Select Top 1 Subdiarios.IdSubdiario From Subdiarios Where Subdiarios.IdTipoComprobante=1 and Subdiarios.IdComprobante=Facturas.IdFactura)

INSERT INTO #Auxiliar1 
 SELECT 
  3, 
  NotasDebito.IdNotaDebito, 
  'ND',
  NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
  'El comprobante ND '+NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)+' del '+Convert(varchar,NotasDebito.FechaNotaDebito)+', no esta en subdiarios'
 FROM NotasDebito
 WHERE IsNull(NotasDebito.Anulada,'')<>'SI' and IsNull(NotasDebito.Anulada,'')<>'AN' and NotasDebito.FechaNotaDebito>=@FechaArranqueCajaYBancos and 
		NotasDebito.ImporteTotal>0 and Not Exists(Select Top 1 Subdiarios.IdSubdiario From Subdiarios Where Subdiarios.IdTipoComprobante=3 and Subdiarios.IdComprobante=NotasDebito.IdNotaDebito)

INSERT INTO #Auxiliar1 
 SELECT 
  4, 
  NotasCredito.IdNotaCredito, 
  'NC',
  NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
  'El comprobante NC '+NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito)+' del '+Convert(varchar,NotasCredito.FechaNotaCredito)+', no esta en subdiarios'
 FROM NotasCredito
 WHERE IsNull(NotasCredito.Anulada,'')<>'SI' and IsNull(NotasCredito.Anulada,'')<>'AN' and NotasCredito.FechaNotaCredito>=@FechaArranqueCajaYBancos and 
		NotasCredito.ImporteTotal>0 and Not Exists(Select Top 1 Subdiarios.IdSubdiario From Subdiarios Where Subdiarios.IdTipoComprobante=4 and Subdiarios.IdComprobante=NotasCredito.IdNotaCredito)

IF IsNull((Select Count(*) From #Auxiliar1),0)>0
  BEGIN
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEmpleado FROM #Auxiliar0 ORDER BY IdEmpleado
	OPEN Cur 
	FETCH NEXT FROM Cur INTO @IdEmpleado
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdTipoComprobante, IdComprobante, Tipo, NumeroComprobante, Detalle FROM #Auxiliar1 ORDER BY IdTipoComprobante, IdComprobante
		OPEN Cur2 
		FETCH NEXT FROM Cur2 INTO @IdTipoComprobante, @IdComprobante, @Tipo, @NumeroComprobante, @Detalle
		WHILE @@FETCH_STATUS = 0
		  BEGIN
			IF Not Exists(Select Top 1 nu.IdNovedadUsuarios From NovedadesUsuarios nu Where nu.IdEmpleado=@IdEmpleado and nu.IdElemento=@IdComprobante and IsNull(nu.TipoElemento,'')=@Tipo and IsNull(nu.IdEventoDelSistema,0)=501)
				INSERT INTO NovedadesUsuarios
				(IdEmpleado, IdEventoDelSistema, FechaEvento, Confirmado, FechaConfirmacion, Detalle, IdEnviadoPor, IdElemento, TipoElemento)
				VALUES
				(@IdEmpleado, 501, GetDate(), 'NO', Null, @Detalle, Null, @IdComprobante, @Tipo)
			FETCH NEXT FROM Cur2 INTO @IdTipoComprobante, @IdComprobante, @Tipo, @NumeroComprobante, @Detalle
		  END
		CLOSE Cur2
		DEALLOCATE Cur2

		FETCH NEXT FROM Cur INTO @IdEmpleado
	  END
	CLOSE Cur
	DEALLOCATE Cur
  END

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1

SET NOCOUNT OFF

