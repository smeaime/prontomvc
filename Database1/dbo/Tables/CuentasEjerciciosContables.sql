CREATE TABLE [dbo].[CuentasEjerciciosContables] (
    [IdCuentaEjercicioContable] INT             IDENTITY (1, 1) NOT NULL,
    [IdCuenta]                  INT             NULL,
    [IdEjercicioContable]       INT             NULL,
    [PresupuestoTeoricoMes01]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes02]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes03]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes04]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes05]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes06]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes07]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes08]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes09]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes10]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes11]   NUMERIC (18, 2) NULL,
    [PresupuestoTeoricoMes12]   NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_CuentasEjerciciosContables] PRIMARY KEY CLUSTERED ([IdCuentaEjercicioContable] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[CuentasEjerciciosContables]([IdCuenta] ASC, [IdEjercicioContable] ASC) WITH (FILLFACTOR = 90);

