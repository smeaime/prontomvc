CREATE TABLE [dbo].[Asientos] (
    [IdAsiento]                  INT           IDENTITY (1, 1) NOT NULL,
    [NumeroAsiento]              INT           NULL,
    [FechaAsiento]               DATETIME      NULL,
    [Ejercicio]                  INT           NULL,
    [IdCuentaSubdiario]          INT           NULL,
    [Concepto]                   VARCHAR (50)  NULL,
    [Tipo]                       VARCHAR (5)   NULL,
    [IdIngreso]                  INT           NULL,
    [FechaIngreso]               DATETIME      NULL,
    [IdModifico]                 INT           NULL,
    [FechaUltimaModificacion]    DATETIME      NULL,
    [AsientoApertura]            VARCHAR (2)   NULL,
    [BaseConsolidadaHija]        VARCHAR (50)  NULL,
    [FechaGeneracionConsolidado] DATETIME      NULL,
    [ArchivoImportacion]         VARCHAR (200) NULL,
    [AsignarAPresupuestoObra]    VARCHAR (2)   NULL,
    CONSTRAINT [PK_Asientos] PRIMARY KEY NONCLUSTERED ([IdAsiento] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[Asientos]([NumeroAsiento] ASC, [IdAsiento] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[Asientos]([FechaAsiento] ASC, [NumeroAsiento] ASC) WITH (FILLFACTOR = 90);

