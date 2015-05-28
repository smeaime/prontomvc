

CREATE Procedure [dbo].[Traducciones_A]
@IdTraduccion int  output,
@Descripcion_esp varchar(200),
@Descripcion_ing varchar(200),
@Descripcion_por varchar(200),
@FechaAlta datetime,
@FechaUltimaModificacion datetime
AS 
Insert into Traducciones
(
 Descripcion_esp,
 Descripcion_ing,
 Descripcion_por,
 FechaAlta,
 FechaUltimaModificacion
)
Values
(
 @Descripcion_esp,
 @Descripcion_ing,
 @Descripcion_por,
 @FechaAlta,
 @FechaUltimaModificacion
)
Select @IdTraduccion=@@identity
Return(@IdTraduccion)


