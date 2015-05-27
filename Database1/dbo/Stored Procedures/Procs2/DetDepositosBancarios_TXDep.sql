CREATE PROCEDURE [dbo].[DetDepositosBancarios_TXDep]

@IdDepositoBancario int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111111133'
SET @vector_T='00124114900'

SELECT
 DetDep.IdDetalleDepositoBancario,
 DetDep.IdValor,
 Valores.NumeroInterno as [Nro.Int.],
 Valores.NumeroValor as [Numero],
 Valores.FechaValor as [Fecha Vto.],
 Clientes.RazonSocial as [Cliente],
 Bancos.Nombre as [Banco de origen],
 Valores.Importe as [Importe],
 Monedas.Abreviatura as [Moneda],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDepositosBancarios DetDep
LEFT OUTER JOIN Valores ON Valores.IdValor=DetDep.IdValor
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Valores.IdMoneda
WHERE (DetDep.IdDepositoBancario = @IdDepositoBancario)