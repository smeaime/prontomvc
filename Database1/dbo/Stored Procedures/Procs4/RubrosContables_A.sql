CREATE Procedure [dbo].[RubrosContables_A]

@IdRubroContable int  output,
@Codigo int,
@Descripcion varchar(50),
@Nivel int,
@Financiero varchar(2),
@IngresoEgreso varchar(1),
@IdObra int,
@IdCuenta int,
@NoTomarEnCuboPresupuestoFinanciero varchar(2),
@DistribuirGastosEnResumen varchar(2),
@CodigoAgrupacion int,
@IdTipoRubroFinancieroGrupo int,
@TomarMesDeVentaEnResumen varchar(2)

AS

INSERT INTO [RubrosContables]
(
 Codigo,
 Descripcion,
 Nivel,
 Financiero,
 IngresoEgreso,
 IdObra,
 IdCuenta,
 NoTomarEnCuboPresupuestoFinanciero,
 DistribuirGastosEnResumen,
 CodigoAgrupacion,
 IdTipoRubroFinancieroGrupo,
 TomarMesDeVentaEnResumen
)
VALUES
(
 @Codigo,
 @Descripcion,
 @Nivel,
 @Financiero,
 @IngresoEgreso,
 @IdObra,
 @IdCuenta,
 @NoTomarEnCuboPresupuestoFinanciero,
 @DistribuirGastosEnResumen,
 @CodigoAgrupacion,
 @IdTipoRubroFinancieroGrupo,
 @TomarMesDeVentaEnResumen
)

SELECT @IdRubroContable=@@identity

RETURN(@IdRubroContable)