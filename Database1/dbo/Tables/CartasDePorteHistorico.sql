﻿CREATE TABLE [dbo].[CartasDePorteHistorico] (
    [IdCartaDePorte]                         INT             NOT NULL,
    [NumeroCartaDePorte]                     BIGINT          NULL,
    [IdUsuarioIngreso]                       INT             NULL,
    [FechaIngreso]                           DATETIME        NULL,
    [Anulada]                                VARCHAR (2)     NULL,
    [IdUsuarioAnulo]                         INT             NULL,
    [FechaAnulacion]                         DATETIME        NULL,
    [Observaciones]                          VARCHAR (200)   NULL,
    [FechaTimeStamp]                         ROWVERSION      NULL,
    [Vendedor]                               INT             NULL,
    [CuentaOrden1]                           INT             NULL,
    [CuentaOrden2]                           INT             NULL,
    [Corredor]                               INT             NULL,
    [Entregador]                             INT             NULL,
    [Procedencia]                            VARCHAR (30)    NULL,
    [Patente]                                VARCHAR (30)    NULL,
    [IdArticulo]                             INT             NULL,
    [IdStock]                                INT             NULL,
    [Partida]                                VARCHAR (20)    NULL,
    [IdUnidad]                               INT             NULL,
    [IdUbicacion]                            INT             NULL,
    [Cantidad]                               NUMERIC (12, 2) NULL,
    [Cupo]                                   VARCHAR (30)    NULL,
    [NetoProc]                               NUMERIC (18, 2) NULL,
    [Calidad]                                VARCHAR (30)    NULL,
    [BrutoPto]                               NUMERIC (18, 2) NULL,
    [TaraPto]                                NUMERIC (18, 2) NULL,
    [NetoPto]                                NUMERIC (18, 2) NULL,
    [Acoplado]                               VARCHAR (30)    NULL,
    [Humedad]                                NUMERIC (18, 2) NULL,
    [Merma]                                  NUMERIC (18, 2) NULL,
    [NetoFinal]                              NUMERIC (18, 2) NULL,
    [FechaDeCarga]                           DATETIME        NULL,
    [FechaVencimiento]                       DATETIME        NULL,
    [CEE]                                    VARCHAR (20)    NULL,
    [IdTransportista]                        INT             NULL,
    [TransportistaCUITdesnormalizado]        VARCHAR (13)    NULL,
    [IdChofer]                               INT             NULL,
    [ChoferCUITdesnormalizado]               VARCHAR (13)    NULL,
    [CTG]                                    INT             NULL,
    [Contrato]                               VARCHAR (20)    NULL,
    [Destino]                                INT             NULL,
    [Subcontr1]                              INT             NULL,
    [Subcontr2]                              INT             NULL,
    [Contrato1]                              INT             NULL,
    [contrato2]                              INT             NULL,
    [KmARecorrer]                            NUMERIC (18, 2) NULL,
    [Tarifa]                                 NUMERIC (18, 2) NULL,
    [FechaDescarga]                          DATETIME        NULL,
    [Hora]                                   DATETIME        NULL,
    [NRecibo]                                INT             NULL,
    [CalidadDe]                              INT             NULL,
    [TaraFinal]                              NUMERIC (18, 2) NULL,
    [BrutoFinal]                             NUMERIC (18, 2) NULL,
    [Fumigada]                               NUMERIC (18, 2) NULL,
    [Secada]                                 NUMERIC (18, 2) NULL,
    [Exporta]                                VARCHAR (2)     NULL,
    [NobleExtranos]                          NUMERIC (18, 2) NULL,
    [NobleNegros]                            NUMERIC (18, 2) NULL,
    [NobleQuebrados]                         NUMERIC (18, 2) NULL,
    [NobleDaniados]                          NUMERIC (18, 2) NULL,
    [NobleChamico]                           NUMERIC (18, 2) NULL,
    [NobleChamico2]                          NUMERIC (18, 2) NULL,
    [NobleRevolcado]                         NUMERIC (18, 2) NULL,
    [NobleObjetables]                        NUMERIC (18, 2) NULL,
    [NobleAmohosados]                        NUMERIC (18, 2) NULL,
    [NobleHectolitrico]                      NUMERIC (18, 2) NULL,
    [NobleCarbon]                            NUMERIC (18, 2) NULL,
    [NoblePanzaBlanca]                       NUMERIC (18, 2) NULL,
    [NoblePicados]                           NUMERIC (18, 2) NULL,
    [NobleMGrasa]                            NUMERIC (18, 2) NULL,
    [NobleAcidezGrasa]                       NUMERIC (18, 2) NULL,
    [NobleVerdes]                            NUMERIC (18, 2) NULL,
    [NobleGrado]                             INT             NULL,
    [NobleConforme]                          VARCHAR (2)     NULL,
    [NobleACamara]                           VARCHAR (2)     NULL,
    [Cosecha]                                VARCHAR (20)    NULL,
    [HumedadDesnormalizada]                  NUMERIC (18, 2) NULL,
    [Factor]                                 NUMERIC (18, 2) NULL,
    [IdFacturaImputada]                      INT             NULL,
    [PuntoVenta]                             INT             NULL,
    [SubnumeroVagon]                         INT             NULL,
    [TarifaFacturada]                        NUMERIC (18, 2) NULL,
    [TarifaSubcontratista1]                  NUMERIC (18, 2) NULL,
    [TarifaSubcontratista2]                  NUMERIC (18, 2) NULL,
    [FechaArribo]                            DATETIME        NULL,
    [Version]                                INT             NULL,
    [MotivoAnulacion]                        VARCHAR (100)   NULL,
    [NumeroSubfijo]                          INT             NULL,
    [IdEstablecimiento]                      INT             NULL,
    [EnumSyngentaDivision]                   VARCHAR (10)    NULL,
    [Corredor2]                              INT             NULL,
    [IdUsuarioModifico]                      INT             NULL,
    [FechaModificacion]                      DATETIME        NULL,
    [FechaEmision]                           DATETIME        NULL,
    [EstaArchivada]                          VARCHAR (2)     NULL,
    [ExcluirDeSubcontratistas]               VARCHAR (2)     NULL,
    [IdTipoMovimiento]                       INT             NULL,
    [IdClienteAFacturarle]                   INT             NULL,
    [SubnumeroDeFacturacion]                 INT             NULL,
    [AgregaItemDeGastosAdministrativos]      VARCHAR (2)     NULL,
    [CalidadGranosQuemados]                  NUMERIC (18, 2) NULL,
    [CalidadGranosQuemadosBonifica_o_Rebaja] VARCHAR (2)     NULL,
    [CalidadTierra]                          NUMERIC (18, 2) NULL,
    [CalidadTierraBonifica_o_Rebaja]         VARCHAR (2)     NULL,
    [CalidadMermaChamico]                    NUMERIC (18, 2) NULL,
    [CalidadMermaChamicoBonifica_o_Rebaja]   VARCHAR (2)     NULL,
    [CalidadMermaZarandeo]                   NUMERIC (18, 2) NULL,
    [CalidadMermaZarandeoBonifica_o_Rebaja]  VARCHAR (2)     NULL,
    [FueraDeEstandar]                        VARCHAR (2)     NULL,
    [CalidadPuntaSombreada]                  NUMERIC (18, 2) NULL
);

