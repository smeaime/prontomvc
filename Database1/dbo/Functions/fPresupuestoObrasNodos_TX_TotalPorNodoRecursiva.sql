



--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////

create    FUNCTION fPresupuestoObrasNodos_TX_TotalPorNodoRecursiva (@idNodo int,@CodigoPresupuesto int) 
returns money as
BEGIN


declare @t money
/*
--si tiene algun 0
if 	(select count(cantidad)
	from presupuestoobrasnodos P
	where left(t.lineage,len(@Lineage))=@Lineage
	AND (cantidad=0 OR Importe=0))>0
	begin
		return -1
	end
*/

--si es nodo final, devolver PxQ

SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)


if 	(select count(idPresupuestoobrasnodo)
	from presupuestoobrasnodos P
	where idNodoPadre=@idNodo)=0 
	begin
		(select @t=Cantidad*Importe 
		from presupuestoobrasnodos P
		inner join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
			p.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
		where p.idPresupuestoobrasnodo=@idNodo
		and CodigoPresupuesto=@CodigoPresupuesto
		)

		/*
		if (@t)=0 
		begin
			@t=999
		end
		*/
		if @t=0 or @t is null return -99999999
		else return @t
	end


--si no, volver a llamarse

return (select sum(dbo.fPresupuestoObrasNodos_TX_TotalPorNodoRecursiva
		(idPresupuestoObrasNodo,@CodigoPresupuesto))
	from presupuestoobrasnodos P
	where idNodoPadre=@idNodo)

END





