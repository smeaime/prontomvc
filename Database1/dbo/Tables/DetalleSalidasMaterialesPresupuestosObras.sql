CREATE TABLE [dbo].[DetalleSalidasMaterialesPresupuestosObras] (
    [IdDetalleSalidaMaterialesPresupuestosObras] INT             IDENTITY (1, 1) NOT NULL,
    [IdDetalleSalidaMateriales]                  INT             NULL,
    [IdPresupuestoObrasNodo]                     INT             NULL,
    [Cantidad]                                   NUMERIC (18, 2) NULL,
    [IdDetalleSalidaMaterialesKit]               INT             NULL,
    [IdPresupuestoObrasNodoNoMateriales]         INT             NULL,
    CONSTRAINT [PK_DetalleSalidasMaterialesPresupuestosObras] PRIMARY KEY CLUSTERED ([IdDetalleSalidaMaterialesPresupuestosObras] ASC) WITH (FILLFACTOR = 90)
);

