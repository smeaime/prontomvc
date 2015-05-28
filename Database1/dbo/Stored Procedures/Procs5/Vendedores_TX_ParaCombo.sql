CREATE Procedure [dbo].[Vendedores_TX_ParaCombo]

@IdVendedorExcluido int = Null,
@TodasLasZonas varchar(2) = Null

AS 

SET @IdVendedorExcluido=IsNull(@IdVendedorExcluido,-1)
SET @TodasLasZonas=IsNull(@TodasLasZonas,'')

DECLARE @vector_X varchar(30), @vector_T varchar(30)
SET @vector_X='01133'
SET @vector_T='04900'

SELECT 
 IdVendedor as [IdVendedor],
 Nombre as [Titulo],
 IdVendedor as [IdAux],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Vendedores 
WHERE IdVendedor<>@IdVendedorExcluido and (@TodasLasZonas='' or IsNull(TodasLasZonas,'')=@TodasLasZonas)
ORDER BY Nombre