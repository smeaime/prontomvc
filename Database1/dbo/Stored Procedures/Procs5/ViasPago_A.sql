





























CREATE Procedure [dbo].[ViasPago_A]
@IdViaPago int  output,
@Codigo varchar(5),
@Descripcion varchar(50)
AS 
Insert into [ViasPago]
(
Codigo,
Descripcion
)
Values
(
@Codigo,
@Descripcion
)
Select @IdViaPago=@@identity
Return(@IdViaPago)






























