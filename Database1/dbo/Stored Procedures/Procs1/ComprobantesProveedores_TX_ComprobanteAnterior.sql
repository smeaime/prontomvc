
CREATE Procedure [dbo].[ComprobantesProveedores_TX_ComprobanteAnterior]

@IdProveedor int,
@Letra varchar(1),
@NumeroComprobante1 int,
@NumeroComprobante2 int,
@IdTipoComprobante int

AS

SELECT TOP 1 *
FROM ComprobantesProveedores cp
WHERE (IsNull(cp.IdProveedor,0)=@IdProveedor or IsNull(cp.IdProveedorEventual,0)=@IdProveedor) and 
	cp.IdTipoComprobante=@IdTipoComprobante and 
	cp.Letra=@Letra and 
	cp.NumeroComprobante1=@NumeroComprobante1 and 
	cp.NumeroComprobante2<@NumeroComprobante2  
ORDER BY cp.NumeroComprobante2 DESC
