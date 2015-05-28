





























CREATE Procedure [dbo].[Relaciones_A]
@IdRelacion smallint  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)
AS 
Insert into [Relaciones]
(
Descripcion,
Abreviatura
)
Values
(
@Descripcion,
@Abreviatura
)
Select @IdRelacion=@@identity
Return(@IdRelacion)






























