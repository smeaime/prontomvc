CREATE TABLE [dbo].[LMateriales] (
    [IdLMateriales]          INT           IDENTITY (1, 1) NOT NULL,
    [NumeroLMateriales]      INT           NULL,
    [IdObra]                 INT           NULL,
    [IdCliente]              INT           NULL,
    [IdEquipo]               INT           NULL,
    [Fecha]                  DATETIME      NULL,
    [Realizo]                INT           NULL,
    [Aprobo]                 INT           NULL,
    [IdPlano]                INT           NULL,
    [Nombre]                 VARCHAR (30)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Observaciones]          NTEXT         COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]            TINYINT       NULL,
    [IdLMaterialesOriginal]  INT           NULL,
    [IdOrigenTransmision]    INT           NULL,
    [Embalo]                 VARCHAR (50)  NULL,
    [CircuitoFirmasCompleto] VARCHAR (2)   NULL,
    [ArchivoAdjunto1]        VARCHAR (200) NULL,
    [IdUnidadFuncional]      INT           NULL,
    CONSTRAINT [PK_LMateriales] PRIMARY KEY CLUSTERED ([IdLMateriales] ASC) WITH (FILLFACTOR = 90)
);

