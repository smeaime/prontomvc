CREATE TABLE [dbo].[ArchivosATransmitirLoteo] (
    [IdArchivoATransmitirLoteo]   INT         IDENTITY (1, 1) NOT NULL,
    [IdArchivoATransmitir]        INT         NULL,
    [FechaTransmision]            DATETIME    NULL,
    [IdArchivoATransmitirDestino] INT         NULL,
    [NumeroLote]                  INT         NULL,
    [Confirmado]                  VARCHAR (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaRecepcionOK]            DATETIME    NULL,
    CONSTRAINT [PK_ArchivosATransmitirLoteo] PRIMARY KEY CLUSTERED ([IdArchivoATransmitirLoteo] ASC) WITH (FILLFACTOR = 90)
);

