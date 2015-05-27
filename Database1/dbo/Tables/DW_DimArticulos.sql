CREATE TABLE [dbo].[DW_DimArticulos] (
    [IdArticulo]      INT             NOT NULL,
    [Codigo]          VARCHAR (20)    NULL,
    [IdRubro]         INT             NULL,
    [IdSubrubro]      INT             NULL,
    [Material]        VARCHAR (300)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CostoReposicion] NUMERIC (18, 3) NULL,
    CONSTRAINT [PK_DW_DimArticulos] PRIMARY KEY CLUSTERED ([IdArticulo] ASC) WITH (FILLFACTOR = 90)
);

