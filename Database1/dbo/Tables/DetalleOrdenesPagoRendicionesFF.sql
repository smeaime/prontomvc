CREATE TABLE [dbo].[DetalleOrdenesPagoRendicionesFF] (
    [IdDetalleOrdenPagoRendicionesFF] INT IDENTITY (1, 1) NOT NULL,
    [IdOrdenPago]                     INT NULL,
    [NumeroRendicion]                 INT NULL,
    CONSTRAINT [PK_DetalleOrdenesPagoRendicionesFF] PRIMARY KEY CLUSTERED ([IdDetalleOrdenPagoRendicionesFF] ASC) WITH (FILLFACTOR = 90)
);

