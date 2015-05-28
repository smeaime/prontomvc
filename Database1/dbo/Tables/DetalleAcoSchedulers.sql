CREATE TABLE [dbo].[DetalleAcoSchedulers] (
    [IdDetalleAcoScheduler] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoScheduler]        INT         NULL,
    [IdScheduler]           INT         NULL,
    [Marca]                 VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoSchedulers] PRIMARY KEY CLUSTERED ([IdDetalleAcoScheduler] ASC) WITH (FILLFACTOR = 90)
);

