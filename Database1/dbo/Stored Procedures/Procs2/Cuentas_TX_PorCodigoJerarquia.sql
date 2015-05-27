
CREATE Procedure [dbo].[Cuentas_TX_PorCodigoJerarquia]

@Jerarquia varchar(30),
@IdCuenta int = Null,
@FechaConsulta datetime = Null

AS 

SET @IdCuenta=IsNull(@IdCuenta,-1)
SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

DECLARE @Filtrado int

SET @Filtrado=0
IF not @FechaConsulta is null 
	SET @Filtrado=1

SELECT *
FROM Cuentas
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
WHERE Cuentas.Jerarquia=@Jerarquia and (@IdCuenta=-1 or Cuentas.IdCuenta<>@IdCuenta) and 
	Not (Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
			 Order By dc.FechaCambio),'S/D'))=0 ) and 

	(Len(IsNull(Cuentas.Descripcion,''))>0 or 
	 (Len(IsNull(Cuentas.Descripcion,''))=0 and 
	  Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
			 Order By dc.FechaCambio),''))>0)) and 

	(@Filtrado=0 or Obras.FechaInicio is null or (@Filtrado=1 and Obras.FechaInicio<=@FechaConsulta))
