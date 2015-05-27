CREATE TABLE [dbo].[PresupuestoObrasRubros] (
    [IdPresupuestoObraRubro] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]            VARCHAR (50) NULL,
    [TipoConsumo]            INT          NULL,
    CONSTRAINT [PK_PresupuestoObrasRubros] PRIMARY KEY CLUSTERED ([IdPresupuestoObraRubro] ASC) WITH (FILLFACTOR = 90)
);

