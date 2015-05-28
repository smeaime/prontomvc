CREATE TABLE [dbo].[DW_DimUnidadesOperativas] (
    [IdUnidadOperativa] INT          NOT NULL,
    [Descripcion]       VARCHAR (50) NULL,
    CONSTRAINT [PK_DW_DimUnidadesOperativas] PRIMARY KEY CLUSTERED ([IdUnidadOperativa] ASC) WITH (FILLFACTOR = 90)
);

