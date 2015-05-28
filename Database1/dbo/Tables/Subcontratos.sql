CREATE TABLE [dbo].[Subcontratos] (
    [IdSubcontrato]     INT             IDENTITY (1, 1) NOT NULL,
    [IdNodoPadre]       INT             NULL,
    [Depth]             TINYINT         NULL,
    [Lineage]           VARCHAR (255)   NULL,
    [TipoNodo]          INT             NULL,
    [Descripcion]       VARCHAR (255)   NULL,
    [TipoPartida]       TINYINT         NULL,
    [IdUnidad]          INT             NULL,
    [UnidadAvance]      VARCHAR (1)     NULL,
    [Cantidad]          NUMERIC (18, 2) NULL,
    [Importe]           NUMERIC (18, 2) NULL,
    [NumeroSubcontrato] INT             NULL,
    [Item]              VARCHAR (20)    NULL,
    CONSTRAINT [PK_Subcontratos] PRIMARY KEY CLUSTERED ([IdSubcontrato] ASC) WITH (FILLFACTOR = 90)
);

