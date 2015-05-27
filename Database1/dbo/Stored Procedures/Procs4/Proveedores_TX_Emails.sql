
CREATE Procedure [dbo].[Proveedores_TX_Emails]

@IdProveedor int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 Nombre VARCHAR(50),
			 Email VARCHAR(50)
			)
INSERT INTO #Auxiliar 
 SELECT RazonSocial, Email
 FROM Proveedores
 WHERE Len(IsNull(Email,''))>0 and IdProveedor=@IdProveedor

INSERT INTO #Auxiliar 
 SELECT Contacto, Email
 FROM DetalleProveedores
 WHERE Len(IsNull(Email,''))>0 and IdProveedor=@IdProveedor

SET NOCOUNT OFF

SELECT *
FROM #Auxiliar

DROP TABLE #Auxiliar

