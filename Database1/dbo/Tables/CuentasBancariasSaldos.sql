CREATE TABLE [dbo].[CuentasBancariasSaldos] (
    [IdCuentaBancariaSaldo]     INT             IDENTITY (1, 1) NOT NULL,
    [IdCuentaBancaria]          INT             NULL,
    [Fecha]                     DATETIME        NULL,
    [SaldoInicial]              NUMERIC (18, 2) NULL,
    [SaldoAnteriorPrimerDiaMes] NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_CuentasBancariasSaldos] PRIMARY KEY CLUSTERED ([IdCuentaBancariaSaldo] ASC) WITH (FILLFACTOR = 90)
);

