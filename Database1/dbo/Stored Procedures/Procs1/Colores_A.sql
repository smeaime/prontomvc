CREATE Procedure [dbo].[Colores_A]

@IdColor int output,
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

INSERT INTO [Colores]
(
 Descripcion,
 Abreviatura,
 Codigo,
 Codigo1,
 IdArticulo,
 IdCliente,
 IdVendedor,
 IdUsuarioAlta,
 FechaAlta,
 Codigo2
)
VALUES
(
 @Descripcion,
 @Abreviatura,
 @Codigo,
 @Codigo1,
 @IdArticulo,
 @IdCliente,
 @IdVendedor,
 @IdUsuarioAlta,
 @FechaAlta,
 @Codigo2
)

SELECT @IdColor=@@identity

RETURN(@IdColor)