CREATE Procedure [dbo].[Obras_TX_HabilitadasExcel]

@TipoObra varchar(1),
@IdObra as int,
@EsObra as varchar(2)

AS 

SELECT 
 Obras.IdObra as [Id],
 'O' as [Tipo],
 Obras.NumeroObra as [Obra],
 Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS as [Cliente],
 Obras.FechaInicio as [Fecha inicio],
 Obras.FechaEntrega as [Fecha entrega],
 CASE 	WHEN CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' THEN Obras.FechaFinalizacion 
 	ELSE Null 
 END as [Fecha finalizacion]
 FROM Obras
 LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
 WHERE Obras.FechaFinalizacion is null and
	(@TipoObra='*' or
	 (@TipoObra='1' and Obras.IdObra=@IdObra and @EsObra='SI') or 
	 (@TipoObra='T' and Obras.TipoObra=1) or 
	 (@TipoObra='M' and Obras.TipoObra=2) or 
	 (@TipoObra='S' and Obras.TipoObra=3) )

UNION ALL

SELECT
 IdOrdenTrabajo+100000 as [Id],
 'T' as [Tipo],
 NumeroOrdenTrabajo COLLATE SQL_Latin1_General_CP1_CI_AS as [Obra],
 Descripcion as [Cliente],
 FechaInicio as [Fecha inicio],
 FechaEntrega as [Fecha entrega],
 CASE 	WHEN CONVERT(varchar(8),FechaFinalizacion,3)<>'01/01/00' THEN FechaFinalizacion 
	ELSE Null 
 END as [Fecha finalizacion]
 FROM OrdenesTrabajo
 WHERE OrdenesTrabajo.FechaFinalizacion is null and 
	(@TipoObra='*' or (@TipoObra='1' and OrdenesTrabajo.IdOrdenTrabajo=@IdObra and @EsObra='NO'))

ORDER BY [Obra]