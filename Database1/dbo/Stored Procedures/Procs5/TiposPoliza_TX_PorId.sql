CREATE Procedure [dbo].[TiposPoliza_TX_PorId]

@IdTipoPoliza int

AS 
SELECT * 
FROM TiposPoliza
WHERE IdTipoPoliza=@IdTipoPoliza