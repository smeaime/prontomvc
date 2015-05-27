CREATE TABLE [dbo].[DW_DimVendedores] (
    [IdVendedor] INT          NOT NULL,
    [Nombre]     VARCHAR (50) NULL,
    CONSTRAINT [PK_DW_DimVendedores] PRIMARY KEY CLUSTERED ([IdVendedor] ASC) WITH (FILLFACTOR = 90)
);

