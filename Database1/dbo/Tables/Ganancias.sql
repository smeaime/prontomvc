CREATE TABLE [dbo].[Ganancias] (
    [IdGanancia]              INT             IDENTITY (1, 1) NOT NULL,
    [Desde]                   NUMERIC (18, 2) NULL,
    [Hasta]                   NUMERIC (18, 2) NULL,
    [SumaFija]                NUMERIC (18, 2) NULL,
    [PorcentajeAdicional]     NUMERIC (6, 2)  NULL,
    [IdTipoRetencionGanancia] INT             NULL,
    [MinimoNoImponible]       NUMERIC (18, 2) NULL,
    [MinimoARetener]          NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_Ganancias] PRIMARY KEY NONCLUSTERED ([IdGanancia] ASC) WITH (FILLFACTOR = 90)
);

