CREATE TABLE [dbo].[PresupuestoObrasNodosPresupuestos] (
    [IdPresupuestoObrasNodoPresupuesto] INT           IDENTITY (1, 1) NOT NULL,
    [IdObra]                            INT           NULL,
    [NumeroPresupuesto]                 INT           NULL,
    [Fecha]                             DATETIME      NULL,
    [Detalle]                           VARCHAR (200) NULL,
    CONSTRAINT [PK_PresupuestoObrasNodosPresupuestos] PRIMARY KEY CLUSTERED ([IdPresupuestoObrasNodoPresupuesto] ASC) WITH (FILLFACTOR = 90)
);

