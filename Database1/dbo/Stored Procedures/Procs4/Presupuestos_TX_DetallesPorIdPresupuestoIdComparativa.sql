



CREATE PROCEDURE [dbo].[Presupuestos_TX_DetallesPorIdPresupuestoIdComparativa]

@IdPresupuesto int,
@IdComparativa int

AS

SELECT
 DetPre.*,
 Articulos.Descripcion,
 (Select Top 1 DetCom.IdDetalleComparativa
	From DetalleComparativas DetCom
	Where DetCom.IdComparativa=@IdComparativa and 
		DetCom.IdPresupuesto=@IdPresupuesto and 
		DetCom.IdArticulo=DetPre.IdArticulo) as [IdDetalleComparativa]
FROM DetallePresupuestos DetPre
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetPre.IdArticulo
WHERE DetPre.IdPresupuesto=@IdPresupuesto and 
	EXISTS(Select Top 1 DetCom.IdComparativa
		From DetalleComparativas DetCom
		Left Outer Join Comparativas On DetCom.IdComparativa=Comparativas.IdComparativa
		Where DetCom.IdComparativa=@IdComparativa and 
			DetCom.IdPresupuesto=@IdPresupuesto and 
			DetCom.IdArticulo=DetPre.IdArticulo and 
			DetCom.Precio=DetPre.Precio and 
			(IsNull(DetPre.OrigenDescripcion,1)=1 or 
				(IsNull(DetPre.OrigenDescripcion,1)>1 and 
					Convert(varchar(5000),DetCom.Observaciones)=
					Replace(Replace(Replace(Convert(varchar(5000),DetPre.Observaciones),',',' '),';',' '),Char(13) + Char(10) + Char(13) + Char(10),' '))) and 
			((IsNull(Comparativas.PresupuestoSeleccionado,-1)=-1 and 
			  IsNull(DetCom.Estado,'')='MR') or 
			 (IsNull(Comparativas.PresupuestoSeleccionado,-1)>0 and 
			  DetCom.IdPresupuesto=@IdPresupuesto)))
ORDER BY DetPre.NumeroItem


