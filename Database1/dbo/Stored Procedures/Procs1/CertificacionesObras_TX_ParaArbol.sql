CREATE Procedure [dbo].[CertificacionesObras_TX_ParaArbol]

@NumeroProyecto int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdCertificacionObras INTEGER,
			 IdNodoPadre INTEGER,
			 Descripcion VARCHAR(255),
			 Obra VARCHAR(255)
			)
INSERT INTO #Auxiliar1 
 SELECT C.IdCertificacionObras, C.IdNodoPadre, C.Descripcion, Obras.Descripcion
 FROM CertificacionesObras C
 LEFT OUTER JOIN Obras ON Obras.IdObra=C.IdObra
 WHERE C.IdNodoPadre is null and C.NumeroProyecto=@NumeroProyecto
 ORDER BY C.Item, C.Descripcion, C.IdCertificacionObras

INSERT INTO #Auxiliar1 
 SELECT C.IdCertificacionObras, C.IdNodoPadre, C.Descripcion, Obras.Descripcion
 FROM CertificacionesObras C
 LEFT OUTER JOIN Obras ON Obras.IdObra=C.IdObra
 WHERE C.IdNodoPadre is not null and C.NumeroProyecto=@NumeroProyecto
 ORDER BY C.IdNodoPadre, C.Item, C.Descripcion, C.IdCertificacionObras

SET NOCOUNT OFF

SELECT * FROM #Auxiliar1

DROP TABLE #Auxiliar1