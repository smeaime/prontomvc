































CREATE  Procedure [dbo].[AcoHHTareas_M]
@IdAcoHHTarea int  output,
@IdGrupoTareaHH int
AS
Update AcoHHTareas
SET
IdGrupoTareaHH=@IdGrupoTareaHH
where (IdAcoHHTarea=@IdAcoHHTarea)
Return(@IdAcoHHTarea)
































