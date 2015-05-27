CREATE TABLE [dbo].[Unidades] (
    [IdUnidad]        INT             IDENTITY (1, 1) NOT NULL,
    [Descripcion]     VARCHAR (30)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura]     VARCHAR (15)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CodigoAFIP]      VARCHAR (2)     NULL,
    [UnidadesPorPack] INT             NULL,
    [TaraEnKg]        NUMERIC (18, 4) NULL,
    CONSTRAINT [PK_Unidades] PRIMARY KEY CLUSTERED ([IdUnidad] ASC) WITH (FILLFACTOR = 90)
);

