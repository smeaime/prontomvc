



CREATE Procedure [dbo].[Consulta_TX_PorSQL]
@sql nvarchar(4000)
AS 
EXEC sp_executesql @sql



