
CREATE  Procedure [dbo].[Valores_TX_OtrosIngresosEntreFecha]
	@Desde datetime,
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
	Case 	When Valores.IdTipoValor is null 
		 Then 'EF'
		Else (Select top 1 TiposComprobante.DescripcionAb
			from TiposComprobante 
			Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) 
	End as [Tipo],
	Valores.NumeroInterno as [Nro.Int.],
	Valores.NumeroValor as [Numero],
	Cuentas.Codigo+' - '+Cuentas.Descripcion as [Cuenta],
	Valores.FechaValor as [Fecha Vto.],
	Valores.Importe as [Importe],
	@Vector_E as Vector_E,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Cuentas ON Valores.IdCuentaOrigen=Cuentas.IdCuenta
WHERE Valores.Estado is null And Valores.IdTipoComprobante=23 And IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.FechaComprobante>=@Desde And Valores.FechaComprobante<=@Hasta
ORDER BY Valores.FechaComprobante,Valores.NumeroInterno
