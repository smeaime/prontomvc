CREATE Procedure [dbo].[Comparativas_A]

@IdComparativa int  output,
@Numero int,
@Fecha datetime,
@Observaciones ntext,
@IdConfecciono int,
@IdAprobo int,
@PresupuestoSeleccionado int,
@SubNumeroSeleccionado int,
@MontoPrevisto numeric(12,2),
@MontoParaCompra numeric(12,2),
@NumeroRequerimiento int,
@FechaAprobacion datetime,
@Obras varchar(20),
@CircuitoFirmasCompleto varchar(2),
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100),
@ImporteComparativaCalculado numeric(18,2),
@Anulada varchar(2),
@FechaAnulacion datetime,
@IdUsuarioAnulo int,
@MotivoAnulacion ntext

AS 

INSERT INTO Comparativas
(
 Numero,
 Fecha,
 Observaciones,
 IdConfecciono,
 IdAprobo,
 PresupuestoSeleccionado,
 SubNumeroSeleccionado,
 MontoPrevisto,
 MontoParaCompra,
 NumeroRequerimiento,
 FechaAprobacion,
 Obras,
 CircuitoFirmasCompleto,
 ArchivoAdjunto1,
 ArchivoAdjunto2,
 ImporteComparativaCalculado,
 Anulada,
 FechaAnulacion,
 IdUsuarioAnulo,
 MotivoAnulacion
)
VALUES
(
 @Numero,
 @Fecha,
 @Observaciones,
 @IdConfecciono,
 @IdAprobo,
 @PresupuestoSeleccionado,
 @SubNumeroSeleccionado,
 @MontoPrevisto,
 @MontoParaCompra,
 @NumeroRequerimiento,
 @FechaAprobacion,
 @Obras,
 @CircuitoFirmasCompleto,
 @ArchivoAdjunto1,
 @ArchivoAdjunto2,
 @ImporteComparativaCalculado,
 @Anulada,
 @FechaAnulacion,
 @IdUsuarioAnulo,
 @MotivoAnulacion
)

SELECT @IdComparativa=@@identity

RETURN(@IdComparativa)