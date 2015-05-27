




--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////


create  Procedure [dbo].[PresupuestoObrasNodos_TX_PorObraCodigoPresupuesto]

@IdObra int = null

AS 
begin

declare @LinajeObra varchar(255)

select @LinajeObra=lineage+ Ltrim(Str(P.IdPresupuestoObrasNodo,6,0)) + '/'  
from PresupuestoObrasNodos P
where idobra=@idobra

SELECT distinct PxQ.CodigoPresupuesto --,tiponodo,idnodopadre,lineage
FROM PresupuestoObrasNodos po
inner join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
	po.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
where left(lineage,len(@LinajeObra))=@LinajeObra --que sea de la obra
--where tiponodo=2 and idNodoPadre=1
ORDER BY CodigoPresupuesto



/*
--viejo codigo

declare @nodoObra int
select @nodoObra=IdPresupuestoObrasNodo from PresupuestoObrasNodos P 
		where idObra=@idObra and tiponodo=1

SELECT PxQ.CodigoPresupuesto
FROM PresupuestoObrasNodos po
inner join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
	po.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
where tiponodo=2 and idNodoPadre=@NodoObra
ORDER BY Depth DESC
*/

end








