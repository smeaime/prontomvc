CREATE TABLE [dbo].[DW_DimColores] (
    [IdColor]     INT          NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    CONSTRAINT [PK_DW_DimColores] PRIMARY KEY CLUSTERED ([IdColor] ASC) WITH (FILLFACTOR = 90)
);

