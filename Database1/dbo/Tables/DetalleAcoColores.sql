CREATE TABLE [dbo].[DetalleAcoColores] (
    [IdDetalleAcoColor] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoColor]        INT         NULL,
    [IdColor]           INT         NULL,
    [Marca]             VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoColores] PRIMARY KEY CLUSTERED ([IdDetalleAcoColor] ASC) WITH (FILLFACTOR = 90)
);

