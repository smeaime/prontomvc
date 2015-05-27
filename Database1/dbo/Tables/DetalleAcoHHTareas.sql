CREATE TABLE [dbo].[DetalleAcoHHTareas] (
    [IdDetalleAcoHHTarea] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoHHTarea]        INT         NULL,
    [IdTarea]             INT         NULL,
    [Preparacion]         VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [CaldereriaPlana]     VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Mecanica]            VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Caldereria]          VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Soldadura]           VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Almacen]             VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Mantenimiento]       VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoHHTareas] PRIMARY KEY CLUSTERED ([IdDetalleAcoHHTarea] ASC) WITH (FILLFACTOR = 90)
);

