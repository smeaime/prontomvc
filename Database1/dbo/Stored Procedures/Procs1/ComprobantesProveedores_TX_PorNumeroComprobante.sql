CREATE Procedure [dbo].[ComprobantesProveedores_TX_PorNumeroComprobante]

@IdProveedor int,
@Letra varchar(1),
@NumeroComprobante1 int,
@NumeroComprobante2 int,
@IdComprobanteProveedor int,
@IdTipoComprobante int

AS

SET NOCOUNT ON

DECLARE @FechaInicialControlComprobantes datetime

SET @FechaInicialControlComprobantes=IsNull((Select Top 1 FechaInicialControlComprobantes From Proveedores Where IdProveedor=@IdProveedor),0)

SET NOCOUNT OFF

SELECT *
FROM ComprobantesProveedores cp
WHERE (IsNull(cp.IdProveedor,0)=@IdProveedor or IsNull(cp.IdProveedorEventual,0)=@IdProveedor) and 
	cp.Letra=@Letra and 
	cp.NumeroComprobante1=@NumeroComprobante1 and 
	cp.NumeroComprobante2=@NumeroComprobante2 and 
	(@IdTipoComprobante<=0 or cp.IdTipoComprobante=@IdTipoComprobante) and 
	(@IdComprobanteProveedor<=0 or cp.IdComprobanteProveedor<>@IdComprobanteProveedor) and 
	cp.FechaComprobante>=@FechaInicialControlComprobantes
