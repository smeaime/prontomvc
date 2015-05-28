CREATE TABLE [dbo].[DetalleLMaterialesRevisiones] (
    [IdDetalleLMaterialesRevisiones]         INT           IDENTITY (1, 1) NOT NULL,
    [IdLMateriales]                          INT           NULL,
    [IdDetalleLMateriales]                   INT           NULL,
    [NumeroItem]                             INT           NULL,
    [Fecha]                                  DATETIME      NULL,
    [Detalle]                                VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdRealizo]                              INT           NULL,
    [FechaRealizacion]                       DATETIME      NULL,
    [IdAprobo]                               INT           NULL,
    [FechaAprobacion]                        DATETIME      NULL,
    [TipoRegistro]                           VARCHAR (1)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [NumeroRevision]                         VARCHAR (10)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]                            TINYINT       NULL,
    [IdLMaterialesOriginal]                  INT           NULL,
    [IdDetalleLMaterialesRevisionesOriginal] INT           NULL,
    [IdOrigenTransmision]                    INT           NULL,
    CONSTRAINT [PK_DetalleLMaterialesRevisiones] PRIMARY KEY CLUSTERED ([IdDetalleLMaterialesRevisiones] ASC) WITH (FILLFACTOR = 90)
);

