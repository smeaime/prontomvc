




CREATE Procedure [dbo].[LugaresEntrega_A]
@IdLugarEntrega int  output,
@Descripcion varchar(50),
@Detalle ntext
AS 
Insert into [LugaresEntrega]
(
 Descripcion,
 Detalle
)
Values
(
 @Descripcion,
 @Detalle
)
Select @IdLugarEntrega=@@identity
Return(@IdLugarEntrega)




