CREATE TABLE [dbo].[_TempVentasParaCubo] (
    [IdVentasParaCubo] INT             IDENTITY (1, 1) NOT NULL,
    [CodigoCliente]    VARCHAR (10)    NULL,
    [Cliente]          VARCHAR (100)   NULL,
    [TipoIVA]          VARCHAR (50)    NULL,
    [Fecha]            DATETIME        NULL,
    [Vendedor]         VARCHAR (50)    NULL,
    [Obra]             VARCHAR (20)    NULL,
    [UnidadOperativa]  VARCHAR (50)    NULL,
    [Importe]          NUMERIC (19, 2) NULL,
    [Cuenta]           VARCHAR (50)    NULL,
    [ProvinciaDestino] VARCHAR (50)    NULL,
    [Detalle]          VARCHAR (200)   NULL,
    CONSTRAINT [PK__TempVentasParaCubo] PRIMARY KEY CLUSTERED ([IdVentasParaCubo] ASC) WITH (FILLFACTOR = 90)
);

