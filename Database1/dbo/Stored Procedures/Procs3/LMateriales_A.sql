CREATE Procedure [dbo].[LMateriales_A]

@IdLMateriales int  output,
@NumeroLMateriales int,
@IdObra int,
@IdCliente int,
@IdEquipo int,
@Fecha datetime,
@Realizo int,
@Aprobo int,
@IdPlano int,
@Nombre varchar(30),
@Observaciones ntext,
@EnviarEmail tinyint,
@IdLMaterialesOriginal int,
@IdOrigenTransmision int,
@Embalo varchar(50),
@CircuitoFirmasCompleto varchar(2),
@ArchivoAdjunto1 varchar(200),
@IdUnidadFuncional int

AS 

INSERT INTO LMateriales
(
 NumeroLMateriales,
 IdObra,
 IdCliente,
 IdEquipo,
 Fecha,
 Realizo,
 Aprobo,
 IdPlano,
 Nombre,
 Observaciones,
 EnviarEmail,
 IdLMaterialesOriginal,
 IdOrigenTransmision,
 Embalo,
 CircuitoFirmasCompleto,
 ArchivoAdjunto1,
 IdUnidadFuncional
)
VALUES 
(
 @NumeroLMateriales,
 @IdObra,
 @IdCliente,
 @IdEquipo,
 @Fecha,
 @Realizo,
 @Aprobo,
 @IdPlano,
 @Nombre,
 @Observaciones,
 @EnviarEmail,
 @IdLMaterialesOriginal,
 @IdOrigenTransmision,
 @Embalo,
 @CircuitoFirmasCompleto,
 @ArchivoAdjunto1,
 @IdUnidadFuncional
)

SELECT @IdLMateriales=@@identity

RETURN(@IdLMateriales)