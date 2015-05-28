
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////////////////////

create    FUNCTION fPresupuestoObrasNodos_TX_ImportePorNodoRecursiva (@idNodo int,@CodigoPresupuesto int) 
returns money as
BEGIN


declare @p money
declare @q money


	select @p=Importe,@q=cantidad
	from presupuestoobrasnodos P
	inner join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
		p.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
	where p.idPresupuestoobrasnodo=@idNodo
	and CodigoPresupuesto=@CodigoPresupuesto


if 	(select count(p.idPresupuestoobrasnodo)
	from presupuestoobrasnodos P
	inner join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
		p.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
	where idNodoPadre=@idNodo
		and CodigoPresupuesto=@CodigoPresupuesto
	)=0 or @p<>0
	begin
	
		/*
		if (@t)=0 
		begin
			@t=999
		end
		*/
		if @p=0 or @p is null return -99999999
		else return @p
	end


--si no, volver a llamarse

if (select count(cantidad) 
	from presupuestoobrasnodos P	
	inner join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
		p.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
		and CodigoPresupuesto=@CodigoPresupuesto
	where idNodoPadre=@idNodo and cantidad<=0)>0 

	return -99999999



return (select 
	sum( cantidad*dbo.fPresupuestoObrasNodos_TX_ImportePorNodoRecursiva
		(p.idPresupuestoObrasNodo,@CodigoPresupuesto))
	from presupuestoobrasnodos P
	inner join PresupuestoObrasNodosPxQxPresupuesto PxQ ON 
		p.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo
		and CodigoPresupuesto=@CodigoPresupuesto
	where idNodoPadre=@idNodo)

END





