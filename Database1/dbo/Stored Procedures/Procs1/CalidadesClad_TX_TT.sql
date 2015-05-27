
CREATE Procedure [dbo].[CalidadesClad_TX_TT]

@IdCalidadClad int

AS 

SELECT *
FROM CalidadesClad
WHERE (IdCalidadClad=@IdCalidadClad)
