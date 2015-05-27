CREATE Procedure [dbo].[CertificacionesObras_TX_EtapasPorNumeroProyecto]

@NumeroProyecto int = Null

AS 

SET @NumeroProyecto=IsNull(@NumeroProyecto,-1)

SELECT C.*, U.Abreviatura as [Unidad], Obras.Descripcion as [Obra]
FROM CertificacionesObras C
LEFT OUTER JOIN Obras ON Obras.IdObra=C.IdObra
LEFT OUTER JOIN Unidades U ON U.IdUnidad=C.idUnidad
WHERE (@NumeroProyecto=-1 or C.NumeroProyecto=@NumeroProyecto)
ORDER BY C.NumeroProyecto, C.Item, C.Descripcion