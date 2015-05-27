CREATE Procedure [dbo].[_TempRubrosContablesDatos_A]

@Mes int,
@Año int,
@IdRubroContable int,
@IdObra int,
@Importe numeric(18,2)

AS 

IF Exists(Select Top 1 IdRubroContable From _TempRubrosContablesDatos Where Mes=@Mes and Año=@Año and IdRubroContable=@IdRubroContable and IdObra=@IdObra)
	DELETE _TempRubrosContablesDatos WHERE Mes=@Mes and Año=@Año and IdRubroContable=@IdRubroContable and IdObra=@IdObra

INSERT INTO [_TempRubrosContablesDatos]
(
 Mes,
 Año,
 IdRubroContable,
 IdObra,
 Importe
)
VALUES
(
 @Mes,
 @Año,
 @IdRubroContable,
 @IdObra,
 @Importe
)