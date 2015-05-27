CREATE TABLE [dbo].[DetalleOrdenesPago] (
    [IdDetalleOrdenPago]             INT             IDENTITY (1, 1) NOT NULL,
    [IdOrdenPago]                    INT             NULL,
    [IdImputacion]                   INT             NULL,
    [Importe]                        NUMERIC (18, 2) NULL,
    [ImporteRetencionIVA]            NUMERIC (18, 2) NULL,
    [ImporteRetencionIngresosBrutos] NUMERIC (18, 2) NULL,
    [ImportePagadoSinImpuestos]      NUMERIC (18, 2) NULL,
    [IdTipoRetencionGanancia]        INT             NULL,
    [IdIBCondicion]                  INT             NULL,
    [ImporteRetencionSUSS]           NUMERIC (18, 2) NULL,
    [SaldoAFondoDeReparo]            NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleOrdenesPago] PRIMARY KEY NONCLUSTERED ([IdDetalleOrdenPago] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleOrdenesPago_OrdenesPago] FOREIGN KEY ([IdOrdenPago]) REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleOrdenesPago]([IdOrdenPago] ASC) WITH (FILLFACTOR = 90);

