CREATE TABLE [dbo].[_TempAutorizaciones1] (
    [IdComprobante]         INT          NULL,
    [TipoComprobante]       VARCHAR (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Numero]                VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdAutorizacion]        INT          NULL,
    [IdFormulario]          INT          NULL,
    [IdDetalleAutorizacion] INT          NULL,
    [SectorEmisor]          VARCHAR (1)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [OrdenAutorizacion]     INT          NULL,
    [IdAutoriza]            INT          NULL,
    [IdSector]              INT          NULL,
    [IdLibero]              INT          NULL,
    [Fecha]                 DATETIME     NULL
);

