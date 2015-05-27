CREATE  Procedure [dbo].[Colores_M]

@IdColor int ,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@Codigo int,
@Codigo1 varchar(1),
@IdArticulo int,
@IdCliente int,
@IdVendedor int,
@IdUsuarioAlta int,
@FechaAlta datetime,
@Codigo2 varchar(5)

AS

UPDATE Colores
SET
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura,
 Codigo=@Codigo,
 Codigo1=@Codigo1,
 IdArticulo=@IdArticulo,
 IdCliente=@IdCliente,
 IdVendedor=@IdVendedor,
 IdUsuarioAlta=@IdUsuarioAlta,
 FechaAlta=@FechaAlta,
 Codigo2=@Codigo2
WHERE (IdColor=@IdColor)

RETURN(@IdColor)