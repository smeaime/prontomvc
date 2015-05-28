CREATE TABLE [dbo].[DetalleOrdenesPagoValores] (
    [IdDetalleOrdenPagoValores] INT             IDENTITY (1, 1) NOT NULL,
    [IdOrdenPago]               INT             NULL,
    [IdTipoValor]               INT             NULL,
    [NumeroValor]               NUMERIC (18)    NULL,
    [NumeroInterno]             INT             NULL,
    [FechaVencimiento]          DATETIME        NULL,
    [IdBanco]                   INT             NULL,
    [Importe]                   NUMERIC (18, 2) NULL,
    [IdValor]                   INT             NULL,
    [IdCuentaBancaria]          INT             NULL,
    [IdBancoChequera]           INT             NULL,
    [IdCaja]                    INT             NULL,
    [ChequesALaOrdenDe]         VARCHAR (100)   NULL,
    [NoALaOrden]                VARCHAR (2)     NULL,
    [Anulado]                   VARCHAR (2)     NULL,
    [IdUsuarioAnulo]            INT             NULL,
    [FechaAnulacion]            DATETIME        NULL,
    [MotivoAnulacion]           VARCHAR (30)    NULL,
    [IdTarjetaCredito]          INT             NULL,
    CONSTRAINT [PK_DetalleOrdenesPagoValores] PRIMARY KEY NONCLUSTERED ([IdDetalleOrdenPagoValores] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleOrdenesPagoValores_IdTipoValor] FOREIGN KEY ([IdTipoValor]) REFERENCES [dbo].[TiposComprobante] ([IdTipoComprobante]),
    CONSTRAINT [FK_DetalleOrdenesPagoValores_OrdenesPago] FOREIGN KEY ([IdOrdenPago]) REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleOrdenesPagoValores]([IdOrdenPago] ASC) WITH (FILLFACTOR = 90);

