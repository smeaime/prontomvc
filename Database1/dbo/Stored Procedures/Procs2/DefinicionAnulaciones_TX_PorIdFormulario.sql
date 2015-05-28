


CREATE Procedure [dbo].[DefinicionAnulaciones_TX_PorIdFormulario]
@IdFormulario int
AS 
SELECT * 
FROM DefinicionAnulaciones
WHERE (IdFormulario=@IdFormulario)


