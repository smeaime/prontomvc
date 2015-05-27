CREATE TABLE [dbo].[PresupuestoObrasGruposMateriales] (
    [IdPresupuestoObraGrupoMateriales] INT           IDENTITY (1, 1) NOT NULL,
    [Codigo]                           VARCHAR (20)  NULL,
    [Descripcion]                      VARCHAR (256) NULL,
    CONSTRAINT [PK_PresupuestoObrasGruposMateriales] PRIMARY KEY CLUSTERED ([IdPresupuestoObraGrupoMateriales] ASC) WITH (FILLFACTOR = 90)
);

