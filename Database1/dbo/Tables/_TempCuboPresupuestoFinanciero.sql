CREATE TABLE [dbo].[_TempCuboPresupuestoFinanciero] (
    [idPresupuestoFinanciero] INT             IDENTITY (1, 1) NOT NULL,
    [Obra]                    VARCHAR (13)    NULL,
    [Tipo]                    VARCHAR (10)    NULL,
    [Rubro]                   VARCHAR (50)    NULL,
    [Fecha]                   DATETIME        NULL,
    [Año]                     INT             NULL,
    [Mes]                     VARCHAR (15)    NULL,
    [Semana]                  VARCHAR (10)    NULL,
    [Detalle]                 VARCHAR (100)   NULL,
    [ImporteTeorico]          NUMERIC (18, 2) NULL,
    [ImporteReal]             NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboPresupuestoFinanciero] PRIMARY KEY CLUSTERED ([idPresupuestoFinanciero] ASC) WITH (FILLFACTOR = 90)
);

