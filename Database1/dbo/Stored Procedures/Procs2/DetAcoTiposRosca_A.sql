





























CREATE Procedure [dbo].[DetAcoTiposRosca_A]
@IdDetalleAcoTipoRosca int  output,
@IdAcoTipoRosca int,
@IdTipoRosca int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoTiposRosca]
(
IdAcoTipoRosca,
IdTipoRosca
)
Values
(
@IdAcoTipoRosca,
@IdTipoRosca
)
Select @IdDetalleAcoTipoRosca=@@identity
Return(@IdDetalleAcoTipoRosca)






























