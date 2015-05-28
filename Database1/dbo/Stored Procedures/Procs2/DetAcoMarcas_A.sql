





























CREATE Procedure [dbo].[DetAcoMarcas_A]
@IdDetalleAcoMarca int  output,
@IdAcoMarca int,
@IdMarca int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoMarcas]
(
IdAcoMarca,
IdMarca
)
Values
(
@IdAcoMarca,
@IdMarca
)
Select @IdDetalleAcoMarca=@@identity
Return(@IdDetalleAcoMarca)






























