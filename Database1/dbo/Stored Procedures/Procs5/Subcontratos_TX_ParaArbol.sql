CREATE Procedure [dbo].[Subcontratos_TX_ParaArbol]

@NumeroSubcontrato int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdSubcontrato INTEGER,
			 IdNodoPadre INTEGER,
			 Descripcion VARCHAR(255),
			 Item VARCHAR(20),
			 Item1 INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT C.IdSubcontrato, C.IdNodoPadre, C.Descripcion, C.Item, 0 --Case When IsNumeric(C.Item)=1 Then Convert(int,C.Item) Else 0 End
 FROM Subcontratos C
 WHERE C.IdNodoPadre is null and C.NumeroSubcontrato=@NumeroSubcontrato
 ORDER BY C.Descripcion, C.IdSubcontrato

INSERT INTO #Auxiliar1 
 SELECT C.IdSubcontrato, C.IdNodoPadre, C.Descripcion, C.Item, 0 --Case When IsNumeric(C.Item)=1 Then Convert(int,C.Item) Else 0 End
 FROM Subcontratos C
 WHERE C.IdNodoPadre is not null and C.NumeroSubcontrato=@NumeroSubcontrato
 ORDER BY C.IdNodoPadre, C.Descripcion, C.IdSubcontrato

SET NOCOUNT OFF

SELECT * FROM #Auxiliar1
ORDER BY IdNodoPadre, Item1, Item

DROP TABLE #Auxiliar1