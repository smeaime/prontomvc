CREATE TABLE [dbo].[OrdenesTrabajo] (
    [IdOrdenTrabajo]     INT          IDENTITY (1, 1) NOT NULL,
    [NumeroOrdenTrabajo] VARCHAR (20) NULL,
    [Descripcion]        VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaInicio]        DATETIME     NULL,
    [FechaEntrega]       DATETIME     NULL,
    [FechaFinalizacion]  DATETIME     NULL,
    [TrabajosARealizar]  NTEXT        COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdOrdeno]           INT          NULL,
    [IdSuperviso]        INT          NULL,
    [Observaciones]      NTEXT        NULL,
    [IdEquipoDestino]    INT          NULL,
    CONSTRAINT [PK_OrdenesTrabajo] PRIMARY KEY CLUSTERED ([IdOrdenTrabajo] ASC) WITH (FILLFACTOR = 90)
);

