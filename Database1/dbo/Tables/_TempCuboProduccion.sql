CREATE TABLE [dbo].[_TempCuboProduccion] (
    [IdTempCuboProduccion] INT             IDENTITY (1, 1) NOT NULL,
    [Rubro]                VARCHAR (50)    NULL,
    [Articulo]             VARCHAR (100)   NULL,
    [Uni]                  VARCHAR (15)    NULL,
    [StockInicial]         NUMERIC (18, 2) NULL,
    [Bajas]                NUMERIC (18, 2) NULL,
    [Muestras]             NUMERIC (18, 2) NULL,
    [Ajustes]              NUMERIC (18, 2) NULL,
    [Devoluciones]         NUMERIC (18, 2) NULL,
    [Compras]              NUMERIC (18, 2) NULL,
    [Costo]                NUMERIC (18, 2) NULL,
    [Cliente]              VARCHAR (50)    NULL,
    [Consumo]              NUMERIC (18, 2) NULL,
    [Total]                NUMERIC (18, 2) NULL,
    [Detalle]              VARCHAR (150)   NULL,
    CONSTRAINT [PK__TempCuboProduccion] PRIMARY KEY CLUSTERED ([IdTempCuboProduccion] ASC) WITH (FILLFACTOR = 90)
);

