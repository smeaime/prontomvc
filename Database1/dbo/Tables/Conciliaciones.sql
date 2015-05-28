CREATE TABLE [dbo].[Conciliaciones] (
    [IdConciliacion]      INT             IDENTITY (1, 1) NOT NULL,
    [IdCuentaBancaria]    INT             NULL,
    [Numero]              VARCHAR (20)    NULL,
    [FechaIngreso]        DATETIME        NULL,
    [SaldoInicialResumen] NUMERIC (18, 2) NULL,
    [SaldoFinalResumen]   NUMERIC (18, 2) NULL,
    [FechaInicial]        DATETIME        NULL,
    [FechaFinal]          DATETIME        NULL,
    [ImporteAjuste]       NUMERIC (18, 2) NULL,
    [Observaciones]       NTEXT           NULL,
    [IdRealizo]           INT             NULL,
    [IdAprobo]            INT             NULL,
    CONSTRAINT [PK_Conciliaciones] PRIMARY KEY CLUSTERED ([IdConciliacion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_Conciliaciones_CuentasBancarias] FOREIGN KEY ([IdCuentaBancaria]) REFERENCES [dbo].[CuentasBancarias] ([IdCuentaBancaria])
);

