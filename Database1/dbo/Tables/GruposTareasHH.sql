CREATE TABLE [dbo].[GruposTareasHH] (
    [IdGrupoTareaHH]  INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]     VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Preparacion]     NUMERIC (18) NULL,
    [CaldereriaPlana] NUMERIC (18) NULL,
    [Mecanica]        NUMERIC (18) NULL,
    [Caldereria]      NUMERIC (18) NULL,
    [Soldadura]       NUMERIC (18) NULL,
    [Almacenes]       NUMERIC (18) NULL,
    CONSTRAINT [PK_GruposTareasHH] PRIMARY KEY CLUSTERED ([IdGrupoTareaHH] ASC) WITH (FILLFACTOR = 90)
);

