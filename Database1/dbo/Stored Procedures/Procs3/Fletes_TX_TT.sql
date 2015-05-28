
CREATE Procedure [dbo].[Fletes_TX_TT]

@IdFlete int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111111133'
SET @vector_T='01311110122220777100'

SELECT 
 Fletes.IdFlete,
 Fletes.Descripcion as [Descripcion],
 Fletes.Patente as [Patente],
 Fletes.NumeroInterno as [Nro.Int.],
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 Marcas.Descripcion as [Marca],
 Modelos.Descripcion as [Modelo],
 Fletes.Año as [Año],
 Fletes.Ancho as [Ancho],
 Fletes.Largo as [Largo],
 Fletes.Alto as [Alto],
 Fletes.Capacidad as [Capacidad],
 Fletes.Tara as [Tara],
 Fletes.TouchCarga as [Touch de carga],
 Fletes.TouchDescarga as [Touch de descarga],
 Case When IsNull(Fletes.ModalidadFacturacion,1)=1 Then 'Por M3-Km'
	When IsNull(Fletes.ModalidadFacturacion,1)=2 Then 'Por Viaje'
	When IsNull(Fletes.ModalidadFacturacion,1)=3 Then 'Por Horas'
	Else ''
 End as [Modalidad de facturacion],
 TarifasFletes.Descripcion+' [ '+Convert(varchar,TarifasFletes.ValorUnitario)+' ]' as [Tarifa],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Fletes
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
LEFT OUTER JOIN Marcas ON Marcas.IdMarca=Fletes.IdMarca
LEFT OUTER JOIN Modelos ON Modelos.IdModelo=Fletes.IdModelo
LEFT OUTER JOIN TarifasFletes ON TarifasFletes.IdTarifaFlete=Fletes.IdTarifaFlete
WHERE (IdFlete=@IdFlete)
