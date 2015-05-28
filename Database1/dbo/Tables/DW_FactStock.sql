CREATE TABLE [dbo].[DW_FactStock] (
    [IdStock]          INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]       INT             NULL,
    [IdUnidad]         INT             NULL,
    [IdUbicacion]      INT             NULL,
    [IdObra]           INT             NULL,
    [IdColor]          INT             NULL,
    [Cantidad]         NUMERIC (18, 2) NULL,
    [Fecha]            INT             NULL,
    [ClaveComprobante] NUMERIC (16)    NULL,
    CONSTRAINT [PK_DW_FactStock] PRIMARY KEY CLUSTERED ([IdStock] ASC) WITH (FILLFACTOR = 90)
);

