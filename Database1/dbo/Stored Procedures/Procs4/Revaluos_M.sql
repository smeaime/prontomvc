





CREATE  Procedure [dbo].[Revaluos_M]
@IdRevaluo int ,
@Descripcion varchar(50),
@FechaRevaluo datetime
As 
Update Revaluos
Set 
 Descripcion=@Descripcion,
 FechaRevaluo=@FechaRevaluo
Where (IdRevaluo=@IdRevaluo)
Return(@IdRevaluo)






