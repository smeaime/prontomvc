CREATE TABLE [dbo].[DetalleValoresCuentas] (
    [IdDetalleValorCuentas]   INT             IDENTITY (1, 1) NOT NULL,
    [IdValor]                 INT             NULL,
    [IdCuenta]                INT             NULL,
    [CodigoCuenta]            VARCHAR (10)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Debe]                    NUMERIC (18, 2) NULL,
    [Haber]                   NUMERIC (18, 2) NULL,
    [IdObra]                  INT             NULL,
    [IdCuentaGasto]           INT             NULL,
    [IdCuentaBancaria]        INT             NULL,
    [IdCaja]                  INT             NULL,
    [IdMoneda]                INT             NULL,
    [CotizacionMonedaDestino] NUMERIC (18, 4) NULL,
    CONSTRAINT [PK_DetalleValoresCuentas] PRIMARY KEY NONCLUSTERED ([IdDetalleValorCuentas] ASC) WITH (FILLFACTOR = 90)
);

