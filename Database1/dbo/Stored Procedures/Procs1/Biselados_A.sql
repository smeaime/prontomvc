





























CREATE Procedure [dbo].[Biselados_A]
@IdBiselado int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [Biselados]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdBiselado=@@identity
Return(@IdBiselado)






























