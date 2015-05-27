CREATE TABLE [dbo].[DetalleAcoBiselados] (
    [IdDetalleAcoBiselado] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoBiselado]        INT         NULL,
    [IdBiselado]           INT         NULL,
    [Marca]                VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoBiselados] PRIMARY KEY CLUSTERED ([IdDetalleAcoBiselado] ASC) WITH (FILLFACTOR = 90)
);

