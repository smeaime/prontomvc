




CREATE Procedure [dbo].[Obras_TX_ControlDominioEnObra]
@IdObra int,
@IdArticulo int
AS
SELECT *
FROM Obras
WHERE IdObra<>@IdObra and 
	IdArticuloAsociado=@IdArticulo and 
	FechaFinalizacion is null




