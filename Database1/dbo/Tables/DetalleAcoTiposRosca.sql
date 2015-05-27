CREATE TABLE [dbo].[DetalleAcoTiposRosca] (
    [IdDetalleAcoTipoRosca] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoTipoRosca]        INT         NULL,
    [IdTipoRosca]           INT         NULL,
    [Marca]                 VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoTiposRosca] PRIMARY KEY CLUSTERED ([IdDetalleAcoTipoRosca] ASC) WITH (FILLFACTOR = 90)
);

