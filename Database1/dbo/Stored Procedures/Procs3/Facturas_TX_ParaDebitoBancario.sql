CREATE PROCEDURE [dbo].[Facturas_TX_ParaDebitoBancario]

@Desde datetime,
@Hasta datetime,
@IdBanco int

AS

SET NOCOUNT ON

SET DATEFIRST 1

DECLARE @Registro_Inicio varchar(200), @Registro_Fin varchar(200), @CantReg int, @ImporteTotal numeric(18,0), @Codigo int, @Entidad int, @Subentidad int, 
	@NumeroDiaSemana int, @Hasta2 datetime, @Cuit varchar(11), @SumaDigitoVerificador int, @IdTarjetaCredito int, @NumeroEstablecimiento varchar(10),
	@CodigoServicio varchar(5),@NumeroServicio varchar(10), @FechaActual datetime

SET @FechaActual=GetDate()

SET @IdTarjetaCredito=0
IF @IdBanco>1000000
    BEGIN
	SET @IdTarjetaCredito=@IdBanco-1000000
	SET @IdBanco=0
	SET @Codigo=IsNull((Select Top 1 DiseñoRegistro From TarjetasCredito Where IdTarjetaCredito=@IdTarjetaCredito),0)
	SET @NumeroEstablecimiento=IsNull((Select Top 1 NumeroEstablecimiento From TarjetasCredito Where IdTarjetaCredito=@IdTarjetaCredito),'')
	SET @CodigoServicio=IsNull((Select Top 1 CodigoServicio From TarjetasCredito Where IdTarjetaCredito=@IdTarjetaCredito),'')
	SET @NumeroServicio=IsNull((Select Top 1 NumeroServicio From TarjetasCredito Where IdTarjetaCredito=@IdTarjetaCredito),'')
	SET @Entidad=0
	SET @Subentidad=0
    END
ELSE
    BEGIN
	SET @Codigo=IsNull((Select Top 1 Codigo From Bancos Where IdBanco=@IdBanco),0)
	SET @Entidad=IsNull((Select Top 1 Entidad From Bancos Where IdBanco=@IdBanco),0)
	SET @Subentidad=IsNull((Select Top 1 Subentidad From Bancos Where IdBanco=@IdBanco),0)
	SET @NumeroEstablecimiento=''
	SET @CodigoServicio=''
	SET @NumeroServicio=''
    END

SET @Cuit=IsNull((Select Top 1 Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1) From Empresa),'')

CREATE TABLE #Auxiliar0 
			(
			 IdComprobante INTEGER,
			 Tipo VARCHAR(02),
			 Numero VARCHAR(15),
			 Fecha DATETIME,
			 CodigoCliente INTEGER,
			 Cliente VARCHAR(50),
			 CBU VARCHAR(22),
			 Cuit VARCHAR(11),
			 CondicionIva VARCHAR(50),
			 Importe NUMERIC(18,0),
			 Moneda VARCHAR(15),
			 Registro VARCHAR(200),
			 ClaveComprobante VARCHAR(14),
			 NumeroTarjeta VARCHAR(16),
			 NumeroComprobante INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT 
  Facturas.IdFactura, 
  '01',
  Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
  Facturas.FechaFactura,
  Clientes.CodigoCliente, 
  Clientes.RazonSocial, 
  Clientes.CBU, 
  Substring(Clientes.Cuit,1,2)+Substring(Clientes.Cuit,4,8)+Substring(Clientes.Cuit,13,1),
  DescripcionIva.Descripcion, 
  IsNull((Select Top 1 cc.Saldo From CuentasCorrientesDeudores cc Where cc.IdComprobante=Facturas.IdFactura and cc.IdTipoComp=1),Facturas.ImporteTotal)*100,
  Monedas.Abreviatura,
  '',
  '01'+Substring('000000000000',1,12-len(Convert(varchar,Facturas.IdFactura)))+Convert(varchar,Facturas.IdFactura),
  IsNull(Clientes.Tarjeta_NumeroTarjeta,''),
  Facturas.NumeroFactura
 FROM Facturas 
 LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda
 WHERE (Facturas.FechaFactura between @Desde and @hasta) and IsNull(Facturas.Anulada,'NO')<>'SI' and 
	((Clientes.IdBancoDebito is not null and IsNull(Clientes.IdBancoGestionador,0)=@IdBanco) or (Clientes.IdTarjetaCredito is not null and IsNull(Clientes.IdTarjetaCredito,0)=@IdTarjetaCredito))

 UNION ALL

 SELECT 
  NotasDebito.IdNotaDebito, 
  '03',
  NotasDebito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
  NotasDebito.FechaNotaDebito,
  Clientes.CodigoCliente, 
  Clientes.RazonSocial, 
  Clientes.CBU, 
  Substring(Clientes.Cuit,1,2)+Substring(Clientes.Cuit,4,8)+Substring(Clientes.Cuit,13,1),
  DescripcionIva.Descripcion, 
  IsNull((Select Top 1 cc.Saldo From CuentasCorrientesDeudores cc Where cc.IdComprobante=NotasDebito.IdNotaDebito and cc.IdTipoComp=3),NotasDebito.ImporteTotal)*100,
  Monedas.Abreviatura,
  '',
  '03'+Substring('000000000000',1,12-len(Convert(varchar,NotasDebito.IdNotaDebito)))+Convert(varchar,NotasDebito.IdNotaDebito),
  IsNull(Clientes.Tarjeta_NumeroTarjeta,''),
  NotasDebito.NumeroNotaDebito
 FROM NotasDebito 
 LEFT OUTER JOIN Clientes ON NotasDebito.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN DescripcionIva ON IsNull(NotasDebito.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN Monedas ON NotasDebito.IdMoneda = Monedas.IdMoneda
 WHERE (NotasDebito.FechaNotaDebito between @Desde and @hasta) and IsNull(NotasDebito.Anulada,'NO')<>'SI' and 
	((Clientes.IdBancoDebito is not null and IsNull(Clientes.IdBancoGestionador,0)=@IdBanco) or (Clientes.IdTarjetaCredito is not null and IsNull(Clientes.IdTarjetaCredito,0)=@IdTarjetaCredito))

DELETE #Auxiliar0
WHERE Importe=0

CREATE TABLE #Auxiliar1 
			(
			 IdAux INTEGER IDENTITY (1, 1),
			 IdComprobante INTEGER,
			 Tipo VARCHAR(02),
			 Numero VARCHAR(15),
			 Fecha DATETIME,
			 CodigoCliente INTEGER,
			 Cliente VARCHAR(50),
			 CBU VARCHAR(22),
			 Cuit VARCHAR(11),
			 CondicionIva VARCHAR(50),
			 Importe NUMERIC(18,0),
			 Moneda VARCHAR(15),
			 Registro VARCHAR(200),
			 ClaveComprobante VARCHAR(14),
			 NumeroTarjeta VARCHAR(16),
			 NumeroComprobante INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT IdComprobante, Tipo, Numero, Fecha, CodigoCliente, Cliente, CBU, Cuit, CondicionIva, Importe, Moneda, Registro, ClaveComprobante, NumeroTarjeta, NumeroComprobante
 FROM #Auxiliar0
 ORDER BY Tipo, Fecha, Numero

SET @CantReg=IsNull((Select Count(*) From #Auxiliar1),0)
SET @ImporteTotal=IsNull((Select Sum(IsNull(Importe,0)) From #Auxiliar1),0)
SET @SumaDigitoVerificador=IsNull((Select Sum(IsNull(Convert(int,Substring(CBU,Len(CBU),1)),0)) From #Auxiliar1),0)
SET @NumeroDiaSemana=DatePart(dw,@Hasta)
SET @Hasta2=DateAdd(day,Case When @NumeroDiaSemana=6 Then 2 Else 1 End,@Hasta)

-- RIO
IF @IdBanco>0 and @Codigo=1
   BEGIN
	UPDATE #Auxiliar1
	SET Registro='11CUOTAS    '+
		IsNull(Cuit,'')+Substring('                      ',1,22-len(IsNull(Cuit,'')))+
		IsNull(CBU,'')+Substring('                      ',1,22-len(IsNull(CBU,'')))+
		Convert(varchar,Year(@Hasta))+
			Substring('00',1,2-len(Convert(varchar,Month(@Hasta))))+Convert(varchar,Month(@Hasta))+
			Substring('00',1,2-len(Convert(varchar,Day(@Hasta))))+Convert(varchar,Day(@Hasta))+
		Substring('0000000000000000',1,16-len(Convert(varchar,Importe)))+Convert(varchar,Importe)+
		Numero+
		Substring(IsNull(Cliente,''),1,30)+Substring('                              ',1,30-len(Substring(IsNull(Cliente,''),1,30)))+
		' '+
		ClaveComprobante+Numero+'                     '
	
	SET @Registro_Inicio='10'+
		Convert(varchar,Year(GetDate()))+
			Substring('00',1,2-len(Convert(varchar,Month(GetDate()))))+Convert(varchar,Month(GetDate()))+
			Substring('00',1,2-len(Convert(varchar,Day(GetDate()))))+Convert(varchar,Day(GetDate()))+
		Substring('00000',1,5-len(Convert(varchar,@CantReg)))+Convert(varchar,@CantReg)+
		Substring('0000000000000000000',1,19-len(Convert(varchar,@ImporteTotal)))+Convert(varchar,@ImporteTotal)
	SET @Registro_Fin=''
   END

-- HSBC
IF @IdBanco>0 and @Codigo=2
   BEGIN
	UPDATE #Auxiliar1
	SET Registro='6'+
		Substring('00000',1,5-len(Convert(varchar,@Entidad)))+Convert(varchar,@Entidad)+
		Substring('000',1,3-len(Convert(varchar,@Subentidad)))+Convert(varchar,@Subentidad)+
		'HAWK GPS  '+
		'080'+
		Convert(varchar,Year(@Hasta))+
			Substring('00',1,2-len(Convert(varchar,Month(@Hasta))))+Convert(varchar,Month(@Hasta))+
			Substring('00',1,2-len(Convert(varchar,Day(@Hasta))))+Convert(varchar,Day(@Hasta))+
		Convert(varchar,Year(@Hasta2))+
			Substring('00',1,2-len(Convert(varchar,Month(@Hasta2))))+Convert(varchar,Month(@Hasta2))+
			Substring('00',1,2-len(Convert(varchar,Day(@Hasta2))))+Convert(varchar,Day(@Hasta2))+
		Substring(IsNull(CBU,'')+'        ',1,8)+
			'000'+Substring(Substring(IsNull(CBU,''),9,14)+'               ',1,14)+
		Substring('0000000000',1,10-len(Convert(varchar,Importe)))+Convert(varchar,Importe)+
		ClaveComprobante+' '+ --IsNull(Numero,'')+Substring('               ',1,15-len(IsNull(Numero,'')))+
		Substring(IsNull(Cuit,'')+'                     ',1,22)+
		'3700'+
		'000'+
		'                                                        '+
		Substring('0000000',1,7-len(Convert(varchar,IdAux+1)))+Convert(varchar,IdAux+1)
	
	SET @Registro_Inicio='5'+
		Substring('00000',1,5-len(Convert(varchar,@Entidad)))+Convert(varchar,@Entidad)+
		@Cuit+
		'000'+
		'                                                                                                                                                         '+
		'0000001'
	SET @Registro_Fin='8'+
		Substring('00000',1,5-len(Convert(varchar,@Entidad)))+Convert(varchar,@Entidad)+
		Substring('000000',1,6-len(Convert(varchar,@CantReg)))+Convert(varchar,@CantReg)+
		Substring('000000000000',1,12-len(Convert(varchar,@ImporteTotal)))+Convert(varchar,@ImporteTotal)+
		Substring('00000000000000000',1,17-len(Convert(varchar,@SumaDigitoVerificador)))+Convert(varchar,@SumaDigitoVerificador)+
		'                                                                                                                                    '+
		Substring('0000000',1,7-len(Convert(varchar,@CantReg+2)))+Convert(varchar,@CantReg+2)
   END

-- AMERICAN EXPRESS
IF @IdTarjetaCredito>0 and @Codigo=1
   BEGIN
	UPDATE #Auxiliar1
	SET Registro=Substring(@NumeroEstablecimiento+'          ',1,10)+
		Substring(IsNull(NumeroTarjeta,'')+'                ',1,15)+
		Substring(@CodigoServicio+'     ',1,5)+
		Substring(@NumeroServicio+'          ',1,10)+
		'01'+
		Substring(Convert(varchar,Year(DateAdd(m,1,@Hasta))),3,2)+Substring('00',1,2-len(Convert(varchar,Month(DateAdd(m,1,@Hasta)))))+Convert(varchar,Month(DateAdd(m,1,@Hasta)))+
		Substring('00000000000',1,11-len(Convert(varchar,Importe)))+Convert(varchar,Importe)+
		Substring('00',1,2-len(Convert(varchar,Month(@Hasta))))+Convert(varchar,Month(@Hasta))+'/'+Substring(Convert(varchar,Year(DateAdd(m,1,@Hasta))),3,2)+
		'                                      '
   END

-- VISA
IF @IdTarjetaCredito>0 and @Codigo=2
   BEGIN
	UPDATE #Auxiliar1
	SET Registro='1'+
		Substring(IsNull(NumeroTarjeta,'')+'                 ',1,16)+
		'   '+
		Substring('00000000',1,8-len(Convert(varchar,NumeroComprobante)))+Convert(varchar,NumeroComprobante)+
		--Substring('00000000',1,8-len(Convert(varchar,IdAux+1)))+Convert(varchar,IdAux+1)+
		Convert(varchar,Year(@Hasta))+
			Substring('00',1,2-len(Convert(varchar,Month(@Hasta))))+Convert(varchar,Month(@Hasta))+
			Substring('00',1,2-len(Convert(varchar,Day(@Hasta))))+Convert(varchar,Day(@Hasta))+
		'0005'+
		Substring('000000000000000',1,15-len(Convert(varchar,Importe)))+Convert(varchar,Importe)+
		ClaveComprobante+' '+
		'E'+
		'  '+
		'                          '+
		'*'
	
	SET @Registro_Inicio='0'+'DEBLIQC '+
		Substring(@NumeroEstablecimiento+'          ',1,10)+
		'900000    '+
		Convert(varchar,Year(@FechaActual))+
			Substring('00',1,2-len(Convert(varchar,Month(@FechaActual))))+Convert(varchar,Month(@FechaActual))+
			Substring('00',1,2-len(Convert(varchar,Day(@FechaActual))))+Convert(varchar,Day(@FechaActual))+
		Substring('00',1,2-len(Convert(varchar,datepart(hh,@FechaActual))))+Convert(varchar,datepart(hh,@FechaActual))+
			Substring('00',1,2-len(Convert(varchar,datepart(mi,@FechaActual))))+Convert(varchar,datepart(mi,@FechaActual))+
		'0'+
		'  '+
		'                                                       '+
		'*'
	SET @Registro_Fin='9'+'DEBLIQC '+
		Substring(@NumeroEstablecimiento+'          ',1,10)+
		'900000    '+
		Convert(varchar,Year(@FechaActual))+
			Substring('00',1,2-len(Convert(varchar,Month(@FechaActual))))+Convert(varchar,Month(@FechaActual))+
			Substring('00',1,2-len(Convert(varchar,Day(@FechaActual))))+Convert(varchar,Day(@FechaActual))+
		Substring('00',1,2-len(Convert(varchar,datepart(hh,@FechaActual))))+Convert(varchar,datepart(hh,@FechaActual))+
			Substring('00',1,2-len(Convert(varchar,datepart(mi,@FechaActual))))+Convert(varchar,datepart(mi,@FechaActual))+
		Substring('0000000',1,7-len(Convert(varchar,@CantReg)))+Convert(varchar,@CantReg)+
		Substring('000000000000000',1,15-len(Convert(varchar,@ImporteTotal)))+Convert(varchar,@ImporteTotal)+
		'                                    '+
		'*'
   END

SET NOCOUNT ON

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00111111111133'
SET @vector_T='00074144240400'

SELECT 
 -1 as [IdAux], 
 0 as [IdComprobante], 
 '00' as [Tipo],
 Null as [Numero],
 Null as [Fecha],
 Null as [Cod.Cli.], 
 'REGISTRO CABECERA' as [Cliente], 
 Null as [CBU], 
 Null as [Condicion IVA], 
 Null as [Total],
 Null as [Mon.],
 @Registro_Inicio as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL

SELECT 
 #Auxiliar1.IdAux as [IdAux], 
 #Auxiliar1.IdComprobante as [IdComprobante], 
 #Auxiliar1.Tipo as [Tipo],
 #Auxiliar1.Numero as [Numero],
 #Auxiliar1.Fecha as [Fecha],
 #Auxiliar1.CodigoCliente as [Cod.Cli.], 
 #Auxiliar1.Cliente as [Cliente], 
 #Auxiliar1.CBU as [CBU], 
 #Auxiliar1.CondicionIva as [Condicion IVA], 
 #Auxiliar1.Importe/100 as [Total],
 #Auxiliar1.Moneda as [Mon.],
 #Auxiliar1.Registro as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 

UNION ALL

SELECT 
 999999 as [IdAux], 
 0 as [IdComprobante], 
 '99' as [Tipo],
 Null as [Numero],
 Null as [Fecha],
 Null as [Cod.Cli.], 
 'REGISTRO PIE' as [Cliente], 
 Null as [CBU], 
 Null as [Condicion IVA], 
 Null as [Total],
 Null as [Mon.],
 @Registro_Fin as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

ORDER BY [IdAux], [Tipo], [Fecha], [Registro]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1