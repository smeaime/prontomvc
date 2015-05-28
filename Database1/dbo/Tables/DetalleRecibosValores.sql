CREATE TABLE [dbo].[DetalleRecibosValores] (
    [IdDetalleReciboValores]           INT          IDENTITY (1, 1) NOT NULL,
    [IdRecibo]                         INT          NULL,
    [IdTipoValor]                      INT          NULL,
    [NumeroValor]                      NUMERIC (18) NULL,
    [NumeroInterno]                    INT          NULL,
    [FechaVencimiento]                 DATETIME     NULL,
    [IdBanco]                          INT          NULL,
    [Importe]                          MONEY        NULL,
    [IdCuentaBancariaTransferencia]    INT          NULL,
    [IdBancoTransferencia]             INT          NULL,
    [NumeroTransferencia]              INT          NULL,
    [IdTipoCuentaGrupo]                INT          NULL,
    [IdCuenta]                         INT          NULL,
    [IdCaja]                           INT          NULL,
    [CuitLibrador]                     VARCHAR (13) NULL,
    [IdTarjetaCredito]                 INT          NULL,
    [NumeroTarjetaCredito]             VARCHAR (20) NULL,
    [NumeroAutorizacionTarjetaCredito] INT          NULL,
    [CantidadCuotas]                   INT          NULL,
    [EnviarEmail]                      TINYINT      NULL,
    [IdOrigenTransmision]              INT          NULL,
    [IdReciboOriginal]                 INT          NULL,
    [IdDetalleReciboValoresOriginal]   INT          NULL,
    [FechaImportacionTransmision]      DATETIME     NULL,
    [FechaExpiracionTarjetaCredito]    VARCHAR (5)  NULL,
    CONSTRAINT [PK_DetalleRecibosValores] PRIMARY KEY NONCLUSTERED ([IdDetalleReciboValores] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleRecibosValores_Recibos] FOREIGN KEY ([IdRecibo]) REFERENCES [dbo].[Recibos] ([IdRecibo])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleRecibosValores]([IdRecibo] ASC, [IdDetalleReciboValores] ASC) WITH (FILLFACTOR = 90);

