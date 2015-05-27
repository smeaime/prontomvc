CREATE Procedure [dbo].[Pesadas_TXAnio]

@Estado varchar(1)= Null,
@TipoMovimiento varchar(1) = Null

AS

SET @Estado=IsNull(@Estado,'*')
SET @TipoMovimiento=IsNull(@TipoMovimiento,'*')

SELECT Min(CONVERT(varchar,YEAR(FechaIngreso)))  as [Período], YEAR(FechaIngreso)
FROM Pesadas
WHERE FechaIngreso is not null and 
	(@Estado='*' or 
	 (@Estado='P' and (IsNull(Pesadas.Tara,0)=0 or IsNull(Pesadas.PesoBruto,0)=0)) or 
	 (@Estado='T' and IsNull(Pesadas.Tara,0)<>0 and IsNull(Pesadas.PesoBruto,0)<>0)) and 
	(@TipoMovimiento='*' or IsNull(Pesadas.TipoMovimiento,'')=@TipoMovimiento)  
GROUP BY YEAR(FechaIngreso) 
ORDER BY YEAR(FechaIngreso) desc