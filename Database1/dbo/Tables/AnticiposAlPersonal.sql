CREATE TABLE [dbo].[AnticiposAlPersonal] (
    [IdAnticipoAlPersonal] INT             IDENTITY (1, 1) NOT NULL,
    [IdOrdenPago]          INT             NULL,
    [IdEmpleado]           INT             NULL,
    [Importe]              NUMERIC (18, 2) NULL,
    [IdAsiento]            INT             NULL,
    [CantidadCuotas]       INT             NULL,
    [Detalle]              VARCHAR (50)    NULL,
    [IdRecibo]             INT             NULL,
    CONSTRAINT [PK_AnticiposAlPersonal] PRIMARY KEY CLUSTERED ([IdAnticipoAlPersonal] ASC) WITH (FILLFACTOR = 90)
);

