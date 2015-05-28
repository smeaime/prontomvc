
CREATE  Procedure [dbo].[Valores_TX_VencidosAFecha]

@Hasta datetime

AS 

declare @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(30)
set @vector_X='01111111111333'
set @vector_T='05555555555000'
set @vector_E=' DCNCCNNCDI   '

SELECT 
	Valores.IdValor,
	Valores.FechaComprobante as [Fec.Comp.],
	(Select top 1 TiposComprobante.DescripcionAb
	 from TiposComprobante 
	 Where Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante) as [Comp.],
	Valores.NumeroComprobante as [Nro.],
	Bancos.Nombre as [Banco origen],
	(Select top 1 TiposComprobante.DescripcionAb
	 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
	Valores.NumeroInterno as [Nro.Int.],
	Valores.NumeroValor as [Numero],
	Convert(varchar,Clientes.CodigoCliente)+'  '+Clientes.RazonSocial as [Cliente],
	Valores.FechaValor as [Fecha Vto.],
	Valores.Importe as [Importe],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
WHERE Valores.Estado is null And Valores.FechaValor=@Hasta And Valores.IdCaja is null and IsNull(Valores.Anulado,'NO')<>'SI' 
ORDER BY Valores.FechaValor,Valores.NumeroInterno
