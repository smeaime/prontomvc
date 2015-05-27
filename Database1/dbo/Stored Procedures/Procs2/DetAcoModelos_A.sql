





























CREATE Procedure [dbo].[DetAcoModelos_A]
@IdDetalleAcoModelo int  output,
@IdAcoModelo int,
@IdModelo int,
@Modelo varchar(1)
AS 
Insert into [DetalleAcoModelos]
(
IdAcoModelo,
IdModelo
)
Values
(
@IdAcoModelo,
@IdModelo
)
Select @IdDetalleAcoModelo=@@identity
Return(@IdDetalleAcoModelo)






























