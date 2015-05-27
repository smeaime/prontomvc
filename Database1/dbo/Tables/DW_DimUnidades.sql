CREATE TABLE [dbo].[DW_DimUnidades] (
    [IdUnidad]    INT          NOT NULL,
    [Descripcion] VARCHAR (15) NULL,
    CONSTRAINT [PK_DW_DimUnidades] PRIMARY KEY CLUSTERED ([IdUnidad] ASC) WITH (FILLFACTOR = 90)
);

