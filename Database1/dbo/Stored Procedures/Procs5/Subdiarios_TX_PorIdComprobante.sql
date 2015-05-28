

































CREATE PROCEDURE [dbo].[Subdiarios_TX_PorIdComprobante]
@IdComprobante int,
@IdTipoComprobante int
AS
SELECT *
FROM Subdiarios
WHERE IdTipoComprobante=@IdTipoComprobante And IdComprobante=@IdComprobante


































