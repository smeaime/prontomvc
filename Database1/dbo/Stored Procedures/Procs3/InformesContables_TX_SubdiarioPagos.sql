
CREATE PROCEDURE [dbo].[InformesContables_TX_SubdiarioPagos]

@FechaDesde datetime,
@FechaHasta datetime

AS

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='00000111116133'
Set @vector_T='00000433234900'

SELECT 
 0 as [IdAux1], 
 op.FechaOrdenPago as [IdAux2], 
 1 as [IdAux3], 
 0 as [IdAux4], 
 '' as [IdAux5], 
 op.FechaOrdenPago as [Fecha], 
 Null as [Cod.Comp.],
 Null as [Nro.Comp.], 
 Null as [Cod.Prov.],
 Null as [Razon Social],
 Null as [Importe],
 ' FEC |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	(op.Confirmado is null or op.Confirmado<>'NO')
GROUP BY op.FechaOrdenPago

UNION ALL

SELECT 
 op.IdOrdenPago as [IdAux1], 
 op.FechaOrdenPago as [IdAux2], 
 2 as [IdAux3], 
 op.NumeroOrdenPago as [IdAux4], 
 Case 	When op.Anulada='SI' Then 'AA ANULA' 
	When op.Tipo='CC' Then 'OP O/PAG' 
	When op.Tipo='FF' Then 'FF FFIJO' 
	When op.Tipo='OT' Then 'OTROS ' 
	Else ''
 End as [IdAux5], 
 Null as [Fecha], 
 Case 	When op.Anulada='SI' Then 'AA ANULA' 
	When op.Tipo='CC' Then 'OP O/PAG' 
	When op.Tipo='FF' Then 'FF FFIJO' 
	When op.Tipo='OT' Then 'OTROS ' 
	Else ''
 End as [Cod.Comp.],
 op.NumeroOrdenPago as [Nro.Comp.], 
 Case When IsNull(op.Anulada,'NO')='SI' Then Null Else Proveedores.CodigoEmpresa End as [Cod.Prov.],
 Case When IsNull(op.Anulada,'NO')='SI' Then 'ANULADA' 
	When op.IdProveedor is not null Then Proveedores.RazonSocial
	When Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=op.IdCuenta),''))>0 
		Then (Select Top 1 dc.NombreAnterior COLLATE SQL_Latin1_General_CP1_CI_AS 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=op.IdCuenta)
	Else Cuentas.Descripcion
 End as [Razon Social],
 Case When IsNull(op.Anulada,'NO')='SI' 
	Then Null 
	Else IsNull(op.Valores,0)+IsNull(op.RetencionGanancias,0)+
		IsNull(op.RetencionIBrutos,0)+IsNull(op.RetencionIVA,0)+
		IsNull(op.GastosGenerales,0)+IsNull(op.RetencionSUSS,0)+
		IsNull(op.Otros1,0)+IsNull(op.Otros2,0)+IsNull(op.Otros3,0) 
 End as [Importe],
 '  |  |  |  |  | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	(op.Confirmado is null or op.Confirmado<>'NO')

UNION ALL

SELECT 
 0 as [IdAux1], 
 op.FechaOrdenPago as [IdAux2], 
 3 as [IdAux3], 
 Null as [IdAux4], 
 '' as [IdAux5], 
 Null as [Fecha], 
 Null as [Cod.Comp.],
 Null as [Nro.Comp.], 
 Null as [Cod.Prov.],
 '          Total Fecha' as [Razon Social],
 Sum(IsNull(op.Valores,0)+IsNull(op.RetencionGanancias,0)+
	IsNull(op.RetencionIBrutos,0)+IsNull(op.RetencionIVA,0)+
	IsNull(op.GastosGenerales,0)+IsNull(op.RetencionSUSS,0)+
	IsNull(op.Otros1,0)+IsNull(op.Otros2,0)+IsNull(op.Otros3,0)) as [Importe],
 '  |  |  |  |  | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	(op.Confirmado is null or op.Confirmado<>'NO') and IsNull(op.Anulada,'NO')<>'SI' 
GROUP BY op.FechaOrdenPago

UNION ALL

SELECT 
 0 as [IdAux1], 
 op.FechaOrdenPago as [IdAux2], 
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
FROM OrdenesPago op
WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	(op.Confirmado is null or op.Confirmado<>'NO')
GROUP BY op.FechaOrdenPago

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
 Sum(IsNull(op.Valores,0)+IsNull(op.RetencionGanancias,0)+
	IsNull(op.RetencionIBrutos,0)+IsNull(op.RetencionIVA,0)+
	IsNull(op.GastosGenerales,0)+IsNull(op.RetencionSUSS,0)+
	IsNull(op.Otros1,0)+IsNull(op.Otros2,0)+IsNull(op.Otros3,0)) as [Importe],
 'EBH, CO2, AN2:3;8, AN2:5;50, AV2:1;3, AV2:5;3, AV2:6;3, AH2:2;1, AH2:3;1, AH2:4;1, AH2:5;1, '+
	'VAL:1;2;Codigo;Comprob., VAL:1;3;Nro.;Comp., VAL:1;4;Codigo;Proveed, '+
	 '  |  |  |  |  | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	(op.Confirmado is null or op.Confirmado<>'NO') and IsNull(op.Anulada,'NO')<>'SI' 

ORDER BY [IdAux2], [IdAux3], [IdAux5], [IdAux4]
