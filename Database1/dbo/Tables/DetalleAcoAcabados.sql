CREATE TABLE [dbo].[DetalleAcoAcabados] (
    [IdDetalleAcoAcabado] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoAcabado]        INT         NULL,
    [IdAcabado]           INT         NULL,
    [Marca]               VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoAcabados] PRIMARY KEY CLUSTERED ([IdDetalleAcoAcabado] ASC) WITH (FILLFACTOR = 90)
);

