




CREATE Procedure [dbo].[_TempBasesConciliacion_InsertarRegistro]
@Orden int,
@BaseDatos varchar(50),
@Numeral int
AS
INSERT INTO _TempBasesConciliacion
(Orden, BaseDatos, Numeral)
VALUES
(@Orden, @BaseDatos, @Numeral)




