CREATE TABLE [dbo].[DetalleAcoSeries] (
    [IdDetalleAcoSerie] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoSerie]        INT         NULL,
    [IdSerie]           INT         NULL,
    [Marca]             VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoSeries] PRIMARY KEY CLUSTERED ([IdDetalleAcoSerie] ASC) WITH (FILLFACTOR = 90)
);

