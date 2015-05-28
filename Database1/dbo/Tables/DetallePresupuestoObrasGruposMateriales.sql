CREATE TABLE [dbo].[DetallePresupuestoObrasGruposMateriales] (
    [IdDetallePresupuestoObraGrupoMateriales] INT IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObraGrupoMateriales]        INT NULL,
    [IdArticulo]                              INT NULL,
    CONSTRAINT [PK_DetallePresupuestoObrasGruposMateriales] PRIMARY KEY CLUSTERED ([IdDetallePresupuestoObraGrupoMateriales] ASC) WITH (FILLFACTOR = 90)
);

