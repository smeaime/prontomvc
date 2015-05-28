CREATE Procedure [dbo].[Requerimientos_TX_TodosLosDetalles]

@IdRequerimiento int

AS 

SET NOCOUNT ON

DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0 
  BEGIN
	SET @sql1='Select A.IdArticulo, A.Descripcion, A.NumeroInventario From '+@BasePRONTOMANT+'.dbo.Articulos A 
			Where IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT IdArticulo, Descripcion, NumeroInventario
	 FROM Articulos
  END

SET NOCOUNT OFF

SELECT
 DetReq.*,
 Requerimientos.NumeroRequerimiento,
 (Select Sum(DetalleRecepciones.CantidadCC) From DetalleRecepciones Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) as [Entregado],
 Case When (Select Sum(DetalleRecepciones.CantidadCC) From DetalleRecepciones Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) is not null
	Then (DetReq.Cantidad - (Select Sum(DetalleRecepciones.CantidadCC) From DetalleRecepciones Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento))
	Else	DetReq.Cantidad
 End as [Pendiente],
 Requerimientos.IdObra as [IdObra],
 Obras.NumeroObra as [Obra],
 Articulos.Descripcion as [DescripcionArt],
 Articulos.Codigo,
 IsNull(A2.NumeroInventario,'') as [EquipoDestino],
 A2.NumeroInventario as [Cod.Eq.Destino],
 A2.Descripcion as [Equipo destino]
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos On Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
LEFT OUTER JOIN Obras On Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Articulos On DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN #Auxiliar1 A2 ON DetReq.IdEquipoDestino = A2.IdArticulo
WHERE DetReq.IdRequerimiento=@IdRequerimiento
ORDER BY DetReq.NumeroItem

DROP TABLE #Auxiliar1