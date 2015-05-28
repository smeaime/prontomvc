CREATE Procedure [dbo].[LogComprobantesElectronicos_TX_LeerRegistro]

@Tipo varchar(2),
@Letra varchar(2),
@PuntoVenta int,
@NumeroComprobante int

AS 

SELECT * 
FROM LogComprobantesElectronicos
WHERE Tipo=@Tipo and Letra=@Letra and PuntoVenta=@PuntoVenta and NumeroComprobante=@NumeroComprobante
