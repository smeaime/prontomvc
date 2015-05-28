CREATE TABLE [dbo].[DetalleAcoTipos] (
    [IdDetalleAcoTipo] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoTipo]        INT         NULL,
    [IdTipo]           INT         NULL,
    [Marca]            VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoTipos] PRIMARY KEY CLUSTERED ([IdDetalleAcoTipo] ASC) WITH (FILLFACTOR = 90)
);

