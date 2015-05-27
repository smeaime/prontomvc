































CREATE Procedure [dbo].[Obras_TX_ParaInformes]
AS 
Select 
Obras.IdObra as [Id],
'O' as [Tipo],
Obras.NumeroObra as [Obra],
Clientes.RazonSocial as [Cliente],
Obras.FechaInicio as [Fecha inicio],
Obras.FechaEntrega as [Fecha entrega],
CASE 	WHEN CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' THEN Obras.FechaFinalizacion 
	ELSE Null 
END as [Fecha finalizacion]
FROM Obras
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
WHERE Obras.ParaInformes='SI'
ORDER BY [Obra]
































