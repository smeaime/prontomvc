CREATE TABLE [dbo].[ProduccionProgRecursos] (
    [IdProduccionProgRecurso] INT             IDENTITY (1, 1) NOT NULL,
    [Fecha]                   DATETIME        NULL,
    [IdMaquina]               INT             NULL,
    [Cantidad]                NUMERIC (18, 2) NULL,
    [ProgRecurso]             INT             NULL,
    [FechaInicio]             DATETIME        NULL,
    [FechaFinal]              DATETIME        NULL,
    [GrillaSerializada]       TEXT            NULL,
    [Fraccionado]             NUMERIC (18, 2) NULL,
    PRIMARY KEY CLUSTERED ([IdProduccionProgRecurso] ASC) WITH (FILLFACTOR = 90)
);

