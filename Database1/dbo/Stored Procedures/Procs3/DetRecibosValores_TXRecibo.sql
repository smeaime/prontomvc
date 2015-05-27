CREATE PROCEDURE [dbo].[DetRecibosValores_TXRecibo]

@IdRecibo int

As

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleReciboValores INTEGER,
			 Tipo VARCHAR(20),
			 NumeroInterno INTEGER,
			 NumeroValor NUMERIC(18,0),
			 FechaVencimiento DATETIME,
			 Banco VARCHAR(50),
			 Caja VARCHAR(50),
			 Tarjeta VARCHAR(50),
			 NumeroTarjeta VARCHAR(20),
			 Importe NUMERIC(18, 2),
			 CuitLibrador varchar(13),
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetRec.IdDetalleReciboValores,
  TiposComprobante.DescripcionAB,
  DetRec.NumeroInterno,
  IsNull(DetRec.NumeroValor,DetRec.NumeroTransferencia),
  DetRec.FechaVencimiento,
  IsNull(B1.Nombre,B2.Nombre),
  Cajas.Descripcion,
  TarjetasCredito.Nombre,
  DetRec.NumeroTarjetaCredito,
  DetRec.Importe,
  DetRec.CuitLibrador
 FROM DetalleRecibosValores DetRec
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetRec.IdTipoValor
 LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=DetRec.IdCuentaBancariaTransferencia
 LEFT OUTER JOIN Bancos B1 ON B1.IdBanco=DetRec.IdBanco
 LEFT OUTER JOIN Bancos B2 ON B2.IdBanco=CuentasBancarias.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetRec.IdCaja
 LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=DetRec.IdTarjetaCredito
 WHERE (DetRec.IdRecibo = @IdRecibo)

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111111133'
Set @vector_T='0010404300'

SELECT
 IdDetalleReciboValores,
 Tipo as [Tipo],
 NumeroInterno as [Nro.Int.],
 Case 	When NumeroValor is not null Then Convert(varchar,NumeroValor)
	When NumeroTarjeta is not null Then NumeroTarjeta
	Else Null
 End as [Numero],
 FechaVencimiento as [Fec.Vto.],
 Case 	When Caja is not null Then Caja 
	When Banco is not null Then Banco 
	When Tarjeta is not null Then Tarjeta 
	 Else Null
 End as [Banco / Caja],
 Importe,
 CuitLibrador,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1

DROP TABLE #Auxiliar1