CREATE Procedure [dbo].[Impuestos_A]

@IdImpuesto int  output,
@IdTipoComprobante int,
@Fecha datetime,
@IdEquipoImputado int,
@NumeroTramite varchar(50),
@CodigoPlan varchar(50),
@Agencia varchar(50),
@Observaciones ntext,
@IdCuenta int,
@EnUsoPor varchar(30),
@Detalle varchar(50),
@TipoPlan varchar(20)

AS 

INSERT INTO [Impuestos]
(
 IdTipoComprobante,
 Fecha,
 IdEquipoImputado,
 NumeroTramite,
 CodigoPlan,
 Agencia,
 Observaciones,
 IdCuenta,
 EnUsoPor,
 Detalle,
 TipoPlan
)
VALUES
(
 @IdTipoComprobante,
 @Fecha,
 @IdEquipoImputado,
 @NumeroTramite,
 @CodigoPlan,
 @Agencia,
 @Observaciones,
 @IdCuenta,
 @EnUsoPor,
 @Detalle,
 @TipoPlan
)

SELECT @IdImpuesto=@@identity

RETURN(@IdImpuesto)