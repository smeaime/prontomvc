CREATE TABLE [dbo].[DetalleConciliacionesNoContables] (
    [IdDetalleConciliacionNoContable] INT             IDENTITY (1, 1) NOT NULL,
    [IdConciliacion]                  INT             NULL,
    [Detalle]                         VARCHAR (50)    NULL,
    [FechaIngreso]                    DATETIME        NULL,
    [FechaCaducidad]                  DATETIME        NULL,
    [FechaRegistroContable]           DATETIME        NULL,
    [Ingresos]                        NUMERIC (18, 2) NULL,
    [Egresos]                         NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleConciliacionesFueraDeContabilidad] PRIMARY KEY CLUSTERED ([IdDetalleConciliacionNoContable] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleConciliacionesNoContables_Conciliaciones] FOREIGN KEY ([IdConciliacion]) REFERENCES [dbo].[Conciliaciones] ([IdConciliacion])
);

