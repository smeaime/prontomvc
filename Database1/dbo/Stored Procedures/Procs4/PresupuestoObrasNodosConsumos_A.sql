
CREATE Procedure [dbo].[PresupuestoObrasNodosConsumos_A]

@IdPresupuestoObrasNodoConsumo int output,
@IdPresupuestoObrasNodo int,
@Fecha datetime,
@Numero int,
@Detalle  varchar(100),
@Importe numeric(18,2),
@Origen varchar(10),
@IdEntidad int,
@Cantidad numeric(18,2),
@IdObraOrigen int

AS 

INSERT INTO [PresupuestoObrasNodosConsumos]
(
 IdPresupuestoObrasNodo,
 Fecha,
 Numero,
 Detalle,
 Importe,
 Origen,
 IdEntidad,
 Cantidad,
 IdObraOrigen
)
VALUES
(
 @IdPresupuestoObrasNodo,
 @Fecha,
 @Numero,
 @Detalle,
 @Importe,
 @Origen,
 @IdEntidad,
 @Cantidad,
 @IdObraOrigen
)

SELECT @IdPresupuestoObrasNodoConsumo=@@identity
RETURN(@IdPresupuestoObrasNodoConsumo)
