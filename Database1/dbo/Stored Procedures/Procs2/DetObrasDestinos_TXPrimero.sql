
CREATE PROCEDURE [dbo].[DetObrasDestinos_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111133'
SET @vector_T='04312433'

SELECT TOP 1 
 Det.IdDetalleObraDestino,
 Det.Destino as [Destino],
 Det.Detalle as [Detalle],
 Det.ADistribuir as [A distrib.],
 Det.InformacionAuxiliar as [Inf.Aux.],
 Case When IsNull(Det.TipoConsumo,3)=1 Then 'Directo'
	When IsNull(Det.TipoConsumo,3)=2 Then 'Indirecto'
	Else 'Ambos'
 End as [Tipo consumo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasDestinos Det
