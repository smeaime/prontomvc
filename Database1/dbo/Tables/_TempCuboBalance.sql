CREATE TABLE [dbo].[_TempCuboBalance] (
    [IdCuboBalance]        INT             IDENTITY (1, 1) NOT NULL,
    [Jerarquia1]           VARCHAR (60)    NULL,
    [Jerarquia2]           VARCHAR (60)    NULL,
    [Jerarquia3]           VARCHAR (60)    NULL,
    [Jerarquia4]           VARCHAR (60)    NULL,
    [Cuenta]               VARCHAR (60)    NULL,
    [Detalle]              VARCHAR (100)   NULL,
    [SaldoInicial]         NUMERIC (18, 2) NULL,
    [SaldoDeudorPeriodo]   NUMERIC (18, 2) NULL,
    [SaldoAcreedorPeriodo] NUMERIC (18, 2) NULL,
    [SaldoPeriodo]         NUMERIC (18, 2) NULL,
    [SaldoFinal]           NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboBalance] PRIMARY KEY CLUSTERED ([IdCuboBalance] ASC) WITH (FILLFACTOR = 90)
);

