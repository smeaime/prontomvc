





























CREATE Procedure [dbo].[DetAcoBiselados_A]
@IdDetalleAcoBiselado int  output,
@IdAcoBiselado int,
@IdBiselado int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoBiselados]
(
IdAcoBiselado,
IdBiselado
)
Values
(
@IdAcoBiselado,
@IdBiselado
)
Select @IdDetalleAcoBiselado=@@identity
Return(@IdDetalleAcoBiselado)






























