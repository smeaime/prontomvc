
CREATE PROCEDURE wBusqueda
    @q VARCHAR(50)
WITH RECOMPILE
AS


-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
-- http://stackoverflow.com/questions/20864934/option-recompile-is-always-faster-why
--PARAMETER SNIFFING - The query plan that is cached is not Optimal for the particular Parameters 
--you are passing in, even though the query itself has not changed. For example, if you pass 
--in a Parameter which only retrieves 10 out of 1,000,000 rows, then the 
--Query Plan created may use a Hash Join, however if the Parameter you pass 
--in will use 750,000 of the 1,000,000 rows, the Plan created may be an Index Scan or Table Scan. 
--In such a situation you can tell the SQL statement to use the option OPTION (RECOMPILE) or an 
--SP to use WITH RECOMPILE. To tell the Engine this is a "Single Use Plan" and not to use a 
--Cached Plan which likely does not apply. There is no rule on how to make this decision, it 
--depends on knowing they way the Query will be used by users.

--if				isnumeric(@q)>0 -- pinta que no se da cuenta de que no tiene que gastarse si esto no se cumple
--begin

--	SELECT top 20 * 
--	FROM dbo.wFuncionBusquedaNumerico(@q) 
----	group by Numero
--	order by Fecha desc
--	end
--	else
--	begin
	SELECT top 20 * 
	FROM dbo.wFuncionBusqueda(@q) 
--	group by Numero
	order by Fecha desc
--	end

