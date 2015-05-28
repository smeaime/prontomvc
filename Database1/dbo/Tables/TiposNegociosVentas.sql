CREATE TABLE [dbo].[TiposNegociosVentas] (
    [IdTipoNegocioVentas] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]         VARCHAR (50) NULL,
    [Codigo]              INT          NULL,
    [Grupo]               VARCHAR (20) NULL,
    CONSTRAINT [PK_TiposNegociosVentas] PRIMARY KEY CLUSTERED ([IdTipoNegocioVentas] ASC) WITH (FILLFACTOR = 90)
);

