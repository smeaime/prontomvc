CREATE TABLE [dbo].[DetalleOrdenesPagoCuentas] (
    [IdDetalleOrdenPagoCuentas] INT             IDENTITY (1, 1) NOT NULL,
    [IdOrdenPago]               INT             NULL,
    [IdCuenta]                  INT             NULL,
    [CodigoCuenta]              VARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Debe]                      NUMERIC (18, 2) NULL,
    [Haber]                     NUMERIC (18, 2) NULL,
    [IdObra]                    INT             NULL,
    [IdCuentaGasto]             INT             NULL,
    [IdCuentaBancaria]          INT             NULL,
    [IdCaja]                    INT             NULL,
    [IdMoneda]                  INT             NULL,
    [CotizacionMonedaDestino]   NUMERIC (18, 4) NULL,
    [IdTarjetaCredito]          INT             NULL,
    CONSTRAINT [PK_DetalleOrdenesPagoCuentas] PRIMARY KEY NONCLUSTERED ([IdDetalleOrdenPagoCuentas] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleOrdenesPagoCuentas_OrdenesPago] FOREIGN KEY ([IdOrdenPago]) REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
);

