using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

using ProntoMVC.Data.Models; using ProntoMVC.Models;

namespace ProntoMVC.Models
{
    public class TablasDAL
    {


        public static List<Object> GetStore(string nombrebase, string storeproc, SqlParameter[] parametros)
        {
            string spName = storeproc;
            string connectionString = Generales.sCadenaConexSQL(nombrebase,null);


            List<object> Lista = new List<object>();




            DataTable dt;


            if (string.IsNullOrEmpty(connectionString))
                return null;

            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand sqlCommand = new SqlCommand(spName, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddRange(parametros);

                sqlConnection.Open();

                if (true)
                {
                    Lista = FillDocumentosPorAutoriza(sqlCommand); //AutorizacionesPorComprobante_TX_DocumentosPorAutoriza
                }
                else
                {


                    using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
                    {
                        int tomar = 100;
                        int cont = 0;


                        dt = ConvertDataReaderToDataTable(sqlDataReader);
                        DataSet ds = ConvertDataReaderToDataSet(sqlDataReader);




                        //    while (sqlDataReader.Read() && cont < tomar)
                        //    {
                        //        // acá se podría paginar el store!



                        //        int size;
                        //        object[] data = new object[sqlDataReader.FieldCount];

                        //        size = sqlDataReader.GetValues(data);
                        //        sqlDataReader.

                        //            sqlDataReader[0].ToString()

                        //        Lista.Add(data);
                        //        //              a[0].ToString(),
                        //        //              a[1].ToString(),
                        //        //              a[2].ToString(),
                        //        //              a[3].ToString(),
                        //        //              a[4].ToString(),
                        //        //              a[5].ToString(),
                        //        //              a[6].ToString(),
                        //        //              a[7].ToString(),
                        //        //              a[8].ToString(),
                        //        //              a[9].ToString(),
                        //        //              a[10].ToString(),
                        //        //              a[11].ToString()

                        //        cont++;
                        //    }

                        sqlCommand.Cancel();
                        sqlDataReader.Close();
                    }
                }
            }

            //return dt;
            return Lista;
        }


        private static List<Object> FillDocumentosPorAutoriza(SqlCommand sqlCommand)
        {
            List<Object> articulos = new List<Object>();
            using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
            {
                while (sqlDataReader.Read())
                {
                    articulos.Add(new
                    {
                        IdComprobante = sqlDataReader["IdComprobante"].ToString()
                        //sqlDataReader["Documento"].ToString(),
                        //sqlDataReader["Numero"].ToString(),
                        //sqlDataReader["Fecha"].ToString(),
                        //sqlDataReader["Proveedor"].ToString(),
                        //sqlDataReader["Monto p/compra"].ToString(),
                        //sqlDataReader["Monto previsto"].ToString(),
                        //sqlDataReader["Orden"].ToString(),
                        //sqlDataReader[8].ToString(), //mon
                        //sqlDataReader["Obra"].ToString(),
                        //sqlDataReader["Sector"].ToString(),
                        //sqlDataReader["Centro de costo"].ToString(),
                        //sqlDataReader["Cliente"].ToString(),
                        //sqlDataReader["IdFormulario"].ToString(),
                        //sqlDataReader[14].ToString(), //Nro.Orden
                        //sqlDataReader["SectorEmisor"].ToString(),
                        //sqlDataReader["IdObra"].ToString(),
                        //sqlDataReader["IdAux"].ToString(),
                        //sqlDataReader["Cotizacion"].ToString(),
                        //sqlDataReader["Liberado por"].ToString(),
                        //sqlDataReader["Importe Iva"].ToString(),
                        //sqlDataReader["IdAutoriza"].ToString()
                    }
                    );
                }
            }
            return articulos;
        }



        public static DataSet ConvertDataReaderToDataSet(System.Data.SqlClient.SqlDataReader reader)
        {

            DataSet dataSet = new DataSet();
            DataTable schemaTable = reader.GetSchemaTable();

            DataTable dataTable = new DataTable();

            // http://www.infysolutions.com ;
            for (int i = 0; i <= schemaTable.Rows.Count - 1; i++)
            {

                DataRow dataRow = schemaTable.Rows[i];

                string columnName = dataRow["ColumnName"].ToString(); DataColumn column = new DataColumn(columnName, dataRow["DataType"].GetType());
                dataTable.Columns.Add(column);

            }

            dataSet.Tables.Add(dataTable);

            while (reader.Read())
            {

                DataRow dataRow = dataTable.NewRow(); for (int i = 0; i <= reader.FieldCount - 1; i++)
                {

                    dataRow[i] = reader.GetValue(i);

                }

                dataTable.Rows.Add(dataRow);

            }

            return dataSet;
        }




        public static DataTable ConvertDataReaderToDataTable(SqlDataReader dataReader)
        {
            DataTable datatable = new DataTable();
            DataTable schemaTable = dataReader.GetSchemaTable();

            try
            {

                foreach (DataRow myRow in schemaTable.Rows)
                {
                    DataColumn myDataColumn = new DataColumn();
                    myDataColumn.DataType = myRow.GetType();
                    myDataColumn.ColumnName = myRow[0].ToString();
                    datatable.Columns.Add(myDataColumn);
                }

                int tomar = 100, saltar = 5;

                while (dataReader.Read())
                {
                    DataRow myDataRow = datatable.NewRow();
                    for (int i = 0; i < schemaTable.Rows.Count && i < tomar; i++)
                    {
                        myDataRow[i] = dataReader[i].ToString();
                    }
                    datatable.Rows.Add(myDataRow);
                    myDataRow = null;
                }
                schemaTable = null;
                return datatable;
            }
            catch (Exception ex)
            {
                // Error.Log(ex.ToString());
                return datatable;
            }

        }

        public static List<Tablas.Tree> Arbol(string nombrebase, Generales.IStaticMembershipService ServicioMembership)
        {
            const string spName = "Tree_TX_Arbol";
            List<Tablas.Tree> TreeCollection;

            //string connectionString = ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString;
            string connectionString = Generales.sCadenaConexSQL(nombrebase,null);

            if (string.IsNullOrEmpty(connectionString))
                return null;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand sqlCommand = new SqlCommand(spName, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlConnection.Open();
                TreeCollection = FillTreeEntity(sqlCommand);
            }

            if (TreeCollection.Count == 0) ArbolRegenerar(nombrebase, ServicioMembership);
 
            return TreeCollection;
        }

        public static List<Tablas.Tree> ArbolRegenerar(string nombrebase, Generales.IStaticMembershipService ServicioMembership)
        {
            const string spName = "Tree_TX_Generar";
            List<Tablas.Tree> TreeCollection;

            //string connectionString = ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString;
            string connectionString = Generales.sCadenaConexSQL(nombrebase, ServicioMembership);

            if (string.IsNullOrEmpty(connectionString))
                return null;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand sqlCommand = new SqlCommand(spName, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlConnection.Open();
                TreeCollection = FillTreeEntity(sqlCommand);
            }
            return TreeCollection;
        }

        private static List<Tablas.Tree> FillTreeEntity(SqlCommand sqlCommand)
        {
            List<Tablas.Tree> TreeCollection = new List<Tablas.Tree>();
            using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
            {
                while (sqlDataReader.Read())
                {
                    TreeCollection.Add(new Tablas.Tree
                    {
                        IdItem = sqlDataReader["IdItem"].NullSafeToString(),
                        Clave = sqlDataReader["Clave"].NullSafeToString(),
                        Descripcion = sqlDataReader["Descripcion"].NullSafeToString(),
                        ParentId = sqlDataReader["ParentId"].NullSafeToString(),
                        Orden = Generales.Val(sqlDataReader["Orden"].NullSafeToString()),
                        Parametros = sqlDataReader["Parametros"].NullSafeToString(),
                        Link = sqlDataReader["Link"].NullSafeToString(),
                        Imagen = sqlDataReader["Imagen"].NullSafeToString(),
                        EsPadre = sqlDataReader["EsPadre"].NullSafeToString()
                    });
                }
            }
            return TreeCollection;
        }

        public static List<Tablas.Tree> Menu(string nombrebase)
        {
            const string spName = "Tree_TX_Arbol";
            List<Tablas.Tree> TreeCollection;

            string connectionString = Generales.sCadenaConexSQL(nombrebase,null);
            //string connectionString = ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString;
            if (string.IsNullOrEmpty(connectionString))
                return null;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand sqlCommand = new SqlCommand(spName, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.Add(new SqlParameter("@GrupoMenu", "Horizontal"));
                sqlConnection.Open();
                TreeCollection = FillTreeEntity(sqlCommand);
            }
            return TreeCollection;
        }
    }

    /// <summary>
    /// Articulo Data Access Layer - Acceso a data de articulos por store procedure
    /// </summary>
    public class ArticuloDAL
    {
        public static List<ProntoMVC.Data.Models.Articulo> SelectArticulos(string filtro, string nombrebase)
        {
            const string spName = "Articulos_TX_Busca";
            List<Articulo> articuloCollection;

            //string connectionString = ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString;
            string connectionString = Generales.sCadenaConexSQL(nombrebase,null);

            if (string.IsNullOrEmpty(connectionString))
                return null;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand sqlCommand = new SqlCommand(spName, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlParameter[] sqlParameterCollection = SetParameterSP(filtro);
                sqlCommand.Parameters.AddRange(sqlParameterCollection);
                sqlConnection.Open();
                articuloCollection = FillArticuloEntity(sqlCommand);
            }
            return articuloCollection;
        }

        /// <summary>
        /// Fill SQL paramter for Stored Procedure
        /// <returns>Collection of SQL paramters object</returns>
        private static SqlParameter[] SetParameterSP(string filtro)
        {
            SqlParameter FiltroParam = new SqlParameter("@Buscar", SqlDbType.VarChar, 50);
            FiltroParam.Value = filtro;
            return new SqlParameter[]
            { 
                FiltroParam
            };
        }

        /// <summary>
        /// Fill the Articulo Entity by using sql reader of command
        /// </summary>
        /// <param name="sqlCommand">sql command object for excute reader</param>
        /// <returns>colletion of Articulos</returns>
        private static List<Articulo> FillArticuloEntity(SqlCommand sqlCommand)
        {
            List<Articulo> articulos = new List<Articulo>();
            using (SqlDataReader sqlDataReader = sqlCommand.ExecuteReader())
            {
                while (sqlDataReader.Read())
                {
                    articulos.Add(new Articulo
                    {
                        IdArticulo = Convert.ToInt32(sqlDataReader["IdArticulo"]),
                        Descripcion = sqlDataReader["Descripcion"].ToString(),
                        Codigo = sqlDataReader["Codigo"].ToString()
                    });
                }
            }
            return articulos;
        }
    }
}

