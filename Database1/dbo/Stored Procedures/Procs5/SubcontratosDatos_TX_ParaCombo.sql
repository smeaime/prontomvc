CREATE Procedure [dbo].[SubcontratosDatos_TX_ParaCombo]

@NumeroSubcontrato int = Null,
@IdProveedor int = Null

AS 

SET @NumeroSubcontrato=IsNull(@NumeroSubcontrato,-1)
SET @IdProveedor=IsNull(@IdProveedor,-1)

SELECT C.NumeroSubcontrato, Convert(varchar(10),C.NumeroSubcontrato)+' '+Proveedores.RazonSocial as [Titulo]
FROM SubcontratosDatos C
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=C.IdProveedor
WHERE (@NumeroSubcontrato=-1 or C.NumeroSubcontrato=@NumeroSubcontrato) and (@IdProveedor=-1 or C.IdProveedor=@IdProveedor)  and IsNull(C.Anulado,'')<>'SI'
ORDER BY Proveedores.RazonSocial, C.NumeroSubcontrato