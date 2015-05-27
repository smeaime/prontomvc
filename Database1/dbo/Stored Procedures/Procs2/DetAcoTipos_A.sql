





























CREATE Procedure [dbo].[DetAcoTipos_A]
@IdDetalleAcoTipo int  output,
@IdAcoTipo int,
@IdTipo int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoTipos]
(
IdAcoTipo,
IdTipo
)
Values
(
@IdAcoTipo,
@IdTipo
)
Select @IdDetalleAcoTipo=@@identity
Return(@IdDetalleAcoTipo)






























