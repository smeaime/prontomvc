





























CREATE Procedure [dbo].[DetAcoHHItemsDocumentacion_A]
@IdDetalleAcoHHItemDocumentacion int  output,
@IdAcoHHItemDocumentacion int,
@IdItemDocumentacion int,
@Marca varchar(1)
AS 
Insert into [DetalleAcoHHItemsDocumentacion]
(
IdAcoHHItemDocumentacion,
IdItemDocumentacion
)
Values
(
@IdAcoHHItemDocumentacion,
@IdItemDocumentacion
)
Select @IdDetalleAcoHHItemDocumentacion=@@identity
Return(@IdDetalleAcoHHItemDocumentacion)






























