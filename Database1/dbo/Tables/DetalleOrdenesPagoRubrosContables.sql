CREATE TABLE [dbo].[DetalleOrdenesPagoRubrosContables] (
    [IdDetalleOrdenPagoRubrosContables] INT             IDENTITY (1, 1) NOT NULL,
    [IdOrdenPago]                       INT             NULL,
    [IdRubroContable]                   INT             NULL,
    [Importe]                           NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleOrdenesPagoRubrosContables] PRIMARY KEY CLUSTERED ([IdDetalleOrdenPagoRubrosContables] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleOrdenesPagoRubrosContables_OrdenesPago] FOREIGN KEY ([IdOrdenPago]) REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleOrdenesPagoRubrosContables]([IdOrdenPago] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleOrdenesPagoRubrosContables]([IdRubroContable] ASC) WITH (FILLFACTOR = 90);

