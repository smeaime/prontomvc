
CREATE PROCEDURE [dbo].[InformesContables_TX_SubdiarioCobranzas]

@FechaDesde datetime,
@FechaHasta datetime

AS

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='00000111116133'
Set @vector_T='00000433234900'

SELECT 
 0 as [IdAux1], 
 Recibos.FechaRecibo as [IdAux2], 
 1 as [IdAux3], 
 0 as [IdAux4], 
 '' as [IdAux5], 
 Recibos.FechaRecibo as [Fecha], 
 Null as [Cod.Comp.],
 Null as [Nro.Comp.], 
 Null as [Cod.Prov.],
 Null as [Razon Social],
 Null as [Importe],
 ' FEC |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos 
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Cuentas ON Recibos.IdCuenta = Cuentas.IdCuenta
WHERE Recibos.FechaRecibo between @FechaDesde and @FechaHasta 
GROUP BY Recibos.FechaRecibo

UNION ALL

SELECT 
 Recibos.IdRecibo as [IdAux1], 
 Recibos.FechaRecibo as [IdAux2], 
 2 as [IdAux3], 
 Recibos.NumeroRecibo as [IdAux4], 
 Case 	When Recibos.Tipo='CC' Then 'CC CCTE' 
	When Recibos.Tipo='OT' Then 'OT OTROS' 
	Else ''
 End as [IdAux5],
 Null as [Fecha], 
 Case 	When Recibos.Tipo='CC' Then 'CC CCTE' 
	When Recibos.Tipo='OT' Then 'OT OTROS' 
	Else ''
 End as [Cod.Comp.],
 Recibos.NumeroRecibo as [Nro.Comp.], 
 Clientes.CodigoCliente as [Cod.Prov.],
 Case When IsNull(Recibos.Anulado,'NO')='SI' Then 'ANULADO' 
	When Recibos.IdCliente is not null Then Clientes.RazonSocial
	When Len(IsNull((Select Top 1 dc.NombreAnterior COLLATE SQL_Latin1_General_CP1_CI_AS 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Recibos.IdCuenta),''))>0 
		Then (Select Top 1 dc.NombreAnterior COLLATE SQL_Latin1_General_CP1_CI_AS 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Recibos.IdCuenta)
	Else Cuentas.Descripcion
 End as [Razon Social],
 Case When IsNull(Recibos.Anulado,'NO')<>'SI' 
	Then IsNull(Recibos.Valores,0)+IsNull(Recibos.RetencionGanancias,0)+
		IsNull(Recibos.RetencionIBrutos,0)+IsNull(Recibos.RetencionIVA,0)+
		IsNull(Recibos.GastosGenerales,0)+IsNull(Recibos.Otros1,0)+
		IsNull(Recibos.Otros2,0)+IsNull(Recibos.Otros3,0)+IsNull(Recibos.Otros4,0)+
		IsNull(Recibos.Otros5,0)+IsNull(Recibos.Otros6,0)+IsNull(Recibos.Otros7,0)+
		IsNull(Recibos.Otros8,0)+IsNull(Recibos.Otros9,0)+IsNull(Recibos.Otros10,0)
	Else 0
 End as [Importe],
 '  |  |  |  |  | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos 
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Cuentas ON Recibos.IdCuenta = Cuentas.IdCuenta
WHERE Recibos.FechaRecibo between @FechaDesde and @FechaHasta 

UNION ALL

SELECT 
 0 as [IdAux1], 
 Recibos.FechaRecibo as [IdAux2], 
 3 as [IdAux3], 
 Null as [IdAux4], 
 '' as [IdAux5], 
 Null as [Fecha], 
 Null as [Cod.Comp.],
 Null as [Nro.Comp.], 
 Null as [Cod.Prov.],
 '          Total Fecha' as [Razon Social],
 Sum(Case When IsNull(Recibos.Anulado,'NO')<>'SI' 
		Then IsNull(Recibos.Valores,0)+IsNull(Recibos.RetencionGanancias,0)+
			IsNull(Recibos.RetencionIBrutos,0)+IsNull(Recibos.RetencionIVA,0)+
			IsNull(Recibos.GastosGenerales,0)+IsNull(Recibos.Otros1,0)+
			IsNull(Recibos.Otros2,0)+IsNull(Recibos.Otros3,0)+IsNull(Recibos.Otros4,0)+
			IsNull(Recibos.Otros5,0)+IsNull(Recibos.Otros6,0)+IsNull(Recibos.Otros7,0)+
			IsNull(Recibos.Otros8,0)+IsNull(Recibos.Otros9,0)+IsNull(Recibos.Otros10,0)
		Else 0
	End) as [Importe],
 '  |  |  |  |  | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos
WHERE Recibos.FechaRecibo between @FechaDesde and @FechaHasta 
GROUP BY Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1], 
 Recibos.FechaRecibo as [IdAux2], 
 4 as [IdAux3], 
 Null as [IdAux4], 
 '' as [IdAux5], 
 Null as [Fecha], 
 Null as [Cod.Comp.],
 Null as [Nro.Comp.], 
 Null as [Cod.Prov.],
 Null as [Razon Social],
 Null as [Importe],
 ' ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos
WHERE Recibos.FechaRecibo between @FechaDesde and @FechaHasta 
GROUP BY Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1], 
 @FechaHasta as [IdAux2], 
 5 as [IdAux3], 
 Null as [IdAux4], 
 '' as [IdAux5], 
 Null as [Fecha], 
 Null as [Cod.Comp.],
 Null as [Nro.Comp.], 
 Null as [Cod.Prov.],
 '          Total Sucursal' as [Razon Social],
 Sum(Case When IsNull(Recibos.Anulado,'NO')<>'SI' 
		Then IsNull(Recibos.Valores,0)+IsNull(Recibos.RetencionGanancias,0)+
			IsNull(Recibos.RetencionIBrutos,0)+IsNull(Recibos.RetencionIVA,0)+
			IsNull(Recibos.GastosGenerales,0)+IsNull(Recibos.Otros1,0)+
			IsNull(Recibos.Otros2,0)+IsNull(Recibos.Otros3,0)+IsNull(Recibos.Otros4,0)+
			IsNull(Recibos.Otros5,0)+IsNull(Recibos.Otros6,0)+IsNull(Recibos.Otros7,0)+
			IsNull(Recibos.Otros8,0)+IsNull(Recibos.Otros9,0)+IsNull(Recibos.Otros10,0)
		Else 0
	End) as [Importe],
 ' EBH, CO2, AN2:2;11, AN2:3;10, AN2:4;10, AV2:1;3, AV2:5;3, AV2:6;3, AH2:5;1, '+
	'VAL:1;2;Codigo;Comprob., VAL:1;3;Nro.;Comp., VAL:1;4;Codigo;Cliente, '+
	'  |  |  |  |  | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos
WHERE Recibos.FechaRecibo between @FechaDesde and @FechaHasta 

ORDER BY [IdAux2], [IdAux3], [IdAux5], [IdAux4]
