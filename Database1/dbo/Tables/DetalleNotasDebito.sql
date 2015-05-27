CREATE TABLE [dbo].[DetalleNotasDebito] (
    [IdDetalleNotaDebito] INT             IDENTITY (1, 1) NOT NULL,
    [IdNotaDebito]        INT             NULL,
    [IdConcepto]          INT             NULL,
    [Importe]             NUMERIC (19, 2) NULL,
    [Gravado]             VARCHAR (2)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdDiferenciaCambio]  INT             NULL,
    [IvaNoDiscriminado]   NUMERIC (19, 2) NULL,
    [IdCuentaBancaria]    INT             NULL,
    [IdCaja]              INT             NULL,
    CONSTRAINT [PK_DetalleNotasDebito] PRIMARY KEY NONCLUSTERED ([IdDetalleNotaDebito] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleNotasDebito_Conceptos] FOREIGN KEY ([IdConcepto]) REFERENCES [dbo].[Conceptos] ([IdConcepto]),
    CONSTRAINT [FK_DetalleNotasDebito_NotasDebito] FOREIGN KEY ([IdNotaDebito]) REFERENCES [dbo].[NotasDebito] ([IdNotaDebito])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleNotasDebito]([IdNotaDebito] ASC, [IdDetalleNotaDebito] ASC) WITH (FILLFACTOR = 90);

