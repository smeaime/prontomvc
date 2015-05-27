CREATE TABLE [dbo].[_TempCuadroGastosParaCubo] (
    [IdCuboGastos]      INT             IDENTITY (1, 1) NOT NULL,
    [IdObra]            INT             NULL,
    [Obra]              VARCHAR (20)    NULL,
    [IdRubroContable]   INT             NULL,
    [RubroContable]     VARCHAR (50)    NULL,
    [IdUnidadOperativa] INT             NULL,
    [UnidadOperativa]   VARCHAR (50)    NULL,
    [Importe]           NUMERIC (18, 4) NULL,
    [ProvinciaDestino]  VARCHAR (50)    NULL,
    [Detalle]           VARCHAR (200)   NULL,
    [Mes]               VARCHAR (20)    NULL,
    CONSTRAINT [PK__TempCuadroGastosParaCubo] PRIMARY KEY CLUSTERED ([IdCuboGastos] ASC) WITH (FILLFACTOR = 90)
);

