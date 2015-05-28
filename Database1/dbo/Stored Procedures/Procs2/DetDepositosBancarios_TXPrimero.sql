




CREATE PROCEDURE [dbo].[DetDepositosBancarios_TXPrimero]

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0011111133'
Set @vector_T='0012411400'

SELECT TOP 1
 DetDep.IdDetalleDepositoBancario,
 DetDep.IdValor,
 Valores.NumeroInterno as [Nro.Int.],
 Valores.NumeroValor as [Numero],
 Valores.FechaValor as [Fecha Vto.],
 Clientes.RazonSocial as [Cliente],
 Bancos.Nombre as [Banco de origen],
 Valores.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDepositosBancarios DetDep
LEFT OUTER JOIN Valores ON Valores.IdValor=DetDep.IdValor
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco




