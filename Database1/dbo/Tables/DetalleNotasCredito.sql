CREATE TABLE [dbo].[DetalleNotasCredito] (
    [IdDetalleNotaCredito] INT             IDENTITY (1, 1) NOT NULL,
    [IdNotaCredito]        INT             NULL,
    [IdConcepto]           INT             NULL,
    [Importe]              NUMERIC (19, 2) NULL,
    [Gravado]              VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdDiferenciaCambio]   INT             NULL,
    [IvaNoDiscriminado]    NUMERIC (19, 2) NULL,
    [IdCuentaBancaria]     INT             NULL,
    [IdCaja]               INT             NULL,
    CONSTRAINT [PK_DetalleNotasCredito] PRIMARY KEY NONCLUSTERED ([IdDetalleNotaCredito] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleNotasCredito_Conceptos] FOREIGN KEY ([IdConcepto]) REFERENCES [dbo].[Conceptos] ([IdConcepto]),
    CONSTRAINT [FK_DetalleNotasCredito_NotasCredito] FOREIGN KEY ([IdNotaCredito]) REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleNotasCredito]([IdNotaCredito] ASC, [IdDetalleNotaCredito] ASC) WITH (FILLFACTOR = 90);

