CREATE TABLE [dbo].[SaldosEjercicios] (
    [IdSaldoEjercicio] INT   IDENTITY (1, 1) NOT NULL,
    [IdCuenta]         INT   NULL,
    [Ejercicio]        INT   NULL,
    [Debe]             MONEY NULL,
    [Haber]            MONEY NULL,
    CONSTRAINT [PK_SaldosEjercicios] PRIMARY KEY NONCLUSTERED ([IdSaldoEjercicio] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[SaldosEjercicios]([IdCuenta] ASC, [Ejercicio] ASC) WITH (FILLFACTOR = 90);

