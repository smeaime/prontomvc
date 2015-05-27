
CREATE Procedure [dbo].[_TempSAP_TX_CAI]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 IdProveedor INTEGER,
			 FechaComprobante DATETIME,
			 NumeroComprobante1 INTEGER,
			 NumeroComprobante2 INTEGER,
			 Letra VARCHAR(1),
			 FechaVencimientoCAI DATETIME,
			 NumeroCAI VARCHAR(20)
			)
INSERT INTO #Auxiliar 
 SELECT IsNull(IdProveedor,IdProveedorEventual), FechaComprobante, 
	NumeroComprobante1, NumeroComprobante2, Letra, FechaVencimientoCAI, NumeroCAI
 FROM ComprobantesProveedores cp 
 WHERE cp.FechaVencimientoCAI is not null and cp.NumeroCAI is not null
 ORDER BY FechaComprobante, NumeroComprobante2

SET NOCOUNT OFF

SELECT 
 IsNull(Proveedores.CodigoEmpresa,'') as [LIFNR],
 (Select Top 1 #Auxiliar.NumeroComprobante1 From #Auxiliar 
	Where #Auxiliar.IdProveedor=Proveedores.IdProveedor
	Order By #Auxiliar.FechaComprobante Desc, #Auxiliar.NumeroComprobante2 Desc) as [J_1BBRANC],
 (Select Top 1 #Auxiliar.Letra From #Auxiliar
	Where #Auxiliar.IdProveedor=Proveedores.IdProveedor
	Order By #Auxiliar.FechaComprobante Desc, #Auxiliar.NumeroComprobante2 Desc) as [J_1ADOCCL_],
 (Select Top 1 #Auxiliar.Letra From #Auxiliar
	Where #Auxiliar.IdProveedor=Proveedores.IdProveedor
	Order By #Auxiliar.FechaComprobante Desc, #Auxiliar.NumeroComprobante2 Desc) as [J_1APCHAR],
 Replace(Convert(varchar,(Select Top 1 #Auxiliar.FechaVencimientoCAI From #Auxiliar
				Where #Auxiliar.IdProveedor=Proveedores.IdProveedor
				Order By #Auxiliar.FechaComprobante Desc, #Auxiliar.NumeroComprobante2 Desc),103),'/','.') as [J_1APACVD],
 (Select Top 1 #Auxiliar.NumeroCAI From #Auxiliar
	Where #Auxiliar.IdProveedor=Proveedores.IdProveedor
	Order By #Auxiliar.FechaComprobante Desc, #Auxiliar.NumeroComprobante2 Desc) as [J_1APAC]
FROM Proveedores
WHERE IsNull(Proveedores.Confirmado,'SI')<>'NO' and IsNull(Proveedores.IdEstado,1)=1 and 
	Exists(Select Top 1 #Auxiliar.NumeroComprobante1 From #Auxiliar 
		Where #Auxiliar.IdProveedor=Proveedores.IdProveedor)
ORDER BY Proveedores.InformacionAuxiliar, Proveedores.RazonSocial

DROP TABLE #Auxiliar
