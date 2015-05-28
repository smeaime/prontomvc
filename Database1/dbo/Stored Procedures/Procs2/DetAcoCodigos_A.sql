





























CREATE Procedure [dbo].[DetAcoCodigos_A]
@IdDetalleAcoCodigo int  output,
@IdAcoCodigo int,
@IdCodigo int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoCodigos]
(
IdAcoCodigo,
IdCodigo
)
Values
(
@IdAcoCodigo,
@IdCodigo
)
Select @IdDetalleAcoCodigo=@@identity
Return(@IdDetalleAcoCodigo)






























