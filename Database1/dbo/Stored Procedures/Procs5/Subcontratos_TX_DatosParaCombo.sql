CREATE Procedure [dbo].[Subcontratos_TX_DatosParaCombo]

@IdProveedor int = Null

AS 

SET @IdProveedor=IsNull(@IdProveedor,-1)

SELECT sc.NumeroSubcontrato, Proveedores.RazonSocial + ' [' + Convert(varchar,sc.NumeroSubcontrato)+ '] ' + 
	IsNull(sc.DescripcionSubcontrato COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Titulo]
FROM SubcontratosDatos sc
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=sc.IdProveedor
WHERE (@IdProveedor=-1 or sc.IdProveedor=@IdProveedor) and IsNull(sc.Anulado,'')<>'SI'
ORDER by Proveedores.RazonSocial, sc.NumeroSubcontrato