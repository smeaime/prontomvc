































CREATE Procedure [dbo].[ValoresIngresos_A]
@IdValorIngreso int output,
@FechaIngreso datetime,
@IdBanco int,
@Observaciones ntext,
@Importe numeric(18,2)
AS 
Insert into [ValoresIngresos]
(
 FechaIngreso,
 IdBanco,
 Observaciones,
 Importe
)
Values
(
 @FechaIngreso,
 @IdBanco,
 @Observaciones,
 @Importe
)
Select @IdValorIngreso=@@identity
Return(@IdValorIngreso)
































