CREATE TABLE [dbo].[DetalleAcoGrados] (
    [IdDetalleAcoGrado] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoGrado]        INT         NULL,
    [IdGrado]           INT         NULL,
    [Marca]             VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoGrados] PRIMARY KEY CLUSTERED ([IdDetalleAcoGrado] ASC) WITH (FILLFACTOR = 90)
);

