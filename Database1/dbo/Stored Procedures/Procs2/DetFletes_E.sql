CREATE Procedure [dbo].[DetFletes_E]

@IdDetalleFlete int  

AS

DELETE DetalleFletes
WHERE (IdDetalleFlete=@IdDetalleFlete)