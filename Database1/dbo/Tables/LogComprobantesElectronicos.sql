CREATE TABLE [dbo].[LogComprobantesElectronicos] (
    [IdLog]             INT         IDENTITY (1, 1) NOT NULL,
    [Tipo]              VARCHAR (2) NULL,
    [Letra]             VARCHAR (2) NULL,
    [PuntoVenta]        INT         NULL,
    [NumeroComprobante] INT         NULL,
    [Identificador]     INT         NULL,
    [FechaRegistro]     DATETIME    NULL,
    [Enviado]           NTEXT       NULL,
    [Recibido]          NTEXT       NULL,
    CONSTRAINT [PK_LogComprobantesElectronicos] PRIMARY KEY CLUSTERED ([IdLog] ASC)
);

