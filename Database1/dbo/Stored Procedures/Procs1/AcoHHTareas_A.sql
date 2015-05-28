































CREATE Procedure [dbo].[AcoHHTareas_A]
@IdAcoHHTarea int  output,
@IdGrupoTareaHH int
AS 
Insert into [AcoHHTareas]
(
IdGrupoTareaHH
)
Values
(
@IdGrupoTareaHH
)
Select @IdAcoHHTarea=@@identity
Return(@IdAcoHHTarea)
































