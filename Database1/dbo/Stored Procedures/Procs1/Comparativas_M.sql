CREATE Procedure [dbo].[Comparativas_M]

@IdComparativa int,
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

UPDATE Comparativas
SET 
 Numero=@Numero,
 Fecha=@Fecha,
 Observaciones=@Observaciones,
 IdConfecciono=@IdConfecciono,
 IdAprobo=@IdAprobo,
 PresupuestoSeleccionado=@PresupuestoSeleccionado,
 SubNumeroSeleccionado=@SubNumeroSeleccionado,
 MontoPrevisto=@MontoPrevisto,
 MontoParaCompra=@MontoParaCompra,
 NumeroRequerimiento=@NumeroRequerimiento,
 FechaAprobacion=@FechaAprobacion,
 Obras=@Obras,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
 ArchivoAdjunto1=@ArchivoAdjunto1,
 ArchivoAdjunto2=@ArchivoAdjunto2,
 ImporteComparativaCalculado=@ImporteComparativaCalculado,
 Anulada=@Anulada,
 FechaAnulacion=@FechaAnulacion,
 IdUsuarioAnulo=@IdUsuarioAnulo,
 MotivoAnulacion=@MotivoAnulacion
WHERE (IdComparativa=@IdComparativa)

RETURN(@IdComparativa)