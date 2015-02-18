select * from FondoDesempleo
where IdFondoDesempleo=16521

select * from Liquidaciones
where IdParametroLiquidacion=465 and IdEmpleado=22 and IdConcepto=77



update FondoDesempleo
set Importe=(Select Top 1 L.Importe From Liquidaciones L Where L.IdParametroLiquidacion=FondoDesempleo.IdParametroLiquidacion and L.IdEmpleado=FondoDesempleo.IdEmpleado and L.IdConcepto=77)
Where FondoDesempleo.IdParametroLiquidacion=465 and FondoDesempleo.Estado is null

