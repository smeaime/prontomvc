




CREATE Procedure [dbo].[Depositos_A]
@IdDeposito int  output,
@Descripcion varchar(50),
@Abreviatura varchar(10),
@IdObra int
As 
Insert into [Depositos]
(
 Descripcion,
 Abreviatura,
 IdObra
)
Values
(
 @Descripcion,
 @Abreviatura,
 @IdObra
)
Select @IdDeposito=@@identity
Return(@IdDeposito)




