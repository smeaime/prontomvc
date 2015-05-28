CREATE TABLE [dbo].[DetalleAcoTratamientos] (
    [IdDetalleAcoTratamiento] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoTratamiento]        INT         NULL,
    [IdTratamiento]           INT         NULL,
    [Marca]                   VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoTratamientos] PRIMARY KEY CLUSTERED ([IdDetalleAcoTratamiento] ASC) WITH (FILLFACTOR = 90)
);

