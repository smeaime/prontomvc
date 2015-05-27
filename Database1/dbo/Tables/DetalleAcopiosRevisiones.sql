CREATE TABLE [dbo].[DetalleAcopiosRevisiones] (
    [IdDetalleAcopiosRevisiones]         INT           IDENTITY (1, 1) NOT NULL,
    [IdAcopio]                           INT           NULL,
    [IdDetalleAcopio]                    INT           NULL,
    [NumeroItem]                         INT           NULL,
    [Fecha]                              DATETIME      NULL,
    [Detalle]                            VARCHAR (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdRealizo]                          INT           NULL,
    [FechaRealizacion]                   DATETIME      NULL,
    [IdAprobo]                           INT           NULL,
    [FechaAprobacion]                    DATETIME      NULL,
    [NumeroRevision]                     VARCHAR (10)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [EnviarEmail]                        TINYINT       NULL,
    [IdAcopioOriginal]                   INT           NULL,
    [IdDetalleAcopiosRevisionesOriginal] INT           NULL,
    [IdOrigenTransmision]                INT           NULL,
    CONSTRAINT [PK_DetalleAcopiosRevisiones] PRIMARY KEY CLUSTERED ([IdDetalleAcopiosRevisiones] ASC) WITH (FILLFACTOR = 90)
);

