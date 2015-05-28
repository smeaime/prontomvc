































CREATE  Procedure [dbo].[AlimentacionesElectricas_M]
@IdAlimentacionElectrica int ,
@Descripcion varchar(50)
AS
Update AlimentacionesElectricas
SET
Descripcion=@Descripcion
where (IdAlimentacionElectrica=@IdAlimentacionElectrica)
Return(@IdAlimentacionElectrica)
































