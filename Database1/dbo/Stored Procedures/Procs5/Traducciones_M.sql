

CREATE  Procedure [dbo].[Traducciones_M]
@IdTraduccion int ,
@Descripcion_esp varchar(200),
@Descripcion_ing varchar(200),
@Descripcion_por varchar(200),
@FechaAlta datetime,
@FechaUltimaModificacion datetime
AS
Update Traducciones
SET
 Descripcion_esp=@Descripcion_esp,
 Descripcion_ing=@Descripcion_ing,
 Descripcion_por=@Descripcion_por,
 FechaAlta=@FechaAlta,
 FechaUltimaModificacion=@FechaUltimaModificacion
Where (IdTraduccion=@IdTraduccion)
Return(@IdTraduccion)


