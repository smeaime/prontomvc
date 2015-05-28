CREATE TABLE [dbo].[RubrosContables] (
    [IdRubroContable]                    INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]                             INT          NULL,
    [Descripcion]                        VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Nivel]                              INT          NULL,
    [Financiero]                         VARCHAR (2)  NULL,
    [IngresoEgreso]                      VARCHAR (1)  NULL,
    [IdObra]                             INT          NULL,
    [IdCuenta]                           INT          NULL,
    [NoTomarEnCuboPresupuestoFinanciero] VARCHAR (2)  NULL,
    [DistribuirGastosEnResumen]          VARCHAR (2)  NULL,
    [CodigoAgrupacion]                   INT          NULL,
    [IdTipoRubroFinancieroGrupo]         INT          NULL,
    [TomarMesDeVentaEnResumen]           VARCHAR (2)  NULL,
    CONSTRAINT [PK_RubrosContables] PRIMARY KEY CLUSTERED ([IdRubroContable] ASC) WITH (FILLFACTOR = 90)
);

