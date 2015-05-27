CREATE  Procedure [dbo].[Requerimientos_TX_Todos]

@IdUsuario int = Null

AS 

SET NOCOUNT ON

SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @ActivarSolicitudMateriales varchar(2), @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @ActivarSolicitudMateriales=IsNull((Select Top 1 ActivarSolicitudMateriales From Parametros Where IdParametro=1),'NO')
SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
    BEGIN
	SET @sql1='Select A.IdArticulo, A.Descripcion, A.NumeroInventario From '+@BasePRONTOMANT+'.dbo.Articulos A Where IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
    END
ELSE
    BEGIN
	INSERT INTO #Auxiliar1 
	SELECT IdArticulo, Descripcion, NumeroInventario
	FROM Articulos
	WHERE IsNull(Activo,'')<>'NO' and IsNull(ParaMantenimiento,'SI')='SI'
    END


SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111111111111111111133'
IF @ActivarSolicitudMateriales='SI'
	SET @vector_T='0494D922200FFFFF5141235D143E16205525500'
ELSE
	SET @vector_T='0494D122200FFFFF5141235D143E16205525500'

SELECT 
 Requerimientos.IdRequerimiento,
 Requerimientos.NumeroRequerimiento as [Numero Req.],
 Requerimientos.IdRequerimiento as [IdReq],
 Requerimientos.FechaRequerimiento as [Fecha],
 IsNull('/'+Convert(varchar,Requerimientos.NumeradorEliminacionesFirmas),'') as [Vs],
 Requerimientos.Cumplido as [Cump.],
 Requerimientos.Recepcionado as [Recibido],
 Requerimientos.Entregado as [Entregado],
 Requerimientos.Impresa as [Impresa],
 Requerimientos.Detalle as [Detalle],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 dbo.Requerimientos_Presupuestos(Requerimientos.IdRequerimiento)as [Presupuestos],
 dbo.Requerimientos_Comparativas(Requerimientos.IdRequerimiento)as [Comparativas],
 dbo.Requerimientos_Pedidos(Requerimientos.IdRequerimiento)as [Pedidos],
 dbo.Requerimientos_Recepciones(Requerimientos.IdRequerimiento)as [Recepciones],
 dbo.Requerimientos_SalidasMateriales(Requerimientos.IdRequerimiento)as [Salidas], 
 (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
 E1.Nombre as [Liberada por],
 Requerimientos.FechaAprobacion as [Fecha libero],
 E2.Nombre as [Solicitada por],
 Sectores.Descripcion as [Sector],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],
 #Auxiliar1.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+#Auxiliar1.Descripcion as [Equipo destino],
 Requerimientos.UsuarioAnulacion as [Anulo],
 Requerimientos.FechaAnulacion as [Fecha anulacion],
 Requerimientos.MotivoAnulacion as [Motivo anulacion],
 TiposCompra.Descripcion as [Tipo compra],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo 
				From AutorizacionesPorComprobante Aut 
				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],
 (Select Top 1 Aut.FechaAutorizacion 
  From AutorizacionesPorComprobante Aut 
  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador 
				From DetalleRequerimientos Det 
				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
 E3.Nombre as [Importada por],
 Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],
 dbo.Requerimientos_FechasLiberacion(Requerimientos.IdRequerimiento) as [Fechas de liberacion para compras por item],
 Requerimientos.DetalleImputacion as [Detalle imputacion],
 Requerimientos.Observaciones as [Observaciones],
 Requerimientos.NumeradorEliminacionesFirmas as [Elim.Firmas],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Requerimientos
LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN #Auxiliar1 ON Requerimientos.IdEquipoDestino=#Auxiliar1.IdArticulo
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.Aprobo
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado = Requerimientos.IdImporto
WHERE IsNull(Requerimientos.Confirmado,'SI')<>'NO' and IsNull(Requerimientos.ConfirmadoPorWeb,'SI')<>'NO' and 
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and deo.IdObra=Requerimientos.IdObra))
ORDER BY Requerimientos.FechaRequerimiento Desc, Requerimientos.NumeroRequerimiento Desc

DROP TABLE #Auxiliar1