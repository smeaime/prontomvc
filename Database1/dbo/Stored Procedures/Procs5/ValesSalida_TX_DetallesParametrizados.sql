



CREATE  Procedure [dbo].[ValesSalida_TX_DetallesParametrizados]

@NivelParametrizacion int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='0111111133'
	Set @vector_T='0693459200'
   END
ELSE
   BEGIN
	Set @vector_X='0111111133'
	Set @vector_T='0693452200'
   END

SELECT 
 ValesSalida.IdValeSalida,
 ValesSalida.NumeroValeSalida as [Numero de vale],
 ValesSalida.IdValeSalida as [IdAux],
 ValesSalida.NumeroValePreimpreso as [Nro.preimp.],
 ValesSalida.FechaValeSalida as [Fecha],
 Obras.NumeroObra as [Numero obra],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 ValesSalida.Cumplido as [Cumplido],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ValesSalida
LEFT OUTER JOIN Obras ON ValesSalida.IdObra = Obras.IdObra
LEFT OUTER JOIN ArchivosATransmitirDestinos ON ValesSalida.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
ORDER BY NumeroValeSalida



