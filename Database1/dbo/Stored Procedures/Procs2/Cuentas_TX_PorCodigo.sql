CREATE Procedure [dbo].[Cuentas_TX_PorCodigo]

@Codigo int,
@FechaConsulta datetime = Null

AS 

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

SELECT 
 Cuentas.*,
 IsNull((Select Top 1 dc.CodigoAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
	Order By dc.FechaCambio),Cuentas.Codigo) as [Codigo1],
 IsNull((Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
	Order By dc.FechaCambio),Cuentas.Descripcion) as [Descripcion1]
FROM Cuentas
WHERE  IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Codigo)=@Codigo