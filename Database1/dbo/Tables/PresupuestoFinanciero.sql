CREATE TABLE [dbo].[PresupuestoFinanciero] (
    [IdPresupuestoFinanciero] INT             IDENTITY (1, 1) NOT NULL,
    [Año]                     INT             NULL,
    [Mes]                     INT             NULL,
    [Semana]                  INT             NULL,
    [IdRubroContable]         INT             NULL,
    [PresupuestoIngresos]     NUMERIC (18, 2) NULL,
    [PresupuestoEgresos]      NUMERIC (18, 2) NULL,
    [Tipo]                    VARCHAR (1)     NULL,
    CONSTRAINT [PK_PresupuestoFinanciero] PRIMARY KEY CLUSTERED ([IdPresupuestoFinanciero] ASC) WITH (FILLFACTOR = 90)
);

