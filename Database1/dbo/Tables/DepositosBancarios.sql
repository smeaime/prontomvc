CREATE TABLE [dbo].[DepositosBancarios] (
    [IdDepositoBancario]  INT             IDENTITY (1, 1) NOT NULL,
    [FechaDeposito]       DATETIME        NULL,
    [IdBanco]             INT             NULL,
    [NumeroDeposito]      INT             NULL,
    [Observaciones]       NTEXT           COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Efectivo]            NUMERIC (18, 2) NULL,
    [IdCuentaBancaria]    INT             NULL,
    [Anulado]             VARCHAR (2)     NULL,
    [IdAutorizaAnulacion] INT             NULL,
    [FechaAnulacion]      DATETIME        NULL,
    [IdCaja]              INT             NULL,
    [IdMonedaEfectivo]    INT             NULL,
    [CotizacionMoneda]    NUMERIC (18, 4) NULL,
    CONSTRAINT [PK_DepositosBancarios] PRIMARY KEY NONCLUSTERED ([IdDepositoBancario] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DepositosBancarios]([FechaDeposito] ASC, [IdDepositoBancario] ASC) WITH (FILLFACTOR = 90);

