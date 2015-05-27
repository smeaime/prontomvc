CREATE  Procedure [dbo].[Impuestos_M]

@IdImpuesto int ,
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

UPDATE Impuestos
SET
 IdTipoComprobante=@IdTipoComprobante,
 Fecha=@Fecha,
 IdEquipoImputado=@IdEquipoImputado,
 NumeroTramite=@NumeroTramite,
 CodigoPlan=@CodigoPlan,
 Agencia=@Agencia,
 Observaciones=@Observaciones,
 IdCuenta=@IdCuenta,
 EnUsoPor=@EnUsoPor,
 Detalle=@Detalle,
 TipoPlan=@TipoPlan
WHERE (IdImpuesto=@IdImpuesto)

RETURN(@IdImpuesto)