





























CREATE Procedure [dbo].[DetAcoTratamientos_A]
@IdDetalleAcoTratamiento int  output,
@IdAcoTratamiento int,
@IdTratamiento int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoTratamientos]
(
IdAcoTratamiento,
IdTratamiento
)
Values
(
@IdAcoTratamiento,
@IdTratamiento
)
Select @IdDetalleAcoTratamiento=@@identity
Return(@IdDetalleAcoTratamiento)






























