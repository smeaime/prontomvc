CREATE TABLE [dbo].[DetalleSalidasMaterialesKits] (
    [IdDetalleSalidaMaterialesKit] INT             IDENTITY (1, 1) NOT NULL,
    [IdDetalleSalidaMateriales]    INT             NULL,
    [IdArticulo]                   INT             NULL,
    [IdUnidad]                     INT             NULL,
    [Cantidad]                     NUMERIC (18, 2) NULL,
    [CostoUnitario]                NUMERIC (18, 4) NULL,
    CONSTRAINT [PK_DetalleSalidasMaterialesKits] PRIMARY KEY CLUSTERED ([IdDetalleSalidaMaterialesKit] ASC) WITH (FILLFACTOR = 90)
);

