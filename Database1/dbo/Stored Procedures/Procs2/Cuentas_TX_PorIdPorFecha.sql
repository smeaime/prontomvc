
CREATE Procedure [dbo].[Cuentas_TX_PorIdPorFecha]

@IdCuenta int,
@FechaConsulta datetime = Null

AS 

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

SELECT Cuentas.IdCuenta, 
	IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Codigo) as [Codigo],
	IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Descripcion) as [Descripcion]
FROM Cuentas
WHERE IdCuenta=@IdCuenta

