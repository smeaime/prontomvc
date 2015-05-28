
CREATE Procedure [dbo].[Autorizaciones_TX_PorIdFormulario]

@IdFormulario int,
@Detalle varchar(2) = Null

AS 

SET @Detalle=IsNull(@Detalle,'')

IF @Detalle='SI'
	SELECT DetalleAutorizaciones.*
	FROM DetalleAutorizaciones
	LEFT OUTER JOIN Autorizaciones ON Autorizaciones.IdAutorizacion=DetalleAutorizaciones.IdAutorizacion
	WHERE Autorizaciones.IdFormulario=@IdFormulario
ELSE
	SELECT *
	FROM Autorizaciones
	WHERE IdFormulario=@IdFormulario
