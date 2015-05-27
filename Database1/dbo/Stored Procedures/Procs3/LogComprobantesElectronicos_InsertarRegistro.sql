CREATE Procedure [dbo].[LogComprobantesElectronicos_InsertarRegistro]

@Tipo varchar(2),
@Letra varchar(2),
@PuntoVenta int,
@NumeroComprobante int,
@Identificador int,
@Enviado ntext,
@Recibido ntext

AS 

INSERT INTO [LogComprobantesElectronicos]
(
 Tipo,
 Letra,
 PuntoVenta,
 NumeroComprobante,
 Identificador,
 FechaRegistro,
 Enviado,
 Recibido
)
VALUES 
(
 @Tipo,
 @Letra,
 @PuntoVenta,
 @NumeroComprobante,
 @Identificador,
 GetDate(),
 @Enviado,
 @Recibido
)