
CREATE PROCEDURE wBusquedaMVC
    @q VARCHAR(50)
    with recompile 
AS

	SELECT top 20 * 
	FROM dbo.wFuncionBusquedaMVC(@q) 
--	group by Numero
	order by Fecha desc

