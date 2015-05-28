CREATE TABLE [dbo].[AnexosEquipos] (
    [IdAnexoEquipos]  INT          IDENTITY (1, 1) NOT NULL,
    [NumeroNCM]       VARCHAR (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Equipo]          VARCHAR (70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DescripcionAESA] NTEXT        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [DescripcionNCM]  NTEXT        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_AnexosEquipos] PRIMARY KEY CLUSTERED ([IdAnexoEquipos] ASC) WITH (FILLFACTOR = 90)
);

