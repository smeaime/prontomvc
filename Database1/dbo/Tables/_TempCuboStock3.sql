CREATE TABLE [dbo].[_TempCuboStock3] (
    [IdCuboStock]     INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]      INT             NULL,
    [Articulo]        VARCHAR (300)   NULL,
    [Fecha]           DATETIME        NULL,
    [Deposito]        VARCHAR (50)    NULL,
    [Ubicacion]       VARCHAR (20)    NULL,
    [Obra]            VARCHAR (113)   NULL,
    [Partida]         VARCHAR (20)    NULL,
    [Detalle]         VARCHAR (200)   NULL,
    [Cantidad]        NUMERIC (18, 2) NULL,
    [Costo]           NUMERIC (18, 3) NULL,
    [StockValorizado] NUMERIC (18, 3) NULL,
    [Cuenta]          VARCHAR (60)    NULL,
    [Unidad]          VARCHAR (50)    NULL,
    CONSTRAINT [PK__TempCuboStock3] PRIMARY KEY CLUSTERED ([IdCuboStock] ASC) WITH (FILLFACTOR = 90)
);

