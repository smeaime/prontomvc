CREATE Procedure [dbo].[PresupuestoObrasNodos_CrearPresupuestoTemporal]

@IdObra int, 
@CodigoPresupuesto int,
@IdentificadorSesion int

AS 

SET NOCOUNT ON

/*  Como el temporal se utiliza para cargar datos reales, asume que @CodigoPresupuesto=0  */
--SET @CodigoPresupuesto=0

DELETE _TempPresupuestoObrasNodosPxQxPresupuestoPorDia
WHERE FechaSesion<DateAdd(d,-2,GetDate()) or IdentificadorSesion=@IdentificadorSesion

DELETE _TempPresupuestoObrasNodosPxQxPresupuesto
WHERE FechaSesion<DateAdd(d,-2,GetDate()) or IdentificadorSesion=@IdentificadorSesion

INSERT INTO _TempPresupuestoObrasNodosPxQxPresupuestoPorDia
 SELECT PxQ.IdPresupuestoObrasNodosPxQxPresupuestoPorDia, PxQ.IdPresupuestoObrasNodo, PxQ.CodigoPresupuesto, PxQ.Dia, PxQ.Mes, PxQ.Año, PxQ.CantidadAvance, @IdentificadorSesion, GetDate()
 FROM PresupuestoObrasNodosPxQxPresupuestoPorDia PxQ 
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
 WHERE pon.IdObra=@IdObra and PxQ.CodigoPresupuesto=0

INSERT INTO _TempPresupuestoObrasNodosPxQxPresupuesto
 SELECT 
  PxQ.IdPresupuestoObrasNodosPxQxPresupuesto, 
  PxQ.IdPresupuestoObrasNodo, 
  PxQ.CodigoPresupuesto, 
  IsNull((Select PxQ2.Importe From PresupuestoObrasNodosPxQxPresupuesto PxQ2 Where PxQ2.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and PxQ2.CodigoPresupuesto=@CodigoPresupuesto and PxQ2.Año=PxQ.Año and PxQ2.Mes=PxQ.Mes),0),
  IsNull((Select PxQ2.Cantidad From PresupuestoObrasNodosPxQxPresupuesto PxQ2 Where PxQ2.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and PxQ2.CodigoPresupuesto=@CodigoPresupuesto and PxQ2.Año=PxQ.Año and PxQ2.Mes=PxQ.Mes),0),
  PxQ.ImporteDesnormalizado, 
  PxQ.Mes, 
  PxQ.Año, 
  PxQ.ImporteAvance, 
  PxQ.CantidadAvance, 
  IsNull((Select PxQ2.CantidadTeorica From PresupuestoObrasNodosPxQxPresupuesto PxQ2 Where PxQ2.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and PxQ2.CodigoPresupuesto=@CodigoPresupuesto and PxQ2.Año=PxQ.Año and PxQ2.Mes=PxQ.Mes),0),
  PxQ.Certificado, 
  @IdentificadorSesion, 
  GetDate()
 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ 
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
 WHERE pon.IdObra=@IdObra and PxQ.CodigoPresupuesto=0

SET NOCOUNT OFF