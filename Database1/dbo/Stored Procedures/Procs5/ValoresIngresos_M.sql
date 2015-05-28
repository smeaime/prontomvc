































CREATE  Procedure [dbo].[ValoresIngresos_M]
@IdValorIngreso int,
@FechaIngreso datetime,
@IdBanco int,
@Observaciones ntext,
@Importe numeric(18,2)
AS
Update ValoresIngresos
SET 
 FechaIngreso=@FechaIngreso,
 IdBanco=@IdBanco,
 Observaciones=@Observaciones,
 Importe=@Importe
Where (IdValorIngreso=@IdValorIngreso)
Return(@IdValorIngreso)
































