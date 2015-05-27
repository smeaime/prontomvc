CREATE TABLE [dbo].[DW_DimRubros] (
    [IdRubro] INT          NOT NULL,
    [Rubro]   VARCHAR (50) NULL,
    CONSTRAINT [PK_DW_DimRubros] PRIMARY KEY CLUSTERED ([IdRubro] ASC) WITH (FILLFACTOR = 90)
);

