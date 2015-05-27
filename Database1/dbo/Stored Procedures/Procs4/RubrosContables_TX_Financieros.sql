CREATE Procedure [dbo].[RubrosContables_TX_Financieros]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111133'
SET @vector_T='0595555456300'

SELECT 
 RubrosContables.IdRubroContable,
 RubrosContables.Codigo,
 RubrosContables.IdRubroContable as [IdAux],
 RubrosContables.Descripcion as [Rubro],
 RubrosContables.Nivel,
 Case When RubrosContables.IngresoEgreso is null Then Null
	When RubrosContables.IngresoEgreso='I' Then 'Ingreso'
	When RubrosContables.IngresoEgreso='E' Then 'Egreso'
	Else Null
 End as [Tipo],
 Obras.NumeroObra as [Obra],
 Convert(varchar,Cuentas.Codigo)+' - '+Cuentas.Descripcion as [Cuenta contable],
 RubrosContables.NoTomarEnCuboPresupuestoFinanciero as [No tomar en PF],
 RubrosContables.CodigoAgrupacion as [Cod. Agrupacion],
 TiposRubrosFinancierosGrupos.Descripcion as [Grupo financiero],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM RubrosContables 
LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
LEFT OUTER JOIN Cuentas ON RubrosContables.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN TiposRubrosFinancierosGrupos ON RubrosContables.IdTipoRubroFinancieroGrupo=TiposRubrosFinancierosGrupos.IdTipoRubroFinancieroGrupo
WHERE RubrosContables.Financiero is not null and RubrosContables.Financiero='SI'
ORDER by RubrosContables.Descripcion