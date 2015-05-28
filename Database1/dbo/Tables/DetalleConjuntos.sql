CREATE TABLE [dbo].[DetalleConjuntos] (
    [IdDetalleConjunto] INT             IDENTITY (1, 1) NOT NULL,
    [IdConjunto]        INT             NULL,
    [IdArticulo]        INT             NULL,
    [Cantidad]          NUMERIC (18, 3) NULL,
    [IdUnidad]          INT             NULL,
    [Cantidad1]         NUMERIC (18, 2) NULL,
    [Cantidad2]         NUMERIC (18, 2) NULL,
    [Observaciones]     NTEXT           NULL,
    [FechaAlta]         DATETIME        NULL,
    [FechaModificacion] DATETIME        NULL,
    CONSTRAINT [PK_DetalleConjuntos] PRIMARY KEY CLUSTERED ([IdDetalleConjunto] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleConjuntos_Conjuntos] FOREIGN KEY ([IdConjunto]) REFERENCES [dbo].[Conjuntos] ([IdConjunto])
);

