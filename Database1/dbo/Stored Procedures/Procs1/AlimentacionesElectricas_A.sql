































CREATE Procedure [dbo].[AlimentacionesElectricas_A]
@IdAlimentacionElectrica int  output,
@Descripcion varchar(50)
AS 
Insert into [AlimentacionesElectricas]
(Descripcion)
Values(@Descripcion)
Select @IdAlimentacionElectrica=@@identity
Return(@IdAlimentacionElectrica)
































