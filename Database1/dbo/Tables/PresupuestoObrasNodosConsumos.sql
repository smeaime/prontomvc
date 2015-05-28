CREATE TABLE [dbo].[PresupuestoObrasNodosConsumos] (
    [IdPresupuestoObrasNodoConsumo] INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodo]        INT             NULL,
    [Fecha]                         DATETIME        NULL,
    [Numero]                        INT             NULL,
    [Detalle]                       VARCHAR (100)   NULL,
    [Importe]                       NUMERIC (18, 2) NULL,
    [Origen]                        VARCHAR (10)    NULL,
    [IdEntidad]                     INT             NULL,
    [Cantidad]                      NUMERIC (18, 2) NULL,
    [IdObraOrigen]                  INT             NULL,
    CONSTRAINT [PK_PresupuestoObrasNodosConsumos] PRIMARY KEY CLUSTERED ([IdPresupuestoObrasNodoConsumo] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_PresupuestoObrasNodosConsumos_PresupuestoObrasNodos] FOREIGN KEY ([IdPresupuestoObrasNodo]) REFERENCES [dbo].[PresupuestoObrasNodos] ([IdPresupuestoObrasNodo])
);

