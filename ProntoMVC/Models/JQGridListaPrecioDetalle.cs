﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Trirand.Web.Mvc;
using System.Web.UI.WebControls;

namespace ProntoMVC.Models // JQGridMVCExamples.Models
{
    // public class OrdersJqGridModel
    partial class ListasPrecio44444
    {

        // http://stackoverflow.com/questions/247800/override-default-constructor-of-partial-class-with-another-partial-class
        // como ya se declaró el constructor en el codigo autogenerado, llamo a OnCreated


        // public OrdersJqGridModel()
        void OnCreated()
        {
            ProntoMVC.Models.ListasPrecio o;

            OrdersGrid = new JQGrid
            {
                Columns = new List<JQGridColumn>()
                                 {

                                     

                                     new JQGridColumn { DataField = "IdListaPrecios",  
                                                        // always set PrimaryKey for Add,Edit,Delete operations
                                                        // if not set, the first column will be assumed as primary key
                                                        PrimaryKey = true,
                                                        Editable = false,
                                                        Width = 50 },
                                     new JQGridColumn { DataField = "Descripcion", 
                                                        Editable = true,
                                                        Width = 100, 
                                                        DataFormatString = "{0:d}" },
                                     new JQGridColumn { DataField = "IdMoneda", 
                                                        Editable = true,
                                                        Width = 100 },
                                     new JQGridColumn { DataField = "Descripcion", 
                                                        Editable = true,
                                                        Width = 75 },
                                     new JQGridColumn { DataField = "Descripcion",
                                                        Editable =  true
                                                      }                                     
                                 },
                Width = Unit.Pixel(640)
            };

            OrdersGrid.ToolBarSettings.ShowRefreshButton = true;
        }

        public JQGrid OrdersGrid { get; set; }
    }
}
