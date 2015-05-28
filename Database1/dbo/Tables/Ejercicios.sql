CREATE TABLE [dbo].[Ejercicios] (
    [IdEjercicio] INT             IDENTITY (1, 1) NOT NULL,
    [Ejercicio]   INT             NULL,
    [IdCuenta]    INT             NULL,
    [SaldoDebe]   NUMERIC (19, 2) NULL,
    [SaldoHaber]  NUMERIC (19, 2) NULL,
    CONSTRAINT [PK_Ejercicios] PRIMARY KEY NONCLUSTERED ([IdEjercicio] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[Ejercicios]([Ejercicio] ASC, [IdCuenta] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[Ejercicios]([IdCuenta] ASC, [Ejercicio] ASC) WITH (FILLFACTOR = 90);

