CREATE Procedure [dbo].[UnidadesEmpaque_A]

@IdUnidadEmpaque int  output,
@NumeroUnidad int,
@IdArticulo int,
@Partida varchar(20),
@IdUnidad int,
@PesoBruto numeric(18,2),
@Tara numeric(18,3),
@PesoNeto numeric(18,2),
@IdUsuarioAlta int,
@FechaAlta datetime,
@IdUbicacion int,
@IdColor int,
@IdUnidadTipoCaja int,
@EsDevolucion varchar(2) = Null,
@IdDetalleRecepcion int = Null,
@Metros numeric(18,2) = Null,
@TipoRollo varchar(1) = Null,
@Observaciones ntext = Null,
@PartidasOrigen varchar(110) = Null

AS 

SET @EsDevolucion=IsNull(@EsDevolucion,'')
SET @IdDetalleRecepcion=IsNull(@IdDetalleRecepcion,0)
SET @Metros=IsNull(@Metros,0)
SET @TipoRollo=IsNull(@TipoRollo,'')
SET @PartidasOrigen=IsNull(@PartidasOrigen,'')

INSERT INTO [UnidadesEmpaque]
(
 NumeroUnidad,
 IdArticulo,
 Partida,
 IdUnidad,
 PesoBruto,
 Tara,
 PesoNeto,
 IdUsuarioAlta,
 FechaAlta,
 IdUbicacion,
 IdColor,
 IdUnidadTipoCaja,
 EsDevolucion,
 IdDetalleRecepcion,
 Metros,
 TipoRollo,
 Observaciones,
 PartidasOrigen
)
VALUES
(
 @NumeroUnidad,
 @IdArticulo,
 @Partida,
 @IdUnidad,
 @PesoBruto,
 @Tara,
 @PesoNeto,
 @IdUsuarioAlta,
 @FechaAlta,
 @IdUbicacion,
 @IdColor,
 @IdUnidadTipoCaja,
 @EsDevolucion,
 @IdDetalleRecepcion,
 @Metros,
 @TipoRollo,
 @Observaciones,
 @PartidasOrigen
)

SELECT @IdUnidadEmpaque=@@identity

RETURN(@IdUnidadEmpaque)