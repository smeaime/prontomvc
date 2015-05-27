CREATE Procedure [dbo].[Proveedores_TX_PorActividadParaCombo]

@Agrupacion1 int = Null

AS 

SET @Agrupacion1=IsNull(@Agrupacion1,-1)

SELECT 
 Proveedores.IdProveedor,
 Proveedores.RazonSocial as [Titulo]
FROM Proveedores
LEFT OUTER JOIN [Actividades Proveedores] ap ON Proveedores.IdActividad = ap.IdActividad
WHERE (@Agrupacion1=-1 or IsNull(ap.Agrupacion1,0)=@Agrupacion1)
ORDER by Proveedores.RazonSocial