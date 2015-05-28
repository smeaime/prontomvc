CREATE  Procedure [dbo].[Proveedores_TX_TT_Eventual]

@IdProveedor int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111133'
SET @vector_T='0595555500'

SELECT 
		Proveedores.IdProveedor, 
		Proveedores.RazonSocial as [Razon social (Eventual)], 
		Proveedores.IdProveedor as [IdAux], 
		Proveedores.Cuit, 
		DescripcionIva.Descripcion as [Condicion IVA], 
		Proveedores.Telefono1 as [Telefono], 
		Proveedores.Email, 
		IsNull(ap.Descripcion,'') as [Actividad principal],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
FROM Proveedores
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN [Actividades Proveedores] ap ON ap.IdActividad=Proveedores.IdActividad
WHERE Eventual is not null and Eventual='SI' and 
	(Confirmado is null or Confirmado<>'NO') and 
	IdProveedor=@IdProveedor




