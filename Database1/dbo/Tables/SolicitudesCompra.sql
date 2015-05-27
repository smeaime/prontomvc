CREATE TABLE [dbo].[SolicitudesCompra] (
    [IdSolicitudCompra] INT      IDENTITY (1, 1) NOT NULL,
    [NumeroSolicitud]   INT      NULL,
    [FechaSolicitud]    DATETIME NULL,
    [Confecciono]       INT      NULL,
    CONSTRAINT [PK_SolicitudesCompra] PRIMARY KEY CLUSTERED ([IdSolicitudCompra] ASC) WITH (FILLFACTOR = 90)
);

