CREATE TABLE [dbo].[DetalleAcoFormas] (
    [IdDetalleAcoForma] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoForma]        INT         NULL,
    [IdForma]           INT         NULL,
    [Marca]             VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoFormas] PRIMARY KEY CLUSTERED ([IdDetalleAcoForma] ASC) WITH (FILLFACTOR = 90)
);

