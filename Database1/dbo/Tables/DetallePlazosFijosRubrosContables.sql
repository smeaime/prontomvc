CREATE TABLE [dbo].[DetallePlazosFijosRubrosContables] (
    [IdDetallePlazoFijoRubrosContables] INT             IDENTITY (1, 1) NOT NULL,
    [IdPlazoFijo]                       INT             NULL,
    [IdRubroContable]                   INT             NULL,
    [Tipo]                              VARCHAR (1)     NULL,
    [Importe]                           NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetallePlazosFijosRubrosContables] PRIMARY KEY CLUSTERED ([IdDetallePlazoFijoRubrosContables] ASC) WITH (FILLFACTOR = 90)
);

