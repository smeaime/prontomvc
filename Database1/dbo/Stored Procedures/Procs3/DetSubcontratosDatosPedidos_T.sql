
CREATE Procedure [dbo].[DetSubcontratosDatosPedidos_T]

@IdDetalleSubcontratoDatosPedido int

AS 

SELECT *
FROM [DetalleSubcontratosDatosPedidos]
WHERE (IdDetalleSubcontratoDatosPedido=@IdDetalleSubcontratoDatosPedido)
