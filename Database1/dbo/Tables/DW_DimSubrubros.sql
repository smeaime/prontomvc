CREATE TABLE [dbo].[DW_DimSubrubros] (
    [IdSubrubro] INT          NOT NULL,
    [Subrubro]   VARCHAR (50) NULL,
    CONSTRAINT [PK_DW_DimSubrubro] PRIMARY KEY CLUSTERED ([IdSubrubro] ASC) WITH (FILLFACTOR = 90)
);

