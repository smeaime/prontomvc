































CREATE Procedure [dbo].[AcoTipos_A]
@IdAcoTipo int  output,
@IdRubro int,
@IdSubrubro int
AS 
Insert into [AcoTipos]
(
IdRubro,
IdSubrubro
)
Values
(
@IdRubro,
@IdSubrubro
)
Select @IdAcoTipo=@@identity
Return(@IdAcoTipo)
































