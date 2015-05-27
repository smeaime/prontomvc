CREATE TABLE [dbo].[DW_DimObras] (
    [IdObra]            INT           NOT NULL,
    [NumeroObra]        VARCHAR (13)  NULL,
    [Descripcion]       VARCHAR (100) NULL,
    [IdUnidadOperativa] INT           NULL,
    CONSTRAINT [PK_DW_DimObras] PRIMARY KEY CLUSTERED ([IdObra] ASC) WITH (FILLFACTOR = 90)
);

