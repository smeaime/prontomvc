CREATE FUNCTION [dbo].[PresupuestoObrasNodos_Items](@Descripcion varchar(200),@IdObra int)
RETURNS VARCHAR(1000)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+'('+Item+') '
	FROM PresupuestoObrasNodos
	WHERE IdObra=@IdObra and Upper(Descripcion)=Upper(@Descripcion)
	GROUP BY SubItem1, SubItem2, SubItem3, Item
	ORDER BY SubItem1, SubItem2, SubItem3, Item

	RETURN Substring(@Retorno,1,1000)
END

