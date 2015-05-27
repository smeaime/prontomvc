﻿CREATE TABLE [dbo].[AjustesStock] (
    [IdAjusteStock]               INT           IDENTITY (1, 1) NOT NULL,
    [NumeroAjusteStock]           INT           NULL,
    [FechaAjuste]                 DATETIME      NULL,
    [Observaciones]               NTEXT         COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdRealizo]                   INT           NULL,
    [FechaRegistro]               DATETIME      NULL,
    [IdAprobo]                    INT           NULL,
    [NumeroMarbete]               INT           NULL,
    [TipoAjuste]                  VARCHAR (1)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]                 TINYINT       NULL,
    [IdAjusteStockOriginal]       INT           NULL,
    [IdOrigenTransmision]         INT           NULL,
    [FechaImportacionTransmision] DATETIME      NULL,
    [IdUsuarioIngreso]            INT           NULL,
    [FechaIngreso]                DATETIME      NULL,
    [IdUsuarioModifico]           INT           NULL,
    [FechaModifico]               DATETIME      NULL,
    [IdRecepcionSAT]              INT           NULL,
    [CircuitoFirmasCompleto]      VARCHAR (2)   NULL,
    [IdSalidaMateriales]          INT           NULL,
    [TipoAjusteInventario]        VARCHAR (1)   NULL,
    [ArchivoAdjunto1]             VARCHAR (100) NULL,
    [ArchivoAdjunto2]             VARCHAR (100) NULL,
    CONSTRAINT [PK_AjustesStock] PRIMARY KEY CLUSTERED ([IdAjusteStock] ASC) WITH (FILLFACTOR = 90)
);

