CREATE TABLE [dbo].[CartasDePorteReglasDeFacturacion] (
    [IdRegla]                                         INT         IDENTITY (1, 1) NOT NULL,
    [IdCliente]                                       INT         NULL,
    [PuntoVenta]                                      INT         NULL,
    [SeLeFacturaCartaPorteComoTitular]                VARCHAR (2) NULL,
    [SeLeFacturaCartaPorteComoIntermediario]          VARCHAR (2) NULL,
    [SeLeFacturaCartaPorteComoRemcomercial]           VARCHAR (2) NULL,
    [SeLeFacturaCartaPorteComoCorredor]               VARCHAR (2) NULL,
    [SeLeFacturaCartaPorteComoDestinatario]           VARCHAR (2) NULL,
    [SeLeFacturaCartaPorteComoDestinatarioExportador] VARCHAR (2) NULL,
    [SeLeDerivaSuFacturaAlCorredorDeLaCarta]          VARCHAR (2) NULL,
    [SeLeFacturaCartaPorteComoClienteAuxiliar]        VARCHAR (2) NULL,
    [EsEntregador]                                    VARCHAR (2) NULL,
    PRIMARY KEY CLUSTERED ([IdRegla] ASC) WITH (FILLFACTOR = 90),
    FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Clientes] ([IdCliente]),
    CONSTRAINT [U_CartasDePorteReglasDeFacturacion] UNIQUE NONCLUSTERED ([IdCliente] ASC, [PuntoVenta] ASC) WITH (FILLFACTOR = 90)
);

