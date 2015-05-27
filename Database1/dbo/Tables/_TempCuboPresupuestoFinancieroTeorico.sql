CREATE TABLE [dbo].[_TempCuboPresupuestoFinancieroTeorico] (
    [IdPresupuestoFinancieroTeorico] INT             IDENTITY (1, 1) NOT NULL,
    [Tipo]                           VARCHAR (20)    NULL,
    [RubroFinanciero]                VARCHAR (50)    NULL,
    [UnidadOperativa]                VARCHAR (50)    NULL,
    [Obra]                           VARCHAR (20)    NULL,
    [Fecha]                          DATETIME        NULL,
    [Detalle]                        VARCHAR (200)   NULL,
    [Importe]                        NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboPresupuestoFinancieroTeorico] PRIMARY KEY CLUSTERED ([IdPresupuestoFinancieroTeorico] ASC) WITH (FILLFACTOR = 90)
);

