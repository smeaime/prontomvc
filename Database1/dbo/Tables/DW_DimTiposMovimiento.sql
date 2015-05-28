CREATE TABLE [dbo].[DW_DimTiposMovimiento] (
    [IdTipoMovimiento] INT          NOT NULL,
    [Descripcion]      VARCHAR (30) NULL,
    CONSTRAINT [PK_DW_DimTiposMovimiento] PRIMARY KEY CLUSTERED ([IdTipoMovimiento] ASC) WITH (FILLFACTOR = 90)
);

