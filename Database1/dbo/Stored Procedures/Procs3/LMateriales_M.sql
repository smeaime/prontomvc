CREATE Procedure [dbo].[LMateriales_M]

@IdLMateriales int,
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

UPDATE LMateriales
SET 
 NumeroLMateriales=@NumeroLMateriales,
 IdObra=@IdObra,
 IdCliente=@IdCliente,
 IdEquipo=@IdEquipo,
 Fecha=@Fecha,
 Realizo=@Realizo,
 Aprobo=@Aprobo,
 IdPlano=@IdPlano,
 Nombre=@Nombre,
 Observaciones=@Observaciones,
 EnviarEmail=@EnviarEmail,
 IdLMaterialesOriginal=@IdLMaterialesOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 Embalo=@Embalo,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
 ArchivoAdjunto1=@ArchivoAdjunto1,
 IdUnidadFuncional=@IdUnidadFuncional
WHERE (IdLMateriales=@IdLMateriales)

RETURN(@IdLMateriales)