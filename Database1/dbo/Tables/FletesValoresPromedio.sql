CREATE TABLE [dbo].[FletesValoresPromedio] (
    [IdFleteValorPromedio] INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]           INT             NULL,
    [IdUnidad]             INT             NULL,
    [Año]                  INT             NULL,
    [Mes]                  INT             NULL,
    [Valor]                NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_FletesValoresPromedio] PRIMARY KEY CLUSTERED ([IdFleteValorPromedio] ASC) WITH (FILLFACTOR = 90)
);

