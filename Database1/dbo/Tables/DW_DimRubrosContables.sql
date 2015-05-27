CREATE TABLE [dbo].[DW_DimRubrosContables] (
    [IdRubroContable] INT          NOT NULL,
    [Descripcion]     VARCHAR (50) NULL,
    CONSTRAINT [PK_DW_DimRubrosContables] PRIMARY KEY CLUSTERED ([IdRubroContable] ASC) WITH (FILLFACTOR = 90)
);

