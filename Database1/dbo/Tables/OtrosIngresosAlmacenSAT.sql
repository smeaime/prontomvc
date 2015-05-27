﻿CREATE TABLE [dbo].[OtrosIngresosAlmacenSAT] (
    [IdOtroIngresoAlmacen]         INT         IDENTITY (1, 1) NOT NULL,
    [NumeroOtroIngresoAlmacen]     INT         NULL,
    [FechaOtroIngresoAlmacen]      DATETIME    NULL,
    [IdObra]                       INT         NULL,
    [Observaciones]                NTEXT       COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Aprobo]                       INT         NULL,
    [TipoIngreso]                  INT         NULL,
    [Emitio]                       INT         NULL,
    [FechaRegistracion]            DATETIME    NULL,
    [EnviarEmail]                  TINYINT     NULL,
    [IdOtroIngresoAlmacenOriginal] INT         NULL,
    [IdOrigenTransmision]          INT         NULL,
    [FechaImportacionTransmision]  DATETIME    NULL,
    [Anulado]                      VARCHAR (2) NULL,
    [IdAutorizaAnulacion]          INT         NULL,
    [FechaAnulacion]               DATETIME    NULL,
    CONSTRAINT [PK_OtrosIngresosAlmacenSAT] PRIMARY KEY CLUSTERED ([IdOtroIngresoAlmacen] ASC) WITH (FILLFACTOR = 90)
);

