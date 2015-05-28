


























CREATE  Procedure [dbo].[Proveedores_TX_UnRegistroResumen]
@IdProveedor int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01133'
set @vector_T='05500'
SELECT 
		Proveedores.IdProveedor, 
		Proveedores.RazonSocial as [Razon social], 
		Proveedores.CodigoEmpresa as [Codigo],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
FROM Proveedores
WHERE Eventual is null And IdProveedor=@IdProveedor


























