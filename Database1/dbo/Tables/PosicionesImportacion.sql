CREATE TABLE [dbo].[PosicionesImportacion] (
    [IdPosicionImportacion] INT             IDENTITY (1, 1) NOT NULL,
    [CodigoPosicion]        VARCHAR (15)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcion]           VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdTipoPosicion]        INT             NULL,
    [Derechos]              NUMERIC (18, 2) NULL,
    [GastosEstadisticas]    NUMERIC (18, 2) NULL,
    [OtrosGastos1]          NUMERIC (18, 2) NULL,
    [OtrosGastos2]          NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_PosicionesImportacion] PRIMARY KEY NONCLUSTERED ([IdPosicionImportacion] ASC) WITH (FILLFACTOR = 90)
);

