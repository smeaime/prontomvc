CREATE TABLE [dbo].[DetalleAcoCalidades] (
    [IdDetalleAcoCalidad] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoCalidad]        INT         NULL,
    [IdCalidad]           INT         NULL,
    [Marca]               VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoCalidades] PRIMARY KEY CLUSTERED ([IdDetalleAcoCalidad] ASC) WITH (FILLFACTOR = 90)
);

