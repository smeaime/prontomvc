CREATE TABLE [dbo].[ArchivosATransmitir] (
    [IdArchivoATransmitir] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]          VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Sistema]              VARCHAR (20) NULL,
    CONSTRAINT [PK_ArchivosATransmitir] PRIMARY KEY CLUSTERED ([IdArchivoATransmitir] ASC) WITH (FILLFACTOR = 90)
);

