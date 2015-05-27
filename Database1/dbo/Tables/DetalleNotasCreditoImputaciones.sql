CREATE TABLE [dbo].[DetalleNotasCreditoImputaciones] (
    [IdDetalleNotaCreditoImputaciones] INT             IDENTITY (1, 1) NOT NULL,
    [IdNotaCredito]                    INT             NULL,
    [IdImputacion]                     INT             NULL,
    [Importe]                          NUMERIC (19, 2) NULL,
    CONSTRAINT [PK_DetalleNotasCreditoImputaciones] PRIMARY KEY NONCLUSTERED ([IdDetalleNotaCreditoImputaciones] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleNotasCreditoImputaciones_NotasCredito] FOREIGN KEY ([IdNotaCredito]) REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleNotasCreditoImputaciones]([IdNotaCredito] ASC, [IdDetalleNotaCreditoImputaciones] ASC) WITH (FILLFACTOR = 90);

