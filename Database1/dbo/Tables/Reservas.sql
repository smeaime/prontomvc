CREATE TABLE [dbo].[Reservas] (
    [IdReserva]                   INT         IDENTITY (1, 1) NOT NULL,
    [NumeroReserva]               INT         NULL,
    [FechaReserva]                DATETIME    NULL,
    [Observaciones]               NTEXT       COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Tipo]                        VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]                 TINYINT     NULL,
    [IdReservaOriginal]           INT         NULL,
    [IdOrigenTransmision]         INT         NULL,
    [FechaImportacionTransmision] DATETIME    NULL,
    CONSTRAINT [PK_Reservas] PRIMARY KEY CLUSTERED ([IdReserva] ASC) WITH (FILLFACTOR = 90)
);

