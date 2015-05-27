CREATE Procedure [dbo].[Subcontratos_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111111111133'
SET @vector_T='07267771045333333333300'

SELECT 
 sc.NumeroSubcontrato,
 sc.NumeroSubcontrato as [Nro. subcontrato], 
 sc.DescripcionSubcontrato as [Descripcion del subcontrato],
 Proveedores.RazonSocial as [Proveedor],
 sc.Fecha as [Fecha subcontrato],
 sc.FechaInicio as [Fecha inicio],
 sc.FechaFinalizacion as [Fecha finalizacion],
 sc.Anulado as [Anulado],
 E1.Nombre as [Anulo],
 sc.FechaAnulacion as [Fecha anulacion],
 sc.MotivoAnulacion as [Motivo anulacion],
 sc.Adjunto1 as [Archivo adjunto 1],
 sc.Adjunto2 as [Archivo adjunto 2],
 sc.Adjunto3 as [Archivo adjunto 3],
 sc.Adjunto4 as [Archivo adjunto 4],
 sc.Adjunto5 as [Archivo adjunto 5],
 sc.Adjunto6 as [Archivo adjunto 6],
 sc.Adjunto7 as [Archivo adjunto 7],
 sc.Adjunto8 as [Archivo adjunto 8],
 sc.Adjunto9 as [Archivo adjunto 9],
 sc.Adjunto10 as [Archivo adjunto 10],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM SubcontratosDatos sc
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = sc.IdProveedor
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = sc.IdUsuarioAnulo
ORDER BY sc.NumeroSubcontrato, sc.Fecha