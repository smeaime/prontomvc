CREATE TABLE [dbo].[SituacionImpositivaEntidades] (
    [Cuit]                 VARCHAR (11)  NOT NULL,
    [Denominacion]         VARCHAR (30)  NULL,
    [Ganacias]             VARCHAR (2)   NULL,
    [Iva]                  VARCHAR (2)   NULL,
    [Monotributo]          VARCHAR (2)   NULL,
    [IntegranteSoc]        VARCHAR (1)   NULL,
    [Empleador]            VARCHAR (1)   NULL,
    [ActividadMonotributo] VARCHAR (2)   NULL,
    [Registro]             VARCHAR (100) NULL,
    CONSTRAINT [PK_SituacionImpositivaEntidades] PRIMARY KEY CLUSTERED ([Cuit] ASC) WITH (FILLFACTOR = 90)
);

