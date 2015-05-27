
CREATE PROCEDURE [dbo].[InformeDeDiario_TX_2_Resumido]

@FechaDesde datetime,
@FechaHasta datetime,
@TransporteInicial numeric(18,2),
@IncluirConsolidacion varchar(2) = Null

AS

SET NOCOUNT ON

SET DATEFORMAT dmy

IF @IncluirConsolidacion is null 
	SET @IncluirConsolidacion='SI'

CREATE TABLE #Auxiliar0 
			(
			 IdCuenta INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Detalle VARCHAR(100),
			 Concepto VARCHAR(100)
			)
INSERT INTO #Auxiliar0 
 SELECT 
  Subdiarios.IdCuenta,
  DATEADD(d,-1,CONVERT(datetime,'01/'+
			CONVERT(varchar,MONTH(DATEADD(m,1,Subdiarios.FechaComprobante)))+'/'+
			CONVERT(varchar,YEAR(DATEADD(m,1,Subdiarios.FechaComprobante))))),
  Subdiarios.IdCuentaSubdiario,
  IsNull(Subdiarios.Debe,0),
  Null,
  Titulos.Titulo,
  Titulos.Titulo
 FROM Subdiarios
 LEFT OUTER JOIN Titulos ON Subdiarios.IdCuentaSubdiario=Titulos.IdTitulo
 WHERE Subdiarios.FechaComprobante>=@FechaDesde and 
	Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	IsNull(Subdiarios.Debe,0)<>0

 UNION ALL

 SELECT 
  Subdiarios.IdCuenta,
  DATEADD(d,-1,CONVERT(datetime,'01/'+
			CONVERT(varchar,MONTH(DATEADD(m,1,Subdiarios.FechaComprobante)))+'/'+
			CONVERT(varchar,YEAR(DATEADD(m,1,Subdiarios.FechaComprobante))))),
  Subdiarios.IdCuentaSubdiario,
  Null,
  IsNull(Subdiarios.Haber,0),
  Titulos.Titulo,
  Titulos.Titulo
 FROM Subdiarios
 LEFT OUTER JOIN Titulos ON Subdiarios.IdCuentaSubdiario=Titulos.IdTitulo
 WHERE Subdiarios.FechaComprobante>=@FechaDesde and 
	Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta) and 
	IsNull(Subdiarios.Haber,0)<>0


CREATE TABLE #Auxiliar1 
			(
			 IdAux INTEGER,
			 IdCuenta INTEGER,
			 Asiento INTEGER,
			 Fecha DATETIME,
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 Tipo VARCHAR(5),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Detalle VARCHAR(100),
			 Letra VARCHAR(1),
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 IdCliente INTEGER,
			 Cliente VARCHAR(50),
			 IdProveedor INTEGER,
			 Proveedor VARCHAR(50),
			 Concepto VARCHAR(100),
			 Comprobante VARCHAR(20)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  1,
  DetAsi.IdCuenta,
  Asientos.NumeroAsiento,
  Asientos.FechaAsiento,
  DetAsi.IdTipoComprobante,
  Null,
  TiposComprobante.DescripcionAb,
  Asientos.Tipo,
  DetAsi.Debe,
  Null,
  DetAsi.Detalle,
  ' ',
  0,
  DetAsi.NumeroComprobante,
  Null,
  Null,
  Null,
  Null,
  Asientos.Concepto,
  Null
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE Asientos.IdCuentaSubdiario is null and
	IsNull(DetAsi.Debe,0)<>0 and 
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta) and 
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL

 SELECT 
  1,
  DetAsi.IdCuenta,
  Asientos.NumeroAsiento,
  Asientos.FechaAsiento,
  DetAsi.IdTipoComprobante,
  Null,
  TiposComprobante.DescripcionAb,
  Asientos.Tipo,
  Null,
  DetAsi.Haber,
  DetAsi.Detalle,
  ' ',
  0,
  DetAsi.NumeroComprobante,
  Null,
  Null,
  Null,
  Null,
  Asientos.Concepto,
  Null
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE Asientos.IdCuentaSubdiario is null and
	IsNull(DetAsi.Haber,0)<>0 and 
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta) and 
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL

 SELECT 
  1,
  #Auxiliar0.IdCuenta,
  Null,
  #Auxiliar0.Fecha,
  #Auxiliar0.IdTipoComprobante+1000,
  Null,
  Null,
  Null,
  SUM(IsNull(#Auxiliar0.Debe,0)),
  Null,
  #Auxiliar0.Detalle,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  #Auxiliar0.Concepto,
  Null
 FROM #Auxiliar0
 WHERE IsNull(#Auxiliar0.Debe,0)<>0
 GROUP BY #Auxiliar0.IdCuenta,#Auxiliar0.Fecha,#Auxiliar0.IdTipoComprobante,
	#Auxiliar0.Detalle,#Auxiliar0.Concepto

 UNION ALL

 SELECT 
  1,
  #Auxiliar0.IdCuenta,
  Null,
  #Auxiliar0.Fecha,
  #Auxiliar0.IdTipoComprobante+1000,
  Null,
  Null,
  Null,
  Null,
  SUM(IsNull(#Auxiliar0.Haber,0)),
  #Auxiliar0.Detalle,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  #Auxiliar0.Concepto,
  Null
 FROM #Auxiliar0
 WHERE IsNull(#Auxiliar0.Haber,0)<>0
 GROUP BY #Auxiliar0.IdCuenta,#Auxiliar0.Fecha,#Auxiliar0.IdTipoComprobante,
	#Auxiliar0.Detalle,#Auxiliar0.Concepto

UPDATE #Auxiliar1
SET Letra=' '
WHERE Letra IS NULL

UPDATE #Auxiliar1
SET NumeroComprobante1=0
WHERE NumeroComprobante1 IS NULL

UPDATE #Auxiliar1
SET NumeroComprobante2=0
WHERE NumeroComprobante2 IS NULL

UPDATE #Auxiliar1
SET NumeroComprobante1=0
WHERE Len(Convert(varchar,NumeroComprobante1))>4

UPDATE #Auxiliar1
SET NumeroComprobante2=0
WHERE Len(Convert(varchar,NumeroComprobante2))>8

UPDATE #Auxiliar1
SET Cliente=(Select Top 1 Clientes.RazonSocial From Clientes 
		Where #Auxiliar1.IdCliente=Clientes.IdCliente)
WHERE #Auxiliar1.IdCliente IS NOT NULL

UPDATE #Auxiliar1
SET Proveedor=(Select Top 1 Proveedores.RazonSocial From Proveedores 
		Where #Auxiliar1.IdProveedor=Proveedores.IdProveedor)
WHERE #Auxiliar1.IdProveedor IS NOT NULL

UPDATE #Auxiliar1
SET Comprobante = 
		Case 	When #Auxiliar1.Asiento is not null
			 Then 'AS '+Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.Asiento)))+
				Convert(varchar,#Auxiliar1.Asiento)
			When #Auxiliar1.Letra=' ' and #Auxiliar1.NumeroComprobante1=0 and #Auxiliar1.NumeroComprobante2=0
			 Then #Auxiliar1.TipoComprobante
			 Else Substring(#Auxiliar1.TipoComprobante+' '+
				Case When #Auxiliar1.Letra=' ' Then '' Else #Auxiliar1.Letra+'-' End+
				Substring('0000',1,4-Len(Convert(varchar,#Auxiliar1.NumeroComprobante1)))+
				Convert(varchar,#Auxiliar1.NumeroComprobante1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,#Auxiliar1.NumeroComprobante2)))+
				Convert(varchar,#Auxiliar1.NumeroComprobante2),1,30)
		End

UPDATE #Auxiliar1
SET Concepto = 
		Case 	When #Auxiliar1.Comprobante is null
			 Then 	Case 	When #Auxiliar1.IdCliente is not null and #Auxiliar1.Cliente is not null 
					 Then #Auxiliar1.Cliente
					When #Auxiliar1.IdProveedor is not null and #Auxiliar1.Proveedor is not null 
					 Then #Auxiliar1.Proveedor
					When #Auxiliar1.Asiento is not null and #Auxiliar1.Concepto is not null 
					 Then #Auxiliar1.Concepto
					 Else ''
				End
			Else #Auxiliar1.Comprobante + ' ' +
			 	Case 	When #Auxiliar1.IdCliente is not null and #Auxiliar1.Cliente is not null 
					 Then #Auxiliar1.Cliente
					When #Auxiliar1.IdProveedor is not null and #Auxiliar1.Proveedor is not null 
					 Then #Auxiliar1.Proveedor
					When #Auxiliar1.Asiento is not null and #Auxiliar1.Concepto is not null 
					 Then #Auxiliar1.Concepto
					 Else ''
				End
		End

UPDATE #Auxiliar1
SET Tipo='BBB'
WHERE Tipo is null

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

Declare @NumeroAsiento int
Set @NumeroAsiento=0

Declare @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(200)
Set @vector_X='00000001111166133'
Set @vector_T='00000004223233900'
Set @vector_E='  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 '

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.Tipo as [K_Tipo],
 IsNull(#Auxiliar1.IdTipoComprobante,0) as [K_IdTipoComprobante],
 #Auxiliar1.IdComprobante as [K_IdComprobante],
 #Auxiliar1.Asiento as [K_Asiento],
 1 as [K_Orden],
 #Auxiliar1.Fecha as [Fecha],
 @NumeroAsiento as [Numero],
 #Auxiliar1.Concepto as [Concepto],
 Null as [Cuenta],
 Null as [Descripcion],
 Null as [Debe],
 Null as [Haber],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY #Auxiliar1.Fecha, #Auxiliar1.Tipo, #Auxiliar1.Asiento, 
	#Auxiliar1.IdTipoComprobante, #Auxiliar1.IdComprobante, 
	#Auxiliar1.Concepto, #Auxiliar1.Comprobante

UNION ALL 

SELECT
 1 as [Id],
 #Auxiliar1.Fecha as [K_Fecha],
 #Auxiliar1.Tipo as [K_Tipo],
 IsNull(#Auxiliar1.IdTipoComprobante,0) as [K_IdTipoComprobante],
 #Auxiliar1.IdComprobante as [K_IdComprobante],
 #Auxiliar1.Asiento as [K_Asiento],
 2 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 #Auxiliar1.Detalle as [Concepto],
 IsNull(#Auxiliar4.A_CodigoAnterior,#Auxiliar4.A_Codigo) as [Cuenta],
 Case	When #Auxiliar1.Debe is null Then '   '+IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
	Else IsNull(#Auxiliar4.A_NombreAnterior,#Auxiliar4.A_Descripcion)
 End as [Descripcion],
 #Auxiliar1.Debe as [Debe],
 #Auxiliar1.Haber as [Haber],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar1.IdCuenta=#Auxiliar4.A_IdCuenta

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz' as [K_Tipo],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_Asiento],
 3 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 Null as [Concepto],
 Null as [Cuenta],
 Null as [Descripcion],
 Null as [Debe],
 Null as [Haber],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT
 1 as [Id],
 @FechaHasta+1 as [K_Fecha],
 'zz' as [K_Tipo],
 Null as [K_IdTipoComprobante],
 Null as [K_IdComprobante],
 Null as [K_Asiento],
 4 as [K_Orden],
 Null as [Fecha],
 Null as [Numero],
 'TOTALES GENERALES' as [Concepto],
 Null as [Cuenta],
 Null as [Descripcion],
 SUM(IsNull(#Auxiliar1.Debe,0))+@TransporteInicial as [Debe],
 SUM(IsNull(#Auxiliar1.Haber,0))+@TransporteInicial as [Haber],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Fecha], [K_Tipo], [K_IdTipoComprobante], 
	[K_IdComprobante], [K_Asiento], [K_Orden], 
	[Haber],[Debe],[Cuenta]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar4
