CREATE TABLE [dbo].[DetalleRecibosCuentas] (
    [IdDetalleReciboCuentas]         INT             IDENTITY (1, 1) NOT NULL,
    [IdRecibo]                       INT             NULL,
    [IdCuenta]                       INT             NULL,
    [CodigoCuenta]                   VARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Debe]                           NUMERIC (19, 2) NULL,
    [Haber]                          NUMERIC (19, 2) NULL,
    [IdObra]                         INT             NULL,
    [IdCuentaGasto]                  INT             NULL,
    [IdCuentaBancaria]               INT             NULL,
    [IdCaja]                         INT             NULL,
    [IdMoneda]                       INT             NULL,
    [CotizacionMonedaDestino]        NUMERIC (18, 3) NULL,
    [EnviarEmail]                    TINYINT         NULL,
    [IdOrigenTransmision]            INT             NULL,
    [IdReciboOriginal]               INT             NULL,
    [IdDetalleReciboCuentasOriginal] INT             NULL,
    [FechaImportacionTransmision]    DATETIME        NULL,
    CONSTRAINT [PK_DetalleRecibosCuentas] PRIMARY KEY NONCLUSTERED ([IdDetalleReciboCuentas] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleRecibosCuentas_Recibos] FOREIGN KEY ([IdRecibo]) REFERENCES [dbo].[Recibos] ([IdRecibo])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleRecibosCuentas]([IdRecibo] ASC, [IdDetalleReciboCuentas] ASC) WITH (FILLFACTOR = 90);

