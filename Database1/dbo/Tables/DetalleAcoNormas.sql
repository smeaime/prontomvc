CREATE TABLE [dbo].[DetalleAcoNormas] (
    [IdDetalleAcoNorma] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoNorma]        INT         NULL,
    [IdNorma]           INT         NULL,
    [Marca]             VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoNormas] PRIMARY KEY CLUSTERED ([IdDetalleAcoNorma] ASC) WITH (FILLFACTOR = 90)
);

