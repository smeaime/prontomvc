CREATE TABLE [dbo].[EjerciciosContables] (
    [IdEjercicioContable] INT      IDENTITY (1, 1) NOT NULL,
    [NumeroEjercicio]     INT      NULL,
    [FechaInicio]         DATETIME NULL,
    [FechaFinalizacion]   DATETIME NULL,
    CONSTRAINT [PK_EjerciciosContables] PRIMARY KEY CLUSTERED ([IdEjercicioContable] ASC) WITH (FILLFACTOR = 90)
);

