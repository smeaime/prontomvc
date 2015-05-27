CREATE TABLE [dbo].[ProduccionFichas] (
    [IdProduccionFicha]  INT             IDENTITY (1, 1) NOT NULL,
    [Observaciones]      NTEXT           NULL,
    [IdColor]            INT             NULL,
    [Codigo]             VARCHAR (20)    NULL,
    [Descripcion]        VARCHAR (50)    NULL,
    [Cantidad]           NUMERIC (18, 2) NULL,
    [IdUnidad]           INT             NULL,
    [Minimo]             NUMERIC (18, 2) NULL,
    [IdArticuloAsociado] INT             NULL,
    [ArchivoAdjunto1]    VARCHAR (100)   NULL,
    [ArchivoAdjunto2]    VARCHAR (100)   NULL,
    [EstaActiva]         VARCHAR (2)     NULL,
    PRIMARY KEY CLUSTERED ([IdProduccionFicha] ASC) WITH (FILLFACTOR = 90)
);

