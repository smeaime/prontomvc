CREATE  Procedure [dbo].[RubrosContables_M]

@IdRubroContable int ,
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

UPDATE RubrosContables
SET 
 Codigo=@Codigo,
 Descripcion=@Descripcion,
 Nivel=@Nivel,
 Financiero=@Financiero,
 IngresoEgreso=@IngresoEgreso,
 IdObra=@IdObra,
 IdCuenta=@IdCuenta,
 NoTomarEnCuboPresupuestoFinanciero=@NoTomarEnCuboPresupuestoFinanciero,
 DistribuirGastosEnResumen=@DistribuirGastosEnResumen,
 CodigoAgrupacion=@CodigoAgrupacion,
 IdTipoRubroFinancieroGrupo=@IdTipoRubroFinancieroGrupo,
 TomarMesDeVentaEnResumen=@TomarMesDeVentaEnResumen
WHERE (IdRubroContable=@IdRubroContable)

RETURN(@IdRubroContable)