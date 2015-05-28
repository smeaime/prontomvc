CREATE TABLE [dbo].[Autorizaciones] (
    [IdAutorizacion]           INT      IDENTITY (1, 1) NOT NULL,
    [IdFormulario]             INT      NULL,
    [FechaUltimaActualizacion] DATETIME NULL,
    CONSTRAINT [PK_Autorizaciones] PRIMARY KEY CLUSTERED ([IdAutorizacion] ASC) WITH (FILLFACTOR = 90)
);

