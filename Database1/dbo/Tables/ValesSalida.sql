CREATE TABLE [dbo].[ValesSalida] (
    [IdValeSalida]                INT         IDENTITY (1, 1) NOT NULL,
    [NumeroValeSalida]            INT         NULL,
    [FechaValeSalida]             DATETIME    NULL,
    [IdObra]                      INT         NULL,
    [Observaciones]               NTEXT       COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCentroCosto]               INT         NULL,
    [Aprobo]                      INT         NULL,
    [NumeroValePreimpreso]        INT         NULL,
    [Cumplido]                    VARCHAR (2) NULL,
    [EnviarEmail]                 TINYINT     NULL,
    [IdValeSalidaOriginal]        INT         NULL,
    [IdOrigenTransmision]         INT         NULL,
    [FechaImportacionTransmision] DATETIME    NULL,
    [IdUsuarioAnulo]              INT         NULL,
    [FechaAnulacion]              DATETIME    NULL,
    [MotivoAnulacion]             NTEXT       NULL,
    [CircuitoFirmasCompleto]      VARCHAR (2) NULL,
    [IdUsuarioDioPorCumplido]     INT         NULL,
    [FechaDioPorCumplido]         DATETIME    NULL,
    [MotivoDioPorCumplido]        NTEXT       NULL,
    CONSTRAINT [PK_ValesSalida] PRIMARY KEY CLUSTERED ([IdValeSalida] ASC) WITH (FILLFACTOR = 90)
);

