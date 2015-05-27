CREATE TABLE [dbo].[TarifasFletes] (
    [IdTarifaFlete]  INT             IDENTITY (1, 1) NOT NULL,
    [Descripcion]    VARCHAR (50)    NULL,
    [ValorUnitario]  NUMERIC (18, 2) NULL,
    [Codigo]         VARCHAR (10)    NULL,
    [LimiteInferior] NUMERIC (18, 2) NULL,
    [LimiteSuperior] NUMERIC (18, 2) NULL,
    [IdUnidad]       INT             NULL,
    [FechaVigencia]  DATETIME        NULL,
    CONSTRAINT [PK_TarifasFletes] PRIMARY KEY CLUSTERED ([IdTarifaFlete] ASC) WITH (FILLFACTOR = 90)
);

