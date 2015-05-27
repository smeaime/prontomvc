





























CREATE Procedure [dbo].[DetPresupuestos_TX_UnItem]
@IdDetallePresupuesto int
AS 
SELECT 
DetPre.*,
(	Select Top 1
	DetalleRequerimientos.IdDetalleLMateriales
	From DetalleRequerimientos
	Where DetPre.IdDetalleRequerimiento=DetalleRequerimientos.IdDetalleRequerimiento	) as IdDetalleLMateriales
FROM DetallePresupuestos DetPre
where (DetPre.IdDetallePresupuesto=@IdDetallePresupuesto)






























