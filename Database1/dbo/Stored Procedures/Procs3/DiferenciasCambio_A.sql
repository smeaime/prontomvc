
CREATE Procedure [dbo].[DiferenciasCambio_A]

@IdDiferenciaCambio int  output,
@IdTipoComprobante int,
@IdRegistroOrigen int,
@Estado varchar(2),
@IdTipoComprobanteGenerado int,
@IdComprobanteGenerado int

AS 

INSERT INTO [DiferenciasCambio]
(
 IdTipoComprobante,
 IdRegistroOrigen,
 Estado,
 IdTipoComprobanteGenerado,
 IdComprobanteGenerado
)
VALUES
(
 @IdTipoComprobante,
 @IdRegistroOrigen,
 @Estado,
 @IdTipoComprobanteGenerado,
 @IdComprobanteGenerado
)

SELECT @IdDiferenciaCambio=@@identity
RETURN(@IdDiferenciaCambio)
