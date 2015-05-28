
CREATE  Procedure [dbo].[Valores_TX_OtrosIngresos]

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111133'
set @vector_T='02114321242300'

SELECT 
Valores.IdValor,
Case 	When Valores.IdTipoValor is null 
	 Then 'EF'
	Else (Select top 1 TiposComprobante.DescripcionAb
		from TiposComprobante 
		Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) 
End as [Tipo valor],
Valores.NumeroInterno as [Nro.Int.],
Valores.NumeroValor as [Numero],
Valores.FechaValor as [Fecha Vto.],
Valores.Importe as [Importe],
Bancos.Nombre as [Banco origen],
(Select top 1 TiposComprobante.DescripcionAb
 from TiposComprobante Where Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante) as [Comp.],
Valores.NumeroComprobante as [Nro.Comp.],
Valores.FechaComprobante as [Fec.Comp.],
Clientes.RazonSocial as [Cliente],
Cuentas.Descripcion as [Cuenta contable],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Cuentas ON Valores.IdCuentaOrigen=Cuentas.IdCuenta
WHERE Valores.IdTipoComprobante=23 and IsNull(Valores.Anulado,'NO')<>'SI'
ORDER BY Valores.FechaValor,Valores.NumeroInterno
