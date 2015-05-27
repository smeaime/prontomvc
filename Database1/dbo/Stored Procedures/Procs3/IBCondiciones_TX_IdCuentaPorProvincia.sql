CREATE Procedure [dbo].[IBCondiciones_TX_IdCuentaPorProvincia]

@IdIBCondicion int

AS 

SELECT 
 IBCondiciones.*,
 Case When IsNull(IBCondiciones.CodigoActividad,0)=1 and IsNull(Provincias.IdCuentaRetencionIBrutos2,0)>0
		Then Provincias.IdCuentaRetencionIBrutos2
		Else Provincias.IdCuentaRetencionIBrutos
 End as [IdCuentaRetencionIBrutos],
 Provincias.PlantillaRetencionIIBB
FROM IBCondiciones
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
WHERE (IBCondiciones.IdIBCondicion=@IdIBCondicion)