





























CREATE  Procedure [dbo].[TTermicos_M]
@IdTratamiento int ,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS
Update TratamientosTermicos
SET
Descripcion=@Descripcion,
Abreviatura=@Abreviatura
where (IdTratamiento=@IdTratamiento)
Return(@IdTratamiento)






























