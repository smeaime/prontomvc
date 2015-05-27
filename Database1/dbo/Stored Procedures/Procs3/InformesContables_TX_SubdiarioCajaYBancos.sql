
CREATE PROCEDURE [dbo].[InformesContables_TX_SubdiarioCajaYBancos]

@FechaDesde datetime,
@FechaHasta datetime

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
			 IdAux INTEGER,
			 IdCuenta INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Detalle VARCHAR(100),
			 NumeroComprobante INTEGER,
			 TipoValor VARCHAR(1),
			 NumeroValor INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT
  1,
  Subdiarios.IdCuenta, 
  Subdiarios.FechaComprobante,
  Subdiarios.IdTipoComprobante,
  Subdiarios.IdComprobante,
  TiposComprobante.DescripcionAb,
  Subdiarios.Debe,
  Subdiarios.Haber,
  Null,
  IsNull(Subdiarios.NumeroComprobante,0),
  Null,
  Valores.NumeroValor
 FROM Subdiarios
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Valores ON Subdiarios.IdComprobante=Valores.IdValor and 
				Subdiarios.NumeroComprobante=Valores.NumeroComprobante
 WHERE Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	(IsNull(Subdiarios.Debe,0)<>0 or IsNull(Subdiarios.Haber,0)<>0) and 
	Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
	Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
	Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
	Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
	Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
	Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
	IsNull(TiposComprobante.Agrupacion1,'')<>'PROVEEDORES' and 
	Not ((Subdiarios.IdTipoComprobante=28 or Subdiarios.IdTipoComprobante=29) and 
		IsNull(Valores.Iva,0)<>0) and 
	Not ((Subdiarios.IdTipoComprobante=44 or Subdiarios.IdTipoComprobante=45) and 
		IsNull(Valores.Iva,0)<>0) 

UNION ALL

 SELECT
  1,
  0, 
  DepositosBancarios.FechaDeposito,
  14,
  DepositosBancarios.IdDepositoBancario,
  'DE',
  0,
  0,
  'ANU',
  IsNull(DepositosBancarios.NumeroDeposito,0),
  Null,
  Null
 FROM DepositosBancarios
 LEFT OUTER JOIN Bancos ON DepositosBancarios.IdBanco=Bancos.IdBanco
 WHERE DepositosBancarios.FechaDeposito>=@FechaDesde and 
	DepositosBancarios.FechaDeposito<=DATEADD(n,1439,@FechaHasta) and 
	IsNull(DepositosBancarios.Anulado,'NO')='SI'


CREATE TABLE #Auxiliar4	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_Descripcion VARCHAR(50),
			 A_NombreAnterior VARCHAR(50),
			 A_CodigoAnterior INTEGER
			)
INSERT INTO #Auxiliar4 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  (Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio),
  (Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaHasta 
	Order By dc.FechaCambio)
 FROM Cuentas 

SET NOCOUNT ON

Declare @vector_X varchar(30), @vector_T varchar(30), @vector_E varchar(30)
Set @vector_X='00000111111111133'
Set @vector_T='0000040H2E1133900'

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 Null as [K_TipoComprobante],
 Null as [K_NumeroComprobante],
 1 as [K_Orden],
 #Auxiliar1.Fecha as [Fecha],
 Null as [Tipo],
 Null as [Numero],
-- IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
 Null as [Cuenta contable],
 Null as [Referencia],
 Null as [Tipo Valor],
 Null as [Nto.Valor],
 Null as [Debe],
 Null as [Haber],
 ' FEC |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY  #Auxiliar1.Fecha

UNION ALL

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.TipoComprobante as [K_TipoComprobante],
 #Auxiliar1.NumeroComprobante as [K_NumeroComprobante],
 2 as [K_Orden],
 Null as [Fecha],
 #Auxiliar1.TipoComprobante as [Tipo],
 '0000 '+Substring('0000000000',1,10-Len(Convert(varchar,#Auxiliar1.NumeroComprobante)))+
	Convert(varchar,#Auxiliar1.NumeroComprobante) as [Numero],
-- IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
 Null as [Cuenta contable],
 Null as [Referencia],
 Null as [Tipo Valor],
 Null as [Nto.Valor],
 Null as [Debe],
 Null as [Haber],
 '  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY  #Auxiliar1.Fecha, #Auxiliar1.TipoComprobante, #Auxiliar1.NumeroComprobante

UNION ALL

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.TipoComprobante as [K_TipoComprobante],
 #Auxiliar1.NumeroComprobante as [K_NumeroComprobante],
 3 as [K_Orden],
 Null as [Fecha],
 Null as [Tipo],
 Null as [Numero],
-- IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
 Case When IsNull(#Auxiliar1.Detalle,'')='ANU' Then 'ANULADO'
	When #Auxiliar1.Debe is null Then '   '+IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
	Else IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
 End as [Cuenta contable],
 Case When IsNull(#Auxiliar1.Detalle,'')='ANU' Then '' Else #Auxiliar1.Detalle End as [Referencia],
 #Auxiliar1.TipoValor as [Tipo Valor],
 #Auxiliar1.NumeroValor as [Nto.Valor],
 #Auxiliar1.Debe as [Debe],
 #Auxiliar1.Haber as [Haber],
 '  |  |  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar1.IdCuenta=#Auxiliar4.A_IdCuenta

UNION ALL

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.TipoComprobante as [K_TipoComprobante],
 #Auxiliar1.NumeroComprobante as [K_NumeroComprobante],
 4 as [K_Orden],
 Null as [Fecha],
 Null as [Tipo],
 Null as [Numero],
 Null as [Cuenta contable],
 Null as [Referencia],
 Null as [Tipo Valor],
 Null as [Nto.Valor],
 Sum(IsNull(#Auxiliar1.Debe,0)) as [Debe],
 Sum(IsNull(#Auxiliar1.Haber,0)) as [Haber],
 ' LIN:50:- | LIN:50:- | LIN:50:- | LIN:70:- | LIN:50:- | LIN:50:- | LIN:50:- |'+
	' NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY  #Auxiliar1.Fecha, #Auxiliar1.TipoComprobante, #Auxiliar1.NumeroComprobante

UNION ALL

/*
SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.TipoComprobante as [K_TipoComprobante],
 #Auxiliar1.NumeroComprobante as [K_NumeroComprobante],
 4 as [K_Orden],
 Null as [Fecha],
 Null as [Tipo],
 Null as [Numero],
 Null as [Cuenta contable],
 Null as [Referencia],
 Null as [Tipo Valor],
 Null as [Nto.Valor],
 Null as [Debe],
 Null as [Haber],
 '  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY  #Auxiliar1.Fecha, #Auxiliar1.TipoComprobante, #Auxiliar1.NumeroComprobante

UNION ALL
*/

SELECT
 1 as [Id],
 @FechaHasta as [K_Fecha],
 'zzz' as [K_TipoComprobante],
 Null as [K_NumeroComprobante],
 5 as [K_Orden],
 Null as [Fecha],
 Null as [Tipo],
 Null as [Numero],
 Null as [Cuenta contable],
 Null as [Referencia],
 Null as [Tipo Valor],
 Null as [Nto.Valor],
 Null as [Debe],
 Null as [Haber],
 ' EBH, CO2, AN2:2;9, AN2:6;5, AN2:7;5, FN2:1;8, FN2:2;8, FN2:3;8, FN2:4;8, FN2:5;8, FN2:6;8, '+
	'FN2:7;8, FN2:8;8, FN2:9;8, FN2:10;8, '+
	'AV2:3;3, AV2:4;3, AV2:5;3, '+
	'AH2:1;1, AH2:4;1, AH2:6;4, AH2:7;2, '+
	'VAL:1;1;Fecha;Comprob., VAL:1;2;Codigo;Comprob., VAL:1;3;Nro.Comp., '+
	'VAL:1;6;Tipo;Val., VAL:1;7;Nro.;Valor, VAL:1;8;Importe;Debito, VAL:1;9;Importe;Credito'+
	'  |  |  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

ORDER BY [K_Fecha], [K_TipoComprobante], [K_NumeroComprobante], [K_Orden], [Haber], [Debe]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar4
