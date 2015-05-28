




CREATE Procedure [dbo].[PlazosEntrega_A]
@IdPlazoEntrega int  output,
@Descripcion varchar(50),
@Detalle ntext
AS 
Insert into [PlazosEntrega]
(
 Descripcion,
 Detalle
)
Values
(
 @Descripcion,
 @Detalle
)
Select @IdPlazoEntrega=@@identity
Return(@IdPlazoEntrega)




