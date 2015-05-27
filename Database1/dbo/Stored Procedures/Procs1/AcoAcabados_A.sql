































CREATE Procedure [dbo].[AcoAcabados_A]
@IdAcoAcabado int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoAcabados]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoAcabado=@@identity
Return(@IdAcoAcabado)
































