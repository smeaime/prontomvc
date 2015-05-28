






























CREATE Procedure [dbo].[ItemsPopUpMateriales_TX_CamposConTablas]
AS
SET NOCOUNT ON
CREATE TABLE #Tablas 	(
			 Campo VARCHAR(50),
			 Tabla VARCHAR(50)
			)
INSERT INTO #Tablas 
Select 
 It.Campo01_Nombre as [Campo],
 It.Campo01_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo02_Nombre as [Campo],
 It.Campo02_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo03_Nombre as [Campo],
 It.Campo03_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo04_Nombre as [Campo],
 It.Campo04_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo05_Nombre as [Campo],
 It.Campo05_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo06_Nombre as [Campo],
 It.Campo06_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo07_Nombre as [Campo],
 It.Campo07_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo08_Nombre as [Campo],
 It.Campo08_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo09_Nombre as [Campo],
 It.Campo09_Tabla as [Tabla]
From ItemsPopUpMateriales It
Union all
Select 
 It.Campo10_Nombre as [Campo],
 It.Campo10_Tabla as [Tabla]
From ItemsPopUpMateriales It
SET NOCOUNT OFF
SELECT *
FROM #Tablas
WHERE Tabla is not null and len(tabla)>0
GROUP By Campo,Tabla
DROP TABLE #Tablas































