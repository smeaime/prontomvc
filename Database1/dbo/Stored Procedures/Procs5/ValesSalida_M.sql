CREATE Procedure [dbo].[ValesSalida_M]

@IdValeSalida int,
@NumeroValeSalida int,
@FechaValeSalida datetime,
@IdObra int,
@Observaciones ntext,
@IdCentroCosto int,
@Aprobo int,
@NumeroValePreimpreso int,
@Cumplido varchar(2),
@EnviarEmail tinyint,
@IdValeSalidaOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime,
@IdUsuarioAnulo int,
@FechaAnulacion datetime,
@MotivoAnulacion ntext,
@CircuitoFirmasCompleto varchar(2),
@IdUsuarioDioPorCumplido int,
@FechaDioPorCumplido datetime,
@MotivoDioPorCumplido ntext

AS

UPDATE ValesSalida
SET 
 NumeroValeSalida=@NumeroValeSalida,
 FechaValeSalida=@FechaValeSalida,
 IdObra=@IdObra,
 Observaciones=@Observaciones,
 IdCentroCosto=@IdCentroCosto,
 Aprobo=@Aprobo,
 NumeroValePreimpreso=@NumeroValePreimpreso,
 Cumplido=@Cumplido,
 EnviarEmail=@EnviarEmail,
 IdValeSalidaOriginal=@IdValeSalidaOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 FechaImportacionTransmision=@FechaImportacionTransmision,
 IdUsuarioAnulo=@IdUsuarioAnulo,
 FechaAnulacion=@FechaAnulacion,
 MotivoAnulacion=@MotivoAnulacion,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
 IdUsuarioDioPorCumplido=@IdUsuarioDioPorCumplido,
 FechaDioPorCumplido=@FechaDioPorCumplido,
 MotivoDioPorCumplido=@MotivoDioPorCumplido
WHERE (IdValeSalida=@IdValeSalida)

RETURN(@IdValeSalida)
