CREATE FUNCTION [dbo].[Autorizaciones_CantidadFirmas](@IdFormulario int,@Importe numeric(18,2))
RETURNS VARCHAR(10)

BEGIN
	DECLARE @Retorno varchar (10)
	SET @Retorno = ''
	SELECT @Retorno = Convert(varchar,Max(DetAut.OrdenAutorizacion))
	FROM DetalleAutorizaciones DetAut
	LEFT OUTER JOIN Autorizaciones ON DetAut.IdAutorizacion=Autorizaciones.IdAutorizacion
	WHERE Autorizaciones.IdFormulario=@IdFormulario and 
	(Patindex('%'+DetAut.SectorEmisor1+'%', 'F S O')=0 or 
	 (Patindex('%'+DetAut.SectorEmisor1+'%', 'F S O')<>0 and @Importe between IsNull(DetAut.ImporteDesde1,0) and IsNull(DetAut.ImporteHasta1,0)))
	RETURN Substring(@Retorno,1,10)
END