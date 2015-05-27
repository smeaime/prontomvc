CREATE TABLE [dbo].[DetalleAcoModelos] (
    [IdDetalleAcoModelo] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoModelo]        INT         NULL,
    [IdModelo]           INT         NULL,
    [Marca]              VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoModelos] PRIMARY KEY CLUSTERED ([IdDetalleAcoModelo] ASC) WITH (FILLFACTOR = 90)
);

