CREATE FUNCTION [dbo].[Autorizaciones_Firmas](@IdFormulario int,@IdComprobante int)
RETURNS VARCHAR(1000)

BEGIN
	DECLARE @Retorno varchar (1000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+IsNull('( '+Convert(varchar,AutorizacionesPorComprobante.OrdenAutorizacion)+':'+Empleados.Nombre+' )  ','')
	FROM AutorizacionesPorComprobante
	LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=AutorizacionesPorComprobante.IdAutorizo
	LEFT OUTER JOIN Sectores ON Sectores.IdSector=Empleados.IdSector
	WHERE AutorizacionesPorComprobante.IdFormulario=@IdFormulario and AutorizacionesPorComprobante.IdComprobante=@IdComprobante
	ORDER BY AutorizacionesPorComprobante.OrdenAutorizacion

	RETURN Substring(@Retorno,1,1000)
END

