CREATE TABLE [dbo].[DetalleArticulosUnidades] (
    [IdDetalleArticuloUnidades]         INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]                        INT             NULL,
    [IdUnidad]                          INT             NULL,
    [Equivalencia]                      NUMERIC (18, 6) NULL,
    [EnviarEmail]                       TINYINT         NULL,
    [IdArticuloOriginal]                INT             NULL,
    [IdDetalleArticuloUnidadesOriginal] INT             NULL,
    [IdOrigenTransmision]               INT             NULL,
    CONSTRAINT [PK_DetalleArticulosUnidades] PRIMARY KEY CLUSTERED ([IdDetalleArticuloUnidades] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleArticulosUnidades_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo]),
    CONSTRAINT [FK_DetalleArticulosUnidades_Unidades] FOREIGN KEY ([IdUnidad]) REFERENCES [dbo].[Unidades] ([IdUnidad])
);

