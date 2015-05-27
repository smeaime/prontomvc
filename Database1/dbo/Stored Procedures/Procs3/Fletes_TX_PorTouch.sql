CREATE Procedure [dbo].[Fletes_TX_PorTouch]

@Touch varchar(5)

AS 

SELECT 
 Fletes.*,
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 'C' as [CodigoTouch]
FROM Fletes
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
WHERE IsNull(Fletes.TouchCarga,'')=@Touch

UNION ALL

SELECT 
 Fletes.*,
 Transportistas.RazonSocial as [Propietario],
 Choferes.Nombre as [Chofer],
 'D' as [CodigoTouch]
FROM Fletes
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista=Fletes.IdTransportista
LEFT OUTER JOIN Choferes ON Choferes.IdChofer=Fletes.IdChofer
WHERE IsNull(Fletes.TouchDescarga,'')=@Touch