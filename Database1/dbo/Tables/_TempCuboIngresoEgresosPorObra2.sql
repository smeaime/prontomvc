CREATE TABLE [dbo].[_TempCuboIngresoEgresosPorObra2] (
    [IdCuboIngresoEgresosPorObra] INT             IDENTITY (1, 1) NOT NULL,
    [Tipo]                        VARCHAR (30)    NULL,
    [UnidadOperativa]             VARCHAR (50)    NULL,
    [Obra]                        VARCHAR (100)   NULL,
    [RubroContable]               VARCHAR (50)    NULL,
    [Detalle]                     VARCHAR (100)   NULL,
    [Importe]                     NUMERIC (18, 2) NULL,
    [Grupo]                       VARCHAR (50)    NULL,
    [Entidad]                     VARCHAR (100)   NULL,
    [Cuenta]                      VARCHAR (100)   NULL
);

