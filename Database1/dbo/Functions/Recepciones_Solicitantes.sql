
CREATE FUNCTION [dbo].[Recepciones_Solicitantes](@IdRecepcion int)
RETURNS VARCHAR(1000)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Empleados.Nombre+' '
	FROM DetalleRecepciones DetRec
	LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetRec.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
	LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado = Requerimientos.IdSolicito
	WHERE DetRec.IdRecepcion=@IdRecepcion and Empleados.Nombre is not null
	GROUP BY Empleados.Nombre
	ORDER BY Empleados.Nombre

	RETURN Substring(@Retorno,1,1000)
END


